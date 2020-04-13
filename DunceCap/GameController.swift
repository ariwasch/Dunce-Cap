//
//  GameController.swift
//  DunceCap
//
//  Created by Ari Wasch on 3/31/20.
//  Copyright © 2020 Ari Wasch. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation
import GoogleMobileAds
import AudioToolbox

class GameController: UIViewController {
    var motionManager = CMMotionManager()
    //    var timer = Timer()
//    var bannerView: GADBannerView!

    @IBOutlet weak var ad1: GADBannerView!
    @IBOutlet weak var ad2: GADBannerView!
    @IBOutlet weak var ad3: GADBannerView!
    @IBOutlet weak var ad4: GADBannerView!
    @IBOutlet weak var ad5: GADBannerView!
    @IBOutlet weak var ad6: GADBannerView!
    @IBOutlet weak var ad7: GADBannerView!
    @IBOutlet weak var ad8: GADBannerView!
    @IBOutlet weak var ad9: GADBannerView!
    @IBOutlet weak var ad10: GADBannerView!
    var timer = Timer()
    var counter = 0.0
    var roll = 0.0
    var yaw = 0.0
    static var beepSound: AVAudioPlayer?
    var points = 0.0
    let defaults = UserDefaults.standard
    var oldCounter = 0.0
    @IBOutlet weak var pointsDisplay: UILabel!
    let view1 = ViewController()
    
    var start = true
    var compensateYaw = 0.0
    var compensateRoll = 0.0
    override func viewDidLoad() {
       super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(play(timer:)), userInfo: nil, repeats: true)
        UIApplication.shared.isIdleTimerDisabled = true
        timer.fire()
       // Do any additional setup after loading the view.
        
//        ad1 = GADBannerView(adSize: kGADAdSizeBanner)

        
        
//        addBannerViewToView(ad1)
        setUpAds()

   }
    override func viewDidAppear(_ animated: Bool)
    {
        motionManager.gyroUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                self.yaw = (180/3.1415926) * (data?.attitude.pitch as! Double)
//                if(self.yaw < 0){
//                    self.yaw = 360 - abs(self.yaw)
//                }
                self.roll = (180/3.1415926) * (data?.attitude.roll as! Double)
//                if(self.roll < 0){
//                    self.roll = 360 - abs(self.roll)
//                }
            }
        }
    }

    @objc func play(timer: Timer){
//        print(abs(yaw))
        counter += 0.1
//        print(start)
//        print("SFOIJFAF", self.yaw)
//        print("ssadsdas", self.roll)

        if((self.yaw != 0 && self.roll != 0) && start){
            compensateYaw = self.yaw
            compensateRoll = self.roll
            start = false
        }

        if(abs(roll - compensateRoll) > abs(yaw - compensateYaw)){
            delayBeep(angle: abs(roll - compensateRoll))
            backFade(percent: abs(roll - compensateRoll)/30)
        }else{
            delayBeep(angle: abs(yaw - compensateYaw))

            backFade(percent: abs(yaw - compensateYaw)/30)

        }
        
        print(compensateYaw)
        print(yaw)
        if(!start){
        if((abs(roll - compensateRoll) < 30) && abs(yaw - compensateYaw) < 30 && !start){
            pointsDisplay.text = "Score: \(GameController.getTimeStamp(secs: Int(counter)))"
        }else{
//            pointsDisplay.text = "LOSE"

            isHighscore()
            timer.invalidate()
            counter = 0
            performSegue(withIdentifier: "back", sender: nil)
        }
        }
    }

    func isHighscore(){
        let oldScore = defaults.double(forKey: "highscore")
        if(counter > oldScore){
            defaults.set(counter, forKey: "highscore")
        }
        GameOver.score = counter
    }
    
    static func getTimeStamp(secs: Int) -> String{
        let hours = secs / 3600;
        let minutes = (secs % 3600) / 60;
        let seconds = (secs % 60);
//        print(minutes)
        let text = "\(hours):\(minutes):\(seconds)"
        return text
    }
    
    static func beep(){
        do {
           try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        let path = Bundle.main.path(forResource: "beep-3.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            GameController.beepSound = try AVAudioPlayer(contentsOf: url)
            GameController.beepSound?.play()
        } catch {
           print("error")
        }
        
    }
    
    func delayBeep(angle: Double){
        var delay = 0.0
//        if(angle >= 5){
////            delay = pow(0.588704, angle) * 10.6265918
//            delay = 0.2 * cos((90/(15) * (3.1415926/180) * angle))
//        }else{
        if(angle >= 6){
            delay = cos((90/(30) * (3.1415926/180) * angle))
        }else{
            delay = 30
        }
//        }
        
//        let delay = 15 - abs(cos(((90/15) * (3.1415926/180))) * (angle))
//        print(angle)
//        print(delay)
        if(counter - oldCounter > delay){
            GameController.beep()
            oldCounter = counter
        }

    }
    
    public func  backFade(percent: Double){
        let inverse_percent = 1.0 - percent;
        let r = (percent + 0 * inverse_percent)
        let g = (0 * percent + inverse_percent)
        let b = 0
        view.backgroundColor = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)

    }
    func setUpAds(){
        ad1.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad1.rootViewController = self
        ad1.load(GADRequest())
        ad2.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad2.rootViewController = self
        ad2.load(GADRequest())
        ad3.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad3.rootViewController = self
        ad3.load(GADRequest())
        ad4.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad4.rootViewController = self
        ad4.load(GADRequest())
        ad5.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad5.rootViewController = self
        ad5.load(GADRequest())
        ad6.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad6.rootViewController = self
        ad6.load(GADRequest())
        ad7.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad7.rootViewController = self
        ad7.load(GADRequest())
        ad8.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad8.rootViewController = self
        ad8.load(GADRequest())
        ad9.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad9.rootViewController = self
        ad9.load(GADRequest())
        ad10.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        ad10.rootViewController = self
        ad10.load(GADRequest())

    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
     bannerView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(bannerView)
     view.addConstraints(
       [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: bottomLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
       ])
    }

    
}

