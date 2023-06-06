//
//  MainTableViewCell.swift
//  HiveScreeningTest
//
//  Created by Manu on 06/06/23.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.layer.cornerRadius = 5
        myImageView.layer.borderColor = UIColor.gray.cgColor
        myImageView.layer.borderWidth = 1
        
    }
    
    func setup(page: Page){
        titleLabel.text = page.title
        if let url = page.thumbnail?.source{
            myImageView.imageFromServerURL(urlString: url)
        }else{
            myImageView.isHidden = true
        }
        if let width = page.thumbnail?.width, let height = page.thumbnail?.height{
            imageViewWidthConstraint.constant = CGFloat(width) * 2
            imageViewHeightConstraint.constant = CGFloat(height) * 2
        }
        subTitleLabel.text = page.extract
        layoutIfNeeded()
    }
}
