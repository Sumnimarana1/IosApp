//
//  EventViewController.swift
//  
//
//  Created by Supraja Kumbam on 10/21/18.
//

import UIKit

class EventViewController: UIViewController {

    var evntName=""
    var evntImage=""
    var evntType=""
    var evntDescription=""
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title=evntName
        self.eventImage.image=UIImage(named: evntImage)
        self.label.text=evntName
        self.eventType.text="Event Type: "+self.evntType
        self.eventDescription.text=evntDescription
    }

    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
