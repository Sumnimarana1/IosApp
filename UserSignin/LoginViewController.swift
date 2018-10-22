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
    
    
    func loginUser() {
    
    Types.tryblock({ () -> Void in
    
        let user = self.backendless.userService.login(self.email.text, password: self.password.text)
        print("User has been logged in (SYNC): \(String(describing: user))")
        if user != nil{
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "nextView") as! AdminTableViewController
            self.present(nextViewController, animated:true, completion:nil)
        }else{
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "nextView") as! AdminTableViewController
            self.present(nextViewController, animated:true, completion:nil)
        }
    },
    
    catchblock: { (exception) -> Void in
    print("Server reported an error: \(exception as! Fault)")
    })
    }
    
    @IBAction func login(_ sender: Any) {
         loginUser()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
