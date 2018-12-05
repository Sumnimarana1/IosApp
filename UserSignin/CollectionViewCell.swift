//
//  CollectionViewCell.swift
//  UserSignin
//
//  Created by Supraja Kumbam on 10/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

/* Collection View cell the customized cell for the homeview to appear in the format for the user to view*/
class CollectionViewCell: UICollectionViewCell {
    var evntImage=""
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    
    func displayContent(imageName:String, eventTitle:String, eventDescription:String, eventDate:Date, eventLocation:String){
        self.eventImage.load(url: URL(string: imageName)!)
        self.eventTitle.text=eventTitle
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="MM/dd/yy h:mm"
        let date=dateFormatter.string(from: eventDate)
        self.eventDescription.text=eventDescription+"\n"+date
        self.eventType.text=eventLocation
    }
    
}
