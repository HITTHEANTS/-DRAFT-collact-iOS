//
//  ProfilePopupVC.swift
//  collact
//
//  Created by minjae on 2019/10/27.
//  Copyright © 2019 minjae. All rights reserved.
//

import UIKit

class ProfilePopupVC: BaseVC {
    
    @IBOutlet weak var gradationColorView: UIView!
    @IBOutlet weak var swipeCardContainerView: UIView!
    @IBOutlet weak var historyCountLabel: UILabel!
    @IBOutlet weak var collectorCountLabel: UILabel!
    @IBOutlet weak var chatableLabel: UILabel!
//    var swipeCardView: SwipeCardView!
    
    override func loadView() {
        super.loadView()
        configureSwipeCardView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraintForDevice(swipeCardContainerView, NotchO: 420, NotchX: 340, identifier: "height")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topToBottomGradientColor(gradationColorView, colorArray: [UIColor(hex: "#ffffff"), UIColor(hex: "#e4e8ed")])
    }
    
    
    func configureSwipeCardView() {
        let array = [0,7,-7,0]
        for i in array {
            let swipeCardView = SwipeCardView()
            swipeCardView.transform = CGAffineTransform(rotationAngle: (CGFloat(i) * .pi) / 180.0)
            swipeCardView.translatesAutoresizingMaskIntoConstraints = false
            swipeCardContainerView.addSubview(swipeCardView)
            
            swipeCardView.topAnchor.constraint(equalTo: swipeCardContainerView.topAnchor).isActive = true
            swipeCardView.leftAnchor.constraint(equalTo: swipeCardContainerView.leftAnchor).isActive = true
            swipeCardView.rightAnchor.constraint(equalTo: swipeCardContainerView.rightAnchor).isActive = true
            swipeCardView.bottomAnchor.constraint(equalTo: swipeCardContainerView.bottomAnchor).isActive = true
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    

}
