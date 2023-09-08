//
//  UIImageViewExtension.swift
//  HeroFind
//
//  Created by user on 07/09/23.
//

import UIKit

extension UIImageView {
    func download(from imagePath: String) {
        let url = URL(string: imagePath.replacingOccurrences(of: "http", with: "https"))!
        
        URLSession.shared.dataTask(with: .init(url: url)) { data, _, error in
            if error != nil { return }

            if let data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else { return }
        }.resume()
    }
}
