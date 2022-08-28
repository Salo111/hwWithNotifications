//
//  TableViewNote.swift
//  NoteAppHw
//
//  Created by salo khizanishvili on 26.08.22.
//

import UIKit
import CoreData

var myNotes = [Note]()

class TableViewNote: UITableViewController{
    
    var load = true
    
    func notesThatAreNotDeleted() -> [Note]{
        var notesThatAreNotDeleted = [Note]()
        for note in myNotes {
            if(note.delete == nil){
                notesThatAreNotDeleted.append(note)
            }
        }
        return notesThatAreNotDeleted
    }
    
    
    override func viewDidLoad() {
        if(load){
            load = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    myNotes.append(note)
                }
            }
            catch{
                print("failed")
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! CellNote
        let note: Note!
        note = notesThatAreNotDeleted()[indexPath.row]
        cell.noteTitleLbl.text = note.title
        cell.noteDescriptionLbl.text = note.descript
        if(note.isFavourite == true){
            cell.heartBtn.tintColor = .red
        }
        if(note.isFavourite == false){
            cell.heartBtn.tintColor = .black
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesThatAreNotDeleted().count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editNote"){
            let indexPath = tableView.indexPathForSelectedRow!
            let noteDeTail = segue.destination as? DetailsVCNote
            let selectNote : Note!
            selectNote = notesThatAreNotDeleted()[indexPath.row]
            noteDeTail!.selectNote = selectNote
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
