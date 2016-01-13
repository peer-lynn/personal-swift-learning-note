//
//  AddPlayerTableViewController.swift
//  Ratings
//
//  Created by lynn on 16/1/13.
//  Copyright © 2016年 lynn. All rights reserved.
//

import UIKit

class AddPlayerTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var player:Player?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let player = player{
            nameTextField.text = player.name
            detailLabel.text = player.game
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            nameTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "SavePlayerSegue"{
            player = Player(name: nameTextField.text, game: player?.game, rating: 3)
        }
        
        if segue.identifier == "PickerGame"{
            if let pickGameController = segue.destinationViewController as? GamePickerTableViewController
            {
                pickGameController.selectedGame = player?.game
            }
            
        }
        
    }
    
    @IBAction func unwindWithSelectedGame(segue: UIStoryboardSegue){
        if let sourceController = segue.sourceViewController as? GamePickerTableViewController,
            selectedGame = sourceController.selectedGame{
              player?.game = selectedGame
        }
    }
}
