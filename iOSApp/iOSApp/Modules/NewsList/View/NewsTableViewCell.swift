import SDWebImage
import UIKit
import UIView_Shimmer

protocol CellReusableView {
    static var reuseableIdentifier: String { get }
}

extension CellReusableView where Self: UIView {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }
}

class NewsTableViewCell: UITableViewCell, CellReusableView, ShimmeringViewProtocol {
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var byLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateImage: UIImageView!
    @IBOutlet var imageRoundView: UIView!
    @IBOutlet var avatarImage: UIImageView!
    
    
    var cellViewModel: NewsCellViewModel? {
        didSet {
            if let url = URL(string: cellViewModel?.image ?? "") {
                avatarImage.sd_setImage(with: url, completed: nil)
            }
            titleLabel.text = cellViewModel?.title
            byLabel.text = cellViewModel?.byLine
            dateLabel.text = cellViewModel?.publishedDate
        }
    }
    
    var shimmeringAnimatedItems: [UIView] {
        [
            avatarImage,
            titleLabel,
            byLabel,
            dateLabel,
            dateImage
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        avatarImage.applyShadowWithCorner(containerView: imageRoundView,
                                          color: UIColor(red: 0.68,
                                                         green: 0.68,
                                                         blue: 0.68,
                                                         alpha: 0.8),
                                          radius: 8,
                                          corner: imageRoundView.frame.height / 2)
    }
}
