//
//  SCPlayerVC.swift
//  SoundCloud
//
//  Created by sasha ataman on 08.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SCPlayerVC: UIViewController {
    
    private var avPlayer: AVPlayer?
    private var avItem: AVPlayerItem?
    private var currentSeconds: Float = 0.0
    private var currentMinutes: Int = 0
    private var timeObserver: AnyObject?
    var playerLayer: AVPlayerLayer?
    var track: SCTracks?
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var genreLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackName.text = track?.title
        durationLabel.text = "00 : 00"
        if track?.streamUrl != nil {
            musicParametrs(track!.streamUrl! + "?client_id=\(Constaints.Path.clientId)")
        } else {
            let alert = UIAlertController(title: "No podcast", message: "This user not have podcast", preferredStyle: .Alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .Default, handler: {
                action in self.closeVC()
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        setImageWidthUrl()
        playerObserver()
        addNavigationBar()
        genreSetUp()
    }
    
    func addNavigationBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Player");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: #selector(closeVC));
        navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false)
    }
    
    func closeVC() {
        avPlayer?.removeTimeObserver(timeObserver!)
        avPlayer?.pause()
        playerLayer?.removeFromSuperlayer()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setImageWidthUrl() {
        if let image = track?.artworkUrl{
            trackImageView.sd_setImageWithURL(NSURL(string: image))
        }else {
            trackImageView.image = UIImage(named: "defaultImage")
        }
    }
    
    func playerObserver() {
        timeObserver = avPlayer?.addPeriodicTimeObserverForInterval(CMTimeMakeWithSeconds(1.0 / 60.0, Int32(NSEC_PER_SEC)), queue: nil, usingBlock: {
            time in
            self.positionChanged()
            self.durationLabel.text = "0\(Int(self.currentSeconds / 60)) : \(self.currentSeconds % 60)"
        })

    }
    
    func genreSetUp() {
        if track?.genre != nil{
            var genreL = ""
            for item in  SCGenreManager.sharedInstance.addHashtagToGenre(genre: (track?.genre)!){
                if item == SCGenreManager.sharedInstance.addHashtagToGenre(genre: (track?.genre)!).first{
                    genreL += item
                }else {
                    genreL += " \(item)"
                }
            }
            genreLable.text = genreL
        }
    }
    
    func musicParametrs(url: String) {
        avItem = AVPlayerItem(URL: NSURL(string: url)!)
        avPlayer = AVPlayer(playerItem: avItem!)
        playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer!.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
        self.view.layer.addSublayer(playerLayer!)
    }
    
    func positionChanged() {
        let duration = (track?.duration)!.floatValue / 1000.0
        currentSeconds = Float((avPlayer?.currentTime().value)! / Int64((avPlayer?.currentTime().timescale)!))
        let value =  currentSeconds / duration
        trackSlider.value = value
    }
    
    @IBAction func stopMusicButton(sender: AnyObject) {
        let timeScale = self.avPlayer!.currentItem!.asset.duration.timescale;
        let time = CMTimeMakeWithSeconds(0, timeScale);
        avPlayer?.seekToTime(time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        playButton.setBackgroundImage(UIImage(named: "play"), forState: .Normal)
        avPlayer?.pause()
    }
    
    @IBAction func playMusicButton(sender: AnyObject) {
        if avPlayer?.rate == 0{
            avPlayer?.play()
            print(avPlayer?.currentTime().seconds)
            playButton.setBackgroundImage(UIImage(named: "pause"), forState: .Normal)
        }else {
            avPlayer?.pause()
            playButton.setBackgroundImage(UIImage(named: "play"), forState: .Normal)
        }
    }
    
    @IBAction func sliderAction(sender: AnyObject) {
        let seconds = Double(trackSlider.value * ((track?.duration?.floatValue)! / 1000.0))
        let timeScale = self.avPlayer!.currentItem!.asset.duration.timescale;
        let time = CMTimeMakeWithSeconds(seconds, timeScale);
        avPlayer?.seekToTime(time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    }
}
