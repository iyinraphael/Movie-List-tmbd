//
//  BaseButton.swift
//  Movie-List
//
//  Created by Iyin Raphael on 5/11/23.
//

import UIKit

class BaseButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }
}
