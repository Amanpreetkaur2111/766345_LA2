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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
}
    
    
    
func saveCoreData() {
    // print("hi")
let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
let context = appDelegate.persistentContainer.viewContext
        
       
            
    let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "TasksModel", into: context)
    taskEntity.setValue("\(textFields[0].text)", forKey: "tasks")
    taskEntity.setValue(textFields[1].text , forKey: "days")
            
            do{
                try context.save()
                print(taskEntity)
            } catch {
                print(error)
            }
            
        
        
               
        
        
    }
    
    
    
    func loadCoreData(){
        
        tasks = [Task]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        
        
        
        
        
    }
    
    


    @IBAction func addTasks(_ sender: UIBarButtonItem) {
       // print("hi")
        saveCoreData()
//        let task = textFields[0].text ?? ""
//        let days = Int(textFields[1].text ?? "0") ?? 0
//
//        let t_task = Task(tasks: task, days: days)
//        tasks?.append(t_task)
//
//        for textField in textFields {
//
//
//            textField.text = ""
//            textField.resignFirstResponder()
//        }
    }
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
if let task_table = segue.destination as? TaskTableVC {
            task_table.tasks = self.tasks
        }
        
    }
    
    
    
}

