//
//  Name.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/31/24.
//

struct Name {
    var firstName: String
    var lastName: String

    var canSubmit: Bool {
        !firstName.isEmpty && !lastName.isEmpty
    }
}
