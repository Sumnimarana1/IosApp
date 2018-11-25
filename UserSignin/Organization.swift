//
//  Orgnization.swift
//  UserSignin
//
//  Created by Student on 11/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

@objcMembers
class Organization:NSObject {
    
var OrgName:String?
var eventData:[EventData] = []

override var description: String { // NSObject adheres to the CustomStringConvertible protocol
    return "Name: \(OrgName ?? ""), ObjectId: \(objectId ?? "N/A")"
}
var objectId:String?

static let impossiblePopulation = -1

init(OrgName:String?,eventData:[EventData]){
    self.OrgName = OrgName
   
    self.eventData = eventData
    //self.objectId = ""
}

convenience override init(){
    self.init(OrgName:"", eventData:[])
}

}
