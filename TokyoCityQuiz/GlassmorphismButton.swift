//
//  GlassmorphismButton.swift
//  QuizApp_YouTube
//
//  Created by 羽田野真央 on 2024/02/14.
//

import UIKit

@IBDesignable
class GlassmorphismButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    func setup() {
        backgroundColor = .clear
        layer.cornerRadius = 30
        layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.borderWidth = 1
        layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
    }
}

#Preview {
    GlassmorphismButton()
}
