import TokamakDOM
import TokamakStaticHTML
import DiffModel

struct PageView : View {
    let page: DocPage
    let idx: Int
    
    var body: some View {
        ScrollView {
            HStack { Spacer() }
            VStack(alignment: .leading) {
                Text(page.title)
                    .font(.title)
                    .bold()
                Divider()
                ForEach(Array(page.sections.enumerated()), id: \.offset) { (offset, section) in
                    VStack {
//                        VStack(alignment: .leading) {
//                            ForEach(section.text.split(separator: "\n"), id: \.self) { line in
//                                Text(line)
//                                    .font(section.isCode ? .system(.body, design: .monospaced) : .body)
////                                    .padding(.leading, line.count - line.trimming(in: .whitespace).count)
//                            }
//                        }
                        if section.isCode {
                            DemoView(code: section.text) {
                                demos[idx][offset]()
                                    .padding(.leading)
                            }
                        } else {
                            ForEach(section.text.split(separator: "\n"), id: \.self) { line in
                                Text(line)
                            }
                        }
                    }
                        .padding(section.isCode ? 10 : 0)
                        .cornerRadius(section.isCode ? 10 : 0)
                        .padding(section.isCode ? 10 : 0)
                }
            }
        }
    }
}
