//
//  loginView.swift
//  UserSignin
//
//  Created by Student on 9/30/18.
//  Copyright © 2018 Student. All rights reserved.
//
import UIKit

import Foundation

/*This is the main model for the project where all the functions are written in order to add the events, retrieve all the events, retrieve all the organization.*/
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
    
    //returns number of organisations
    func numOrg() -> Int{
        return organization.count
    }
    
    
   //rerurns number of events
    func numEvents()->Int {
        return allEvents.count
    }
    
    //returns a selected index
    func eventNum(_ index:Int) -> EventData {
        return allEvents[index]
    }
    var eventsForSelectedOrg:[EventData] = []
    
    
    subscript(index:Int) -> Organization {
        return organization[index]
    }
    
    //returns number of events in a particular selected organisation
    func numeventsForSelectedOrg() -> Int {
        return eventsForSelectedOrg.count
    }
    
    // adds a new event
    func addNewEvent(_ event:EventData){
        allEvents.append(event)
    }
    
    
    func retrieveAllOrganization() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["eventData"])
        queryBuilder!.setPageSize(100)
        Types.tryblock({() -> Void in
            self.organization = self.OrganizationDataStore.find(queryBuilder) as! [Organization]
            
        },
                       catchblock: {(fault) -> Void in print(fault ?? "Something has gone wrong  reloadingAllOrg()")}
        )
        
    }
    
    //saves an event
    func saveEvent(image:String, EventName:String,Description:String,DateOfEvent:Date,Location:String,selectedImage:UIImage){
        
      
        var EventToSave = EventData(imageName:image,eventTitle:EventName,eventDescription:Description,eventDate:DateOfEvent, eventLocation:Location)
        EventToSave = EventDataStore.save(EventToSave) as! EventData
       
        allEvents.append(EventToSave)
        
        let imageToSave = UIImageJPEGRepresentation(selectedImage, 1.0)
        backendless.fileService.uploadFile("images/\(EventName).jpg", content: imageToSave!)
        
    }
    
    //retrieves data from a selected organisation
    func retrieveDataForSelectedOrganization(org:String) {
        //let eventStorage = backendless.data.ofTable("EventData")
        let startDate = Date()
        eventsForSelectedOrg = []
        print("events")
        let queryBuilder:DataQueryBuilder  = DataQueryBuilder()
        queryBuilder.setWhereClause("OrgName = '\(org)'" )
        print("events")
        
        queryBuilder.setRelated( ["eventData"] )
        self.OrganizationDataStore.find(queryBuilder,
                                        response: {(results) -> Void in
                                            let selectedOrganization = results![0] as! Organization
                                            self.selectedOrg = selectedOrganization
                                            self.eventsForSelectedOrg = selectedOrganization.eventData
                                            NotificationCenter.default.post(name: .eventsForSelectedOrgRetrieved,  object: nil)
        }, error: {(exception) -> Void in
            print(exception.debugDescription)
        })
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
       
    }
    
    //retrieves all events asynchronously
    func retrieveAllEventsAsynchronously() {
        let startDate = Date()
        
        EventDataStore.find({
            (retrievedTouristSites) -> Void in
            self.allEvents = retrievedTouristSites as! [EventData]
            NotificationCenter.default.post(name: .EventDataRetrieved, object: nil)
            
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
    
    //retrieve all events data asynchronously
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
   
    
    //retrieve all organisations asynchronously
    func retrieveAllOrganizationAsynchronously() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["eventData"])
        queryBuilder!.setPageSize(100)
        OrganizationDataStore.find(queryBuilder, response: {(results) -> Void in
            self.organization = results as! [Organization]
            NotificationCenter.default.post(name: .OrgRetrieved, object: nil)
        }, error: {(exception) -> Void in
            print(exception.debugDescription)
        })
        
    }
    
    //saves deatils for a event in a selected organisation
    func saveEventsForSelectedOrg(eventData:EventData,selectedImage:UIImage) {
        print("Saving the event Data for the selected org...")
        let startingDate = Date()
        Types.tryblock({
            let savedeventData = self.EventDataStore.save(eventData) as! EventData
            self.OrganizationDataStore.addRelation("eventData:EventData:n", parentObjectId: self.selectedOrg!.objectId, childObjects: [savedeventData.objectId!])
            let imageToSave = UIImageJPEGRepresentation(selectedImage, 1.0)
            self.backendless.fileService.uploadFile("images/\(String(describing: eventData.eventTitle!)).jpg", content: imageToSave!)
            
            
        }, catchblock:{ (exception) -> Void in
            print(exception.debugDescription)
        })
        
        print("Done!! in \(Date().timeIntervalSince(startingDate)) seconds")
    }
    
}
