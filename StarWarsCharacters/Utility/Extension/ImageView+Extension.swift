//
//  ImageView+Extension.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 22/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(url: URL) {
        self.kf.setImage(with: url)
    }
}

extension UIImageView {
     func setImage(withName name: String) {
        self.image = self.image(WithName: name)
      }

    func image(WithName name: String) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .imageBackgroundColor
        nameLabel.textColor = .white
        nameLabel.font = .imageTitle
        nameLabel.text = String(name.prefix(2)).uppercased()
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
