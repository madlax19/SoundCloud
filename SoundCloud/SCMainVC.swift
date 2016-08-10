
//
//  SCMainVC.swift
//  SoundCloud
//
//  Created by sasha ataman on 03.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


var track: SCTracks?

class SCMainVC: UICollectionViewController, NSFetchedResultsControllerDelegate {
    //var track = [SCTracks]()
    var track: SCTracks?
    var audioPlayer: AVPlayer?
    var audioItem: AVPlayerItem?
    var playerIndexPath: Int?
    let trackManager : SCTracks! = nil
    
    lazy var fetchResultController: NSFetchedResultsController = {
        let moc : NSManagedObjectContext = SCRestKitManager.sharedManager.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: SCTracks.entityName())
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "userId=%@", track)
        
        var fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTrack()
    }
    
    @objc private func fetchTrack(){
        SCRequestHelper.trackRequest({
            self.track += $0
            SCRestKitManager.saveContext()
            self.collectionView?.reloadData()
            }, failed: {
                print("error")
        })
    }

}


extension SCMainVC {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.fetchResultController.fetchedObjects?.count)!
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SCCell
        cell.setupCell((self.fetchResultController.fetchedObjects?.first as? SCTracks)!)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PlayerId") as! SCPlayerVC
        vc.track = track[indexPath.row]
        presentViewController(vc, animated: true, completion: nil)
    }
}
