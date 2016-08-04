//
//  SCCell.swift
//  SoundCloud
//
//  Created by sasha ataman on 03.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit

class SCCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func setupCell() {
        titleLabel.text = "Hello"
    }
}
