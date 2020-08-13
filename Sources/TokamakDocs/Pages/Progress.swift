import TokamakDOM

extension Page {
    static let progress = Page(name: "Progress") {
        Text("Tokamak currently supports \(diffObj.tokamak.views.count) views.")
            .padding(.bottom)
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                ForEach(Array(diffObj.swiftUI.views).sorted(by: <), id: \.self) {
                    Link(destination: "https://developer.apple.com/documentation/swiftui/\($0)", label: $0)
                }
            }
            VStack(alignment: .leading) {
                ForEach(Array(diffObj.swiftUI.views).sorted(by: <), id: \.self) { view -> AnyView in
                    if diffObj.tokamak.views.contains(view) {
                        return AnyView(Link(destination: "https://developer.apple.com/documentation/swiftui/\(view)", label: view))
                    } else {
                        return AnyView(Text("🚧"))
                    }
                }
            }
        }
    }
}
