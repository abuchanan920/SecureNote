//
//  ViewController.swift
//  SecureNote
//
//  Created by Karan Krishnani on 9/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var editorView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEditor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadEditor() {
        editorView.delegate = self
        let urlPath = Bundle.main.path(forResource: "editor", ofType: "html", inDirectory: "/editor")
        let url = NSURL.fileURL(withPath: urlPath!)
        editorView.loadRequest(URLRequest(url: url))
    }


}

