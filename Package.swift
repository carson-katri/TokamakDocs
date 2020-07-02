// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TokamakDocs",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "TokamakAutoDiff", targets: [ "TokamakAutoDiff" ]),
        .executable(name: "TokamakDocs", targets: [ "TokamakDocs" ])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/kateinoigakukun/JavaScriptKit.git", .revision("47f2bb1")),
        .package(name: "Tokamak", url: "https://github.com/swiftwasm/Tokamak", .revision("3893b2a")),
        
        .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax", .branch("release/5.3")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DiffModel"
        ),
        .target(
            name: "Demos",
            dependencies: [
                .product(name: "TokamakDOM", package: "Tokamak"),
            ]
        ),
        .target(
            name: "TokamakAutoDiff",
            dependencies: [
                "SwiftSyntax",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "DiffModel"
            ]
        ),
        .target(
            name: "TokamakDocs",
            dependencies: [
                .product(name: "TokamakDOM", package: "Tokamak"),
                "JavaScriptKit",
                "DiffModel",
                "Demos"
            ]),
        .testTarget(
            name: "TokamakDocsTests",
            dependencies: ["TokamakDocs"]),
    ]
)
