import TokamakDOM

struct Logo: View {
    let radius: Double = 10
    var logoPath: some View {
        return ZStack {
            Path(ellipseIn: .init(origin: .init(x: radius / 2, y: radius / 2),
                                  size: .init(width: radius, height: radius)))
                .stroke(Color(red: 240/255, green: 82/255, blue: 55/255, opacity: 1.0), lineWidth: 1)
            Path(ellipseIn: .init(origin: .init(x: radius / 4, y: radius / 4),
                                  size: .init(width: radius / 2, height: radius / 2)))
                .stroke(Color(red: 240/255, green: 82/255, blue: 55/255, opacity: 1.0), lineWidth: 1)
            Path(ellipseIn: .init(origin: .init(x: radius / 3, y: radius / 3),
                                  size: .init(width: radius , height: radius / 1.5)))
                .stroke(Color(red: 240/255, green: 82/255, blue: 55/255, opacity: 1.0), lineWidth: 1)
        }
    }
    var body: some View {
        HStack {
            logoPath
            Text("Tokamak")
                .font(.headline)
                .padding(.leading)
        }
    }
}
