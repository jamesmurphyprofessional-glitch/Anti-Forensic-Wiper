// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "DataCorruptor",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "DataCorruptor",
            targets: ["DataCorruptor"]
        )
    ],
    targets: [
        .executableTarget(
            name: "DataCorruptor",
            path: ".",
            sources: [
                "DataCorruptor.swift"
            ]
        )
    ]
)
