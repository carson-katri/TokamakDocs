import TokamakDOM
import TokamakCore

struct Page {
  let name: String
  let content: AnyView
  
  init<Content>(name: String, @ViewBuilder content: () -> Content) where Content: View {
    self.name = name
    self.content = AnyView(VStack(alignment: .leading) {
      content()
    })
  }
}
