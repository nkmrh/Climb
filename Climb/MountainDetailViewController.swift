//
//  MountainDetailViewController.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/20.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MountainDetailViewController: UIViewController {
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var prefectureLabel: UILabel!
    @IBOutlet weak private var likeLabel: UILabel!
    @IBOutlet weak private var elevationLabel: UILabel!
    @IBOutlet weak private var mountainImageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var recommendedContainerStackView: UIStackView!
    @IBOutlet weak private var secondlyRecommendedStackView: UIStackView!
    @IBOutlet weak private var firstlyRecommendedMountainImageView: UIImageView!
    @IBOutlet weak private var firstlyRecommendedMountainNameLabel: UILabel!
    @IBOutlet weak private var secondlyRecommendedMountainImageView: UIImageView!
    @IBOutlet weak private var secondlyRecommendedMountainNameLabel: UILabel!
    @IBOutlet weak private var likeButton: BackgroundHighlightedButton!

    var mountain: Mountain!
    var recommendedMountains: [Mountain]!

    private var likeLabelTextColor: UIColor {
        get {
            return mountain.isLike ? .orange : .black
        }
    }

    private var likeButtonBackgroundColor: UIColor {
        get {
            return mountain.isLike ? .orange : .gray
        }
    }

    static func makeInstance(mountain: Mountain, recommendedMountains: [Mountain]) -> MountainDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MountainDetailViewController") as! MountainDetailViewController
        viewController.mountain = mountain
        viewController.recommendedMountains = recommendedMountains
        return viewController
    }

    override func viewDidLoad() {
        title = "山詳細画面"
        nameLabel.text = mountain.name
        prefectureLabel.text = mountain.prefectures.joined(separator: "/")
        likeLabel.text = "いいね！\(mountain.likeCount)"
        likeLabel.textColor = likeLabelTextColor
        elevationLabel.text = "\(mountain.elevation)m"
        mountainImageView.kf.setImage(with: mountain.imageURL, options: [.transition(.fade(0.2))])
        descriptionLabel.text = mountain.description
        likeButton.highlightedBackgroundColor = likeButtonBackgroundColor.withAlphaComponent(0.8)
        likeButton.nonHighlightedBackgroundColor = likeButtonBackgroundColor
        likeButton.isHighlighted = false

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
}
