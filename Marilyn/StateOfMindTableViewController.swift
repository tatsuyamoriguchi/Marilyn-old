//
//  StateOfMindTableViewController.swift
//  Marilyn
//
//  Created by Tatsuya Moriguchi on 4/27/19.
//  Copyright © 2019 Becko's Inc. All rights reserved.
//

import UIKit
import CoreData

class StateOfMindTableViewController: UITableViewController {

    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResultsController()
        
        tableView.dataSource = self
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func configureFetchedResultsController() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // Create the fetch request, set some sort descriptor, then feed the fetchedResultsController
        // the request with along with the managed object context, which we'll use the view context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StateOfMindDesc")
        let sortDescriptorRate = NSSortDescriptor(key: "rate", ascending: false)
        let sortDescriptorAdjective = NSSortDescriptor(key: "adjective", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptorRate, sortDescriptorAdjective]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: "rate", cacheName: nil)
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
 
    @IBAction func addNewOnPressed(_ sender: UIBarButtonItem) {
    
        let alertController = UIAlertController(title: "Add New", message: "Add an adjective which the best descibes your current state of mind if you can't find one in the existing list.", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            
            let newAdjective = alertController.textFields![0]
            let newRate = alertController.textFields![1]

        
        
/*            let itemToAdd = alertController.textFields?[0].text
            let rateToAdd = alertController.textFields?[1].text
            print("itemToAdd = \(String(describing: itemToAdd))")
*/
            let itemToAdd = newAdjective.text
            let rateToAdd = newRate.text

            self.save(itemName: itemToAdd!, itemRate: rateToAdd!) // Later add no-nil validation
        
        })
        
        
        
            alertController.addTextField { (textField: UITextField) in
            //    textField.text = ""
                textField.placeholder = "Adjective"
            }
            
            alertController.addTextField { (textField: UITextField) in
              //  textField.text = ""
                textField.placeholder = "Rate"
            }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //alertController.addTextField(configurationHandler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
     
  
            
/*            guard let textField = alertController.textFields?[0], let itemToAdd = textField.text else { print("What? error")
                return }
            guard let rateField = alertController.textFields?[1], let rateToAdd = rateField.text else { print("Error rateToAdd")
                return
            }
  */

        
    }

    func save(itemName: String, itemRate: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "StateOfMindDesc", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(itemName, forKey: "adjective")
        let newRate = Int16(itemRate)
        item.setValue(newRate, forKey: "rate")
        
        do {
            try managedContext.save()
           
        } catch {
            print("Failed to save an item: \(error.localizedDescription)")
        }
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        guard let sections = fetchedResultsController?.sections else {
            return 0
        }
        //print("sections.count: \(sections.count)")
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else {
            return 0
        }
        let rowCount = sections[section].numberOfObjects
        print("The amount of rows in the section are: \(rowCount)")

        
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let StateOfMindCell = tableView.dequeueReusableCell(withIdentifier: "StateOfMindCell", for: indexPath)
        if let stateOfMindDesc = fetchedResultsController?.object(at: indexPath) as? StateOfMindDesc {
            StateOfMindCell.textLabel?.text = stateOfMindDesc.adjective
            StateOfMindCell.detailTextLabel?.text = stateOfMindDesc.rate as AnyObject as? String
        }


        return StateOfMindCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let sections = fetchedResultsController?.sections {
            let currentSection = sections[section]
            
/*            // Populate an array for segue, toEditWordSegue
            if rate.contains(currentSection.name) {
            } else {
                rate.append(currentSection.name)
            }
  */
            return "State of Mind Rate: " + currentSection.name
            
        }
        
        return nil
        
    }

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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StateOfMindTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("The Controller Content Has Changed.")
        tableView.reloadData()
    }
    
}
