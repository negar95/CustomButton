//
//  Loadable.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/31/24.
//

enum Loadable<T: Equatable>: Equatable {
    case notRequested
    case isLoading
    case loaded(T)
    case failed(String)
}
