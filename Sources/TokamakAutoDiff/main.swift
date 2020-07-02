import SwiftSyntax
import ArgumentParser
import Foundation
import DiffModel

// swift build --product TokamakAutoDiff && .build/debug/TokamakAutoDiff /Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/SwiftUI.framework/Modules/SwiftUI.swiftmodule/arm64.swiftinterface .build/checkouts/Tokamak/Sources/TokamakCore ./Sources/TokamakDocs/diff.swift ./Sources/TokamakDocs/docs.swift
// --diff to regenerate the diff

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
        readUntil { $0.tokenKind == kind }
    }
    
    func readUntil(_ condition: (TokenSyntax) -> Bool) -> TokenSyntax {
        readUntil(condition: condition).last ?? self
    }
    
    @discardableResult
    func readUntil(condition: (TokenSyntax) -> Bool) -> [TokenSyntax] {
        var cur = self
        var output = [self]
        while let next = cur.nextToken {
            cur = next
            output.append(cur)
            if condition(next) {
                break
            }
        }
        return output
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
    
//    @Argument(help: "The path to the Demos target")
//    var demosPath: String
    @Argument(help: "The path to save the Swift file to", transform: { URL(fileURLWithPath: $0) })
    var docsOutput: URL?
    
    @Flag()
    var diff: Bool = false
    
    mutating func run() throws {
        guard let tokamakCoreEnumerator = FileManager.default.enumerator(atPath: tokamakCorePath) else {
            throw "TokamakCore not found.".red
        }
        let tokamakCoreURL = URL(fileURLWithPath: tokamakCorePath)
        guard let output = self.output else {
            throw "Output file not valid.".red
        }
        guard let docsOutput = self.docsOutput else {
            throw "docsOutput file not valid.".red
        }
        if diff {
            guard let swiftUIPath = self.swiftUIPath else {
                throw "SwiftUI not found.".red
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
        
        // - MARK: Docs
        let tokamakSource = try (tokamakCoreEnumerator.allObjects as! [String])
            .filter { $0.hasSuffix(".swift") }
            .map { URL(fileURLWithPath: $0, relativeTo: tokamakCoreURL) }
            .compactMap { try SyntaxParser.parse($0) }
        var documentation = [DocPage]()
        for file in tokamakSource {
            let pages = genDocs(for: file)
            if pages.count > 0 {
                documentation.append(contentsOf: pages)
            }
        }
        var demos = [[String]]()
        for page in documentation {
            var pageDemos = [String]()
            for (i, section) in page.sections.enumerated() {
                if !section.isCode {
                    pageDemos.append("{ AnyView(EmptyView()) }")
                    continue
                }
                let demoCode = section.text.contains("var body: some View") ? section.text : """
                var body: some View {
                    \(section.text)
                }
                """
                pageDemos.append("""
                {
                    struct Demo\(i) : View {
                        \(demoCode)
                    }
                    return AnyView(Demo\(i)())
                }
                """)
            }
            demos.append(pageDemos)
        }
        try ##"""
        import TokamakDOM
        let docs = #"""
        \##(
            (String(data: try JSONEncoder().encode(documentation), encoding: .utf8) ?? "")
        )
        """#
        let demos: [[() -> AnyView]] = [
            \##(demos.map { "[\($0.joined(separator: ",\n"))]" }.joined(separator: ",\n"))
        ]
        """##
            .write(to: docsOutput, atomically: true, encoding: .utf8)
        print("Saved DocPages file to \(output.path)")
        
        // - MARK: Demos
//        print("Searching Demos\n".cyan.bold)
//        guard let demosEnumerator = FileManager.default.enumerator(atPath: demosPath) else {
//            throw "Demos not found.".red
//        }
//        let demosURL = URL(fileURLWithPath: demosPath)
//        let demosSource = try (demosEnumerator.allObjects as! [String])
//            .filter { $0.hasSuffix(".swift") }
//            .map { URL(fileURLWithPath: $0, relativeTo: demosURL) }
//            .compactMap {
//                ($0, try SyntaxParser.parse($0))
//            }
//        for (file, source) in demosSource {
//            for token in source.tokens.filter({ $0.leadingTriviaLength.utf8Length > 0 }) {
//                if token.description.contains("//#demostart") {
//                    let output = token
//                        .readUntil(condition: { $0.description.contains("//#demoend") })
//                        .dropLast()
//                        .map(\.description)
//                        .reduce("", +)
//                    // Shift indentation left
//                    let minIndentation = output
//                        .split(separator: "\n")
//                        .map {
//                            $0
//                                .trimmingCharacters(in: .newlines)
//                                .count -
//                            $0
//                                .trimmingCharacters(in: .whitespacesAndNewlines)
//                                .count
//                        }
//                        .sorted(by: <)
//                        .first ?? 0
//                    let formatted = output
//                        .split(separator: "\n")
//                        .map { $0.dropFirst(minIndentation) }
//                        .joined(separator: "\n")
//                        .replacingOccurrences(of: "//#demostart", with: "")
//                        .replacingOccurrences(of: "//#demoend", with: "")
//                        .replacingOccurrences(of: "\\", with: "\\\\")
//                        .trimmingCharacters(in: .newlines)
//                    try? """
//                        public let \(file.lastPathComponent.split(separator: ".").first!.lowercased())DemoSource = \"\"\"
//                        \(formatted)
//                        \"\"\"
//                        """.write(to: file.deletingPathExtension().appendingPathExtension("sourcetxt.swift"),
//                                    atomically: true,
//                                    encoding: .utf8)
//                }
//            }
//        }
    }
}

TokamakAutoDiff.main()
