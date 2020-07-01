import TokamakDOM
import Demos

extension Page {
  static let gettingStarted = Page(name: "Getting Started") {
    Text("Welcome to Tokamak. A SwiftUI-compatible framework for building browser apps with WebAssembly.")
    Text("Tokamak gives you the full power of SwiftUI inside of your browser, with the flexibility to tap into HTML when needed.")
    Text("Your SwiftUI skills will transfer seamlessly to Tokamak:")
    DemoView(code: buttonDemoSource) {
      Clicker()
    }
  }
}
