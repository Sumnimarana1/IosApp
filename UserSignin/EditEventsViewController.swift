//
//  EditEventsViewController.swift
//  UserSignin
//
//  Created by Student1 on 10/21/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class EditEventsViewController: UIViewController {

    @IBOutlet weak var orgNameTXT: UITextField!
    @IBOutlet weak var eventNameTXT: UITextField!
    @IBOutlet weak var locationTXT: UITextField!
    @IBOutlet weak var dateOfEvent: UITextField!
    @IBOutlet weak var descTXT: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func EditBtn(_ sender: Any) {
        
//           if let orgName = orgNameTXT.text! , let eventName = eventNameTXT.text!, let location = locationTXT.text!, let date = dateOfEvent.text!, let desc = descTXT.text!{
        
    
        
        let newEvent = AllEvents(nameOfEvent: eventNameTXT.text!,Location: locationTXT.text!,DateOfEvent: dateOfEvent.text!,Organization: orgNameTXT.text!,Description: descTXT.text!)
        Events.events.allEvents.append(newEvent)
            
        
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
