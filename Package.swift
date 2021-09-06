// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Endpoints",
    products: [
        .library(
            name: "Endpoints",
            targets: ["Endpoints"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Endpoints",
            dependencies: []),
        .testTarget(
            name: "EndpointsTests",
            dependencies: ["Endpoints"]),
    ]
)
