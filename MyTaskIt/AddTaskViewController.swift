//
//  AddTaskViewController.swift
//  MyTaskIt
//
//  Created by Frederico Schnekenberg on 20/05/15.
//
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    func addTask(message: String)
    func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {
    
    // property to access all the elements o the view controller
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var delegate: AddTaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTaskCanceled("Task was not added!")
    }
    
    @IBAction func addTaskButtonPressed(sender: UIButton) {

        let appDelegate = (UIApplication.sharedApplication()).delegate as! AppDelegate
        
        // Refactored for iCloud: changed appDelegate.managedObjectContext to ModelManager.instance.managedObjectContext
        let managedObjectContext = ModelManager.instance.managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        // Capitalize the first letters of a task
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) {
            task.task = taskTextField.text.capitalizedString
        } else {
            task.task = taskTextField.text
        }
        
        task.subTask = subTaskTextField.text
        task.date = dueDatePicker.date
        
        // Set a completed task
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) {
            task.isCompleted = true
        } else {
            task.isCompleted = false
        }
        
        // Refactored for iCloud support: appDelegate.saveContext()
        ModelManager.instance.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
    
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task added!")
        
    }
    
}
