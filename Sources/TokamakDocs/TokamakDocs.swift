import TokamakDOM
import TokamakCore
import DiffModel

struct Divider : View {
  var body: some View {
    HTML("hr", ["style": "width: 100%;"])
  }
}

struct Link : View {
  let destination: String
  let label: String
  
  var body: some View {
    HTML("a", ["style": "text-decoration: none;", "href": destination]) {
      Text(label)
    }
  }
}

enum PageSource {
    case docs(Int)
    case custom(Page)
}

struct TokamakDocs : View {
  
  @State private var currentPage: PageSource = .docs(0)
  
  var currentPageView: some View {
    switch currentPage {
    case .docs(let idx):
      return AnyView(PageView(page: docsObj[idx], idx: idx))
    case .custom(let page):
      return AnyView(VStack(alignment: .leading) {
        Text(page.name)
          .font(.title)
          .bold()
        Divider()
        page.content
      })
    }
  }
  
  var body: some View {
    return ScrollView {
      HStack {
        Spacer()
      }
      VStack(alignment: .leading) {
        Logo()
        HStack(alignment: .top) {
          VStack(alignment: .leading) {
            Text("Views")
              .font(.headline)
              .padding()
            ForEach(Array(docsObj.enumerated()), id: \.offset) { (offset, page) in
              Button(action: { currentPage = .docs(offset) }) {
                Text(page.title)
              }
            }
            Text("Other")
              .font(.headline)
              .padding()
            Button(action: { currentPage = .custom(.progress) }) {
              Text("Progress")
            }
          }
              .padding()
          currentPageView
        }
      }
    }
  }
}
