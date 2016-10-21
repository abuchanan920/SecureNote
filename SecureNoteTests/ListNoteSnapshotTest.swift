//
//  ListNoteSnapshotTest.swift
//  SecureNote
//
//  Created by Karan Krishnani on 10/20/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import FBSnapshotTestCase

@testable import SecureNote

class ListNoteSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListNotes() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listNotesVC = storyboard.instantiateViewController(withIdentifier: "ListNotesViewController") as! ListNotesViewController
        let uiView = listNotesVC.view
        FBSnapshotVerifyView(uiView!)
    }
}
