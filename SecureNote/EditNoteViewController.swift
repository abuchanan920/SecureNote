//
//  EditNoteViewController.swift
//  SecureNote
//
//  Created by Karan Krishnani on 9/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//
import UIKit
import CoreData

class EditNoteViewController: UIViewController {

    @IBOutlet weak var textContent: UITextView!
    @IBOutlet weak var textTitle: UITextField!

    var currentNote: Note!

    override func viewDidLoad() {
        super.viewDidLoad()
        textTitle.delegate = self
        textContent.delegate = self

        textTitle.text = currentNote.title
        textContent.text = currentNote.content
    }

    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        saveNote()
    }

    func saveNote() {
        currentNote.title = textTitle.text!
        currentNote.content = textContent.text
        CoreDataService.instance.saveContext()
    }

}

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        saveNote()
    }
}

extension EditNoteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveNote()
    }
}

