//
//  loginView.swift
//  UserSignin
//
//  Created by Student on 9/30/18.
//  Copyright © 2018 Student. All rights reserved.
//
import UIKit
import Foundation

struct EventData {
    var imageName:String
    var eventTitle:String
    var eventDescription:String
    var eventDate:Date
    var eventLocation:String
    init(imageName:String,eventTitle:String,eventDescription:String,eventDate:Date, eventLocation:String) {
        self.imageName=imageName
        self.eventTitle=eventTitle
        self.eventDate=eventDate
        self.eventDescription=eventDescription
        self.eventLocation=eventLocation
    }
}

struct AllEvents {
    var nameOfEvent:String
    var Location:String
    var DateOfEvent:String
    var Organization:String
    var Description:String
}

struct Events {
    
    static var events:Events = Events()
    
    private init(){}
    
    var selectedEventIndex:Int = -1
    
    func selectedEvent() -> AllEvents {
        return allEvents[selectedEventIndex]
    }
    
    //    mutating func addNewCityFlown(city:String){
    //        airlines[selectedAirlineIndex].citiesFlown.append(city)
    //    }
    
    //    var allEvents:[AllEvents] = []
    
     var allEvents:[AllEvents] = [
        AllEvents(nameOfEvent: "Dandiya Night", Location: "Tower View", DateOfEvent: "12/22/2018",Organization: "ISA", Description : "For Dushhera"),
        AllEvents(nameOfEvent: "United", Location: " ", DateOfEvent: "Chicago",Organization: " ", Description : " "),
        AllEvents(nameOfEvent: "United", Location: " ", DateOfEvent: "Chicago",Organization: " ", Description : " "),

        ]
    
    // the idea is that we will keep airlines private, and access it using these methods
    
    // returns # of airlines
    func numEvents()->Int {
        return allEvents.count
    }
    
    // returns a particular airline
    func eventNum(_ index:Int) -> AllEvents {
        return allEvents[index]
    }
    
    subscript(index:Int)->AllEvents{
        return allEvents[index]
    }
    
    // adds a new airline to the mix
    mutating func addNewEvent(_ event:AllEvents){
        allEvents.append(event)
    }
}
