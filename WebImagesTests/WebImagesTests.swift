//
//  DuckDuckGoImagesTests.swift
//  DuckDuckGoImagesTests
//
//  Created by Jakub Mazur on 12/23/19.
//  Copyright © 2019 Jakub Mazur. All rights reserved.
//

import XCTest
@testable import WebImages

class WebImagesTests: XCTestCase {
    
    func testConnect() {
        let exp = self.expectation(description: #function)
        WebImages.search(term: "bob dylan") { results in
            let images = try! results.get()
            self.parseWebImages(images) {
                exp.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1000.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    private func parseWebImages(_ images: [WebImage], _ completion: @escaping() -> Void) {
        images.forEach {
            $0.get { (image) in
                print(image)
            }
        }
    }

}
