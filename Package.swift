// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebImages",
	platforms: [
		.iOS(.v15)
	],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WebImages",
            targets: ["WebImages"]),
    ],
    dependencies: [
		.package(url: "https://github.com/scinfu/SwiftSoup", from: "2.6.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WebImages",
            dependencies: [
				.product(name: "SwiftSoup", package: "SwiftSoup"),
			]),
        .testTarget(
            name: "WebImagesTests",
            dependencies: ["WebImages"]),
    ]
)
