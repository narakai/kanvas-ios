//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

@testable import KanvasCamera
import FBSnapshotTestCase
import Foundation
import UIKit
import XCTest

final class StrokeSelecetorControllerTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        
        self.recordMode = false
    }
    
    func newViewController() -> StrokeSelectorController {
        let controller = StrokeSelectorController()
        controller.view.frame = CGRect(x: 0, y: 0,
                                       width: StrokeSelectorView.selectorWidth,
                                       height: StrokeSelectorView.selectorHeight)
        controller.view.setNeedsDisplay()
        return controller
    }
    
    func testStrokeSelectorControllerView() {
        let controller = newViewController()
        FBSnapshotVerifyView(controller.view)
    }
}

