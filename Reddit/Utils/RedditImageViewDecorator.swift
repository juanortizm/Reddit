//
//  RedditImageViewDecorator.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFrom(string url: String) {
        guard let URL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: URL) { [weak self] (data, _, _) -> Void in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { self?.image = image }
            }.resume()
    }
}
