//
//  SCCell.swift
//  SoundCloud
//
//  Created by sasha ataman on 03.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SDWebImage

class SCCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    func setupCell(track : SCTracks) {
        if let title = track.title{
            titleLabel.text = title
        }
        if let imageUrl = track.artworkUrl{
            trackImageView.sd_setImageWithURL(NSURL(string: imageUrl))
        }else{
            trackImageView.image = UIImage(named: "defaultImage")
        }
        if let date = track.createdAt{
            dateLabel.text = SCDateHelperManager.sharedInstance.convertDate(date: date)
        }
    }
    
    }
