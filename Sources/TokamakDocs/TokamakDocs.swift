import TokamakDOM
import TokamakStaticHTML
import DiffModel

struct Link : View {
  let destination: String
  let label: String
  
  var body: some View {
    HTML("a", ["style": "text-decoration: none;", "href": destination]) {
      Text(label)
    }
  }
}

struct ContentView: View {
  let guides: [Page] = [
    .gettingStarted,
    .progress
  ]
  var body: some View {
    NavigationView {
      List {
        Section(header: Text("Guides")) {
          ForEach(Array(guides.enumerated()), id: \.offset) { (_, page) in
            NavigationLink(page.name, destination: ScrollView { page.content })
          }
        }
        Section(header: Text("Views")) {
          ForEach(Array(docsObj.enumerated()), id: \.offset) { (idx, page) in
            NavigationLink(page.title, destination: PageView(page: docsObj[idx], idx: idx))
          }
        }
      }
      .listStyle(SidebarListStyle())
    }
  }
}
