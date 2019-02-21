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
    @IBOutlet weak private var firstlyRecommendedMountainImageView: UIImageView!
    @IBOutlet weak private var firstlyRecommendedMountainNameLabel: UILabel!
    @IBOutlet weak private var secondlyRecommendedMountainImageView: UIImageView!
    @IBOutlet weak private var secondlyRecommendedMountainNameLabel: UILabel!
    @IBOutlet weak private var likeButton: BackgroundHighlightedButton!

    var mountain: Mountain!

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

    static func makeInstance(mountain: Mountain) -> MountainDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MountainDetailViewController") as! MountainDetailViewController
        viewController.mountain = mountain
        return viewController
    }

    override func viewDidLoad() {
        title = "山詳細画面"
        nameLabel.text = mountain.name
        prefectureLabel.text = mountain.prefectures.joined(separator: "/")
        likeLabel.text = "いいね！\(mountain.likeCount)"
        likeLabel.textColor = likeLabelTextColor
        elevationLabel.text = "\(mountain.elevation)m"
        mountainImageView.kf.setImage(with: mountain.thumbnailURL, options: [.transition(.fade(0.2))])
        descriptionLabel.text = mountain.description
        likeButton.highlightedBackgroundColor = likeButtonBackgroundColor.withAlphaComponent(0.8)
        likeButton.nonHighlightedBackgroundColor = likeButtonBackgroundColor
        likeButton.isHighlighted = false
    }
}
