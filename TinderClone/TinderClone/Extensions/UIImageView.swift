//
//  UIImageView.swift
//  TinderClone
//
//  Created by Richard Price on 27/04/2021.
//

import Foundation
import UIKit
//step 3 create an extension of imageView and use a cache check at the beginning
extension UIImageView {
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = Api.ImageCache.cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, resp, error in
            if error != nil { return }
            guard let response = resp as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            Api.ImageCache.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }
}

