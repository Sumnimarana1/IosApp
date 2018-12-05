//
//  FormViewController.swift
//  UserSignin
//
//  Created by Kancharla,Sravya on 10/7/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class AddNewEventViewController: UIViewController , UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    var event = Events.events
    
    @IBOutlet weak var imageView: UITextField!
    
    @IBOutlet weak var eventDetails:UITextView!
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var dateOfEvent: UITextField!

    
    @IBOutlet weak var LocationTXT: UITextField!
 
    let datePicker = UIDatePicker()
    
    
    @IBOutlet weak var selectedImage: UIImageView!
    
    @IBAction func uploadImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //This method stores the selected images
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo: [String:Any]) {
        print(didFinishPickingMediaWithInfo)
        var selectedImage:UIImage?
        
        
        if let editedImage = didFinishPickingMediaWithInfo["UIImagePickerControllerEditedImage"] as? UIImage {
            print(editedImage.size)
            selectedImage = editedImage
        }
        
        if let originalImage = didFinishPickingMediaWithInfo["UIImagePickerControllerOriginalImage"] as? UIImage {
            print(originalImage.size)
            selectedImage = originalImage
        }
        
        if let finalImage = selectedImage {
            
            dismiss(animated: true, completion: nil)
            self.selectedImage.image = finalImage
            
        }
        
    }
    
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage6.jpg")!)
        createDatePicker()
        eventDetails.textColor = UIColor.lightGray
        eventDetails.font = UIFont(name: "verdana", size: 13.0)
        eventDetails.returnKeyType = .done
        eventDetails.delegate = self
    }
    
    func createDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        dateOfEvent.inputView = datePicker
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

        
        event.saveEventsForSelectedOrg(eventData: EventData(imageName: imageView.text!, eventTitle: eventName.text!, eventDescription: eventDetails.text!, eventDate: datePicker.date, eventLocation: LocationTXT.text!),selectedImage: selectedImage.image!)
        
        
        /*event.saveEvent(image: imageView.text!, EventName: eventName.text!, Description: eventDetails.text!, DateOfEvent: datePicker.date, Location: LocationTXT.text!,selectedImage: selectedImage.image!)*/
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?){
        if segue.identifier == "Done" {
        }
    }
    
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
