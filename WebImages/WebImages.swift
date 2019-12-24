//
//  DuckDuckGoImages.swift
//  DuckDuckGoImages
//
//  Created by Jakub Mazur on 12/23/19.
//  Copyright © 2019 Jakub Mazur. All rights reserved.
//

import UIKit

public class WebImages: NSObject {
    
    public static func search(term: String, _ completion:@escaping(Result<[WebImage],Error>) -> Void) {
        let session: URLSession = URLSession.shared
        let term = term.replacingOccurrences(of: " ", with: "%20")
        let requestURLString = "https://yandex.com/images/search?text=\(term)"
        guard let url = URL(string: requestURLString) else {
            completion(.failure(WebImagesError.invalidURLRequest(requestURLString)))
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            do {
                let images = try Parser.parse(data: data)
                DispatchQueue.main.async {
                    completion(.success(images))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(WebImagesError.unexpectedResponse(error)))
                }
            }
        }
        dataTask.resume()
    }
}


enum WebImagesError: Error {
    case invalidURLRequest(String)
    case responseDataNil
    case unexpectedResponse(Error)
}
