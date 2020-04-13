//
//  Instructions.swift
//  Social Distance Checker
//
//  Created by Ari Wasch on 3/25/20.
//  Copyright © 2020 Ari Wasch. All rights reserved.
//

import UIKit
import GoogleMobileAds
class InfoPage: UIViewController {
    
    
    @IBOutlet weak var text: UITextView!
//    var bannerView: GADBannerView!

    @IBOutlet weak var selfieValue: UISwitch!
    @IBAction func selfieCam(_ sender: Any) {
    }
    override func viewDidLoad() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
//        bannerView = GADBannerView(adSize: kGADAdSizeLargeBanner)
//        bannerView.adUnitID = "ca-app-pub-2006923484031604/2807760775"
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"  //test
//        bannerView.rootViewController = self
//        addBannerViewToView(bannerView)
//        bannerView.load(GADRequest())
        super.viewDidLoad()

        text.text = "How to play \n \nThe goal of Dunce Cap is to see how long you can keep your phone balanced on your head. It can be a fun party game, a game you compete against friends, or a game that boosts your productivity when your phone isn't in sight (because it's on your head, silly). \n\nPush the big play button on the home page to start. You will have 5 seconds to place your phone on your head with the screen facing up and the back on your head. After the 5 seconds is up, the app will record your phone's initial angle on your head. If your phone moves more than 30 degrees from the initial angle, you lose.\n\nMake sure to play with sound on, so you know when you lose...or about to lose!"

//        self.view.bringSubviewToFront(bannerView);

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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
