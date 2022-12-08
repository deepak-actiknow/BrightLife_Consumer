//
//  HomeCell.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 07/11/22.
//

import UIKit

class HomeCell: UITableViewCell {
    
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerRatingLabel: UILabel!
    @IBOutlet weak var providerShortDescriptionLabel: UILabel!
    
    var providerNameLabeltext: String = "Variable Name"
    var providerRatingLabeltext: String = "0.0"
    var providerShortDescriptionLabeltext: String = "variable short description"
    var isFavouriteProviderValue: Bool = false
    var providerImageOp: UIImage = UIImage()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        providerNameLabel.text = providerNameLabeltext
        providerRatingLabel.text = providerRatingLabeltext
        providerShortDescriptionLabel.text = providerShortDescriptionLabeltext
        providerImage.image = providerImageOp
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
