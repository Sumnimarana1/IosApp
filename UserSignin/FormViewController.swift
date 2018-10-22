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
    
    @IBOutlet weak var LocationTXT: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnSave(_ sender: Any) {
        let newEvent = AllEvents(nameOfEvent: eventName.text!,Location: LocationTXT.text!,DateOfEvent: dateOfEvent.text!,Organization: organizationNameTXT.text!,Description: descriptionTXT.text!)
        Events.events.allEvents.append(newEvent)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?){
        if segue.identifier == "Done" {
           
          //  print(Events.events.allEvents)
        }
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
