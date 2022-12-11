// Copyright (c) 2019 Spotify AB.
//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

#if canImport(UIKit)

import Diffuser
import UIKit
import XCTest

class BarButtonItemTests: XCTestCase {

    private let barButtonItem = FakeBarButtonItem()
    private lazy var fuser: Fuser<UIBarButtonItem> = .fromBarButtonItem(barButtonItem)

    func testTargetIsNotSetBeforeConnecting() {
        XCTAssertFalse(barButtonItem.hasTarget)
    }

    func testTargetIsSetWhenConnecting() {
        let disposable = fuser.connect { _ in }
        XCTAssertTrue(barButtonItem.hasTarget)
        disposable.dispose()
    }

    func testTargetIsRemovedAfterDisposing() {
        let disposable = fuser.connect { _ in }
        disposable.dispose()
        XCTAssertFalse(barButtonItem.hasTarget)
    }
}

private class FakeBarButtonItem: UIBarButtonItem {
    var hasTarget = false

    override var target: AnyObject? {
        didSet {
            if target == nil {
                hasTarget = false
            } else {
                hasTarget = true
            }
        }
    }
}

#endif
