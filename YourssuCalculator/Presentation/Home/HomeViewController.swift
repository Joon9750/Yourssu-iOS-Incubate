//
//  ViewController.swift
//  YourssuCalculator
//
//  Created by 홍준혁 on 2023/04/26.
//

import UIKit

import SnapKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    private let homeViewModel: HomeViewModel?

    
    init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        render()
        bind()
        setButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNotificationCenter()
    }
    
    
    private func config() {
        view.backgroundColor = .systemBackground
    }
    
    private func render() {
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        homeViewModel?.calculatorStatus = { [weak self] isValid in
            switch isValid {
            case .success(let result):
                self?.homeView.textLabel.text = "결과는 : " + String(result) 
            case .didGetfirstNum:
                self?.homeView.textLabel.text = "버튼을 눌러주세요."
            case .numEmptyFail:
                self?.homeView.textLabel.text = "숫자를 모두 입력해주세요."
            case .invalidNumFail:
                self?.homeView.textLabel.text = "0으로 나눌 수 없습니다."
            }
        }
    }
}

// MARK: - set notification

private extension HomeViewController {
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(firstTextFieldDidChange), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(secondTextFieldDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    @objc func firstTextFieldDidChange(noti: NSNotification) {
        if let text = homeView.firstNumTextField.text,
           let textToInt = Int(text) {
            self.homeViewModel?.firstTextFieldStartTyping(num: textToInt)
        }
    }
    
    @objc func secondTextFieldDidChange(noti: NSNotification) {
        if let text = homeView.secondNumTextField.text,
           let textToInt = Int(text) {
            self.homeViewModel?.secondTextFieldStartTyping(num: textToInt)
        }
    }
}

// MARK: - set button Action

private extension HomeViewController {
    func setButtonAction() {
        homeView.plusButton.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
        homeView.minusButton.addTarget(self, action: #selector(minusButtonDidTap), for: .touchUpInside)
        homeView.multiplusButton.addTarget(self, action: #selector(multiplusButtonDidTap), for: .touchUpInside)
        homeView.divisButton.addTarget(self, action: #selector(divisButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func plusButtonDidTap() {
        self.homeViewModel?.plusButtonDidTap()
    }
    
    @objc
    func minusButtonDidTap() {
        self.homeViewModel?.minusButtonDidTap()
    }
    
    @objc
    func multiplusButtonDidTap() {
        self.homeViewModel?.multiplusButtonDidTap()
    }
    
    @objc
    func divisButtonDidTap() {
        self.homeViewModel?.divisButtonDidTap()
    }
}
