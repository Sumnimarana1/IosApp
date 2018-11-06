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
     let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage6.jpg")!)

        // Do any additional setup after loading the view.
    }
    
    
    func createDatePicker(){
        //format the display of the date picker
        datePicker.datePickerMode = .dateAndTime
        
        dateOfEvent.inputView = datePicker
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //add button to toolbar
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([donebutton], animated: true)
        dateOfEvent.inputAccessoryView = toolbar
        
    }
    
    @objc func doneClicked(){
        //format the date display in textfield
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .short
        dateOfEvent.text = dateformatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    
    

    @IBAction func EditBtn(_ sender: Any) {
        
//           if let orgName = orgNameTXT.text! , let eventName = eventNameTXT.text!, let location = locationTXT.text!, let date = dateOfEvent.text!, let desc = descTXT.text!{
        
        let newEvent = EventData(  imageName: "",eventTitle:  eventNameTXT.text!,eventDescription: descTXT.text!,eventDate:  datePicker.date ,eventLocation: locationTXT.text!)
        
      
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
