//
//  HomeViewController+UITextFieldDelegate.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/31/24.
//

import UIKit

extension HomeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
