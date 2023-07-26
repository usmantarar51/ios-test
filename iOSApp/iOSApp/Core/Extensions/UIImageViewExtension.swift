import UIKit

extension UIImageView {
    func applyShadowWithCorner(containerView: UIView,
                               color: UIColor,
                               radius: CGFloat,
                               corner: CGFloat) {
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = color.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = radius
        containerView.layer.cornerRadius = corner
        containerView.layer.shadowPath = UIBezierPath(roundedRect:containerView.bounds,
                                                      cornerRadius: corner).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = corner
    }
}
