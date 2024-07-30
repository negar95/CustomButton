//
//  HomeModule.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/31/24.
//

enum HomeModule {

    typealias Controller = HomeViewController
    typealias ViewModel = HomeViewModel

    static func build() -> Controller {
        let viewModel = ViewModel()
        return Controller(viewModel: viewModel)
    }
}
