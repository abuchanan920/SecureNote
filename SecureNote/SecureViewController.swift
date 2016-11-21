import UIKit

class SecureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(showLockScreen), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    func showLockScreen() {
        if let startupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartupViewController") as? StartupViewController {
            startupViewController.firstLoad = false
            self.present(startupViewController, animated: false, completion: nil)
        }
    }
}
