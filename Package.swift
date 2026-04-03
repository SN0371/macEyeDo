// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "maceyes",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "maceyes",
            path: "Sources/maceyes"
        )
    ]
)
