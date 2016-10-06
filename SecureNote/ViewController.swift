//
//  ViewController.swift
//  SecureNote
//
//  Created by Karan Krishnani on 9/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var textContent: UITextView!
    @IBOutlet weak var textTitle: UITextField!

    var currentNote: Note!

    override func viewDidLoad() {
        super.viewDidLoad()
        let context = CoreDataStack.instance.persistentContainer.viewContext
        currentNote = Note(context: context)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        currentNote.title = textTitle.text!
        currentNote.content = textContent.text
        CoreDataStack.instance.saveContext()
    }

}

