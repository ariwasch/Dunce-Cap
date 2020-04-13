//
//  GameOver.swift
//  DunceCap
//
//  Created by Ari Wasch on 4/6/20.
//  Copyright © 2020 Ari Wasch. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
import CoreData
import AVFoundation

class GameOver: UIViewController {

    let defaults = UserDefaults.standard
    var loserSound: AVAudioPlayer?

    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var highscore: UILabel!

    static var score = -1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        playLoserSound()
        if(!(GameOver.score == -1)){
            points.text = GameController.getTimeStamp(secs: Int(GameOver.score))
        }
        highscore.text = GameController.getTimeStamp(secs: Int(defaults.double(forKey: "highscore")))

        // Do any additional setup after loading the view.
    }

    
    @IBAction func start(_ sender: Any) {
        performSegue(withIdentifier: "start", sender: nil)
        
    }
    
    func playLoserSound(){
        do {
           try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        let path = Bundle.main.path(forResource: "Match-Abort.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            loserSound = try AVAudioPlayer(contentsOf: url)
            loserSound?.play()
        } catch {
           print("error")
        }
    }

}
