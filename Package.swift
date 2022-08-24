// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ErrorHandling",
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "ErrorHandling",
            dependencies: []),
        .testTarget(
            name: "ErrorHandlingTests",
            dependencies: ["ErrorHandling"]),
    ]
)
