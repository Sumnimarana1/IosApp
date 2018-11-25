//
//  OrganizationTableViewController.swift
//  UserSignin
//
//  Created by Student on 11/24/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class OrganizationTableViewController: UITableViewController {

     var events:Events!
    override func viewDidLoad() {
        super.viewDidLoad()

        events = Events.events // our model -- storing it in a local variable so we don't always have to keep writing TouristBureau.touristBureau :-)
        
        // We will be notified when a .CitiesRetrieved notification is posted
        // and the citiesRetrieved() method will be triggered
        // this is how we can handle asynchronous retrieval in our model
        NotificationCenter.default.addObserver(self, selector: #selector(orgRetrieved), name: .OrgRetrieved, object: nil)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        events.retrieveAllOrganization()
        //touristBureau.retrieveAllCitiesAsynchronously() // this is faster ...
        tableView.reloadData()
    }
    
    @objc func orgRetrieved(){
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.numOrg()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Orgcell", for: indexPath)

        // Configure the cell...

        let org = events[indexPath.row]
        cell.textLabel?.text = org.OrgName
        //cell.detailTextLabel?.text = "\(org.population)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        events.selectedOrg = events[indexPath.row]
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
