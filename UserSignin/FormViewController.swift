//
//  FormViewController.swift
//  UserSignin
//
//  Created by Kancharla,Sravya on 10/7/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    
    @IBOutlet weak var organizationNameTXT: UITextField!
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var dateOfEvent: UITextField!
    
    @IBOutlet weak var descriptionTXT: UITextField!
    
    @IBAction func done(_ segue: UIStoryboardSegue){}
    
    @IBAction func cancel(_ segue:UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Save(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
