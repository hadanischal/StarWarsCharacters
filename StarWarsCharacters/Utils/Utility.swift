//
//  Utility.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Utility{
    func filterNil(_ value: AnyObject?) -> AnyObject?
}

struct Util {
    
}

extension Util: Utility{
    func filterNil(_ value: AnyObject?) -> AnyObject? {
        return ((value is NSNull || value == nil) ?  "" as AnyObject :  value)
    }
}

