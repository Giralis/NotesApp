//
//  NoteController.swift
//  NotesApp
//
//  Created by Владимир Тимофеев on 15.02.2022.
//

import Foundation

class NoteController {
    let defaults = UserDefaults.standard
    
    func fetchNotes(completion: @escaping ([Note]?) -> Void) {
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                let notes = try jsonDecoder.decode([Note].self, from: savedNotes)
                completion(notes)
            } catch {
                completion(nil)
                print("Failed to load")
            }
        }
    }
    
    func saveNotes(notes: [Note]) {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save")
        }
    }
}
