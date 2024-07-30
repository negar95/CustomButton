//
//  HomeViewController.swift
//  CustomButton
//
//  Created by Negar Moshtaghi on 7/31/24.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {

    // MARK: - Constants
    private enum Constants {
        static let spacing: CGFloat = 20
        static let stackSize: CGFloat = 170
        static let successImageName: String = "checkmark.seal.fill"
        static let successColor: UIColor = .green
        static let errorImageName: String = "xmark.seal.fill"
        static let errorColor: UIColor = .red
    }

    // MARK: - Views
    lazy private var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy private var stack: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [
                firstNameTextField,
                lastNameTextField,
                submitButton
            ]
        )
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = Constants.spacing
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var firstNameTextField: UITextField = {
        let view = createTextField()
        view.returnKeyType = .next
        view.placeholder = "Enter your first name"
        return view
    }()

    lazy var lastNameTextField: UITextField = {
        let view = createTextField()
        view.returnKeyType = .done
        view.placeholder = "Enter your last name"
        return view
    }()

    lazy private var submitButton: CustomButton = {
        let view = CustomButton()
        view.style = .disable
        view.model = CustomButtonModel(
            title: "Submit",
            action: { [weak self] in
                self?.viewModel.action(
                    .submit(
                        firstName: self?.firstNameTextField.text,
                        lastName: self?.lastNameTextField.text
                    )
                )
            }
        )
        return view
    }()

    // MARK: - Variables
    private let viewModel: HomeViewModelProtocol
    private var cancellable: Set<AnyCancellable>

    // MARK: - Create Views
    private func createTextField() -> UITextField {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.textColor = .blue
        view.backgroundColor = .white
        view.keyboardType = .asciiCapable
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    // MARK: - Inits
    init(
        viewModel: HomeViewModelProtocol,
        cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.viewModel = viewModel
        self.cancellable = cancellable
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        setupStackView()
    }

    private func setupStackView() {
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: Constants.stackSize),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing)
        ])
    }

    private func setupImageView() {
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: Constants.stackSize),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing)
        ])
    }

    private func setupStatusView() {
        submitButton.isLoading = false
        stack.isHidden = true
        setupImageView()

    }

    private func setupSuccessView() {
        setupStatusView()
        image.image = UIImage(systemName: Constants.successImageName)
        image.tintColor = Constants.successColor
    }

    private func setupErrorView() {
        setupStatusView()
        image.image = UIImage(systemName: Constants.errorImageName)
        image.tintColor = Constants.errorColor
    }

    // MARK: - Bind
    private func bind() {
        bindViewModel()
        bindTextField()
    }

    private func bindViewModel() {
        viewModel.state
            .map(\.canSubmit)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] canSubmit in
                self?.submitButton.style = canSubmit ? .primary : .disable
            }.store(in: &cancellable)

        viewModel.state
            .map(\.submitStatus)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] submitStatus in
                self?.handleSubmitStatus(submitStatus)
            }.store(in: &cancellable)
    }

    private func bindTextField() {
        firstNameTextField
            .textPublisher
            .sink { [weak self] text in
                self?.viewModel.action(.changeFirstName(text))
            }.store(in: &cancellable)

        lastNameTextField
            .textPublisher
            .sink { [weak self] text in
                self?.viewModel.action(.changeLastName(text))
            }.store(in: &cancellable)
    }

    private func handleSubmitStatus(_ status: Loadable<Bool>) {
        switch status {
        case .notRequested: break
        case .isLoading:
            submitButton.isLoading = true
        case .loaded:
            setupSuccessView()
        case .failed:
            setupErrorView()
        }
    }
}
