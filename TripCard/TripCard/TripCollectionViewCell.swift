//
//  TripCollectionViewCell.swift
//  TripCard
//
//  Created by Студент on 4/19/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

protocol TripCollectionCellDelegate {
    
    func didLikeButtonPressed(cell: TripCollectionViewCell)
    
}

class TripCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var totalDaysLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        delegate?.didLikeButtonPressed(cell: self)
    }

    
    var delegate:TripCollectionCellDelegate?
    

    
    var isLiked:Bool = false {
        
        didSet {
            
            if isLiked {
                
                likeButton.setImage(UIImage(named: "heartfull"), for: .normal)
                
            } else {
                
                likeButton.setImage(UIImage(named: "heart"), for: .normal)
                
            }
            
        }
    }
    
    
}
