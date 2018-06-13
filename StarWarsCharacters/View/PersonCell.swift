//
//  PersonCell.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var personModel : PersonModel? {
        didSet {
            guard let data = personModel else {
                return
            }
            titleLabel?.text =  data.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
