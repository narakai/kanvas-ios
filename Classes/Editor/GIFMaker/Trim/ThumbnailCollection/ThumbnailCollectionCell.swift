//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation
import UIKit

/// Constants for StickerTypeCollectionCell
private struct Constants {
    static let imageHeight: CGFloat = 50
    static let imageWidth: CGFloat = 50
}

/// The cell in ThumbnailCollectionView to display
final class ThumbnailCollectionCell: UICollectionViewCell {
    
    static let cellHeight = Constants.imageHeight
    static let cellWidth = Constants.imageWidth
    
    private let mainView = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    /// Updates the cell to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.image = nil
    }
    
    // MARK: - Layout
    
    private func setUpView() {
        setUpMainView()
    }
    
    /// Sets up the container that changes its color depending on whether the cell is selected or not
    private func setUpMainView() {
        contentView.addSubview(mainView)
        mainView.accessibilityIdentifier = "Thumbnail Collection Cell Main View"
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            mainView.widthAnchor.constraint(equalToConstant: Constants.imageWidth)
        ])
    }
    
    // MARK: - Public interface
    
    /// Updates the cell with an image
    ///
    /// - Parameter image: The image to display
    func bindTo(_ image: UIImage) {
        mainView.image = image
    }
}