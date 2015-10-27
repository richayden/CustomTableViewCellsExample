//
//  CustomTableViewCell.swift
//  CustomTableViewCellsExample
//
//  Created by Bob Pascazio on 10/22/15.
//  Copyright © 2015 Bob Pascazio. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate : NSObjectProtocol {
    func buyButtonHit()
    
}

class CustomTableViewCell: UITableViewCell {

    @IBAction func orderButtonHit(sender: AnyObject) {
        
        if let delegate_ = self.delegate {
            delegate_.buyButtonHit()
            
        }
    }
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    var delegate:CustomTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
