//
//  ViewController.swift
//  DunceCap
//
//  Created by Ari Wasch on 3/30/20.
//  Copyright © 2020 Ari Wasch. All rights reserved.
//

import UIKit
import CoreMotion
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var highscore: UILabel!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        highscore.text = "Best: \(GameController.getTimeStamp(secs: Int(defaults.double(forKey: "highscore"))))"

        // Do any additional setup after loading the view.
    }

    
    @IBAction func start(_ sender: Any) {
        performSegue(withIdentifier: "start", sender: nil)
        
    }
    
//    @objc func fire(){
//        print(timer.timeInterval)
//    }

}

