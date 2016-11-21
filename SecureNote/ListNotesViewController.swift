//
//  ListNotesViewController.swift
//  SecureNote
//
//  Created by Karan Krishnani on 10/6/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit
import CoreData

class ListNotesViewController: SecureViewController {
    let editNoteSegue = "EditNoteSegue"
    let addNoteSegue = "AddNoteSegue"

    var notes: [Note]!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        setupTableView()
        refreshNotes()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshNotes()
    }

    private func refreshNotes() {
        notes = CoreDataService.instance.fetchNotes()
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: NoteTableViewCell.self), bundle: nil), forCellReuseIdentifier: NoteTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editNoteSegue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let editNoteVC = segue.destination as! EditNoteViewController
                editNoteVC.currentNote = notes[indexPath.row]
            }
        } else if segue.identifier == addNoteSegue {
            let editNoteVC = segue.destination as! EditNoteViewController
            let context = CoreDataService.instance.persistentContainer.viewContext
            editNoteVC.currentNote = Note(context: context)
        }
    }
}

extension ListNotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: editNoteSegue, sender: self)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListNotesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell

        cell.populateWith(note: notes[indexPath.row])

        return cell
    }
}

class NoteTableViewCell: UITableViewCell {
    static let identifier = "noteTableViewCell"
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSnippet: UILabel!


    func populateWith(note: Note) {
        labelTitle.text = note.title
        labelSnippet.text = note.content
    }
    
}
