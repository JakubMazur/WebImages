//
//  Parser.swift
//  WebImages
//
//  Created by Jakub Mazur on 12/23/19.
//  Copyright © 2019 Jakub Mazur. All rights reserved.
//

import UIKit
import SwiftSoup

class Parser: NSObject {
	static func parse(data: Data?) throws -> [WebImage] {
		guard let data = data, let html = String(data: data, encoding: .utf8) else {
			throw WebImagesError.responseDataNil
		}
		guard let doc: Elements = try? SwiftSoup.parse(html).select("img") else {
			throw WebImagesError.responseDataNil
		}
		return doc.array().compactMap { WebImage(try? $0.attr("src")) }
	}
}
