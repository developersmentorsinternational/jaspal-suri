import UIKit
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        if token != nil {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let profilePage = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.window?.rootViewController = profilePage
        }
        
        return true
    }
    
}

