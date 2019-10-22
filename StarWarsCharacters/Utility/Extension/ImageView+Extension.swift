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
