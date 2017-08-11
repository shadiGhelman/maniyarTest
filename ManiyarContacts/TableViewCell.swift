//
//  TableViewCell.swift
//  ManiyarContacts
//
//  Created by Shadi Ghelman on 8/9/17.
//  Copyright © 2017 Shadi Ghelman. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   

}
