//
//  BackgroundHighlightedButton.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/21.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import Foundation
import UIKit

class BackgroundHighlightedButton: UIButton {
    var highlightedBackgroundColor: UIColor?
    var nonHighlightedBackgroundColor: UIColor?

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = highlightedBackgroundColor
            } else {
                backgroundColor = nonHighlightedBackgroundColor
            }
        }
    }
}
