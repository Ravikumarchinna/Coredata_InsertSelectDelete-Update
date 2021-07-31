//
//  ViewController.swift
//  CoredataInsertSelectDelete&Update
//
//  Created by Ravikumar on 12/07/18.
//  Copyright © 2018 Ravikumar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var txtf_name: UITextField!
    @IBOutlet var txtf_email: UITextField!
    @IBOutlet var txtf_dateofbirth: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtf_name.delegate=self
        txtf_email.delegate=self
        txtf_dateofbirth.delegate=self
        
    }
    
    func managedObject12() -> NSManagedObjectContext {
         let appDelegate = UIApplication.shared.delegate as? AppDelegate //else { return }
        let managedContext = appDelegate?.persistentContainer.viewContext
        return managedContext!
    }
    
    @IBAction func btn_insertAction(_ sender: Any) {
        
       // guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
      //  let managedContext = appDelegate.persistentContainer.viewContext
        let getmanagedObject = self.managedObject12()
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: getmanagedObject)!
        let user = NSManagedObject(entity: userEntity, insertInto: getmanagedObject)

            user.setValue(self.txtf_name.text, forKeyPath: "name")
            user.setValue(self.txtf_email.text, forKey: "email")
            user.setValue(self.txtf_dateofbirth.text, forKey: "dateofbirth")
            do {
                try getmanagedObject.save()
               
            } catch {
                fatalError("Failure to save context: \(error)")
            }

        
        
    }
    @IBAction func btn_selectAction(_ sender: Any) {

        let managedContext = self.managedObject12()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
      //  request.fetchLimit=1
        request.returnsObjectsAsFaults = false
        request.resultType = NSFetchRequestResultType.dictionaryResultType
     //   request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: false)]
    //    request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))]
        do {
            let result = try managedContext.fetch(request)
        for data in result {
            print("\(data)")
        }

        } catch {
            
            print("Failed")
        }
        
    }
    @IBAction func btn_deleteAction(_ sender: Any) {
        let managedContext = self.managedObject12()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "ntr")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects as! [NSManagedObject] {
                managedContext.delete(object)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func btn_updateAction(_ sender: Any) {
        
        let managedContext = self.managedObject12()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Ravi")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects as! [NSManagedObject] {
                object.setValue("ravi NTR", forKey: "name")
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
       
}
    
    
    
    
    
    
    
    
    
    
    
    

    // MARK: Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

