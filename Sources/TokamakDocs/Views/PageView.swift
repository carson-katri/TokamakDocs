import TokamakDOM

struct PageView : View {
    let page: Page?
    
    var body: some View {
        if let page = page {
            return AnyView(VStack(alignment: .leading) {
                Text(page.name)
                    .font(.largeTitle)
                    .bold()
                page.content
                    .padding(.vertical)
            }.padding())
        } else {
            return AnyView(Text("Select a page"))
        }
    }
}
