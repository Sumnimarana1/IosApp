//
//  HomeViewController.swift
//  UserSignin
//
//  Created by Supraja Kumbam on 10/19/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func event1(_ sender: Any) {
        if let events=storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController{
            events.evntImage=""
            events.evntName="Denim"
            events.evntDescription="Thursday, February 15 at 9PM CST"
            events.evntType="Social"
            self.present(events, animated: true, completion: nil)
        }
    }
    
    @IBAction func event2(_ sender: Any) {
        if let events=storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController{
            events.evntImage=""
            events.evntName="Campus Crush Event"
            events.evntDescription="Thursday, February 15 at 9PM CST"
            events.evntType="Fundraising"
            self.present(events, animated: true, completion: nil)
        }
    }
    @IBAction func event3(_ sender: Any) {
        if let events=storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController{
            events.evntImage=""
            events.evntName="Phl Mu Ball"
            events.evntDescription="Thursday, February 15 at 9PM CST"
            events.evntType="Fundraising"
            self.present(events, animated: true, completion: nil)
        }
    }
    @IBAction func event4(_ sender: Any) {
        if let events=storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController{
            events.evntImage=""
            events.evntName="Tribute To The Ladies"
            events.evntDescription="Thursday, February 15 at 9PM CST"
            events.evntType="Cultural"
            self.present(events, animated: true, completion: nil)
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
