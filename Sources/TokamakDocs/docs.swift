import TokamakDOM
let docs = """
[{"title":"_ViewModifier_Content","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_ShapeView","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Spacer","sections":[{"text":"No overview available.","isCode":false}]},{"title":"TupleView","sections":[{"text":"No overview available.","isCode":false}]},{"title":"ZStack","sections":[{"text":"A view that overlays its children, aligning them in both axes.","isCode":false}]},{"title":"ScrollView","sections":[{"text":"No overview available.","isCode":false}]},{"title":"TextField","sections":[{"text":"A control that displays an editable text interface.","isCode":false},{"text":"","isCode":false},{"text":"Available when `Label` conforms to `View`","isCode":false},{"text":"The","isCode":false},{"text":"","isCode":false},{"text":"@State private var username: String\\nvar body: some View {\\n  TextField(\\\"Username\\\", text: $username)\\n}\\n","isCode":true},{"text":"You can also set callbacks for when the text is changed, or the enter key is pressed:","isCode":false},{"text":"","isCode":false},{"text":"@State private var username: String\\nvar body: some View {\\n  TextField(\\\"Username\\\", text: $username,onEditingChanged: { _ in\\n    print(\\\"Username set to \\\\(username)\\\")\\n  }, onCommit: {\\n    print(\\\"Set password\\\")\\n  })\\n}","isCode":true}]},{"title":"AnyView","sections":[{"text":"No overview available.","isCode":false}]},{"title":"HStack","sections":[{"text":"No overview available.","isCode":false}]},{"title":"VStack","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Text","sections":[{"text":"A view that displays one or more lines of read-only text.","isCode":false},{"text":"","isCode":false},{"text":"You can choose a font using the `font(_:)` view modifier.","isCode":false},{"text":"","isCode":false},{"text":"Text(\\\"Hello World\\\")\\n    .font(.title)\\n","isCode":true},{"text":"There are a variety of modifiers available to fully customize the type:","isCode":false},{"text":"","isCode":false},{"text":"Text(\\\"Hello World\\\")\\n    .foregroundColor(.blue)\\n    .bold()\\n    .italic()\\n    .underline(true, color: .red)","isCode":true}]},{"title":"SecureField","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Button","sections":[{"text":"No overview available.","isCode":false}]},{"title":"EmptyView","sections":[{"text":"No overview available.","isCode":false}]},{"title":"ForEach","sections":[{"text":"No overview available.","isCode":false}]}]
"""
let demos: [[() -> AnyView]] = [
    [{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{
    struct Demo5 : View {
        @State private var username: String = ""
var body: some View {
  TextField("Username", text: $username)
}

    }
    return AnyView(Demo5())
},
{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{
    struct Demo8 : View {
        @State private var username: String = ""
var body: some View {
  TextField("Username", text: $username,onEditingChanged: { _ in
    print("Username set to \\(username)")
  }, onCommit: {
    print("Set password")
  })
}
    }
    return AnyView(Demo8())
}],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{
    struct Demo4 : View {
        var body: some View {
    Text("Hello World")
    .font(.title)

}
    }
    return AnyView(Demo4())
},
{ AnyView(EmptyView()) },
{ AnyView(EmptyView()) },
{
    struct Demo7 : View {
        var body: some View {
    Text("Hello World")
    .foregroundColor(.blue)
    .bold()
    .italic()
    .underline(true, color: .red)
}
    }
    return AnyView(Demo7())
}],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }],
[{ AnyView(EmptyView()) }]
]
