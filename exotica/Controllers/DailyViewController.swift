//
//  ViewController.swift
//  exotica
//
//  Created by Nick Moignard on 27/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import UIKit
import SwiftyJSON

class DailyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: DATA MEMBERS
    private var timeSlots: [TimeSlot] = [], dancers: [Dancer] = []
    private var timeModel = TimeModel()
    private var sections = [Date: [TimeSlot]]()
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.getData()
    }
    
    private func getData() {
        // Grab info from server
        let network = NetworkManager()
        
        network.getItems(db: .TimeSlots) {
            json in
            self.timeSlots = network.parseJSONIntoObjects(type: .TimeSlots, json: json) as! [TimeSlot]
            // TODO: Get and Parse data for view
            self.reloadData()
        }
    }
    
    // MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Slots_DATE"
        tableView.dataSource = self
        self.getData()
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TimeSlotTableViewCell
        cell.timeSlot = timeSlots[indexPath.row]
        
        
        
        
        
        var cellText = ""

        cellText += timeModel.dateToString(timeSlots[indexPath.row].time)

        var poles = timeSlots[indexPath.row].poles
        

        if let upstairsMain = poles["upstairs_main"] {
            cell.upstairsMain.text = upstairsMain.string != nil ? upstairsMain.string!.firstUppercased : ""
        }
        if let upstairsSecondary = poles["upstairs_secondary"] {
            cell.upstairsSecondary.text = upstairsSecondary.string != nil ? upstairsSecondary.string!.firstUppercased : ""
        }
        if let downstairsOne = poles["downstairs_one"] {
            cell.downstairsOne.text = downstairsOne.string != nil ? downstairsOne.string!.firstUppercased : ""
        }
        if let downstairsTwo = poles["downstairs_two"] {
            cell.downstairsTwo.text = downstairsTwo.string != nil ? downstairsTwo.string!.firstUppercased : ""
        }
        if let downstairsBooth = poles["downstairs_booth"] {
            cell.downstairsBooth.text = downstairsBooth.string != nil ? downstairsBooth.string!.firstUppercased : ""
        }
        if let downstairsBar = poles["downstairs_bar"] {
            cell.downstairsBar.text = downstairsBar.string != nil ? downstairsBar.string!.firstUppercased : ""
        }
        cell.timeLabel.text = cellText
        
        
        return cell
    }
    
    // MARK: SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TimeSlotViewController
        {
            let vc = segue.destination as? TimeSlotViewController
            var senderCell = sender as! TimeSlotTableViewCell
            vc?.timeSlot = senderCell.timeSlot
            
            if let _text = senderCell.timeLabel.text {
                vc?.timeSlotTitleVar = _text
            } else {
                vc?.timeSlotTitleVar = ""
            }

            
            
        
            
            vc?.upstairsMainTextFieldVar = senderCell.upstairsMain.text != nil ? senderCell.upstairsMain.text! : ""
            vc?.upstairsSecondaryTextFieldVar = senderCell.upstairsSecondary.text != nil ? senderCell.upstairsSecondary.text! : ""
            vc?.downstairsOneTextFieldVar = senderCell.downstairsOne.text != nil ? senderCell.downstairsOne.text! : ""
            vc?.downstairsTwoTextFieldVar =  senderCell.downstairsTwo.text != nil ? senderCell.downstairsTwo.text! : ""
            vc?.downstairsBoothTextFieldVar = senderCell.downstairsBooth.text != nil ? senderCell.downstairsBooth.text! : ""
            vc?.downstairsBarTextFieldVar = senderCell.downstairsBar.text != nil ? senderCell.downstairsBar.text! : ""
            
        }
    }

    // MARK: HELPERS
    
    private func stageName(key: String) -> String {
        var stageName = ""
        
        switch key {
        case "upstairs_main":
            stageName = "Upstairs Main"
        case "upstairs_secondary":
            stageName = "Upstairs Second"
        case "downstairs_one":
            stageName = "Downstairs Main"
        case "downstairs_two":
            stageName = "Downstairs Main"
        case "downstairs_booth":
            stageName = "Downstairs Booth"
        case "downstairs_bar":
            stageName = "Downstairs Bar"
        default:
            stageName = "Something went horribly wrong"
            print("well fuck my dad")
        }
        
        return stageName
    }
    
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


