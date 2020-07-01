import TokamakDOM
import DiffModel

struct PageView : View {
    let page: DocPage
    let idx: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(page.title)
                .font(.title)
                .bold()
            Divider()
            ForEach(Array(page.sections.enumerated()), id: \.offset) { (offset, section) in
                VStack {
                    VStack(alignment: .leading) {
                        ForEach(section.text.split(separator: "\n"), id: \.self) { line in
                            Text(line)
                                .font(section.isCode ? .system(.body, design: .monospaced) : .body)
            //                    .padding(.leading, line.count - line.trimming(in: .whitespace).count)
                        }
                    }
                    (section.isCode ? AnyView(Divider()) : AnyView(EmptyView()))
                    demos[idx][offset]()
                        .padding(.leading)
                }
                    .padding(section.isCode ? 10 : 0)
                    .background(section.isCode ? Color(red: 0.9, green: 0.9, blue: 0.9, alpha: 1) : Color(red: 1, green: 1, blue: 1, alpha: 1))
                    .cornerRadius(10)
                    .padding(section.isCode ? 10 : 0)
            }
        }
    }
}
