//
//  LoginViewController.swift
//  UserSignin
//
//  Created by Student on 9/30/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBAction func Done(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    let backendless = Backendless.sharedInstance()!
    
    
    /*func loginUser() {
    
    Types.tryblock({ () -> Void in
    
        let user = self.backendless.userService.login("test@gmail.com", password: "123")
        print("User has been logged in (SYNC): \(String(describing: user))")
        if user != nil{
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "nextView") as! AdminTableViewController
            self.present(nextViewController, animated:true, completion:nil)
        }else{
         
        }
    },
    
    catchblock: { (exception) -> Void in
    print("Server reported an error: \(exception as! Fault)")
    })
    }*/
      @IBAction func logout(segue:UIStoryboardSegue){}
    
    
    func loginUser() {
      
        backendless.userService.login(email.text,
                                      password: password.text,
                                      response: {
                                        (loggedUser : BackendlessUser?) -> Void in
                                        
                                        print("User has been logged in (SYNC): \(String(describing: loggedUser))")
                                       //var org = loggedUser?.getProperty("Organization") as? Organization
                                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "nextView") as! AdminTableViewController
                                            self.present(nextViewController, animated:true, completion:nil)
                                      
                                        print("User logged in")
                                        
        },
                                      error: {
                                        (fault : Fault?) -> Void in
                                        print("Server reported an error: \(String(describing: fault?.description))")
                                        self.display(title: "Invalid User Login and password")
        })
    }
    
    @IBAction func login(_ sender: Any) {
        loginUser()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage5.jpg")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func display(title:String){
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
