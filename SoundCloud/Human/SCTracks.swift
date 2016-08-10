import Foundation
import RestKit

private var map: RKEntityMapping?
private var onceToken: dispatch_once_t = 0

@objc(SCTracks)
public class SCTracks: _SCTracks {
    class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        dispatch_once(&onceToken, {
            let mapping = RKEntityMapping(forEntityForName: SCTracks.entityName(), inManagedObjectStore: managedObjectStore)
            mapping.addAttributeMappingsFromArray(["duration", "genre", "title"])
            mapping.addAttributeMappingsFromDictionary([
                "created_at" : "createdAt",
                "stream_url" : "streamUrl",
                "artwork_url" : "artworkUrl",
                "user_id" : "userId"
                ])
            map = mapping
        })
        return map!
    }

}
