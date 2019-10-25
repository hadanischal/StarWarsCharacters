//
//  PeopleTableViewCell.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 22/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView?

    var personModel: PersonModel? {
        didSet {
            guard let data = personModel else {
                return
            }
            titleLabel?.text =  data.name
            subtitleLabel?.text =  "Eye Color : " + data.eyeColor.capitalized
            photoImageView?.setImage(withName: data.name)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .body1
        subtitleLabel.font = .body3

        titleLabel.textColor = .titleColor
        subtitleLabel.textColor = .descriptionColor
    }

}
