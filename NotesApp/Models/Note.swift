//
//  Note.swift
//  NotesApp
//
//  Created by Владимир Тимофеев on 11.02.2022.
//

import Foundation

struct Note: Codable {
    var title: String?
    var body: String?
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
