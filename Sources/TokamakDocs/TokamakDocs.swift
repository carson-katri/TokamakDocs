import TokamakDOM
import TokamakCore
import DiffModel

struct Spacer : View {
  var body: some View {
    HTML("div", ["style": "flex-grow: 1"])
  }
}

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

struct TokamakDocs : View {    
  let pages: [Page] = [
    .gettingStarted,
    .views,
    .progress
//    .viewModifiers
  ]
  
  @State private var currentPage: Int = 0
  
  var body: some View {
    return VStack {
      Logo()
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          ForEach(Array(pages.enumerated()), id: \.offset) { (offset, page) in
            Button(action: { currentPage = offset }) {
              Text(page.name)
                .font(.headline)
            }
          }
        }
        PageView(page: pages[currentPage])
        Spacer()
      }
      Spacer()
    }
  }
}
