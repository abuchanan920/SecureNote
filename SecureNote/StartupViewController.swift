//
//  StartupViewController.swift
//  SecureNote
//
//  Created by Karan Krishnani on 11/11/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//
import UIKit
import LocalAuthentication

class StartupViewController: UIViewController {
    var firstLoad: Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        attemptAuthentication()
    }

    func attemptAuthentication() {
        AuthenticationManager.sharedInstance.authenticate(
            callback: { success, error in
                if(!success) {
                    var failureMessage: String
                    switch (error as! NSError).code {
                    case LAError.Code.authenticationFailed.rawValue,
                         LAError.Code.appCancel.rawValue,
                         LAError.Code.invalidContext.rawValue,
                         LAError.Code.systemCancel.rawValue,
                         LAError.Code.touchIDLockout.rawValue,
                         LAError.Code.touchIDNotAvailable.rawValue:
                        failureMessage = "Could not authenticate the user."
                    case LAError.Code.userFallback.rawValue,
                         LAError.Code.passcodeNotSet.rawValue:
                        failureMessage = "Passcode not set."
                    case LAError.Code.touchIDNotEnrolled.rawValue:
                        failureMessage = "Please enroll in TouchID."
                    case LAError.Code.userCancel.rawValue:
                        failureMessage = "User cancelled the authentication."
                    default:
                        failureMessage = "Unknown error."
                    }
                    let alert = UIAlertController(title: "Security Issue", message: failureMessage, preferredStyle: .alert)
                    let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
                        self.attemptAuthentication()
                    }
                    alert.addAction(retryAction)
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.present(alert, animated: true, completion: nil)
                    }
                } else {
                    if (self.firstLoad) {
                        DispatchQueue.main.async { [weak self] in
                            self?.performSegue(withIdentifier: "ListNotesSegue", sender: self)
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        )
    }

}
