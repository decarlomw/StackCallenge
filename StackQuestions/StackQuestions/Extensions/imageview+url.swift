//
//  imageview+url.swift
//  StackQuestions
//
//  Created by Decarlo Williams on 2/14/20.
//  Copyright © 2020 Decarlo Williams. All rights reserved.
//

import UIKit

// this extension take a url and returns the image -- not the best solution for tableView. May want to use a library in the future.
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
