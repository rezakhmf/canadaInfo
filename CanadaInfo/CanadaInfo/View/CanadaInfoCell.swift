//
//  CanadaInfoCell.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 26/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class CanadaInfoCell: BaseCell {
    
    // MARK: - Dependencies
    var viewmodel: CanadaInfoViewModel?
    var request: Request?
    
    // MARK: - Parameters
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    //MARK: - UI components
    var elementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "info_pic")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Not available!"
        label.font = UIFont.boldSystemFont(ofSize:15)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Not available!"
        label.font = UIFont.boldSystemFont(ofSize:15)
        label.numberOfLines = 0
        // dynamical lable frame
        var maximumLabelSize: CGSize = CGSize(width: 280, height: 9999)
        var expectedLabelSize: CGSize = label.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = label.frame
        newFrame.size.height = expectedLabelSize.height
        label.frame = newFrame
        return label
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
        self.viewmodel = CanadaInfoViewModel()
        
        // MARK: - Adding Views
        [elementImageView, titleLabel, descriptionLabel].forEach { addSubview($0) }
        
        //MARK: - Constraints
        self.elementImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, padding: .init(top: 16, left: 8 , bottom: 0, right: 0), size: .init(width: 64, height: 64))
        
        self.titleLabel.anchor(top: self.elementImageView.topAnchor, leading: nil, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, centerX: nil, padding: .init(top: 16, left: 0 , bottom: 0, right: 16), size: .init(width: 0, height: 0))
        
        self.descriptionLabel.anchor(top: self.elementImageView.bottomAnchor, leading: self.elementImageView.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, centerX: nil, padding: .init(top: 8, left: 0 , bottom: 0, right: 8), size: .init(width: 0, height: 0))
        
    }
    
    func configure(title: String?, description: String?, imageUrl: String?){
        
        //MARK: - rester image request
        reset()
        
        guard let title = title, let description = description, let imageUrl = imageUrl else {
            print("one of the necessary info for building the cell was empty")
            return
        }
        
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        
        loadImage(imageUrl: imageUrl)
        
    }
    
    func loadImage(imageUrl: String) {
        
        
        if let image = self.cachedImage(for: imageUrl) {
            populateImage(with: image)
            return
        }
        downloadImage(imageUrl: imageUrl)
        
        
    }
    
    func downloadImage(imageUrl: String) {
        request = retrieveImage(for: imageUrl) { image in
            self.populateImage(with: image)
            //add image url to cache as an indentifier
            self.cache(image, for: imageUrl)
        }
    }
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        
        return self.viewmodel?.retrieveImage(for: url) { image in
            
            completion(image)
            } ?? AF.request("", method: .get)
    }
    
    func reset() {
        self.elementImageView.image = nil
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        request?.cancel()
    }
    
    func populateImage(with image: UIImage) {
        self.elementImageView.image = image
    }
    
    //MARK: - Image Caching
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
}
