//
//  CustomButton.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/30/24.
//

import UIKit

@IBDesignable
final class CustomButton: UIButton {

    var model: CustomButtonModel? {
        didSet {
            applyModel()
        }
    }

    var style: CustomButtonStyle = .disable {
        didSet {
            applyStyle(style)
        }
    }

    var isLoading: Bool = false {
        didSet {
            applyLoadingStyle()
        }
    }


    lazy private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = style.configuration.titleColor
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.layoutIfNeeded()
        layoutIfNeeded()
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func applyModel() {
        guard let model else { return }

        setTitle(model.title, for: .normal)
    }

    private func setupView() {
        applyStyle(.disable)
        applyLoadingStyle()
        applyModel()
    }

    private func applyStyle(_ style: CustomButtonStyle) {
        backgroundColor = style.configuration.backgroundColor
        setTitleColor(style.configuration.titleColor, for: .normal)
        layer.cornerRadius = style.configuration.cornerRadius
        activityIndicator.color = style.configuration.titleColor
        isEnabled = style.configuration.isEnabled
    }

    private func applyLoadingStyle() {
        if isLoading {
            isEnabled = false
            setTitle("", for: .normal)
            activityIndicator.startAnimating()
        } else {
            isEnabled = style.configuration.isEnabled
            setTitle(model?.title, for: .normal)
            activityIndicator.stopAnimating()
        }
    }
}
