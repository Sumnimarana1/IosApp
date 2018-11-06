//
//  HomeCollectionViewController.swift
//  UserSignin
//
//  Created by Supraja Kumbam on 10/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 
    var events:[EventData]=[]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage5.jpg")!)
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        
        events.append(EventData(imageName: "", eventTitle: "EventTitle", eventDescription: "EventDescritpion", eventType: "EventType"))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let eventData=events[indexPath.row]
        cell.displayContent(imageName: eventData.imageName, eventTitle: eventData.eventTitle, eventDescription: eventData.eventDescription, eventType: eventData.eventType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row)
        if let eventController=storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController{
            eventController.evntImage=self.events[indexPath.row].imageName
            eventController.evntName=self.events[indexPath.row].eventTitle
            eventController.evntDescription=self.events[indexPath.row].eventDescription
            eventController.evntType=self.events[indexPath.row].eventType
            self.present(eventController, animated: true, completion: nil)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
