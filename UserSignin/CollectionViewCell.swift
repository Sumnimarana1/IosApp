//
//  CollectionViewCell.swift
//  UserSignin
//
//  Created by Supraja Kumbam on 10/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    
    func displayContent(imageName:String, eventTitle:String, eventDescription:String, eventDate:Date, eventLocation:String){
        self.eventImage.image=Events.events.selectedImage
        self.eventTitle.text=eventTitle
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="MM/dd/yy h:mm"
        let date=dateFormatter.string(from: eventDate)
        self.eventDescription.text=eventDescription+"\n"+date
        self.eventType.text=eventLocation
    }
    
}
