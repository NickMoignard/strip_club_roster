//
//  ViewController.swift
//  exotica
//
//  Created by Nick Moignard on 27/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var network = NetworkManager()
        network.request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

