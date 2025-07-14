// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import PackageDescription

let package = Package(
  name: "country_codes",
  platforms: [
    .iOS("8.0")
  ],
  products: [
    .library(name: "country-codes", targets: ["country_codes"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "country_codes",
      dependencies: [],
      resources: [
        .process("Resources/PrivacyInfo.xcprivacy")
      ]
    )
  ]
)
