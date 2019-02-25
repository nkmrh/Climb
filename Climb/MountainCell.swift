//
//  MountainCell.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/19.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

class MountainCell: UITableViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var thumbUpImageView: UIImageView!
    @IBOutlet private var likeLabel: UILabel!

    private func makeThumbUpImage(_ isLike: Bool) -> Image? {
        let name = isLike ? "ThumbUpOrange" : "ThumbUp"
        return Image(named: name)
    }

    private func makeLikeLabelTextColor(_ isLike: Bool) -> UIColor {
        return isLike ? .orange : .black
    }

    func configure(with mountain: Mountain) {
        thumbnailImageView.kf.setImage(with: mountain.thumbnailURL, options: [.transition(.fade(0.2))])
        nameLabel.text = mountain.name
        thumbUpImageView.image = makeThumbUpImage(mountain.isLike)
        likeLabel.text = "いいね！\(mountain.likeCount)"
        likeLabel.textColor = makeLikeLabelTextColor(mountain.isLike)
    }
}
