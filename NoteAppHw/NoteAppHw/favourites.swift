//
//  favourites.swift
//  NoteAppHw
//
//  Created by salo khizanishvili on 26.08.22.
//

import UIKit
import CoreData

var favNotes = [Note]()

class favourites: UITableViewController{
    
    func favouriteNotes() -> [Note]{
        var favouriteNotes = [Note]()
        for note in myNotes {
            if(note.delete == nil){
                favouriteNotes.append(note)
            }
        }
        return favouriteNotes
    }
    
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)as! favouritesCellNote
        let note: Note!
        note = favouriteNotes()[indexPath.row]
        cell.favouriteTtl.text = note.title
        cell.favouriteDscp.text = note.descript
        cell.heartOfFav.tintColor = .red
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteNotes().count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}
