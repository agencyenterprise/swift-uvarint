// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "UVarInt",
    products: [
        .library(
            name: "UVarInt",
            targets: ["UVarInt"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "UVarInt",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
    ]
)
