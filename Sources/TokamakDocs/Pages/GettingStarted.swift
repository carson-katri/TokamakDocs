import TokamakDOM

fileprivate struct Counter : View {
  @State private var count: Int = 0
  
  var body: some View {
    Button(action: { count += 1 }) {
      Text("Clicked \(count) times")
    }
  }
}

extension Page {
  static let gettingStarted = Page(name: "Getting Started") {
    Text("Welcome to Tokamak. A SwiftUI-compatible framework for building browser apps with WebAssembly.")
    Divider()
    DemoView(code: """
      struct Counter : View {
        @State private var count: Int = 0
        
        var body: some View {
          Button(action: { count += 1 }) {
            Text("Clicked \\(count) times")
          }
        }
      }
      """) {
      Counter()
    }
  }
}
