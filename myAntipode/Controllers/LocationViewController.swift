import UIKit
import CoreData

// MARK: - Primary
class LocationViewController: UITableViewController {
    
    var savedLocations = [SavedLocation]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadSavedLocations()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new saved location", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add saved location", style: .default) { (action) in
            let newSavedLocation = SavedLocation(context: self.context)
            newSavedLocation.name = textField.text!
            newSavedLocation.latitude =  32.063956
            newSavedLocation.longitude = -64.863281
            
            self.savedLocations.append(newSavedLocation)
            self.saveSavedLocations()
            print("Success!")
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new saved location"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MapViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedSavedLocation = savedLocations[indexPath.row]
        }
    }
}

// MARK: - Table view
extension LocationViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        let savedLocation = savedLocations[indexPath.row]
        
        cell.textLabel?.text = savedLocation.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMap", sender: self)
    }
}


// MARK: - Persistence
extension LocationViewController {
    
    func saveSavedLocations() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadSavedLocations(with request: NSFetchRequest<SavedLocation> = SavedLocation.fetchRequest()) {
        do {
            savedLocations = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }

}

// MARK: -  Generated by Xcode
extension LocationViewController {
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
