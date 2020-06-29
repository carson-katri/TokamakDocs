public struct Diff: Codable {
    public let swiftUI: Module
    public let tokamak: Module
    
    public var missing: Module {
        .init(views: swiftUI.subtracting(\.views, from: tokamak),
              modifiers: swiftUI.subtracting(\.modifiers, from: tokamak),
              shapes: swiftUI.subtracting(\.shapes, from: tokamak),
              shapeStyles: swiftUI.subtracting(\.shapeStyles, from: tokamak),
              viewMethods: swiftUI.subtracting(\.viewMethods, from: tokamak))
    }
    
    public init(swiftUI: Module, tokamak: Module) {
        self.swiftUI = swiftUI
        self.tokamak = tokamak
    }
    
    public struct Module: Codable {
        public let views: Set<String>
        public let modifiers: Set<String>
        public let shapes: Set<String>
        public let shapeStyles: Set<String>
        public let viewMethods: Set<String>
        
        func subtracting(_ keyPath: KeyPath<Module, Set<String>>, from module: Module) -> Set<String> {
            self[keyPath: keyPath].subtracting(module[keyPath: keyPath])
        }
        
        public init(views: Set<String>,
                    modifiers: Set<String>,
                    shapes: Set<String>,
                    shapeStyles: Set<String>,
                    viewMethods: Set<String>) {
            self.views = views
            self.modifiers = modifiers
            self.shapes = shapes
            self.shapeStyles = shapeStyles
            self.viewMethods = viewMethods
        }
    }
}
