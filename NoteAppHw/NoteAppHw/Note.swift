//
//  Note.swift
//  NoteAppHw
//
//  Created by salo khizanishvili on 26.08.22.
//

import CoreData

@objc(Note)
class Note: NSManagedObject {
    @NSManaged var isFavourite: Bool
    @NSManaged var title: String!
    @NSManaged var descript: String!
    @NSManaged var delete: Date!
    @NSManaged var id: NSNumber!
}
