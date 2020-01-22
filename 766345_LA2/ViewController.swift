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
    var t_Vc = ""
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addDaysLabel: UILabel!
   
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addedDaysField: UITextField!
    @IBOutlet weak var descLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var ta = UITapGestureRecognizer(target: self, action: #selector(self.diss))
             self.view.addGestureRecognizer(ta)
        
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                       
    let context = appDelegate.persistentContainer.viewContext
    
                
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TasksModel")
        request.predicate = NSPredicate(format: "task contains %@", t_Vc)
        request.returnsObjectsAsFaults = false
        do{
            let data = try context.fetch(request)
            for object in data as! [NSManagedObject]
            {
                
    textFields[0].text = object.value(forKey: "task") as! String
    textFields[1].text = "\(object.value(forKey: "days")!)"
    descLabel.text = object.value(forKey: "desc") as! String
    timeLabel.text = "\(object.value(forKey: "date")!)"
                
                
                
                
                
            }
        } catch{
            
            print(error)
        }
        
        
        
        
        
        
        
        
        
        loadCoreData()
        // Do any additional setup after loading the view.
        
}
    
    @objc func diss(){
        descLabel.resignFirstResponder()
      }
    
func saveCoreData() {
   
let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
let context = appDelegate.persistentContainer.viewContext
        
       
            
    let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "TasksModel", into: context)
    taskEntity.setValue("\(textFields[0].text!)", forKey: "task")
    taskEntity.setValue(Int(textFields[1].text!) ?? 0 , forKey: "days")
    taskEntity.setValue(NSDate() as! Date, forKey: "date")
    taskEntity.setValue("\(descLabel.text!)", forKey: "desc")
            
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
        
        let request = NSFetchRequest<NSFetchRequestResult>(
       entityName: "TasksModel")
        
        
        
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
        
        if textFields[0].text == "" || textFields[1].text == "" || descLabel.text == "" {
            
       
    let alertController = UIAlertController(title: "Empty Fields", message:"All fields are mandatory", preferredStyle: .alert)
        
    alertController.addAction(UIAlertAction(title: "OK", style: .default))

    self.present(alertController, animated: true, completion: nil)
        
        
        
        }
        
        
        
        saveCoreData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
      if let task_table = segue.destination as? TaskTableVC {
      task_table.tasks = self.tasks
      task_table.tableView.reloadData()
    
        }
        
    }
    
    
    
}

