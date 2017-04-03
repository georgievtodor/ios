import UIKit

class EpisodeViewCell: UITableViewCell {
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeDate: UILabel!
    @IBOutlet weak var episodeYear: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
