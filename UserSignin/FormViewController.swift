//
//  FormViewController.swift
//  UserSignin
//
//  Created by Kancharla,Sravya on 10/7/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class FormViewController: UIViewController , UITextViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var eventDetails:UITextView!
    @IBOutlet weak var organizationNameTXT: UITextField!
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var dateOfEvent: UITextField!
    
    @IBOutlet weak var descriptionTXT: UITextField!
    
    @IBOutlet weak var LocationTXT: UITextField!
 
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage6.jpg")!)
        createDatePicker()
        //datePicker = UIDatePicker()
        
        /*datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(FormViewController.dateChanged(datePicker:)), for: .valueChanged)
        // Do any additional setup after loading the view.*/
        eventDetails.text = "Give event description"
        eventDetails.textColor = UIColor.lightGray
        eventDetails.font = UIFont(name: "verdana", size: 13.0)
        eventDetails.returnKeyType = .done
        eventDetails.delegate = self
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
    
    //place holder text
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Give event description"{
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 18.0)
            
            
        }
    }
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n"){
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            eventDetails.text = "Give your description"
            eventDetails.textColor = UIColor.lightGray
            eventDetails.font = UIFont(name: "verdana", size: 13.0)
        }
    }}
