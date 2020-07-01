import TokamakDOM

struct Logo: View {
  var body: some View {
    HStack {
      Path(roundedRect: CGRect(.zero, CGSize(width: 30, height: 30)), cornerRadius: 1.5)
        .fill(Color.red)
        .overlay(Path(ellipseIn: CGRect(.zero, CGSize(width: 6, height: 6))).fill(Color.white), alignment: .top)
      Text("Tokamak")
        .font(.system(size: 32, weight: .bold, design: .default))
        .padding()
    }
  }
}
