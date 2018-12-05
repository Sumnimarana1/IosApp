//
//  loginView.swift
//  UserSignin
//
//  Created by Student on 9/30/18.
//  Copyright © 2018 Student. All rights reserved.
//
import UIKit

import Foundation

extension Notification.Name {
    static let OrgRetrieved = Notification.Name("Organization Retrieved")
    static let EventsRetrieved = Notification.Name("events Retrieved")
    static let eventsForSelectedOrgRetrieved = Notification.Name("Events for Selected Organisation Retrieved")
    static let EventDataRetrieved = Notification.Name("Event Data Retrieved")
}
let datePicker = UIDatePicker()
var eventsData:[EventData]=[]
var images=["a","b","c","d","e","f"]
class Events {
    let backendless = Backendless.sharedInstance()!
    var EventDataStore:IDataStore!
    var OrganizationDataStore:IDataStore!
    var selectedImage:UIImage?
    static var events:Events = Events()
    
    
    var organization:[Organization] =  []
    
    var allEvents:[EventData] = [
        EventData(imageName: "1.png", eventTitle: "Test", eventDescription: "This is Test Event", eventDate: datePicker.date, eventLocation: "VLK Building")]
    
    init(){
        OrganizationDataStore = backendless.data.of(Organization.self)
        EventDataStore = backendless.data.of(EventData.self)
    }
    
    var selectedOrg:Organization?
    
    var selectedEventIndex:Int = -1
    var selectedEvents:EventData?
    func selectedEvent() -> EventData {
        return allEvents[selectedEventIndex]
    }
    //    mutating func addNewCityFlown(city:String){
    //        airlines[selectedAirlineIndex].citiesFlown.append(city)
    //    }
    //var allEvents:[AllEvents] = []
    
    
    // the idea is that we will keep airlines private, and access it using these methods
    
    func numOrg() -> Int{
        return organization.count
    }
    // returns # of airlines
    func numEvents()->Int {
        return allEvents.count
    }
    
    // returns a particular airline
    func eventNum(_ index:Int) -> EventData {
        return allEvents[index]
    }
    var eventsForSelectedOrg:[EventData] = []
    
    //    subscript(index:Int) -> Events {
    //        return ev
    //    }
    
    subscript(index:Int) -> Organization {
        return organization[index]
    }
    func numeventsForSelectedOrg() -> Int {
        return eventsForSelectedOrg.count
    }
    
    // adds a new airline to the mix
    func addNewEvent(_ event:EventData){
        allEvents.append(event)
    }
    func retrieveAllOrganization() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["eventData"])
        queryBuilder!.setPageSize(100)                  // up to 100 TouristSites can be retrieved for each City)
        
        Types.tryblock({() -> Void in
            self.organization = self.OrganizationDataStore.find(queryBuilder) as! [Organization]
            
        },
                       catchblock: {(fault) -> Void in print(fault ?? "Something has gone wrong  reloadingAllOrg()")}
        )
        
    }
    
    func retrieveAllOrganizationAsynchronously() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["eventData"])
        queryBuilder!.setPageSize(100) // up to 100 EventData an be retrieved for each City
        OrganizationDataStore.find(queryBuilder, response: {(results) -> Void in
            self.organization = results as! [Organization]
            NotificationCenter.default.post(name: .OrgRetrieved, object: nil) // broadcast a Notification that Cities have been retrieved
        }, error: {(exception) -> Void in
            print(exception.debugDescription)
        })
        
    }
    
    func saveEvent(image:String, EventName:String,Description:String,DateOfEvent:Date,Location:String,selectedImage:UIImage){
        
        //
        var EventToSave = EventData(imageName:image,eventTitle:EventName,eventDescription:Description,eventDate:DateOfEvent, eventLocation:Location)
        EventToSave = EventDataStore.save(EventToSave) as! EventData
        // so our local version, in cities, has the objectId filled in
        allEvents.append(EventToSave)
        
        let imageToSave = UIImageJPEGRepresentation(selectedImage, 1.0)
        backendless.fileService.uploadFile("images/\(EventName).jpg", content: imageToSave!)
        
    }
    /*func updateEventSync( ev:EventData){
     
     //func updateContactSync( contact:Contact)
     
     let dataStore = Backendless.sharedInstance().data.of(EventData.ofClass())
     var error: Fault?
     ev.eventDescription = "Hii"
     let updatedEvent = dataStore.save(ev, fault: &error) as? EventData
     if error == nil {
     print("Contact has been updated: \(updatedEvent!.objectId)")
     }
     else {
     print("Server reported an error (2): \(error)")
     }
     }*/
    
    
    /*func updateEventAsync(ev:EventData) {
     let dataStore = Backendless.sharedInstance().data.of(EventData.ofClass())
     
     // update object asynchronously
     ev.eventDescription = "Hii"
     dataStore!.save(
     ev,
     response: { (result: AnyObject!) -> Void in
     let updatedEvent = result as! EventData
     print("Contact has been updated: \(updatedEvent.objectId)")
     } as! (Any?) -> Void,
     error: { (fault: Fault!) -> Void in
     print("Server reported an error (2): \(fault)")
     })
     }*/
    
    func retrieveDataForSelectedOrganization(org:String) {
        //let eventStorage = backendless.data.ofTable("EventData")
        let startDate = Date()
        eventsForSelectedOrg = []
        print("events")
        let queryBuilder:DataQueryBuilder  = DataQueryBuilder()
        queryBuilder.setWhereClause("OrgName = '\(org)'" ) // restrict ourselves to one city
        // EventData referenced in Organization's events  
        print("events")
        
        queryBuilder.setRelated( ["eventData"] )
        self.OrganizationDataStore.find(queryBuilder,
                                        response: {(results) -> Void in
                                            let selectedOrganization = results![0] as! Organization
                                            self.selectedOrg = selectedOrganization
                                            self.eventsForSelectedOrg = selectedOrganization.eventData
                                            NotificationCenter.default.post(name: .eventsForSelectedOrgRetrieved,  object: nil) // broadcast the fact that tourist sites for selected city have been retrieved
        }, error: {(exception) -> Void in
            print(exception.debugDescription)
        })
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
        //        print("events")
    }
    
    
    func retrieveAllEventsAsynchronously() {
        let startDate = Date()
        
        EventDataStore.find({
            (retrievedTouristSites) -> Void in
            self.allEvents = retrievedTouristSites as! [EventData]
            NotificationCenter.default.post(name: .EventDataRetrieved, object: nil) // broadcast a Notification that tourist sites have been retrieved
            
        },
                            error: {(exception) -> Void in
                                print(exception.debugDescription)
        })
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
    }
    
    func getImage(eventName:String){
        
        let urlSession = URLSession.shared
        let url = URL(string: "https://backendlessappcontent.com/A973CD44-FBCE-DEA4-FF7B-407958544E00/E8343EB1-D71A-6350-FFDE-516417EBC600/files/images/\(eventName).jpg")
        urlSession.dataTask(with: url!, completionHandler: displayImage).resume()
    }
    
    func displayImage(data:Data?, urlResponse:URLResponse?, error:Error?)->Void{
        if let e = error {
            print("Error downloading cat picture: \(e)")
        } else {
            // No errors found.
            // It would be weird if we didn't have a response, so check for that too.
            if let res = urlResponse as? HTTPURLResponse {
                print("Downloaded cat picture with response code \(res.statusCode)")
                if let imageData = data {
                    // Finally convert that Data into an image and do what you wish with it.
                     self.selectedImage = UIImage(data: imageData)!
                    // Do something with your image.
                } else {
                    print("Couldn't get image: Image is nil")
                }
            } else {
                print("Couldn't get response code for some reason")
            }
        }
    }
    
    
    func retrieveAllEventsDataAsynchronously() {
        let startDate = Date()
        
        EventDataStore.find({
            (retrievedTouristSites) -> Void in
            eventsData = retrievedTouristSites as! [EventData]
            NotificationCenter.default.post(name: .EventDataRetrieved, object: nil) // broadcast a Notification that tourist sites have been retrieved
            
        },
                            error: {(exception) -> Void in
                                print(exception.debugDescription)
        })
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
    }
    // saves a (new) tourist site for the selected city
    func saveEventsForSelectedOrg(eventData:EventData,selectedImage:UIImage) {
        print("Saving the event Data for the selected org...")
        let startingDate = Date()
        Types.tryblock({
            let savedeventData = self.EventDataStore.save(eventData) as! EventData// save one of its org
            self.OrganizationDataStore.addRelation("eventData:EventData:n", parentObjectId: self.selectedOrg!.objectId, childObjects: [savedeventData.objectId!])
            let imageToSave = UIImageJPEGRepresentation(selectedImage, 1.0)
            self.backendless.fileService.uploadFile("images/\(String(describing: eventData.eventTitle!)).jpg", content: imageToSave!)
            
            
        }, catchblock:{ (exception) -> Void in
            print(exception.debugDescription)
        })
        
        print("Done!! in \(Date().timeIntervalSince(startingDate)) seconds")
    }}
