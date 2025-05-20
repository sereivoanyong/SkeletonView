// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "SkeletonView",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "SkeletonView",
            targets: ["SkeletonView"]
        )
    ],
    targets: [
        .target(
            name: "SkeletonView",
            path: "SkeletonViewCore/Sources",
            resources: [.copy("Supporting Files/PrivacyInfo.xcprivacy")]
        ),
        .testTarget(
            name: "SkeletonViewTests",
            dependencies: ["SkeletonView"],
            path: "SkeletonViewCore/Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
