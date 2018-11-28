//
//  OrganizationEventTableViewController.swift
//  UserSignin
//
//  Created by Sravya Kancharla on 11/25/18.
//  Copyright © 2018 Sravya Kancharla. All rights reserved.
//

import UIKit

class EventsforSelectedOrganizationTableViewController: UITableViewController {
   var events:Events!
    var selectedOrg:Organization!

    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage8.jpg")!)

        events = Events.events // our model -- storing it in a local variable so we don't always have to keep writing TouristBureau.touristBureau :-)
        
        // We will be notified when a .CitiesRetrieved notification is posted
        // and the citiesRetrieved() method will be triggered
        // this is how we can handle asynchronous retrieval in our model
        NotificationCenter.default.addObserver(self, selector: #selector(EventsForSelectedOrgRetrieved), name: .eventsForSelectedOrgRetrieved , object: nil)
      
    }

    // MARK: - Table view data source
    @objc func EventsForSelectedOrgRetrieved() {
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let startDate = Date()
        //touristBureau.reloadTouristSitesForSelectedCity()
        self.navigationItem.title = events.selectedOrg?.OrgName!
        events.retrieveDataForSelectedOrganization()
        tableView.reloadData()
        
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.numeventsForSelectedOrg()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath)
        
        // Configure the cell...
        
        let event = events.eventsForSelectedOrg[indexPath.row]
        cell.textLabel?.text = event.eventTitle
        cell.detailTextLabel?.text = "\(event.eventDate)" + " \(String(describing: event.eventLocation))"
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
