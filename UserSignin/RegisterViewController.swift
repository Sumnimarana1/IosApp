//
//  RegisterViewController.swift
//  UserSignin
//
//  Created by Student on 10/4/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
//import Backendless

class RegisterViewController: UIViewController {
  
    
  
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
      @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
      @IBOutlet weak var retypePassword: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func registering(_ sender: Any) {
        
        //registerUser()
        registerUserAsync()
    }
    
//    let APP_ID = "A973CD44-FBCE-DEA4-FF7B-407958544E00"
//    let API_KEY = "4C705EBE-331F-E54B-FFAB-C1F9D9EB7D00"
     var backendless = Backendless.sharedInstance()!
//
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func registerUser() {
        
        Types.tryblock({ () -> Void in
            
            let user = BackendlessUser()
            user.setProperty("FirstName", object: String(describing: self.firstName.text!))
            user.setProperty("LastName", object: String(describing: self.lastName.text!))
             user.setProperty("email", object:String(describing: self.email.text!))
            //user.email = String(describing: self.self.email) as NSString
            if(String(describing: self.password.text!) as NSString == String(describing: self.retypePassword.text!) as NSString){
                user.password = String(describing: self.password.text!) as NSString
                print(String(self.password.text!))
                print(String(self.retypePassword.text!))
            }else{
                self.display(title: "password didn't match")
            }
            
            user.password = String(describing: self.password.text!) as NSString
            

            
            let registeredUser = self.backendless.userService.register(user)
            print("User has been registered (ASYNC): \(String(describing: registeredUser?.getProperty("FirstName")))")
            self.display(title: "User has been registered (SYNC): \(String(describing: registeredUser?.getProperty("FirstName")))")
        },
                  
                       catchblock: { (exception) -> Void in
                        print("Server reported an error: \(exception as! Fault)")
        })
    }
    
    func registerUserAsync() {
        let user = BackendlessUser()
        user.setProperty("FirstName", object: String(describing: firstName.text!))
        user.setProperty("LirstName", object: String(describing: lastName.text!))
    user.setProperty("email", object:String(describing: self.email.text!))
        if(String(describing: self.password.text!) as NSString == String(describing: self.retypePassword.text!) as NSString){
            print(String(self.password.text!))
            print(String(self.retypePassword.text!))
           user.password = String(describing: self.password.text!) as NSString
        }else{
            display(title: "password didn't match")
        }
        
        backendless.userService.register(user,
                                            response: { ( registeredUser : BackendlessUser!) -> () in
                                               
                                                self.display(title: "User has been registered (SYNC): \(String(describing: registeredUser.getProperty("FirstName")))")
        },
                                            error: { (fault : Fault!) -> () in
                                                print("Server reported an error: \(String(describing: fault))")
        }
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func display(title:String){
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
