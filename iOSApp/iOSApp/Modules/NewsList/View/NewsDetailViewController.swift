import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var byLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var imageRoundView: UIView!
    @IBOutlet private var avatarImage: UIImageView!

    var cellViewModel: NewsCellViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.title = "Details"
        setupImageView()
        if let url = URL(string: cellViewModel?.image ?? "") {
            avatarImage.sd_setImage(with: url, completed: nil)
        }
        titleLabel.text = cellViewModel?.title
        byLabel.text = cellViewModel?.byLine
        dateLabel.text = cellViewModel?.publishedDate
    }

    private func setupImageView() {
        avatarImage.applyShadowWithCorner(containerView: imageRoundView,
                                          color: UIColor(red: 0.68,
                                                         green: 0.68,
                                                         blue: 0.68,
                                                         alpha: 0.8),
                                          radius: 8,
                                          corner: imageRoundView.frame.height / 2)
    }
}
