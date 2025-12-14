// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "ADAnimatedUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ADAnimatedUI",
            targets: ["ADAnimatedUI"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ADAnimatedUI"
        ),

    ]
)
