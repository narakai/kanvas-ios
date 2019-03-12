//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation
import UIKit
import TumblrTheme

private struct MediaClipsEditorViewConstants {
    static let animationDuration: TimeInterval = 0.5
    static let buttonHorizontalMargin: CGFloat = 28
    static let buttonRadius: CGFloat = 25
    static let buttonWidth: CGFloat = 91
    static let buttonHeight: CGFloat = 40.5
    static let buttonTopOffset: CGFloat = 4.8
    static let topPadding: CGFloat = 6
    static let bottomPadding: CGFloat = 12 + (Device.isIPhoneX ? 12 : 0)
}

protocol MediaClipsEditorViewDelegate: class {
    /// Callback for when preview button is selected
    func previewButtonWasPressed()
}

/// View for media clips editor
final class MediaClipsEditorView: IgnoreTouchesView {
    
    static let height = MediaClipsCollectionView.height +
                        MediaClipsEditorViewConstants.topPadding +
                        MediaClipsEditorViewConstants.bottomPadding

    let collectionContainer: IgnoreTouchesView
    let previewButton: UIButton

    weak var delegate: MediaClipsEditorViewDelegate?

    init() {
        collectionContainer = IgnoreTouchesView()
        collectionContainer.backgroundColor = .clear
        collectionContainer.accessibilityIdentifier = "Media Clips Collection Container"
        collectionContainer.clipsToBounds = false

        previewButton = UIButton()
        previewButton.accessibilityIdentifier = "Media Clips Preview Button"
        super.init(frame: .zero)
        
        clipsToBounds = false
        backgroundColor = KanvasCameraColors.translucentBlack
        setUpViews()
        previewButton.addTarget(self, action: #selector(previewPressed), for: .touchUpInside)
    }

    @available(*, unavailable, message: "use init() instead")
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }

    @available(*, unavailable, message: "use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public interface
    
    /// shows or hides the complete view
    ///
    /// - Parameter show: true to show, false to hide
    func show(_ show: Bool) {
        UIView.animate(withDuration: MediaClipsEditorViewConstants.animationDuration) { [weak self] in
            self?.alpha = show ? 1 : 0
        }
    }
    
    /// shows or hides the preview button
    ///
    /// - Parameter show: true to show, false to hide
    func showPreviewButton(_ show: Bool) {
        UIView.animate(withDuration: MediaClipsEditorViewConstants.animationDuration) { [weak self] in
            self?.previewButton.alpha = show ? 1 : 0
        }
    }
}

// MARK: - UI Layout
private extension MediaClipsEditorView {

    func setUpViews() {
        setUpCollection()
        setUpPreview()
    }
    
    func setUpCollection() {
        addSubview(collectionContainer)
        collectionContainer.translatesAutoresizingMaskIntoConstraints = false
        let trailingMargin = MediaClipsEditorViewConstants.buttonWidth + MediaClipsEditorViewConstants.buttonHorizontalMargin * 1.5
        NSLayoutConstraint.activate([
            collectionContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -trailingMargin),
            collectionContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -MediaClipsEditorViewConstants.bottomPadding),
            collectionContainer.heightAnchor.constraint(equalToConstant: MediaClipsCollectionView.height)
        ])
    }
    
    func setUpPreview() {
        addSubview(previewButton)
        previewButton.translatesAutoresizingMaskIntoConstraints = false
        previewButton.setTitle(NSLocalizedString("Preview", comment: "Title for the Preview button"), for: .normal)
        previewButton.layer.cornerRadius = 20
        previewButton.backgroundColor = .tumblrBrightBlue
        previewButton.setTitleColor(.white, for: .normal)
        previewButton.titleLabel?.font = .favoritTumblrMedium(fontSize: 14.8)
        NSLayoutConstraint.activate([
            previewButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -MediaClipsEditorViewConstants.buttonHorizontalMargin),
            previewButton.heightAnchor.constraint(equalToConstant: MediaClipsEditorViewConstants.buttonHeight),
            previewButton.widthAnchor.constraint(equalToConstant: MediaClipsEditorViewConstants.buttonWidth),
            previewButton.centerYAnchor.constraint(equalTo: collectionContainer.centerYAnchor,
                                                   constant: MediaClipsEditorViewConstants.buttonTopOffset)
        ])
    }

}

// MARK: - Button handling
extension MediaClipsEditorView {

    @objc func previewPressed() {
        delegate?.previewButtonWasPressed()
    }
}
