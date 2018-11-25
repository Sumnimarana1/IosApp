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

class Events {
    let backendless = Backendless.sharedInstance()!
    var EventDataStore:IDataStore!
    var OrganizationDataStore:IDataStore!
    
    static var events:Events = Events()
      var organization:[Organization] =  []

     var allEvents:[EventData] = [
        EventData(imageName: "1.png", eventTitle: "Test", eventDescription: "This is Test Event", eventDate: datePicker.date, eventLocation: "VLK Building")]
    private init(){
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
    subscript(index:Int)->Organization{
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
    
     func saveEvent(image:String, EventName:String,Description:String,DateOfEvent:Date,Location:String){
        
        //
        var EventToSave = EventData(imageName:image,eventTitle:EventName,eventDescription:Description,eventDate:DateOfEvent, eventLocation:Location)
        EventToSave = EventDataStore.save(EventToSave) as! EventData
        // so our local version, in cities, has the objectId filled in
        allEvents.append(EventToSave)
        
        //
    }
    func retrieveDataForSelectedOrganization() {
        //let eventStorage = backendless.data.ofTable("EventData")
          let startDate = Date()
        
        print("events")
        let queryBuilder:DataQueryBuilder  = DataQueryBuilder()
        queryBuilder.setWhereClause("name = '\(self.selectedEvents?.eventTitle ?? "")'" ) // restrict ourselves to one city
        // EventData referenced in Organization's events  
        print("events")
        
        queryBuilder.setRelated( ["eventData"] )
        self.EventDataStore.find(queryBuilder,
                    response: {(results) -> Void in
                                    let org = results![0] as! Organization
                                    self.eventsForSelectedOrg = org.eventData
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

    /*func retrieveData() {
        //let eventStorage = backendless.data.ofTable("EventData")
        print("events")
        let queryBuilder:DataQueryBuilder  = DataQueryBuilder()
        queryBuilder.setWhereClause("name = '\(self.selectedEvents?.eventTitle ?? "")'" ) // restrict ourselves to one city
// EventData referenced in Organization's events  
        print("events")
        
        queryBuilder.setRelated( ["touristSites"] )
        self.EventDataStore.find(queryBuilder,
                                response: {(results) -> Void in
                                    let org = results![0] as! Organization
                                    self.touristSitesForSelectedCity = city.touristSites
                                    NotificationCenter.default.post(name: .TouristSitesForSelectedCityRetrieved, object: nil) // broadcast the fact that tourist sites for selected city have been retrieved
        }, error: {(exception) -> Void in
            print(exception.debugDescription)
        })
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
//        print("events")
//        queryBuilder.setPageSize(100) // up to 100 Event Data can be retrieved for each City
//        EventDataStore.find(queryBuilder, response: {(results) -> Void in
//            self.allEvents = results as! [EventData]
//            print(self.allEvents)
//            NotificationCenter.default.post(name: .EventsRetrieved , object: nil) // broadcast a Notification that EventData have been retrieved
//        }, error: {(exception) -> Void in
//            print(exception.debugDescription)
        
//        eventStorage?.find(queryBuilder,
//                           response: {
//                            (result) -> () in
//                            let events=result as? [NSDictionary]
//                            self.allEvents = []
//                           // self.events=[]
//                            for i in events!{
//                                self.allEvents.append(EventData(imageName: "" , eventTitle: i["EventName"] as! String , eventDescription: i["Description"] as! String ?? "", eventDate: i["DateOfEvent"] as! Date, eventLocation: i["Location"] as? String ?? ""))
//                            }
//                            //                                print("Retrieved \(String(describing: result?.count)) objects")
//        },
//                           error: {
//                            (fault: Fault?) -> () in
//                            print("Server reported an error: \(String(describing: fault?.message))")
//        })
    }
    
    */
    
    
    
    /*func retrieveAllCities() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["EventData])      // TouristSites referenced in City's touristSites property will be retrieved for each City
        queryBuilder!.setPageSize(100)                  // up to 100 TouristSites can be retrieved for each City)
        
        Types.tryblock({() -> Void in
            self.cities = self.cityDataStore.find(queryBuilder) as! [City]
            
        },
                       catchblock: {(fault) -> Void in print(fault ?? "Something has gone wrong  reloadingAllCities()")}
        )
        
    }
    
    // fetch all cities and their tourist sites asychronously, storing results in cities
    func retrieveAllCitiesAsynchronously() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["touristSites"]) // TouristSites referenced in City's touristSites                                             // field will be retrieved for each City
        queryBuilder!.setPageSize(100) // up to 100 TouristSites can be retrieved for each City
        cityDataStore.find(queryBuilder, response: {(results) -> Void in
            self.cities = results as! [City]
            NotificationCenter.default.post(name: .CitiesRetrieved, object: nil) // broadcast a Notification that Cities have been retrieved
        }, error: {(exception) -> Void in
            print(exception.debugDescription)
        })
        
    }*/
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
