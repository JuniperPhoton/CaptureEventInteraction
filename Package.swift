// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CaptureEventInteraction",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CaptureEventInteraction",
            targets: ["CaptureEventInteraction"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JuniperPhoton/VolumeButtonHandler", from: "1.0.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CaptureEventInteraction",
            dependencies: ["VolumeButtonHandler"]
        ),
        .testTarget(
            name: "CaptureEventInteractionTests",
            dependencies: ["CaptureEventInteraction"]),
    ]
)
