import TokamakDOM
let docs = #"""
[{"title":"_ViewModifier_Content","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_ShapeView","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_TargetRef","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_NavigationLinkStyleConfiguration","sections":[{"text":"No overview available.","isCode":false}]},{"title":"ButtonStyleConfiguration","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Label","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Button","sections":[{"text":"A control that performs an action when triggered.","isCode":false},{"text":"","isCode":false},{"text":"Available when `Label` conforms to `View`.","isCode":false},{"text":"","isCode":false},{"text":"A button is created using a `Label`; the `action` initializer argument (a method or closure)","isCode":false},{"text":"is to be called on click.","isCode":false},{"text":"","isCode":false},{"text":"@State private var counter: Int = 0\nvar body: some View {\n  Button(action: { counter += 1 }) {\n    Text(\"\\(counter)\")\n  }\n}\n","isCode":true},{"text":"When your label is `Text`, you can create the button by directly passing a `String`:","isCode":false},{"text":"","isCode":false},{"text":"@State private var counter: Int = 0\nvar body: some View {\n  Button(\"\\(counter)\", action: { counter += 1 })\n}","isCode":true}]},{"title":"_Button","sections":[{"text":"No overview available.","isCode":false}]},{"title":"LazyHGrid","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_LazyHGridProxy","sections":[{"text":"No overview available.","isCode":false}]},{"title":"LazyVGrid","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_LazyVGridProxy","sections":[{"text":"No overview available.","isCode":false}]},{"title":"ZStack","sections":[{"text":"A view that overlays its children, aligning them in both axes.","isCode":false},{"text":"","isCode":false},{"text":"ZStack {\n  Text(\"Bottom\")\n  Text(\"Top\")\n}\n","isCode":true}]},{"title":"ScrollView","sections":[{"text":"A scrollable view along a given axis.","isCode":false},{"text":"","isCode":false},{"text":"By default, your app will overflow without the ability to scroll. Embed it in a `ScrollView`","isCode":false},{"text":"to enable scrolling.","isCode":false},{"text":"","isCode":false},{"text":"ScrollView {\n  ForEach(0..<10) {\n    Text(\"\\($0)\")\n  }\n}\n","isCode":true},{"text":"By default, the view will only expand to fit its children.","isCode":false},{"text":"To make it fill its parent along the cross-axis, insert a stack with a `Spacer`:","isCode":false},{"text":"","isCode":false},{"text":"ScrollView {\n  HStack { Spacer() } \/\/ Use VStack for a horizontal ScrollView\n  ForEach(0..<10) {\n    Text(\"\\($0)\")\n  }\n}","isCode":true}]},{"title":"HStack","sections":[{"text":"A view that arranges its children in a horizontal line.","isCode":false},{"text":"","isCode":false},{"text":"HStack {\n  Text(\"Hello\")\n  Text(\"World\")\n}","isCode":true}]},{"title":"VStack","sections":[{"text":"A view that arranges its children in a vertical line.","isCode":false},{"text":"","isCode":false},{"text":"VStack {\n  Text(\"Hello\")\n  Text(\"World\")\n}","isCode":true}]},{"title":"GeometryReader","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Spacer","sections":[{"text":"A `View` that fills the major axis of its parent stack.","isCode":false},{"text":"","isCode":false},{"text":"HStack {\n  Text(\"Hello\")\n  Spacer()\n  Text(\"World\")\n}","isCode":true}]},{"title":"Divider","sections":[{"text":"A horizontal line for separating content.","isCode":false}]},{"title":"NavigationView","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_NavigationViewProxy","sections":[{"text":"This is a helper class that works around absence of \"package private\" access control in Swift","isCode":false}]},{"title":"NavigationLink","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_NavigationLinkProxy","sections":[{"text":"This is a helper class that works around absence of \"package private\" access control in Swift","isCode":false}]},{"title":"AnyView","sections":[{"text":"A type-erased view.","isCode":false}]},{"title":"OutlineSubgroupChildren","sections":[{"text":"No overview available.","isCode":false}]},{"title":"TupleView","sections":[{"text":"A `View` created from a `Tuple` of `View` values.","isCode":false},{"text":"","isCode":false},{"text":"Mainly for use with `@ViewBuilder`.","isCode":false}]},{"title":"DisclosureGroup","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_DisclosureGroupProxy","sections":[{"text":"No overview available.","isCode":false}]},{"title":"List","sections":[{"text":"No overview available.","isCode":false}]},{"title":"ForEach","sections":[{"text":"A structure that computes `View`s from a collection of identified data.","isCode":false},{"text":"","isCode":false},{"text":"Available when `Data` conforms to `RandomAccessCollection`,","isCode":false},{"text":"`ID` conforms to `Hashable`, and `Content` conforms to `View`.","isCode":false},{"text":"","isCode":false},{"text":"The children computed by `ForEach` are directly passed to the encapsulating `View`.","isCode":false},{"text":"Similar to `TupleView` and `Group`.","isCode":false},{"text":"","isCode":false},{"text":"HStack {\n  ForEach(0..<5) {\n    Text(\"\\($0)\")\n  }\n}","isCode":true}]},{"title":"TextField","sections":[{"text":"A control that displays an editable text interface.","isCode":false},{"text":"","isCode":false},{"text":"Available when `Label` conforms to `View`","isCode":false},{"text":"","isCode":false},{"text":"@State private var username: String = \"\"\nvar body: some View {\n  TextField(\"Username\", text: $username)\n}\n","isCode":true},{"text":"You can also set callbacks for when the text is changed, or the enter key is pressed:","isCode":false},{"text":"","isCode":false},{"text":"@State private var username: String = \"\"\nvar body: some View {\n  TextField(\"Username\", text: $username, onEditingChanged: { _ in\n    print(\"Username set to \\(username)\")\n  }, onCommit: {\n    print(\"Set username\")\n  })\n}","isCode":true}]},{"title":"Text","sections":[{"text":"A view that displays one or more lines of read-only text.","isCode":false},{"text":"","isCode":false},{"text":"You can choose a font using the `font(_:)` view modifier.","isCode":false},{"text":"","isCode":false},{"text":"Text(\"Hello World\")\n  .font(.title)\n","isCode":true},{"text":"There are a variety of modifiers available to fully customize the type:","isCode":false},{"text":"","isCode":false},{"text":"Text(\"Hello World\")\n  .foregroundColor(.blue)\n  .bold()\n  .italic()\n  .underline(true, color: .red)","isCode":true}]},{"title":"SecureField","sections":[{"text":"A control that displays a secure editable text interface.","isCode":false},{"text":"","isCode":false},{"text":"`SecureField` is similar to `TextField`, but specifically designed for entering secure","isCode":false},{"text":"text, such as passwords.","isCode":false},{"text":"","isCode":false},{"text":"Available when `Label` conforms to `View`","isCode":false},{"text":"","isCode":false},{"text":"@State private var password: String = \"\"\nvar body: some View {\n  SecureField(\"Password\", text: $password)\n}\n","isCode":true},{"text":"You can also set a callback for when the enter key is pressed:","isCode":false},{"text":"","isCode":false},{"text":"@State private var password: String = \"\"\nvar body: some View {\n  SecureField(\"Password\", text: $password, onCommit: {\n    print(\"Set password\")\n  })\n}","isCode":true}]},{"title":"EmptyView","sections":[{"text":"A `View` with no effect on rendering.","isCode":false}]},{"title":"_ConditionalContent","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_PickerContainer","sections":[{"text":"No overview available.","isCode":false}]},{"title":"_PickerElement","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Picker","sections":[{"text":"No overview available.","isCode":false}]},{"title":"Toggle","sections":[{"text":"No overview available.","isCode":false}]}]
"""#
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
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo7: View {
             @State private var counter: Int = 0
             var body: some View {
                 Button(action: { counter += 1 }) {
                     Text("\(counter)")
                 }
             }
         }
         return AnyView(Demo7())
     },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo10: View {
             @State private var counter: Int = 0
             var body: some View {
                 Button("\(counter)", action: { counter += 1 })
             }
         }
         return AnyView(Demo10())
     }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo2: View {
             var body: some View {
                 ZStack {
                     Text("Bottom")
                     Text("Top")
                 }
             }
         }
         return AnyView(Demo2())
     }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo5: View {
             var body: some View {
                 ScrollView {
                     ForEach(0 ..< 10) {
                         Text("\($0)")
                     }
                 }
             }
         }
         return AnyView(Demo5())
     },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo9: View {
             var body: some View {
                 ScrollView {
                     HStack { Spacer() } // Use VStack for a horizontal ScrollView
                     ForEach(0 ..< 10) {
                         Text("\($0)")
                     }
                 }
             }
         }
         return AnyView(Demo9())
     }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo2: View {
             var body: some View {
                 HStack {
                     Text("Hello")
                     Text("World")
                 }
             }
         }
         return AnyView(Demo2())
     }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo2: View {
             var body: some View {
                 VStack {
                     Text("Hello")
                     Text("World")
                 }
             }
         }
         return AnyView(Demo2())
     }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo2: View {
             var body: some View {
                 HStack {
                     Text("Hello")
                     Spacer()
                     Text("World")
                 }
             }
         }
         return AnyView(Demo2())
     }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo8: View {
             var body: some View {
                 HStack {
                     ForEach(0 ..< 5) {
                         Text("\($0)")
                     }
                 }
             }
         }
         return AnyView(Demo8())
     }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo4: View {
             @State private var username: String = ""
             var body: some View {
                 TextField("Username", text: $username)
             }
         }
         return AnyView(Demo4())
     },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo7: View {
             @State private var username: String = ""
             var body: some View {
                 TextField("Username", text: $username, onEditingChanged: { _ in
                     print("Username set to \(username)")
                 }, onCommit: {
                     print("Set username")
                 })
             }
         }
         return AnyView(Demo7())
     }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo4: View {
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
         struct Demo7: View {
             var body: some View {
                 Text("Hello World")
                     .bold()
                     .italic()
                     .underline(true, color: .red)
                     .foregroundColor(.blue)
             }
         }
         return AnyView(Demo7())
     }],
    [{ AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo7: View {
             @State private var password: String = ""
             var body: some View {
                 SecureField("Password", text: $password)
             }
         }
         return AnyView(Demo7())
     },
     { AnyView(EmptyView()) },
     { AnyView(EmptyView()) },
     {
         struct Demo10: View {
             @State private var password: String = ""
             var body: some View {
                 SecureField("Password", text: $password, onCommit: {
                     print("Set password")
                 })
             }
         }
         return AnyView(Demo10())
     }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
    [{ AnyView(EmptyView()) }],
]
