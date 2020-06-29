import TokamakDOM
import TokamakCore

struct DemoView<Content> : View where Content : View {
  let code: String
  let content: Content
  
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
      Spacer()
      content
        .padding()
      Spacer()
    }
      .padding()
      .background(0xEEEEEE as Color)
      .cornerRadius(15)
  }
}
