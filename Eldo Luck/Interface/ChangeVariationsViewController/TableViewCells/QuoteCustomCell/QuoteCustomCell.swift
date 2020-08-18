//
//  QuoteCustomCell.swift
//  Eldo Luck
//
//  Created by Анастасия on 15.05.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit

class QuoteCustomCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var quoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
