// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "nayau",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "nayau",
            targets: ["nayau"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "nayau",
            dependencies: []),
        .testTarget(
            name: "nayauTests",
            dependencies: ["nayau"]),
    ],
    swiftLanguageVersions: [.v5]
)
