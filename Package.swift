// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SVGAPlayer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SVGAPlayer",
            targets: ["SVGAPlayer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", from: "2.4.3"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.30.0")
    ],
    targets: [
        .target(
            name: "SVGAPlayer",
            dependencies: [
                "SVGAPlayerNoARC"
            ],
            path: "Source",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("../NoARC")
            ]
        ),
        .target(
            name: "SVGAPlayerNoARC",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "ZipArchive", package: "ZipArchive")
            ],
            path: "NoARC",
            publicHeadersPath: ".",
            cSettings: [
                .unsafeFlags(["-fno-objc-arc"])
            ]
        )
    ]
) 
