import Demos
import TokamakDOM

struct GettingStartedDemo: View {
    @State private var count = 0

    var body: some View {
        Button("\(count)") { count += 1 }
    }
}

extension Page {
    static let gettingStarted = Page(name: "Getting Started") {
        Group {
            Text("Welcome to Tokamak")
                .font(.title)
                .bold()
            Text("A SwiftUI-compatible framework for building browser apps with WebAssembly.")
                .italic()
            Text("Tokamak gives you the full power of SwiftUI inside of your browser, with the flexibility to tap into HTML when needed.")
            Text("Your SwiftUI skills will transfer seamlessly to Tokamak:")
            DemoView(code: """
            struct ContentView: View {
                @State private var count = 0

                var body: some View {
                    Button("\\(count)") { count += 1 }
                }
            }
            """) {
                GettingStartedDemo()
            }
        }
        Group {
            Text("Installing Carton 📦")
                .font(.title)
                .bold()
            Text("Carton is used to create, run, and test your swiftwasm projects. You can install it with Homebrew:")
            DemoView(code: "brew install swiftwasm/tap/carton") {}
            Text("Creating a new Tokamak project from there is easy:")
            DemoView(code: """
            mkdir MyTokamakApp
            cd MyTokamakApp
            carton init --template tokamak # Create the project
            carton dev # Start the dev server
            """) {}
            Text("Anytime the source code changes, carton will automatically refresh the page.")
        }
    }
}
