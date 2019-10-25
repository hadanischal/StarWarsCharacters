//
//  ThemeColor.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

extension UIColor {
    static var primary: UIColor {
        return UIColor(red: 0.122, green: 0.737, blue: 0.824, alpha: 1.00)
    }

    static var primaryLight: UIColor {
        return UIColor(red: 163/255, green: 209/255, blue: 218/255, alpha: 1)
    }

    static var darkText: UIColor {
        return UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
    }

    static var text: UIColor {
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }

    static var lightText: UIColor {
        return UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    }

    static var extraLightText: UIColor {
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    }

    static var buttonBackgroundColor: UIColor {
        return UIColor(red: 0.122, green: 0.737, blue: 0.824, alpha: 1.00)
    }

    static var collectionViewBackgroundColor: UIColor {
        return UIColor(rgb: 0xEAE8EA)
    }

    static var contentViewBackgroundColor: UIColor {
        return UIColor(rgb: 0xEAE8EA)
    }

    static var viewBackgroundColor: UIColor {
        return UIColor(rgb: 0xeef0f1)
    }

    static var placeholderColor: UIColor {
        return UIColor(rgb: 0xeef0f1)
    }
    static var titleColor: UIColor {
        return UIColor.black
    }
    static var descriptionColor: UIColor {
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }
    static var segmentSelectedTitle: UIColor {
        return UIColor.black
    }
    static var segmentDefaultTitle: UIColor {
        return UIColor.darkGray
    }
    static var segmentIndicator: UIColor {
        return UIColor(rgb: 0xEf8136)
    }
    static var segmentSeparator: UIColor {
        return UIColor(rgb: 0xDDDDDD)
    }
    static var segmentBadge: UIColor {
        return UIColor(rgb: 0xf46f60)
    }
    static var imageBackgroundColor: UIColor {
        return UIColor(rgb: 0xf46f60)
    }
}
