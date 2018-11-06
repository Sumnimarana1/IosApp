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
    
    func displayContent(imageName:String, eventTitle:String, eventDescription:String, eventType:String){
        self.eventImage.image=UIImage(named: imageName)
        self.eventTitle.text=eventTitle
        self.eventDescription.text=eventDescription
        self.eventType.text=eventType	
    }
    
}