//
//  Player.swift
//  Ratings
//
//  Created by lynn on 16/1/12.
//  Copyright © 2016年 lynn. All rights reserved.
//

import UIKit

class Player {
    var name: String?
    var game: String?
    var rating: Int
    
    init(name: String?, game: String?, rating: Int){
        self.name = name
        self.game = game
        self.rating = rating
    }
}
