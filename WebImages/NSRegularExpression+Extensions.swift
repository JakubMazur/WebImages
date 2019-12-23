//
//  NSRegularExpression+Extensions.swift
//  DuckDuckGoImages
//
//  Created by Jakub Mazur on 12/23/19.
//  Copyright © 2019 Jakub Mazur. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    static func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
