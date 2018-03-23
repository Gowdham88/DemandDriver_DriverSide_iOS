//
//  Otp.swift
//  DemandDriver-Driver
//
//  Created by CZSM2 on 22/03/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuthUI
import FirebaseFirestore
import FirebasePhoneAuthUI

class Otp: UIViewController {
    var phonestring = ""
    
    @IBOutlet weak var phonelbl: UILabel!
    
    @IBOutlet weak var otptxt: UITextField!
    
    @IBOutlet weak var OTPview: UIView!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var resetView: UIView!
    
    let db = Firestore.firestore()
    
    var authHandle: AuthStateDidChangeListenerHandle!
    var tapgesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowForLoginLabel()
        addShadowForResetView()
        addShadowOTPview()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resendotp(_ sender: Any) {
        let phonenumber = phonelbl.text
        PhoneAuthProvider.provider().verifyPhoneNumber(phonenumber!)
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
                
            }
        }
    }
    func addShadowForLoginLabel() {
        
        //for login label
        loginView.layer.cornerRadius = loginView.frame.size.height/2
        loginView.clipsToBounds = true
        
        if #available(iOS 11.0, *) {
            loginView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner ]
        } else {
            // Fallback on earlier versions
        }
        
        let shadowpath2 = UIBezierPath(roundedRect: self.loginView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 58.0, height: 0.0))
        
        
        
        loginView.layer.shadowColor = UIColor(red: 12/255.0, green: 189/255.0, blue: 239/255.0, alpha: 0.5).cgColor
        loginView.layer.shadowOffset = CGSize(width: 1, height: 1)
        loginView.layer.shadowOpacity = 0.5
        loginView.layer.shadowRadius = 10 //Here your control your blur
        loginView.layer.masksToBounds =  false
        loginView.layer.shadowPath = shadowpath2.cgPath
    }
    
    func addShadowForResetView() {
        
        //for resetView
        resetView.layer.cornerRadius = resetView.frame.size.height/2
        resetView.clipsToBounds = true
        
        if #available(iOS 11.0, *) {
            resetView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner ]
        } else {
            
        }
        
        let shadowpath2 = UIBezierPath(roundedRect: self.resetView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 58.0, height: 0.0))
        
        
        
        resetView.layer.shadowColor = UIColor(red: 12/255.0, green: 189/255.0, blue: 239/255.0, alpha: 0.5).cgColor
        resetView.layer.shadowOffset = CGSize(width: 1, height: 1)
        resetView.layer.shadowOpacity = 0.5
        resetView.layer.shadowRadius = 10 //Here your control your blur
        resetView.layer.masksToBounds =  false
        resetView.layer.shadowPath = shadowpath2.cgPath
    }
func addShadowOTPview(){
    
    //for OTP View
    OTPview.layer.cornerRadius = OTPview.frame.size.height/2
    OTPview.clipsToBounds = true
    
    if #available(iOS 11.0, *) {
        OTPview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner ]
    } else {
        
    }
    
    let shadowpath2 = UIBezierPath(roundedRect: self.OTPview.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 58.0, height: 0.0))
    OTPview.layer.shadowColor = UIColor(red: 12/255.0, green: 189/255.0, blue: 239/255.0, alpha: 0.5).cgColor
    OTPview.layer.shadowOffset = CGSize(width: 1, height: 1)
    OTPview.layer.shadowOpacity = 0.5
    OTPview.layer.shadowRadius = 10 //Here your control your blur
    OTPview.layer.masksToBounds =  false
    OTPview.layer.shadowPath = shadowpath2.cgPath
}


@IBAction func Loginbtn(_ sender: Any) {
    let defaults = UserDefaults.standard
    let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!,
                                                                                  verificationCode: otptxt.text!)
    Auth.auth().signIn(with: credential)
    {
        (user, error) in
        if error != nil
        {
            print("error: \(String(describing: error?.localizedDescription))")
        }
        else if user != nil
        {
            print("Phone number: \(String(describing: user?.phoneNumber))")
            let userInfo = user?.providerData[0]
            print("Provider ID: \(String(describing: userInfo?.providerID))")
            
            let currentUser = Auth.auth().currentUser?.uid
            var ref: DocumentReference? = nil
            
            let docRef =  self.db.collection("Users").document(currentUser!)
            print("currentUser:::\(String(describing: currentUser))")
            print("docRef:::\(String(describing: docRef))")
            
            docRef.getDocument { (documents, error) in
                
                if let document = documents {
                    //                        print("Document data: \(document)")
                    print("already exists")
                    
                    
                } else {
                    print("Document does not exist")
                }
    }
        
        } else {
            
         }
        
    }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
