import TokamakDOM

struct Logo: View {
  var body: some View {
    HStack {
      HTML("svg", ["width": "100%", "height": "100%"]) {
        HTML("rect", [
          "x": "0", "y": "0", "width": "100%", "height": "100%",
          "rx": "5%",
          "fill": "rgb(240, 81, 55)"
        ])
        HTML("circle", [
          "cx": "50%", "cy": "0", "r": "10%",
          "fill": "white"
        ])
      }
        .frame(width: 30, height: 30)
      Text("Tokamak")
        .font(.system(size: 32, weight: .bold, design: .default))
        .padding()
    }
  }
}
