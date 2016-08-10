// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SCTracks.swift instead.

import Foundation
import CoreData

public enum SCTracksAttributes: String {
    case artworkUrl = "artworkUrl"
    case createdAt = "createdAt"
    case duration = "duration"
    case genre = "genre"
    case streamUrl = "streamUrl"
    case title = "title"
    case userId = "userId"
}

public class _SCTracks: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Tracks"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _SCTracks.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var artworkUrl: String?

    @NSManaged public
    var createdAt: String?

    @NSManaged public
    var duration: NSNumber?

    @NSManaged public
    var genre: String?

    @NSManaged public
    var streamUrl: String?

    @NSManaged public
    var title: String?

    @NSManaged public
    var userId: String?

    // MARK: - Relationships

}

