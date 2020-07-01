import TokamakDOM
import Demos

extension Page {
    static let text = Page(
        name: "Text"
    ) {
        Text("Tokamak supports many of the Text modifiers available in SwiftUI")
        DemoView(code: textDemoSource) {
            TextDemo()
        }
    }
}
