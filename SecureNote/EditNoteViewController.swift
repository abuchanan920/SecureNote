//
//  EditNoteViewController.swift
//  SecureNote
//
//  Created by Karan Krishnani on 9/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//
import UIKit
import CoreData

class EditNoteViewController: SecureViewController {

    @IBOutlet weak var textContent: UITextView!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var buttonSave: UIBarButtonItem!
    
    var currentNote: Note!

    override func viewDidLoad() {
        super.viewDidLoad()
        textTitle.delegate = self
        textContent.delegate = self

        textTitle.text = currentNote.title
        textContent.text = currentNote.content
        buttonSave.isEnabled = false
    }

    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        saveNote()
    }

    func saveNote() {
        currentNote.title = textTitle.text!
        currentNote.content = textContent.text
        CoreDataService.instance.saveContext()
        buttonSave.isEnabled = false
    }

    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
        let confirmAlert = UIAlertController(title: "Confirm", message: "Delete this note?", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { uiAlertAction in

            self.deleteNote()

            let _ = self.navigationController?.popViewController(animated: true)
        })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: {_ in } )

        confirmAlert.addAction(noAction)
        confirmAlert.addAction(yesAction)
        
        self.present(confirmAlert, animated: true, completion: {})
    }

    func deleteNote() {
        let context = CoreDataService.instance.persistentContainer.viewContext
        context.delete(self.currentNote)
        CoreDataService.instance.saveContext()
    }
}

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        saveNote()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        buttonSave.isEnabled = true
    }
}

extension EditNoteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveNote()
    }

    func textViewDidChange(_ textView: UITextView) {
        buttonSave.isEnabled = true
    }
}

