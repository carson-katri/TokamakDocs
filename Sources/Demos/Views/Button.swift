import TokamakDOM

// #demostart
public struct Clicker: View {
    public init() {}
    @State private var counter: Int = 0
    public var body: some View {
        Button(action: { counter += 1 }) {
            Text("Clicked \(counter) times")
        }
    }
}

// #demoend
