//
//  CanadaInfoCell.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 26/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation
import UIKit

class CanadaInfoCell: BaseCell {
    
    
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
        
        // MARK: - Adding Views
        [elementImageView, titleLabel, descriptionLabel].forEach { addSubview($0) }
        
        //MARK: - Constraints
        self.elementImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, padding: .init(top: 16, left: 8 , bottom: 0, right: 0), size: .init(width: 32, height: 32))
        
        self.titleLabel.anchor(top: self.elementImageView.topAnchor, leading: nil, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, centerX: nil, padding: .init(top: 16, left: 0 , bottom: 0, right: 16), size: .init(width: 0, height: 0))
        
        self.descriptionLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.elementImageView.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, centerX: nil, padding: .init(top: 8, left: 0 , bottom: 0, right: 8), size: .init(width: 0, height: 0))
        
    }
    
    func configure(title: String?, description: String?){
        
        guard let title = title, let description = description  else {
            print("one of the necessary info for building the cell was empty")
            return
        }
        
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
