//
//  SCRestKitManager.swift
//  SoundCloud
//
//  Created by sasha ataman on 04.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit
import RestKit

class SCRestKitManager: NSObject {
    let baseURL = (NSBundle.mainBundle().objectForInfoDictionaryKey("APP_SERVER") as! String)
    
    static let sharedManager = SCRestKitManager()
    var managedObjectContext: NSManagedObjectContext {
        get {
            return RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext
        }
    }

    
    override init() {
        super.init()
        let pathToPersistentStore = "\(RKApplicationDataDirectory())/SoundCloud.sqlite"
        RKlcl_configure_by_name("RestKit/Network", RKlcl_vTrace.rawValue);
        let managedObjectStore = RKManagedObjectStore(managedObjectModel: NSManagedObjectModel.mergedModelFromBundles(nil))
        managedObjectStore.createPersistentStoreCoordinator()
        do {
            _ = try managedObjectStore.addSQLitePersistentStoreAtPath(pathToPersistentStore, fromSeedDatabaseAtPath: nil,  withConfiguration:nil,  options:nil);
        } catch {
            print(error)
        }
        RKLogConfigureFromEnvironment()
        managedObjectStore.createManagedObjectContexts()
        managedObjectStore.managedObjectCache = RKInMemoryManagedObjectCache(managedObjectContext: managedObjectStore.persistentStoreManagedObjectContext)
        
        // Initialize RestKit for server cooperat ion:
        let manager = RKObjectManager(baseURL: NSURL(string: baseURL))
        manager.requestSerializationMIMEType = RKMIMETypeJSON
        manager.managedObjectStore = managedObjectStore
        
        manager.addResponseDescriptor(RKResponseDescriptor(mapping: SCTracks.mappingInStore(managedObjectStore), method: .GET, pathPattern: Constaints.Path.trackPath, keyPath: "", statusCodes: RKStatusCodeIndexSetForClass(.Successful)))
        
        RKObjectManager.setSharedManager(manager)

    }
}
