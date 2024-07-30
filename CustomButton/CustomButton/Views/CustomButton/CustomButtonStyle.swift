//
//  CustomButtonStyle.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/30/24.
//

import UIKit

enum CustomButtonStyle {
    case primary
    case secondary
    case danger
    case disable
    case custom(CustomButtonConfiguration)
}

struct CustomButtonConfiguration {
    let backgroundColor: UIColor
    let titleColor: UIColor
    let cornerRadius: CGFloat
    let isEnabled: Bool
}

extension CustomButtonStyle {

    var configuration: CustomButtonConfiguration {
        switch self {
        case .primary:
            return CustomButtonConfiguration(
                backgroundColor: .blue,
                titleColor: .white,
                cornerRadius: 10,
                isEnabled: true
            )
        case .secondary:
            return CustomButtonConfiguration(
                backgroundColor: .systemOrange,
                titleColor: .darkGray,
                cornerRadius: 10,
                isEnabled: true
            )
        case .danger:
            return CustomButtonConfiguration(
                backgroundColor: .red,
                titleColor: .white,
                cornerRadius: 10,
                isEnabled: true
            )
        case .disable:
            return CustomButtonConfiguration(
                backgroundColor: .systemGray6,
                titleColor: .darkGray,
                cornerRadius: 10,
                isEnabled: false
            )
        case let .custom(configuration):
            return configuration
        }
    }
}

