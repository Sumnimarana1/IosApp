//
//  EventData.swift
//  UserSignin
//
//  Created by Kancharla,Sravya on 11/5/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

import UIKit

struct EventData {
    var imageName:String
    var eventTitle:String
    var eventDescription:String
    var eventType:String
    init(imageName:String,eventTitle:String,eventDescription:String,eventType:String) {
        self.imageName=imageName
        self.eventTitle=eventTitle
        self.eventDescription=eventDescription
        self.eventType=eventType
    }
}
