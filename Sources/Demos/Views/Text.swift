import TokamakDOM

public struct TextDemo : View {
    public init() {}
    public var body: some View {
        VStack {
            //#demostart
            Text("Hello World")

            Text("Hello World")
                .font(.largeTitle)
                .bold()

            Text("Hello World")
                .font(.system(size: 21))
                .italic()

            Text("Hello World")
                .fontWeight(.ultraLight)
                .foregroundColor(.blue)
            //#demoend
        }
    }
}
