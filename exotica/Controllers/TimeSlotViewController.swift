//
//  TimeSlotViewController.swift
//  exotica
//
//  Created by Nick Moignard on 23/3/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TimeSlotViewController: UIViewController, UITextFieldDelegate {
    var timeSlot: TimeSlot = TimeSlot()
    var upstairsMainText = "", upstairsSecondaryText = "", downstairsOneText = "", downstairsTwoText = "", downstairsBoothText = "", downstairsBarText = ""
    let networkManager = NetworkManager()
    
    
    @IBOutlet var timeSlotTitle: UILabel!
    @IBOutlet var upstairsMainTextField: UITextField!
    @IBOutlet var upstairsSecondaryTextField: UITextField!
    @IBOutlet var downstairsOneTextField: UITextField!
    @IBOutlet var downstairsTwoTextField: UITextField!
    @IBOutlet var downstairsBoothTextField: UITextField!
    @IBOutlet var downstairsBarTextField: UITextField!
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var FFSLabel: UILabel!
    @IBOutlet var FFPLabel: UILabel!
    @IBOutlet var GFSLabel: UILabel!
    @IBOutlet var GFSTwoLabel: UILabel!
    @IBOutlet var GFBoothLabel: UILabel!
    @IBOutlet var GFBarLabel: UILabel!
    
    var timeSlotTitleVar = ""
    var upstairsMainTextFieldVar: String = ""
    var upstairsSecondaryTextFieldVar: String = ""
    var downstairsOneTextFieldVar: String = ""
    var downstairsTwoTextFieldVar: String = ""
    var downstairsBoothTextFieldVar: String = ""
    var downstairsBarTextFieldVar: String = ""
    
    func setupView() {
        self.updateButton.layer.cornerRadius = 5;
        self.updateButton.layer.masksToBounds = true;
        
        self.timeSlotTitle.layer.cornerRadius = 5;
        self.timeSlotTitle.layer.masksToBounds = true;
        
        self.FFSLabel.layer.cornerRadius = 5;
        self.FFSLabel.layer.masksToBounds = true;
        
        self.FFPLabel.layer.cornerRadius = 5;
        self.FFPLabel.layer.masksToBounds = true;
        
        self.GFSLabel.layer.cornerRadius = 5;
        self.GFSLabel.layer.masksToBounds = true;
        
        self.GFSTwoLabel.layer.cornerRadius = 5;
        self.GFSTwoLabel.layer.masksToBounds = true;
        
        self.GFBoothLabel.layer.cornerRadius = 5;
        self.GFBoothLabel.layer.masksToBounds = true;
        
        self.GFBarLabel.layer.cornerRadius = 5;
        self.GFBarLabel.layer.masksToBounds = true;
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
        setupView()
        timeSlotTitle.text = timeSlotTitleVar
        upstairsMainTextField.text = upstairsMainTextFieldVar
        upstairsSecondaryTextField.text = upstairsSecondaryTextFieldVar
        downstairsOneTextField.text = downstairsOneTextFieldVar
        downstairsTwoTextField.text = downstairsTwoTextFieldVar
        downstairsBoothTextField.text = downstairsBoothTextFieldVar
        downstairsBarTextField.text = downstairsBarTextFieldVar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        if textFieldToChange == upstairsMainTextField {
             upstairsMainText += string
        } else if textFieldToChange == upstairsSecondaryTextField {
            upstairsSecondaryText += string
        } else if textFieldToChange == downstairsOneTextField {
            downstairsOneText += string
        } else if textFieldToChange == downstairsTwoTextField {
            downstairsTwoText += string
        } else if textFieldToChange == downstairsBoothTextField {
            downstairsBoothText += string
        } else if textFieldToChange == downstairsBarTextField {
            downstairsBarText += string
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
//        saveText()
//        setText()
    }
    
    // MARK: Helpers
    private func saveText() {
        if let uMText = upstairsMainTextField.text {
            upstairsMainText = uMText
        }
        if let uSText = upstairsSecondaryTextField.text {
            upstairsSecondaryText = uSText
        }
        if let dOText = downstairsOneTextField.text {
            downstairsOneText = dOText
        }
        if let dTText = downstairsTwoTextField.text {
            downstairsTwoText = dTText
        }
        if let dBoothText = downstairsBoothTextField.text {
            downstairsBoothText = dBoothText
        }
        if let dBarText = downstairsBarTextField.text {
            downstairsBarText = dBarText
        }
        
//        networkManager.updateTimeSlot()
    }
    
    private func setText() {
        print("sry setting dad now")
        var poles = self.timeSlot.poles
        
        
        if let upstairsMain = poles["upstairs_main"] {
            upstairsMainText =  upstairsMain["name"].string != nil ? upstairsMain["name"].string! : ""
        }
        if let upstairsSecondary = poles["upstairs_secondary"] {
            upstairsSecondaryText = upstairsSecondary["name"].string != nil ? upstairsSecondary["name"].string! : ""
        }
        if let downstairsOne = poles["downstairs_one"] {
            downstairsOneText = downstairsOne["name"].string != nil ? downstairsOne["name"].string! : ""
        }
        if let downstairsTwo = poles["downstairs_two"] {
            downstairsTwoText = downstairsTwo["name"].string != nil ? downstairsTwo["name"].string! : ""
        }
        if let downstairsBooth = poles["downstairs_booth"] {
            downstairsBoothText = downstairsBooth["name"].string != nil ? downstairsBooth["name"].string! : ""
        }
        if let downstairsBar = poles["downstairs_bar"] {
            downstairsBarText = downstairsBar["name"].string != nil ? downstairsBar["name"].string! : ""
        }
        
    }
    
    
    
    @IBAction func updateTimeSlot(_ sender: Any) {
        
        var params = timeSlot.poles as Parameters
        saveText()
        
        params["upstairs_main"] = upstairsMainText
        params["upstairs_secondary"] = upstairsSecondaryText
        params["downstairs_one"] = downstairsOneText
        params["downstairs_two"] = downstairsTwoText
        params["downstairs_booth"] = downstairsBoothText
        params["downstairs_bar"] = downstairsBarText
        
        networkManager.editItem(db: .TimeSlots, id: self.timeSlot.id, params: params) {
            json in
            print("edit item completion handler!")
        
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
