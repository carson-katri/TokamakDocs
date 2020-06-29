import SwiftSyntax
import ArgumentParser
import Foundation
import DiffModel

// swift build --product TokamakAutoDiff && .build/debug/TokamakAutoDiff /Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/SwiftUI.framework/Modules/SwiftUI.swiftmodule/arm64.swiftinterface .build/checkouts/Tokamak/Sources/TokamakCore ./Sources/TokamakDocs/diff.swift

extension String: Error {}

extension String {
    static let prefix = "\u{001B}[0;"
    static let reset = prefix + "0m"
    var green: Self {
        Self.prefix + "32m" + self + Self.reset
    }
    var red: Self {
        Self.prefix + "31m" + self + Self.reset
    }
    var cyan: Self {
        Self.prefix + "36m" + self + Self.reset
    }
    var bold: Self {
        Self.prefix + "1m" + self + Self.reset
    }
}

extension TokenSyntax {
    func readUntil(_ kind: TokenKind) -> TokenSyntax {
        var cur = self
        while let next = cur.nextToken {
            cur = next
            if next.tokenKind == kind {
                break
            }
        }
        return cur
    }
    
    func conformsTo(_ namespace: String?, type: String) -> Bool {
        guard let namespace = namespace else {
            return conformsTo(type)
        }
        return conformsTo(namespace, type: type)
    }
    
    func conformsTo(_ namespace: String, type: String) -> Bool {
        let next = readUntil(.colon).nextToken
        if next?.text == namespace {
            if next?.nextToken?.nextToken?.text == type { // namespace.type
                return true
            }
        }
        return false
    }
    
    func conformsTo(_ type: String) -> Bool {
        if readUntil(.colon).nextToken?.text == type {
            return true
        }
        return false
    }
}

struct DiffInfo {
    let views: [TokenSyntax]
    let modifiers: [TokenSyntax]
    let shapes: [TokenSyntax]
    let shapeStyles: [TokenSyntax]
    
    let viewMethods: [TokenSyntax]
    
    init(views: [TokenSyntax],
         modifiers: [TokenSyntax],
         shapes: [TokenSyntax],
         shapeStyles: [TokenSyntax],
         viewMethods: [TokenSyntax]) {
        self.views = views
        self.modifiers = modifiers
        self.shapes = shapes
        self.shapeStyles = shapeStyles
        self.viewMethods = viewMethods
    }
    
    init(tokens: TokenSequence, namespace: String? = nil, quiet: Bool) {
        let types = tokens
            .filter {
                $0.tokenKind == .structKeyword || // Structs
                $0.tokenKind == .extensionKeyword // Extensions
            }
            .compactMap { tok -> TokenSyntax? in
                if tok.nextToken?.nextToken?.tokenKind == TokenKind.period {
                    return tok.nextToken?.nextToken?.nextToken
                } else {
                    return tok.nextToken
                }
            }
            .sorted(by: { $0.text < $1.text })
//            .filter { !$0.text.hasPrefix("_") }
        
        views       = types.filter { $0.conformsTo(namespace, type: "View") }
        modifiers   = types.filter { $0.conformsTo(namespace, type: "ViewModifier") }
        shapes      = types.filter { $0.conformsTo(namespace, type: "Shape") }
        shapeStyles = types.filter { $0.conformsTo(namespace, type: "ShapeStyle") }
        
        viewMethods = tokens
            .filter {
                $0.tokenKind == .extensionKeyword &&
                $0.nextToken?.text == "View"
            }
            .map { (start) -> [TokenSyntax] in
                var cur = start
                var functions = [TokenSyntax]()
                while let tok = cur.nextToken, tok.tokenKind != .rightBrace {
                    if tok.tokenKind == .funcKeyword {
                        if let signature = tok.nextToken {
                            functions.append(signature)
                            cur = signature
                            continue
                        }
                    }
                    cur = tok
                }
                return functions
            }
            .reduce([], +)
            .sorted(by: { $0.text < $1.text })
        
        if !quiet {
            log()
        }
    }
    
    func log() {
        print("Found".green, "\(views.count)".green.bold, "View types".green)
        print("Found".green, "\(modifiers.count)".green.bold, "ViewModifier types".green)
        print("Found".green, "\(shapes.count)".green.bold, "Shape types".green)
        print("Found".green, "\(shapeStyles.count)".green.bold, "ShapeStyle types".green)
        print("Found".green, "\(viewMethods.count)".green.bold, "View methods\n".green)
    }
    
    var module: Diff.Module {
        .init(views: Set(views.map(\.text)),
              modifiers: Set(modifiers.map(\.text)),
              shapes: Set(shapes.map(\.text)),
              shapeStyles: Set(shapeStyles.map(\.text)),
              viewMethods: Set(viewMethods.map(\.text)))
    }
}

extension Array where Element == DiffInfo {
    func combined() -> DiffInfo {
        let views = map(\.views).reduce([], +)
        let modifiers = map(\.modifiers).reduce([], +)
        let shapes = map(\.shapes).reduce([], +)
        let shapeStyles = map(\.shapeStyles).reduce([], +)
        let viewMethods = map(\.viewMethods).reduce([], +)
        return .init(views: views,
              modifiers: modifiers,
              shapes: shapes,
              shapeStyles: shapeStyles,
              viewMethods: viewMethods)
    }
}

struct TokamakAutoDiff: ParsableCommand {
    @Argument(help: "The path to SwiftUI .swiftinterface", transform: { URL(fileURLWithPath: $0) })
    var swiftUIPath: URL?
    
    @Argument(help: "The path to TokamakCore root folder")
    var tokamakCorePath: String
    
    @Argument(help: "The path to save the Swift file to", transform: { URL(fileURLWithPath: $0) })
    var output: URL?
    
    mutating func run() throws {
        guard let swiftUIPath = self.swiftUIPath else {
            throw "SwiftUI not found.".red
        }
        guard let tokamakCoreEnumerator = FileManager.default.enumerator(atPath: tokamakCorePath) else {
            throw "TokamakCore not found.".red
        }
        let tokamakCoreURL = URL(fileURLWithPath: tokamakCorePath)
        guard let output = self.output else {
            throw "Output file not valid.".red
        }
        
        // - MARK: SwiftUI
        
        print("Searching SwiftUI\n".cyan.bold)
        let swiftUISource = try SyntaxParser.parse(swiftUIPath)
        let swiftUIInfo = DiffInfo(tokens: swiftUISource.tokens, namespace: "SwiftUI", quiet: false)
        
        // - MARK: TokamakCore
        print("Searching TokamakCore\n".cyan.bold)
        let tokamakSource = try (tokamakCoreEnumerator.allObjects as! [String])
            .filter { $0.hasSuffix(".swift") }
            .map { URL(fileURLWithPath: $0, relativeTo: tokamakCoreURL) }
            .compactMap {
                DiffInfo(tokens: try SyntaxParser.parse($0).tokens, quiet: true)
            }
            .combined()
        tokamakSource.log()
        
        print("Diffing SwiftUI and TokamakCore\n".cyan.bold)
        let diff = Diff(swiftUI: swiftUIInfo.module, tokamak: tokamakSource.module)
        print("Missing".red, "\(diff.missing.views.count)".red.bold, "View types".red)
        print("Missing".red, "\(diff.missing.modifiers.count)".red.bold, "ViewModifier types".red)
        print("Missing".red, "\(diff.missing.shapes.count)".red.bold, "Shape types".red)
        print("Missing".red, "\(diff.missing.shapeStyles.count)".red.bold, "ShapeStyle types".red)
        print("Missing".red, "\(diff.missing.viewMethods.count)".red.bold, "View methods".red)
        
        try #"""
        let diff = """
        \#(String(data: try JSONEncoder().encode(diff), encoding: .utf8) ?? "")
        """
        """#
            .write(to: output, atomically: true, encoding: .utf8)
        
        print("Saved diff file to \(output.path)")
    }
}

TokamakAutoDiff.main()
