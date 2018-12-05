//
//  EditEventsViewController.swift
//  UserSignin
//
//  Created by Student1 on 10/21/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class EventsDetailViewController: UIViewController {

    var event = Events.events
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventNameTXT: UILabel!
  
    @IBOutlet weak var locationTXT: UILabel!
    
    @IBOutlet weak var descTXT: UILabel!
    
    @IBOutlet weak var dateOfEvent: UILabel!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage6.jpg")!)
        // Do any additional setup after loading the view.
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
         let event = Events.events.eventsForSelectedOrg[Events.events.selectedEventIndex]
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString =  formatter.string(from: event.eventDate)
        let yourDate = formatter.date(from:myString)
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        let myStringfd = formatter.string(from:yourDate!)
        let s = "https://backendlessappcontent.com/A973CD44-FBCE-DEA4-FF7B-407958544E00/E8343EB1-D71A-6350-FFDE-516417EBC600/files/images/\(event.eventTitle!).jpg"
        self.eventImage.load(url: URL(string: s)!)
       self.eventNameTXT.text = event.eventTitle
        self.locationTXT.text = event.eventLocation!
        
        self.dateOfEvent.text =  "\(myStringfd)"
        
        
        
        self.descTXT.text = event.eventDescription
       
    }
    
    

    @IBAction func EditBtn(_ sender: Any) {
        
       
        let newEvent = EventData(  imageName: "",eventTitle:  eventNameTXT.text!,eventDescription: descTXT.text!,eventDate:  datePicker.date ,eventLocation: locationTXT.text!)
        Events.events.allEvents.append(newEvent)
        
        
        //if let orgName = orgNameTXT.text! , let eventName = eventNameTXT.text!, let location = locationTXT.text!, let date = dateOfEvent.text!, let desc = descTXT.text!{
        //event.updateEventSync(ev: EventData)
        //event.saveEvent(image: "", EventName: eventNameTXT.text!  , Description: descTXT.text!, DateOfEvent: datePicker.date, Location: locationTXT.text!)
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
