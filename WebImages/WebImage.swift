//
//  DuckDuckGoImage.swift
//  DuckDuckGoImages
//
//  Created by Jakub Mazur on 12/23/19.
//  Copyright © 2019 Jakub Mazur. All rights reserved.
//

import Foundation
import UIKit

public struct WebImage {
    let url: URL
    
    init?(_ urlString: String?) {
        guard let urlString = urlString, urlString != "" else { return nil }
        guard let url = URL(string: "https:" + urlString) else {
            return nil
        }
        self.url = url
    }
    
    public func get(_ completion:@escaping(UIImage?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        dataTask.resume()
    }
}
