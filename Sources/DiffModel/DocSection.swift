public struct DocSection: Codable, Equatable {
    public let text: String
    public let isCode: Bool

    public init(_ text: String, _ isCode: Bool = false) {
        self.text = text
        self.isCode = isCode
    }
}
