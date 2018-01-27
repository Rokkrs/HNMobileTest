//
//  CustomCell.swift
//  HNMobileTest
//
//  Created by Oscar Cuadra on 1/26/18.
//  Copyright © 2018 Oscar Cuadra. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var story_title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    
    func customInit(story_title: String, author: String) {
        self.story_title.text = story_title
        self.author.text = author
    }
    
}
