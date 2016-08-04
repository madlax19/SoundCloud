// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SCLogin.swift instead.

import Foundation
import CoreData

public enum SCLoginAttributes: String {
    case password = "password"
    case userToken = "userToken"
    case username = "username"
}

public class _SCLogin: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Login"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _SCLogin.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var password: String?

    @NSManaged public
    var userToken: NSNumber?

    @NSManaged public
    var username: String?

    // MARK: - Relationships

}

