//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Владимир Тимофеев on 11.02.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    weak var noteDelegate: NoteDelegate?
    var note: Note?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setBody()
        setNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNote()
        guard let note = note else { return }
        noteDelegate?.passNote(note: note, at: indexPath)
    }
    
    func setNote() {
        guard let title = titleTextField.text else { return }
        guard let body = bodyTextView.text else { return }
        
        note = Note(title: title, body: body)
    }
    
    func setTitle() {
        guard let title = note?.title else { return }
        titleTextField.text = title
    }
    
    func setBody() {
        guard let body = note?.body else { return }
        bodyTextView.text = body
    }
}
