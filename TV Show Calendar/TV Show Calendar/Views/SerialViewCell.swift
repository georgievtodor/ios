import UIKit

class SerialViewCell: UICollectionViewCell {

    @IBOutlet weak var tvShowImage: UIImageView!

    @IBOutlet weak var tvShowName: UILabel!
    
    @IBOutlet weak var tvShowRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tvShowName.translatesAutoresizingMaskIntoConstraints = false
        tvShowRating.translatesAutoresizingMaskIntoConstraints = false
        tvShowImage.translatesAutoresizingMaskIntoConstraints = false
        
        let tvShowImageBottomConstraint = NSLayoutConstraint(item: tvShowImage, attribute: .bottom, relatedBy: .equal, toItem: tvShowName, attribute: .top, multiplier: 1, constant: 0)
        
        let tvShowImageLeftConstraint = NSLayoutConstraint(item: tvShowImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        
        let tvShowImageRightConstraint = NSLayoutConstraint(item: tvShowImage, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        
        let tvShowImageTopConstraint = NSLayoutConstraint(item: tvShowImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        
        let tvShowNameBottomConstraint = NSLayoutConstraint(item: tvShowName, attribute: .bottom, relatedBy: .equal, toItem: tvShowRating, attribute: .top, multiplier: 1, constant: 0)
        
        let tvShowNameLeftConstraint = NSLayoutConstraint(item: tvShowName, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        
        let tvShowNameRightConstraint = NSLayoutConstraint(item: tvShowName, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        
        let tvShowRatingBottomConstraint = NSLayoutConstraint(item: tvShowRating, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        let tvShowRatingRigthConstraint = NSLayoutConstraint(item: tvShowRating, attribute: .leading, relatedBy: .equal, toItem: tvShowName, attribute: .leading, multiplier: 1, constant: 0)
        
        addConstraint(tvShowNameBottomConstraint)
        addConstraint(tvShowNameLeftConstraint)
        addConstraint(tvShowNameRightConstraint)
        addConstraint(tvShowRatingBottomConstraint)
        addConstraint(tvShowRatingRigthConstraint)
        addConstraint(tvShowImageBottomConstraint)
        addConstraint(tvShowImageTopConstraint)
        addConstraint(tvShowImageLeftConstraint)
        addConstraint(tvShowImageRightConstraint)
    }

}
