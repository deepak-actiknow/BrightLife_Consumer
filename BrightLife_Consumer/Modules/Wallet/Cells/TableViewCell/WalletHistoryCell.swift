//
//  WalletHistoryCell.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 11/11/22.
//

import UIKit

class WalletHistoryCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titleHistory: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
