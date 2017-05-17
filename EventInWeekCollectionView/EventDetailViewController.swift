import UIKit

class EventDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var buttonSave: UIBarButtonItem!
    
    var dayOfWeek = [String]()
    var monthOfYear = [String]()
    struct dateSystemStruct {
        var dayOfWeek = ""
        var date = ""
    }
    
    var systemDate = dateSystemStruct()
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init day of week and month
        dayOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        monthOfYear = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        // Init system date
        systemDate = useSystemDate()
        // Handle the text field’s user input through delegate callbacks.
        textFieldTitle.delegate = self
        // Use system date
        // Set up views if editing an existing Event.
        if let event = event {
            navigationItem.title = event.title
            textFieldTitle.text = event.title
            textViewContent.text   = event.content
            labelDate.text = event.dayOfWeek + ", " + event.date
            
            textFieldTitle.isUserInteractionEnabled = false
            textViewContent.isUserInteractionEnabled = false
            buttonSave.isEnabled = false
        }
        else {
            labelDate.text = systemDate.dayOfWeek + ", " + systemDate.date
            // Enable the Save button only if the text field has a valid Meal name.
            updateSaveButtonState()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    // MARK: - Navigation
    @IBAction func buttonCancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === buttonSave else {
            return
        }
        
        let title = textFieldTitle.text ?? ""
        let content = textViewContent.text  ?? ""
        let dayOfWeek = systemDate.dayOfWeek
        let date = systemDate.date
        
        event = Event(title: title, content: content, dayOfWeek: dayOfWeek, date: date)
    }
    
    //MARK: UITextFieldDelegate 
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        buttonSave.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = textFieldTitle.text ?? ""
        buttonSave.isEnabled = !text.isEmpty
    }
    
    private func useSystemDate() -> dateSystemStruct{
        let date = Date()
        let calendar = Calendar.current
        let dayOfWeekNum = Int(calendar.component(.weekdayOrdinal, from: date))
        let monthOfYearNum = calendar.component(.month, from: date)
        var result = dateSystemStruct()
        
        var dayOfWeek: String
        var dateSystem: String
        
        dayOfWeek = self.dayOfWeek[dayOfWeekNum]
        
        dateSystem = monthOfYear[monthOfYearNum] + " "
        dateSystem += String(calendar.component(.day, from: date)) + ", "
        dateSystem += String(calendar.component(.year, from: date))
        
        result.dayOfWeek = dayOfWeek
        result.date = dateSystem
        
        return result
    }
}
