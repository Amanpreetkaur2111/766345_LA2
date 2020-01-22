//
//  TaskTableVC.swift
//  766345_LA2
//
//  Created by Amanpreet Kaur on 2020-01-20.
//  Copyright © 2020 Amanpreet Kaur. All rights reserved.
//

import UIKit
import CoreData

class TaskTableVC: UITableViewController,UISearchBarDelegate {
    
    var tasks : [Task]?

    @IBOutlet weak var searchbarLabl: UISearchBar!
    override func viewDidLoad() {
    super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
           self.navigationItem.rightBarButtonItem = self.editButtonItem
        
               searchbarLabl.delegate = self
        
     
    }
    
  
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        

   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
        
        tasks = []
     let context = appDelegate.persistentContainer.viewContext
     
                 
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TasksModel")
         request.predicate = NSPredicate(format: "task contains[c] %@", searchText)
         request.returnsObjectsAsFaults = false
         do{
             let data = try context.fetch(request)
             for object in data as! [NSManagedObject]
             {
                
                let task = object.value(forKey: "task") as! String
                let days = object.value(forKey: "days") as! Int
                let date = object.value(forKey: "date") as! Date
                let desc = object.value(forKey: "desc")  as! String
                
                let t = Task(tasks: task, days: days, date: date, desc: desc)
                    
                tasks?.append(t)
                
                
                tableView.reloadData()
                           }
                           
         } catch
                    {
                           
            print(error)
                        
                       }
                 
//     textFields[0].text = object.value(forKey: "task") as! String
//     textFields[1].text = "\(object.value(forKey: "days")!)"
//     descLabel.text = object.value(forKey: "desc") as! String
//     timeLabel.text = "\(object.value(forKey: "date")!)"
                 
                 
    }
    
    

    // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks?.count ?? 0
    }

    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let task = tasks![indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "taskTable")
        cell?.textLabel?.text = task.tasks
        cell?.detailTextLabel?.text = "\(task.days) days needed"
        
        if task.days == 0 {
            cell?.contentView.backgroundColor = .cyan
            cell?.detailTextLabel?.text = "Completed👍🏻"
            
        }
        else {
            cell?.contentView.backgroundColor = .gray
        }
            cell?.textLabel?.textColor = .white

        
        
        // Configure the cell...

        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {
        (action, view, success) in self.tasks?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
            
    })
        
        let AddDayAction = UIContextualAction(style: .normal, title: "Add a Day") {
            (action , view, success) in
            
            self.tasks![indexPath.row].days -= 1
            self.tableView.reloadData()
            
            
        }
        
        AddDayAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [deleteAction , AddDayAction])
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {
        (action, view, success) in self.tasks?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
                   
           })
               
        let AddDayAction = UIContextualAction(style: .normal, title: "Add a Day") {
        (action , view, success) in
        self.tasks![indexPath.row].days -= 1
        self.tableView.reloadData()
        }
        
        AddDayAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [deleteAction , AddDayAction])
               
       }
    
      override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath:IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let move = self.tasks![sourceIndexPath.row]
        tasks!.remove(at: sourceIndexPath.row)
        tasks!.insert(move, at: destinationIndexPath.row)
    }
    
    
    @IBAction func SortTasks(_ sender: Any) {
        
        
    tasks = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRqst = NSFetchRequest<NSFetchRequestResult>(entityName: "TasksModel")
    fetchRqst.sortDescriptors = [NSSortDescriptor(key: "task", ascending: true)]
        
     do{
        
      let results = try context.fetch(fetchRqst)
    if results is [NSManagedObject]{
            
    for result  in results as! [NSManagedObject]{
    
    let task = result.value(forKey: "task") as! String
                
    let days = result.value(forKey: "days") as! Int
                
    let date = result.value(forKey: "date") as! Date
                
    let desc = result.value(forKey: "desc") as! String
                
    tasks?.append(Task(tasks: task, days: days, date: date , desc: desc))
    tableView.reloadData()
                
                
            }
        }
        
        
}  catch {
    
    print(error)
        
    }
    
    
    }
    
    
    @IBAction func dateSort(_ sender: UIBarButtonItem) {
        
        
       
        tasks = []
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRqst = NSFetchRequest<NSFetchRequestResult>(entityName: "TasksModel")
            fetchRqst.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                
             do{
                
              let results = try context.fetch(fetchRqst)
            if results is [NSManagedObject]{
                    
            for result  in results as! [NSManagedObject]{
            
            let task = result.value(forKey: "task") as! String
                        
            let days = result.value(forKey: "days") as! Int
                        
            let date = result.value(forKey: "date") as! Date
                        
            let desc = result.value(forKey: "desc") as! String
                        
            tasks?.append(Task(tasks: task, days: days, date: date , desc: desc))
            tableView.reloadData()
                        
                        
                    }
                }
                
                
        }  catch {
            
            print(error)
                
            }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ViewController{
            
            
            if let cell = sender as? UITableViewCell{
                
        let task_title = tasks?[tableView.indexPath(for: cell)!.row].tasks as! String
                destination.t_Vc = task_title
            }
            
        }
        
        
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    


}
