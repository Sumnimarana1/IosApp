//
//  Events.swift
//  UserSignin
//
//  Created by Kancharla,Sravya on 11/5/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

/*This is the struct for the EventData that has all the properties similar to the backendless database.*/
@objcMembers
class EventData: NSObject {
    var imageName:String?
    var eventTitle:String?
    var eventDescription:String?
    var eventDate:Date
    var eventLocation:String?
    var objectId:String?
    
    init(imageName:String?,eventTitle:String?,eventDescription:String?,eventDate:Date, eventLocation:String?) {
        self.imageName=imageName
        self.eventTitle=eventTitle
        self.eventDate=eventDate
        self.eventDescription=eventDescription
        self.eventLocation=eventLocation
    }
    
    convenience override init() {
        self.init(imageName:"", eventTitle:"", eventDescription: "", eventDate: Date(),eventLocation:"")
    }
    
  
    
    override var description: String {
        return "EventName: \(eventTitle ?? ""), eventDescription: \(String(describing: eventDescription)), eventDate: \(eventDate), eventLocation: \(String(describing: eventLocation)), ObjectId: \(objectId ?? "N/A")"
    }
    
}
