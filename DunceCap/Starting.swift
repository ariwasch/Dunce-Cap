//
//  Starting.swift
//  DunceCap
//
//  Created by Ari Wasch on 4/6/20.
//  Copyright © 2020 Ari Wasch. All rights reserved.
//

import UIKit
import CoreMotion


class Starting: UIViewController {
    
    var timer = Timer()
    var counter = 0.0

    @IBOutlet weak var countDown: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0.0
        var exactCount = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fire(timer:)), userInfo: nil, repeats: true)
        timer.fire()

        // Do any additional setup after loading the view.
    }
    
    @objc func fire(timer: Timer)
    {
//            print(counter)
        if(counter > 5){
            performSegue(withIdentifier: "game", sender: nil)
            timer.invalidate()
            counter = 0
        }else{
            countDown.text = String(5 - Int(floor(counter)))
            backFade(percent: counter/5)
            if(((Int(counter * 10)) % 10) == 0){
                GameController.beep()
            }
        }
        counter += 0.1
    
    }


    
//    @objc func fire(){
//        print(timer.timeInterval)
//    }
    public func  backFade(percent: Double){
        let inverse_percent = 1.0 - percent;
        let r = (0 * percent + inverse_percent)
        let g = (percent + 0 * inverse_percent)
        let b = 0
        view.backgroundColor = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
    }


}


