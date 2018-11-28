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
    var events:Events!
    var orgName:String!
     var selectedEvents:EventData!
   
//    var a = ["Dandiya Night", "ISA Dinner", "Potluck"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "appimage8.jpg")!)
        events = Events.events // our model -- storing it in a local variable so we don't always have to keep writing TouristBureau.touristBureau :-)
        
        // We will be notified when a .CitiesReloaded notification is posted
        // and the citiesReloaded() method will be triggered
        // this is how we can handle asynchronous retrieval in our model
        NotificationCenter.default.addObserver(self, selector: #selector(EventDataRetrieved), name: .EventDataRetrieved, object: nil)
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
        
        /*backendless.userService.logout( {(user : AnyObject!) -> () in
            print("User logged out.")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as! LoginableViewController
            self.present(nextViewController, animated:true, completion:nil)
        }, error: { ( fault : Fault!) -> () in
            print("Server reported an error: \(fault)")
        })*/
    }

    
    @IBAction func done(segue:UIStoryboardSegue){}
      @IBAction func back(segue:UIStoryboardSegue){}
    @IBAction func cancel(segue:UIStoryboardSegue){}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.numEvents()
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Events.events.selectedEventIndex = indexPath.row
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event_cell", for: indexPath)

        // Configure the cell...
        
        let event = events.allEvents[indexPath.row]
        cell.textLabel?.text = event.eventTitle
        cell.detailTextLabel?.text = "Location: \(String(describing: event.eventLocation)) Date: \(event.eventDate)"
        
        return cell
    }
 
    
    override func viewWillAppear(_ animated:Bool){
        //tableView.reloadData()
           //events.retrieveData()
        let startDate = Date()
        //touristBureau.reloadTouristSitesForSelectedCity()
        //self.navigationItem.title = events.selectedEvents?.eventTitle!
        events.retrieveDataForSelectedOrganization()
        tableView.reloadData()
        
        print("Done in \(Date().timeIntervalSince(startDate)) seconds ")
        
    }
    @objc func EventDataRetrieved(){
        tableView.reloadData()
    }
    
    @objc func retrieveDataForSelectedOrganization() {
        tableView.reloadData()
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
