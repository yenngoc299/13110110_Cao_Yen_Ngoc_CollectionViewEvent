import UIKit
import os.log

private let reuseIdentifier = "Cell"

class EventCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    var events = [[Event]]()
    var EventDayOfWeek = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Data of Collection view cell
        initEvents()
        EventDayOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddEvent":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let eventDetailViewController = segue.destination as? EventDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEventCell = sender as? EventCollectionViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = collectionView!.indexPath(for: selectedEventCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedEvent = events[indexPath.section][indexPath.row]
            eventDetailViewController.event = selectedEvent
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //let numOfSec = events[section].count
        return events[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! EventCollectionViewCell
        //
        let event = events[indexPath.section][indexPath.row]
        // Cell configure:
        let eventTitle = cell.labelTitleEvent!
        eventTitle.text = event.title
        
        let eventSortContent = cell.labelSortContentEvent!
        eventSortContent.text = event.content
        
        let eventDate = cell.labelDateEvent!
        eventDate.text = event.date
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let dayOfWeek = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                        withReuseIdentifier: "headerDayOfWeek",
                                                                        for: indexPath) as! EventCollectionReusableView
        dayOfWeek.backgroundColor = UIColor.white
        dayOfWeek.labelDayOfWeek.text = EventDayOfWeek[indexPath.section]
        return dayOfWeek
    }
    
    private func initEvents() {
        //        guard let event1 = Event(title: "Event 1", content: "Content 1", dayOfWeek: "Monday", date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event2 = Event(title: "Event 1", content: "Content 1", dayOfWeek: "Monday",  date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event3 = Event(title: "Event 1", content: "Content 1", dayOfWeek: "Monday", date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event4 = Event(title: "Event 1", content: "Content 1", dayOfWeek: "Monday", date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event5 = Event(title: "Event 2", content: "Content 1", dayOfWeek: "Monday",  date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event6 = Event(title: "Event 2", content: "Content 1", dayOfWeek: "Monday", date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event7 = Event(title: "Event 2", content: "Content 1", dayOfWeek: "Monday", date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event8 = Event(title: "Event 2", content: "Content 1", dayOfWeek: "Monday",  date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let event9 = Event(title: "Event 2", content: "Content 1", dayOfWeek: "Monday", date: "1/5/2017") else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        
        events.append([])
        events.append([])
        events.append([])
        events.append([])
        events.append([])
        events.append([])
        events.append([])
    }
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EventDetailViewController, let event = sourceViewController.event {
            // Add a new event.
            let dayOfWeek = event.dayOfWeek
            var section: Int
            switch dayOfWeek {
            case "Sunday":
                section = 0
            case "Monday":
                section = 1
            case "Tuesday":
                section = 2
            case "Wednesday":
                section = 3
            case "Thursday":
                section = 4
            case "Friday":
                section = 5
            case "Saturday":
                section = 6
            default:
                section = 0
            }
            
            let newIndexPath = IndexPath(row: events[section].count, section: section)
            
            events[section].append(event)
            collectionView?.insertItems(at: [newIndexPath])
        }
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
