//
//  PlayerCell.swift
//  Ratings
//
//  Created by lynn on 16/1/12.
//  Copyright © 2016年 lynn. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gameLabel:UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    
    var player: Player!{
        didSet{
            nameLabel.text = player.name
            gameLabel.text = player.game
            ratingImage.image = imageForRating(player.rating)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    func imageForRating(rating:Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
}
