import TokamakCore
import TokamakDOM
import TokamakStaticHTML

struct DemoView<Content>: View where Content: View {
    let code: String
    let content: Content
    @Environment(\.colorScheme) var colorScheme

    init(code: String, @ViewBuilder content: () -> Content) {
        self.code = code
        self.content = content()
    }

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                ForEach(code.split(separator: "\n"), id: \.self) { line in
                    HTML("p", ["style": "margin: 0; \(line == "  " ? "margin-bottom: 1em;" : "")"]) {
                        Text(line)
                            .font(.system(size: 12, design: .monospaced))
                    }
                    .padding(.leading, CGFloat(line[..<(line.firstIndex(where: { !$0.isWhitespace }) ?? line.startIndex)].count) * 6)
                }
            }
            content
                .padding()
        }
        .padding()
        .cornerRadius(15)
        .padding()
    }
}
