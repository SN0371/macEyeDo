// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "maceyedo",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "maceyedo",
            path: "Sources/maceyedo"
        )
    ]
)
