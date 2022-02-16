//
//  ViewController.swift
//  NotesApp
//
//  Created by Владимир Тимофеев on 11.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    var noteController = NoteController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.leftBarButtonItem = editButtonItem
        loadNotes()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        save()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        save()
    }
    
    func loadNotes() {
        noteController.fetchNotes { notes in
            if let notes = notes {
                self.notes = notes
            }
        }
        
        if notes.isEmpty {
            let note = Note(title: "Hello!", body: "Enjoy the app!")
            notes.append(note)
        }
    }
    
    func save() {
        noteController.saveNotes(notes: notes)
    }
    
    func setupTableView() {
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = .systemGray6
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let detailVC = segue.destination as! DetailViewController
            detailVC.noteDelegate = self
            detailVC.note = notes[indexPath.row]
            detailVC.indexPath = indexPath
        } else if segue.identifier == "add" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.noteDelegate = self
        }
    }
    
}

// MARK: - TableView data source
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedNote = notes.remove(at: sourceIndexPath.row)
        notes.insert(movedNote, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGray6
        
        let note = notes[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = note.title
        config.secondaryText = note.body
        cell.contentConfiguration = config
        
        return cell
    }
    
}

// MARK: - TableView delegate
extension ViewController: UITableViewDelegate {}

// MARK: - Note delegate
extension ViewController: NoteDelegate {
    func passNote(note: Note, at indexPath: IndexPath?) {
        if let indexPath = indexPath {
            self.notes[indexPath.row] = note
        } else {
            self.notes.append(note)
        }
    }
}
