import DiffModel
import SwiftSyntax

extension TriviaPiece {
    var docComments: String? {
        switch self {
        case let .docLineComment(docs):
            return docs
        case let .docBlockComment(docs):
            return docs
        default:
            return nil
        }
    }
}

func parseDocs(_ docComments: [String]) -> [DocSection] {
    var sections = [DocSection]()
    var i = 0
    while i < docComments.count {
        let text = docComments[i]
        if text.hasPrefix("     ") {
            let start = i
            while i < docComments.count, docComments[i].hasPrefix("     ") {
                i += 1
            }
            sections.append(DocSection(docComments[start ..< min(docComments.count, i + 1)]
                    .map { $0.dropFirst(5) }
                    .joined(separator: "\n"), true))
        } else {
            sections.append(DocSection(String(docComments[i].dropFirst())))
        }
        i += 1
    }
    return sections
}

func genDocs(for syntax: SourceFileSyntax) -> [DocPage] {
    var docPages = [DocPage]()
    for token in syntax.tokens {
        if token.tokenKind == .publicKeyword, token.nextToken?.tokenKind == .structKeyword, token.conformsTo("View") {
            if let viewName = token.nextToken?.nextToken?.text {
                let docComments = token
                    .leadingTrivia
                    .compactMap { (trivia) -> String? in
                        if let trimmed = trivia.docComments?.dropFirst(3) {
                            return String(trimmed)
                        } else {
                            return nil
                        }
//                            .replacingOccurrences(of: "\"", with: "\\\"")
//                            .replacingOccurrences(of: #"\("#, with: #"\\("#)
                    }
                var docSections = parseDocs(docComments)
                if docComments.count == 0 {
                    docSections.append(.init("No overview available."))
                }
                docPages.append(.init(title: viewName, sections: docSections))
            }
        }
    }
    return docPages
}
