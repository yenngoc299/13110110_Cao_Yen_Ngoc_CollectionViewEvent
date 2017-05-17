import UIKit

class Event {

    //MARK: Properties
    
    var title: String
    var content: String
    var dayOfWeek: String
    var date: String
    
    //MARK: Archiving Paths
//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
//    
//    //MARK: Types
//    
//    struct PropertyKey {
//        static let name = "name"
//        static let photo = "photo"
//        static let rating = "rating"
//    }
    
    //MARK: Initialization
    
    init?(title: String, content: String, dayOfWeek: String, date: String) {
        
        // The title must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // The dayOfWeek must not be empty
        guard !dayOfWeek.isEmpty else {
            return nil
        }
        
        // The date must not be empty
        guard !date.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.content = content
        self.dayOfWeek = dayOfWeek
        self.date = date
        
    }
    
    //MARK: NSCoding
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: PropertyKey.name)
//        aCoder.encode(photo, forKey: PropertyKey.photo)
//        aCoder.encode(rating, forKey: PropertyKey.rating)
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        
//        // The name is required. If we cannot decode a name string, the initializer should fail.
//        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
//            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
//            return nil
//        }
//        
//        // Because photo is an optional property of Meal, just use conditional cast.
//        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
//        
//        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
//        
//        // Must call designated initializer.
//        self.init(name: name, photo: photo, rating: rating)
//        
//    }
}
