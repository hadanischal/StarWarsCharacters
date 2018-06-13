//
//  Array.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/12/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
