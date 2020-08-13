import JavaScriptKit
import TokamakDOM
import DiffModel

let diffObj = try JSONDecoder().decode(Diff.self, from: Data(stringValue: diff))
let docsObj = try JSONDecoder().decode([DocPage].self, from: Data(stringValue: docs))

struct TokamakDocs: App {
    var body: some Scene {
        WindowGroup("Tokamak") {
            ContentView()
        }
    }
}

TokamakDocs.main()
