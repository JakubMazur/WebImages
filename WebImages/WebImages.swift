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
        let requestURLString = "https://yandex.com/images/search"
        let parameters: [String: String] = [
            "text": term
        ]
        let components = NSURLComponents(string: requestURLString)
        components?.queryItems = parameters.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard let url: URL = components?.url else {
            completion(.failure(WebImagesError.invalidURLRequest(requestURLString)))
            return
        }
        let urlRequest: URLRequest = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
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
