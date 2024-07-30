//
//  HomeViewModel.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/31/24.
//
import Combine

final class HomeViewModel: HomeViewModelProtocol {
    var state: CurrentValueSubject<HomeViewModelState, Never>
    private var name: Name

    init() {
        name = Name(firstName: "", lastName: "")
        state = CurrentValueSubject<HomeViewModelState, Never>(
            HomeViewModelState(
                canSubmit: false, 
                submitStatus: .notRequested
            )
        )
    }
    
    private func updateState(
        canSubmit: Bool? = nil,
        submitStatus: Loadable<Bool>? = nil
    ) {
        state.value = state.value.update(
            canSubmit: canSubmit,
            submitStatus: submitStatus
        )
    }
    
    func action(_ action: HomeViewModelAction) {
        switch action { 
        case .submit:
            submit()
        case let .changeFirstName(text):
            name.firstName = text
            updateState(canSubmit: name.canSubmit)
        case let .changeLastName(text):
            name.lastName = text
            updateState(canSubmit: name.canSubmit)
        }
    }

    private func submit() {
        updateState(submitStatus: .isLoading)
        Task {
            do {
                try await api()
                updateState(submitStatus: .loaded(true))
            } catch let error {
                updateState(submitStatus: .failed(error.localizedDescription))
            }
        }
    }

    private func api() async throws {
        try await Task.sleep(nanoseconds: 5_000_000_000)
    }
}
