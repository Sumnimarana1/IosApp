//
//  AdminTableViewController.swift
//  UserSignin
//
//  Created by Rana,Sumnima on 10/11/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class AdminTableViewController: UITableViewController {

    let backendless = Backendless.sharedInstance()!
 
    var orgName:String!
    var selectedEvents:EventData!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage8.jpg")!)

        NotificationCenter.default.addObserver(self, selector: #selector(retrieveDataForSelectedOrganization), name: .eventsForSelectedOrgRetrieved, object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func logoutUserAsync() {
        
       
    }

    
    @IBAction func done(segue:UIStoryboardSegue){}
      @IBAction func back(segue:UIStoryboardSegue){}
    @IBAction func cancel(segue:UIStoryboardSegue){}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Events.events.eventsForSelectedOrg.count
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Events.events.selectedEventIndex = indexPath.row
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event_cell", for: indexPath)

        // Configure the cell...
        
        let event = Events.events.eventsForSelectedOrg[indexPath.row]
        
        cell.textLabel?.text = event.eventTitle
        
        cell.detailTextLabel?.text = "Location: \(event.eventLocation!) Date: \(event.eventDate)"
        
        return cell
    }
 
    
    override func viewWillAppear(_ animated:Bool){
        let startDate = Date()
        
        let user = self.backendless.userService.currentUser
        let org = user?.getProperty("OrgName") as! String
      
        Events.events.retrieveDataForSelectedOrganization(org:org)
      
        tableView.reloadData()
        
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
    }
//    @objc func EventDataRetrieved(){
//        tableView.reloadData()
//    }
    
    @objc func retrieveDataForSelectedOrganization() {
        tableView.reloadData()
    }
    

}
