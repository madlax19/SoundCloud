
//
//  SCMainVC.swift
//  SoundCloud
//
//  Created by sasha ataman on 03.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit
import AVFoundation

class SCMainVC: UICollectionViewController {
    var track = [SCTracks]()
    var audioPlayer: AVPlayer?
    var audioItem: AVPlayerItem?
    var block: ((AVPlayerLayer) -> ())?
    
    static let sharedInstance = SCMainVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTrack()
    }
    
    @objc private func fetchTrack(){
        SCRequestHelper.trackRequest({
            self.track += $0
            self.collectionView?.reloadData()
            }, failed: {
                print("error")
        })
    }
    

}


extension SCMainVC {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return track.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SCCell
        cell.setupCell(track[indexPath.row])
        block = {
            cell.layer.addSublayer($0)
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PlayerId") as! SCPlayerVC
        presentViewController(vc, animated: true, completion: nil)
    }
}
