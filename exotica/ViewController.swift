//
//  ViewController.swift
//  exotica
//
//  Created by Nick Moignard on 27/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource {
    private var setTimes: [SetTime] = [], dancers: [Dancer] = [], stages: [Stage] = []
    private var timeModel = TimeModel()
    private var sections = [Date: [SetTime]]()
    
    @IBOutlet weak var tableView: UITableView!
    private func sortById(model: Table) {
        switch model {
            case .dancers:
                dancers.sort(by: { (a, b) -> Bool in
                    if a.id < b.id {
                        return true
                    } else {
                        return false
                    }
                })
            case .stages:
                stages.sort(by: { (a, b) -> Bool in
                    if (a.id < b.id ) {
                        return true
                    } else {
                        return false
                    }
                })
            default:
                print("dont use that table here!")
        }
    }
    private func fillTimeSlotsWithSetTimes() {
        setTimes.sort(by: { (a, b) -> Bool in
            if a.time < b.time {
                return true
            } else {
                return false
            }
            })
        for set in setTimes {
            if (sections[set.time] == nil) {
                sections[set.time] = []
            }
            sections[set.time]!.append(set) // group by time
        }
        print(sections)
        self.reloadData()
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        
        // Grab info from server
        let network = NetworkManager()
        network.getItems(db: .stages) {
            json in
            self.stages = network.parseJSONIntoObjects(type: .stages, json: json) as! [Stage]
//            print("Stages: \(self.stages)")
            self.tableView.reloadData()
        }
        network.getItems(db: .dancers) {
            json in
            self.dancers = network.parseJSONIntoObjects(type: .dancers, json: json) as! [Dancer]
//            print("Dancers: \(self.dancers)")
            self.tableView.reloadData()
        }
        network.getItems(db: .setTimes) {
            json in
            self.setTimes = network.parseJSONIntoObjects(type: .setTimes, json: json) as! [SetTime]
            self.fillTimeSlotsWithSetTimes()
        }
    }

    

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var dates = sections.keys.sorted()
        return "\(timeModel.dateToString(dates[section]))"
    }
    
    // how many rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var dateTimes = sections.keys.sorted()
        return sections[dateTimes[section]]!.count
    }
    
    // fill each cell with data
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        var dates = sections.keys.sorted()
        let cell = tableView.dequeueReusableCell(withIdentifier: "rosterCell") as! TableViewCell
        
        let _setTime = sections[dates[indexPath.section]]![indexPath.row]

        
        
        let dancer = dancers.first { (stripper) -> Bool in
            if stripper.id == _setTime.dancer_id {
                return true
            } else {
                return false
            }
        }
        if dancer != nil {
            cell.label.text = dancer!.fakeName
        }
        
        
        
       
        
        
        
        return cell
    }

    private func reloadData() {
        self.sortById(model: .stages)
        self.sortById(model: .dancers)
        self.tableView.reloadData()
    }
}


