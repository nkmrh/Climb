//
//  MountainDetailViewController.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/20.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

protocol MountainDetailViewControllerDelegate: class {
    func mountainDetailViewControllerDidUpdate(_ mountain: Mountain)
}

class MountainDetailViewController: UIViewController {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var prefectureLabel: UILabel!
    @IBOutlet private var likeLabel: UILabel!
    @IBOutlet private var elevationLabel: UILabel!
    @IBOutlet private var mountainImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var recommendedContainerStackView: UIStackView!
    @IBOutlet private var secondlyRecommendedStackView: UIStackView!
    @IBOutlet private var firstlyRecommendedMountainImageView: UIImageView!
    @IBOutlet private var firstlyRecommendedMountainNameLabel: UILabel!
    @IBOutlet private var secondlyRecommendedMountainImageView: UIImageView!
    @IBOutlet private var secondlyRecommendedMountainNameLabel: UILabel!
    @IBOutlet private var likeButton: BackgroundHighlightedButton!

    var mountain: Mountain!
    var recommendedMountains: [Mountain]!

    weak var delegate: MountainDetailViewControllerDelegate?

    private var likeLabelTextColor: UIColor {
        return mountain.isLike ? .orange : .black
    }

    private var likeButtonBackgroundColor: UIColor {
        return mountain.isLike ? .orange : .gray
    }

    static func makeInstance(mountain: Mountain, recommendedMountains: [Mountain]) -> MountainDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MountainDetailViewController") as! MountainDetailViewController
        viewController.mountain = mountain
        viewController.recommendedMountains = recommendedMountains
        return viewController
    }

    private func updateAppearances(with mountain: Mountain) {
        nameLabel.text = mountain.name
        prefectureLabel.text = mountain.prefectures.joined(separator: "/")
        likeLabel.text = "いいね！\(mountain.likeCount)"
        likeLabel.textColor = likeLabelTextColor
        elevationLabel.text = "\(mountain.elevation)m"
        mountainImageView.kf.setImage(with: mountain.imageURL, options: [.transition(.fade(0.2))])
        descriptionLabel.text = mountain.description
        likeButton.highlightedBackgroundColor = likeButtonBackgroundColor.withAlphaComponent(0.9)
        likeButton.nonHighlightedBackgroundColor = likeButtonBackgroundColor
        likeButton.isHighlighted = false
    }

    override func viewDidLoad() {
        title = "山詳細画面"

        updateAppearances(with: mountain)

        if recommendedMountains.isEmpty {
            recommendedContainerStackView.isHidden = true
        } else if recommendedMountains.count == 1 {
            firstlyRecommendedMountainImageView.kf.setImage(with: recommendedMountains.first?.imageURL,
                                                            options: [.transition(.fade(0.2))])
            firstlyRecommendedMountainNameLabel.text = recommendedMountains.first?.name
            secondlyRecommendedStackView.isHidden = true
        } else if recommendedMountains.count >= 2 {
            firstlyRecommendedMountainImageView.kf.setImage(with: recommendedMountains.first?.imageURL,
                                                            options: [.transition(.fade(0.2))])
            firstlyRecommendedMountainNameLabel.text = recommendedMountains.first?.name
            secondlyRecommendedMountainImageView.kf.setImage(with: recommendedMountains[1].imageURL,
                                                             options: [.transition(.fade(0.2))])
            secondlyRecommendedMountainNameLabel.text = recommendedMountains[1].name
        }
    }

    @IBAction func likeButtonAction(_: UIButton) {
        mountain.isLike = !mountain.isLike
        mountain.likeCount = mountain.isLike ? mountain.likeCount + 1 : mountain.likeCount - 1
        updateAppearances(with: mountain)
        delegate?.mountainDetailViewControllerDidUpdate(mountain)
    }
}
