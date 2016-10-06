import CoreData

class Note: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var content: String
}
