// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "KoreaInvestSwift",
    platforms: [
            .iOS(.v13),
            .macOS(.v12)
        ],
    products: [
        .library(
            name: "KoreaInvestSwift",
            targets: ["KoreaInvestSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/southkin/FullyRESTful.git", from: "3.0.0"),
        .package(url: "https://github.com/southkin/kinkit.git", from: "1.0.0"),
//        .package(url: "https://github.com/southkin/FullyRESTful.git", branch: "main")
    ],
    targets: [
        .target(
            name: "KoreaInvestSwift", dependencies: [
                .product(name: "FullyRESTful", package: "FullyRESTful"),
                .product(name: "KinKit", package: "KinKit"),
            ]),
        .testTarget(
            name: "KoreaInvestSwiftTests",
            dependencies: ["KoreaInvestSwift"]
        ),
    ]
)
