import JavaScriptKit
import TokamakDOM
import DiffModel

let diffObj = try JSONDecoder().decode(Diff.self, from: Data(stringValue: diff))

let document = JSObjectRef.global.document.object!

let div = document.createElement!("div").object!
//div.set("style", "display: flex; width: 100%; height: 100%; justify-content: center; align-items: center;")
let renderer = DOMRenderer(
  TokamakDocs(),
  div
)

_ = document.body.object!.appendChild!(div)
