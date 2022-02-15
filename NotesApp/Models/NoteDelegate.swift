//
//  NoteDelegate.swift
//  NotesApp
//
//  Created by Владимир Тимофеев on 15.02.2022.
//

import Foundation

protocol NoteDelegate: AnyObject {
    func passNote(note: Note, at indexPath: IndexPath?)
}
