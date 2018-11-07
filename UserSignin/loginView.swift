//
//  loginView.swift
//  UserSignin
//
//  Created by Student on 9/30/18.
//  Copyright © 2018 Student. All rights reserved.
//
import UIKit
import Foundation

//@objcMembers
//class EventData: NSObject {
//    var imageName:String
//    var eventTitle:String
//    var eventDescription:String
//    var eventDate:Date
//    var eventLocation:String
//    init(imageName:String,eventTitle:String,eventDescription:String,eventDate:Date, eventLocation:String) {
//        self.imageName=imageName
//        self.eventTitle=eventTitle
//        self.eventDate=eventDate
//        self.eventDescription=eventDescription
//        self.eventLocation=eventLocation
//    }
//}

//struct AllEvents {
//    var nameOfEvent:String
//    var Location:String
//    var DateOfEvent:String
//    var Organization:String
//    var Description:String
//}
   let datePicker = UIDatePicker()




class Events {
    let backendless = Backendless.sharedInstance()!
    var EventDataStore:IDataStore!
    var OrganisationDataStore:IDataStore!
    
    static var events:Events = Events()
     var allEvents:[EventData] = [
        EventData(imageName: "1.png", eventTitle: "Test", eventDescription: "This is Test Event", eventDate: datePicker.date, eventLocation: "VLK Building")]
    private init(){
        EventDataStore = backendless.data.of(EventData.self)
    }
    
    var selectedEventIndex:Int = -1
    
    func selectedEvent() -> EventData {
        return allEvents[selectedEventIndex]
    }
    //    mutating func addNewCityFlown(city:String){
    //        airlines[selectedAirlineIndex].citiesFlown.append(city)
    //    }
  //var allEvents:[AllEvents] = []
    
    
    // the idea is that we will keep airlines private, and access it using these methods
    
    // returns # of airlines
    func numEvents()->Int {
        return allEvents.count
    }
    
    // returns a particular airline
    func eventNum(_ index:Int) -> EventData {
        return allEvents[index]
    }
    
    subscript(index:Int)->EventData{
        return allEvents[index]
    }
    
    // adds a new airline to the mix
    func addNewEvent(_ event:EventData){
        allEvents.append(event)
    }

    
     func saveEvent(image:String, EventName:String,Description:String,DateOfEvent:Date,Location:String){
        
        //
        var EventToSave = EventData(imageName:image,eventTitle:EventName,eventDescription:Description,eventDate:DateOfEvent, eventLocation:Location)
        EventToSave = EventDataStore.save(EventToSave) as! EventData
        // so our local version, in cities, has the objectId filled in
        allEvents.append(EventToSave)
        
        //
    }
//    let backendLess = Backendless()
//    var events:[EventData]=[]
//    func retrieveDate() {
//        let eventStorage = backendLess.data.ofTable("Event_Details")
//        
//        let queryBuilder = DataQueryBuilder()
//        
//        eventStorage?.find(queryBuilder,
//                           response: {
//                            (result) -> () in
//                            let events=result as? [NSDictionary]
//                            self.events=[]
//                            for i in events!{
//                                self.events.append(EventData(imageName: "", eventTitle: i["EventName"] as! String, eventDescription: i["Description"] as! String, eventDate: i["DateOfEvent"] as! Date, eventLocation: i["Location"] as! String))
//                            }
//                            //                                print("Retrieved \(String(describing: result?.count)) objects")
//        },
//                           error: {
//                            (fault: Fault?) -> () in
//                            print("Server reported an error: \(String(describing: fault?.message))")
//        })
//    }
//    
//    mutating func saveEventAsynchronously(image:String, EventName:String,Description:String,DateOfEvent:Date,Location:String   ) {
//        
//        //
//        
//        var EventToSave = EventData(imageName:image,eventTitle:EventName,eventDescription:Description,eventDate:DateOfEvent, eventLocation:Location)
//        EventDataStore.save(EventToSave, response: {(result) -> Void in
//            EventToSave = result as! EventData
//          allEvents.append(EventToSave)
//           retrieveDate()},
//                           error:{(exception) -> Void in
//                            print(exception.debugDescription)
//                            
//        })
//        
//        //
//    }
}
