//
//  ViewController.swift
//  766345_LA2
//
//  Created by Amanpreet Kaur on 2020-01-20.
//  Copyright © 2020 Amanpreet Kaur. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
     var tasks : [Task]?
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addDaysLabel: UILabel!
   
    @IBOutlet weak var descLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCoreData()
        // Do any additional setup after loading the view.
        
}
    
    
    
func saveCoreData() {
   
let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
let context = appDelegate.persistentContainer.viewContext
        
       
            
    let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "TasksModel", into: context)
    taskEntity.setValue("\(textFields[0].text!)", forKey: "task")
    taskEntity.setValue(Int(textFields[1].text!) ?? 0 , forKey: "days")
    taskEntity.setValue(NSDate() as! Date, forKey: "date")
    taskEntity.setValue("\(descLabel.text)", forKey: "desc")
            
            do{
                try context.save()
                print(taskEntity)
            } catch {
                print(error)
            }
            
        loadCoreData()
        
    }
    
    func loadCoreData(){
        
        tasks = [Task]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
       
let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TasksModel")
        
        
        
        do{
        let results = try context.fetch(request)
        if results is [NSManagedObject] {
            
            for result in results as! [NSManagedObject]{
                
                let task = result.value(forKey: "task") as! String
                let days = result.value(forKey: "days") as! Int
                let date = result.value(forKey: "date") as! Date
                let desc = result.value(forKey: "desc") as! String
                
                tasks?.append(Task(tasks: task, days: days, date: date, desc: desc))
                
                
                
            }
                
            }
            
        } catch{
            
            print(error)
        }
        
}
    
    

    @IBAction func savetask(_ sender: UIBarButtonItem) {
        
        saveCoreData()
    }
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
if let task_table = segue.destination as? TaskTableVC {
            task_table.tasks = self.tasks
    task_table.tableView.reloadData()
    
        }
        
    }
    
    
    
}

