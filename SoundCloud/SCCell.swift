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

class SCCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var avPlayer: AVPlayer?
    var avItem: AVPlayerItem?
    
    func setupCell(track : SCTracks) {
        titleLabel.text = track.title
        musicParametrs(track.streamUrl! + "?client_id=\(Constaints.Path.clientId)")
    }
    
    func musicParametrs(url: String) {
        avItem = AVPlayerItem(URL: NSURL(string: url)!)
        avPlayer = AVPlayer(playerItem: avItem!)
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = CGRect(x: 0,y: 0,width: 10,height: 50)
        SCMainVC.sharedInstance.block?(playerLayer)
    }
    
    @IBAction func play(sender: AnyObject) {
        playStremMusic()
    }
    
    func playStremMusic() {
        if avPlayer?.rate == 0{
            avPlayer?.play()
        }else{
            avPlayer?.pause()
        }
    }
}
