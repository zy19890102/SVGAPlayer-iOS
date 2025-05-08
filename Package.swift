// swift-tools-version:5.5
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
    ],
    targets: [
        .target(
            name: "SVGAPlayer",
            dependencies: ["SVGAPlayerNoARC"],
            path: "Source",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("../NoARC")
            ]
        ),
        .target(
            name: "SVGAPlayerNoARC",
            dependencies: [],
            path: "NoARC",
            publicHeadersPath: ".",
            cSettings: [
                .unsafeFlags(["-fno-objc-arc"])
            ]
        )
    ]
) 
