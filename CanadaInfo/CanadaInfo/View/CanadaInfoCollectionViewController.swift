//
//  CanadaInfoCollectionViewController.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 26/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import UIKit
import AlamofireImage

class CanadaInfoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Parameteres
    let cellID: String = "CanadaInfoCellId"
    
    //MARK - UI components
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Dependencies
    var viewmodel: CanadaInfoViewModel?
    
    public var canadaInfo: CanadaInfoModel? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    public var canadaInfoHeader: String? = "" {
        didSet {
            navigationItem.title = canadaInfoHeader
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        
        //MARK: - Collection view setting and layout setup
        collectionView?.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        collectionView!.collectionViewLayout = layout
        collectionView!.refreshControl = self.refreshControl
        
        // Configure Refresh Control
        self.refreshControl.addTarget(self, action: #selector(refreshCandaInfoData(_:)), for: .valueChanged)
        self.refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Fetching Canada Info ...", attributes: nil)
        
        self.viewmodel = CanadaInfoViewModel()
        
        self.viewmodel?.getCanadaInfo { canadaInfoModel in
            self.canadaInfo = canadaInfoModel
        }
        
        self.collectionView?.register(CanadaInfoCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    @objc private func refreshCandaInfoData(_ sender: Any) {
        //MARK: - Fetch canda info
         self.viewmodel?.getCanadaInfo { canadaInfoModel in
                   self.canadaInfo = canadaInfoModel
                   self.refreshControl.endRefreshing()
               }
    }
    
    //MARK: - Collection view delegates
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.canadaInfo?.rows?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CanadaInfoCell
        
        self.canadaInfoHeader = self.self.canadaInfo?.title
        let canadaInfo = self.canadaInfo?.rows?[indexPath.row]
        
        
        //MARK: - load canada info into cell
        cell.configure(title: canadaInfo?.title, description: canadaInfo?.description, imageUrl: canadaInfo?.imageHref)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let referenceHeight: CGFloat = 100 // Approximate height of your cell
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
}
