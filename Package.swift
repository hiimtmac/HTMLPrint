// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTMLPrint",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "HTMLPrint", targets: ["HTMLPrint"]),
    ],
    targets: [
        .target(name: "HTMLPrint", dependencies: []),
        .testTarget(name: "HTMLPrintTests", dependencies: ["HTMLPrint"]),
    ]
)
