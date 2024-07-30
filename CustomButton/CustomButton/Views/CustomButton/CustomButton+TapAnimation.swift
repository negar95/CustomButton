//
//  CustomButton+TapAnimation.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/30/24.
//

import UIKit

extension CustomButton {

    private enum AnimationConstants {
        static let duration: CGFloat = 0.45
        static let scale: CGFloat = 0.85
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        tapDownAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        tapUpAnimation()
        model?.action()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        tapUpAnimation()
    }

    private func tapDownAnimation() {
        UIView.animate(withDuration: AnimationConstants.duration) {
            self.transform = CGAffineTransform(
                scaleX: AnimationConstants.scale,
                y: AnimationConstants.scale
            )

        }
    }

    private func tapUpAnimation() {
        UIView.animate(withDuration: AnimationConstants.duration) {
            self.transform = .identity
        }
    }
}
