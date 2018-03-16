//
//  ViewController.swift
//  exotica
//
//  Created by Nick Moignard on 27/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import UIKit
import SwiftyJSON

class DailyViewController: UIViewController, UITableViewDataSource {
    
    // MARK: DATA MEMBERS
    private var timeSlots: [TimeSlot] = [], dancers: [Dancer] = []
    private var timeModel = TimeModel()
    private var sections = [Date: [TimeSlot]]()
    @IBOutlet weak var tableView: UITableView!

 
    // MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Slots_DATE"
        tableView.dataSource = self
        

        // Grab info from server
        let network = NetworkManager()

        network.getItems(db: .TimeSlots) {
            json in
            
//            print(json)
            
            self.timeSlots = network.parseJSONIntoObjects(type: .TimeSlots, json: json) as! [TimeSlot]
            // TODO: Get and Parse data for view
//            print(self.timeSlots)
            self.reloadData()
        }
    }
 
    
    // MARK: TABLE VIEW DELEGATE METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var dates = sections.keys.sorted()
//        return "\(timeModel.dateToString(dates[section]))"
//    }
    
    // how many rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return timeSlots.count
    }
    
    // fill each cell with data
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "rosterCell") as! TableViewCell
        cell.label.text = "FUCK MY DAD"
        
        return cell
    }

    // MARK: HELPERS
    
    private func reloadData() {
        // do get data
        self.tableView.reloadData()
    }
    
    private func sortById(model: Table) {
        switch model {
        case .Dancers:
            dancers.sort(by: { (a, b) -> Bool in
                if a.id < b.id {
                    return true
                } else {
                    return false
                }
            })
            
        default:
            print("dont use that table here!")
        }
    }
}


