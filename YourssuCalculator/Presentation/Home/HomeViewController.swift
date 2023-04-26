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

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        render()
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
}
