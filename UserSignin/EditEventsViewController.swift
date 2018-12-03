//
//  EditEventsViewController.swift
//  UserSignin
//
//  Created by Student1 on 10/21/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class EditEventsViewController: UIViewController {

    var event = Events.events
    
   
    @IBOutlet weak var eventNameTXT: UILabel!
    @IBOutlet weak var locationTXT: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        //self.title=eventNameTXT
        let event = Events.events.allEvents[Events.events.selectedEventIndex]
       self.eventNameTXT.text = event.eventTitle
        self.locationTXT.text = event.eventLocation
        self.dateOfEvent.text =  "\(event.eventDate)"
        
        
        
        self.descTXT.text = event.eventDescription
       
    }
    
    

    @IBAction func EditBtn(_ sender: Any) {
        
        //if let orgName = orgNameTXT.text! , let eventName = eventNameTXT.text!, let location = locationTXT.text!, let date = dateOfEvent.text!, let desc = descTXT.text!{
        //event.updateEventSync(ev: EventData)
        let newEvent = EventData(  imageName: "",eventTitle:  eventNameTXT.text!,eventDescription: descTXT.text!,eventDate:  datePicker.date ,eventLocation: locationTXT.text!)
        //event.saveEvent(image: "", EventName: eventNameTXT.text!  , Description: descTXT.text!, DateOfEvent: datePicker.date, Location: locationTXT.text!)
        Events.events.allEvents.append(newEvent)
        //self.dismiss(animated: true, completion: nil)
        
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
