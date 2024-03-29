//
//  HomeVC.swift
//  collact
//
//  Created by minjae on 29/09/2019.
//  Copyright © 2019 minjae. All rights reserved.
//

import UIKit

protocol CollaboDetailDelegate {
    func enterCollaboDetail()
}

class HomeVC: BaseVC {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var collaboButton: UIButton!
    @IBOutlet weak var artistView: UIView!
    @IBOutlet weak var collaboView: UIView!
    @IBOutlet weak var svBorderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewType: ViewType = .ARTIST
    let artistCardCVC = UINib(nibName: "ArtistCardCVC", bundle: nil)
    let collaboCardCVC = UINib(nibName: "CollaboCardCVC", bundle: nil)
    let myArtistCount = Int(ceil(15 / 3))
    let mycollaboCount = Int(ceil(17 / 2))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.setCollectionView()
        self.setRecentlyCollaboView()
        self.setTodayArtistView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    func setTodayArtistView() {
        let view = Bundle.main.loadNibNamed("TodayArtistView", owner: self, options: nil)?.first as! TodayArtistView
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 330)
        artistView.addSubview(view)
    }
    
    func setRecentlyCollaboView() {
        let view = Bundle.main.loadNibNamed("RecentlyCollaboView", owner: self, options: nil)?.first as! RecentlyCollaboView
        view.frame = CGRect(x: 0, y: 0, width: collaboView.frame.width, height: 280)
        view.collaboDetailDelegate = self
        collaboView.addSubview(view)
    }
    
    
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(artistCardCVC, forCellWithReuseIdentifier: "ArtistCard")
        self.collectionView.register(collaboCardCVC, forCellWithReuseIdentifier: "CollaboCard")
        if viewType == .ARTIST {
            self.setConstraint(collectionView, value: CGFloat(160 * myArtistCount))
        } else {
            self.setConstraint(collectionView, value: CGFloat(160 * mycollaboCount))
        }
    }
    
    @IBAction func changeToView(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.artistButton.setTitleColor(UIColor.black, for: .normal)
            self.artistView.isHidden = false
            self.collaboButton.setTitleColor(UIColor.black15, for: .normal)
            self.collaboView.isHidden = true
            self.viewType = .ARTIST
        case 1:
            self.artistButton.setTitleColor(UIColor.black15, for: .normal)
            self.artistView.isHidden = true
            self.collaboButton.setTitleColor(UIColor.black, for: .normal)
            self.collaboView.isHidden = false
            self.viewType = .COLLABO
        default:
            break
        }
        if viewType == .ARTIST {
            self.setConstraint(collectionView, value: CGFloat(160 * myArtistCount))
        } else {
            self.setConstraint(collectionView, value: CGFloat(160 * mycollaboCount))
        }
        collectionView.reloadData()
    }
    
}
extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewType == .ARTIST {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCard", for: indexPath) as! ArtistCardCVC
            setConstraint(cell.imageView, value: (self.collectionView.frame.width - 16) / 3)
//            cell.imageView.image = UIImage(named: "demoImage1")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollaboCard", for: indexPath) as! CollaboCardCVC
            setConstraint(cell.imageContainer, value: (self.collectionView.frame.width - 8) / 2)
//            cell.leftImageView.image = UIImage(named: "demoImage1")
//            cell.rightImageView.image = UIImage(named: "demoImage2")
            return cell
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let artistCardWidth = (self.collectionView.frame.width - 16) / 3
        let collaboCardWidth = (self.collectionView.frame.width - 8) / 2
        if viewType == .ARTIST {
            return CGSize(width: artistCardWidth, height: 160)
        } else {
            return CGSize(width: collaboCardWidth, height: 160)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if viewType == .ARTIST {
            if offsetY < 330 {
                svBorderView.isHidden = true
            } else {
                svBorderView.isHidden = false
            }
        } else {
            if offsetY < 360 {
                svBorderView.isHidden = true
            } else {
                svBorderView.isHidden = false
            }
        }
    }
}

extension HomeVC: CollaboDetailDelegate {
    func enterCollaboDetail() {
        self.performSegue(withIdentifier: "CollaboDetail", sender: nil)
    }
}

