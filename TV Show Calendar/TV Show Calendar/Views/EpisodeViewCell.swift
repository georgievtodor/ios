//
//  EpisodeViewCell.swift
//  TV Show Calendar
//
//  Created by Todor on 4/2/17.
//  Copyright © 2017 Todor. All rights reserved.
//

import UIKit

class EpisodeViewCell: UITableViewCell {
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeDate: UILabel!
    @IBOutlet weak var episodeYear: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
