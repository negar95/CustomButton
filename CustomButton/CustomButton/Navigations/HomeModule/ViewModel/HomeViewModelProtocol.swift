//
//  HomeViewModelProtocol.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/31/24.
//

import Combine

protocol HomeViewModelProtocol {
    var state: CurrentValueSubject<HomeViewModelState, Never> { get }
    func action(_ action: HomeViewModelAction)
}

enum HomeViewModelAction {
    case submit(firstName: String?, lastName: String?)
    case changeFirstName(String)
    case changeLastName(String)
}

struct HomeViewModelState {

    let canSubmit: Bool
    let submitStatus: Loadable<Bool>

    func update(
        canSubmit: Bool? = nil,
        submitStatus: Loadable<Bool>? = nil
    ) -> HomeViewModelState {
        HomeViewModelState(
            canSubmit: canSubmit ?? self.canSubmit,
            submitStatus: submitStatus ?? self.submitStatus
        )
    }
}
