import JavaScriptKit

public struct Data {
    let stringValue: String
}

public extension String {
    init?(data: Data, encoding _: String.Encoding) {
        self = data.stringValue
    }

    enum Encoding {
        case utf8
    }
}

public class JSONDecoder {
    public init() {}

    public func decode<T: Decodable>(_ type: T.Type, from jsonString: String) throws -> T {
        guard let json = JSObjectRef.global.JSON.object?.parse?(jsonString) else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: [], debugDescription: "The given data did not contain a top-level value."))
        }
        return try JSValueDecoder().decode(from: json)
    }

    public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        guard let json = JSObjectRef.global.JSON.object?.parse?(data.stringValue) else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: [], debugDescription: "The given data did not contain a top-level value."))
        }
        do {
            return try JSValueDecoder().decode(from: json)
        } catch {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: [], debugDescription: "The given data did not contain a top-level value."))
        }
    }
}
