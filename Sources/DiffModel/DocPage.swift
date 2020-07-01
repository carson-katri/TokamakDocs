public struct DocPage : Codable {
    public let title: String
    public let sections: [DocSection]
    
    public init(title: String, sections: [DocSection]) {
        self.title = title
        self.sections = sections
    }
}
