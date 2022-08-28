//
//  ViewController.swift
//  NoteAppHw
//
//  Created by salo khizanishvili on 26.08.22.
//

import UIKit
import CoreData

class DetailsVCNote: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var descriptionTxtVw: UITextView!
    
    var selectNote : Note? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectNote != nil){
            titleTxtFld.text = selectNote?.title
            descriptionTxtVw.text = selectNote?.descript
        }
        
    }

    @IBAction func saveBtn(_ sender: Any) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            if(selectNote == nil){
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let myNote = Note(entity: entity!, insertInto: context)
            myNote.id = myNotes.count as NSNumber
            myNote.title = titleTxtFld.text
            myNote.descript = descriptionTxtVw.text
            do{
                try context.save()
                myNotes.append(myNote)
                navigationController?.popViewController(animated: true)
            }
            catch{
                print("error")
            }
        }
        else{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    if(note == selectNote){
                        note.title = titleTxtFld.text
                        note.descript = descriptionTxtVw.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch{
                print("failed")
            }
        }
        
        LocalLocationManager.register(notification: LocalNotification(id: UUID().uuidString , title: "your edited notes are saved", message: "see more"), duration: 5, repeats: false, userInfo: ["name": [1]])
    }
    
    
    @IBAction func noteDeleteBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                if(note == selectNote){
                    note.delete = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch{
            print("failed")
        }
        
        LocalLocationManager.register(notification: LocalNotification(id: UUID().uuidString , title: "you deleted note", message: "see more"), duration: 5, repeats: false, userInfo: ["name": [1]])
    }
    
    @IBAction func favouriteBtn(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                if(note == selectNote){
                        note.isFavourite = true
                        try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch{
            print("failed")
        }
        
        LocalLocationManager.register(notification: LocalNotification(id: UUID().uuidString , title: "you add note to favourites", message: "see more"), duration: 5, repeats: false, userInfo: ["name": [1]])
    }
    
    
    @IBAction func notFavBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                if(note == selectNote){
                        note.isFavourite = false
                        try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch{
            print("failed")
        }
        
        LocalLocationManager.register(notification: LocalNotification(id: UUID().uuidString , title: "you delete note from favourites", message: "see more"), duration: 5, repeats: false, userInfo: ["name": [1]])
    }
    
}

