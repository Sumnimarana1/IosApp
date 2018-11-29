//
//  HomeCollectionViewController.swift
//  UserSignin
//
//  Created by Supraja Kumbam on 10/28/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var events = Events.events
    var event = Events.events.allEvents
    let backendLess = Backendless()
    //var event:[EventData]=[]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage5.jpg")!)
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        var timer=Timer()
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeCollectionViewController.reloadView), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    
    @objc func reloadView(){
        collectionView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        override func viewWillAppear(_ animated: Bool) {
       events.retrieveAllEventsDataAsynchronously()
        //retrieveDate()
        collectionView.reloadData()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let eventData=eventsData[indexPath.row]
        cell.displayContent(imageName: eventData.imageName ?? "", eventTitle: eventData.eventTitle ?? "", eventDescription: eventData.eventDescription ?? "", eventDate: eventData.eventDate,eventLocation:eventData.eventLocation ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row)
        if let eventController=storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController{
            eventController.evntImage=self.event[indexPath.row].imageName ?? "home.png"
            eventController.evntName=self.event[indexPath.row].eventTitle ?? "No Events"
            eventController.evntDescription=self.event[indexPath.row].eventDescription ?? "Sorry!"
            let dateFormatter=DateFormatter()
            dateFormatter.dateFormat="MM/dd/yy h:mm"
            let date=dateFormatter.string(from: event[indexPath.row].eventDate)
            eventController.evntDate=date
            eventController.evntLocation=self.event[indexPath.row].eventLocation ?? "Try Again"
            self.present(eventController, animated: true, completion: nil)
        }
    }
    

    
}
