//
//  NewLogin.swift
//  DemandDriver-Driver
//
//  Created by CZSM2 on 22/03/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import UserNotifications

class NewLogin: UIViewController {

    @IBOutlet weak var country: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      country.text = "+91"
        // Do any additional setup after loading the view.
    
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        phone.resignFirstResponder()
        country.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendcode(_ sender: Any) {
        let mobileNumber = country.text! + phone.text!
         print("mobileNumber::::\(mobileNumber)")
        let alert = UIAlertController(title: "Phone Number", message: "Is this your phone number? \n \(mobileNumber)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default)
        {
            (UIAlertAction) in PhoneAuthProvider.provider().verifyPhoneNumber(mobileNumber)
            {
            (verificationID, error) in
            if error != nil
            {
                print ("insde SendCode, there is error")
                
                print("error: \(String(describing: error?.localizedDescription))")
                
            }
            else
            {
                print ("else  SendCode, going to move to next page")
                let defaults = UserDefaults.standard
                defaults.set(verificationID, forKey: "authVID")
                //self.performSegue(withIdentifier: "code", sender: Any?.self)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "otp") as! Otp
                vc.phonestring = mobileNumber
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // Pass device token to auth
//        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenTypeProd)
//        
//        // Further handling of the device token if needed by the app
//        // ...
//    }
//    
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification notification: [AnyHashable : Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if Auth.auth().canHandleNotification(notification) {
//            completionHandler(UIBackgroundFetchResultNoData)
//            return
//        }
//        // This notification is not auth related, developer should handle it.
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
