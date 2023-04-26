//
//  HomeViewModel.swift
//  YourssuCalculator
//
//  Created by 홍준혁 on 2023/04/26.
//

import Foundation

@frozen
enum CalculatorResult {
    case success(firstNum: Int, secondNum: Int, type: String, result: Int)
    case didGetfirstNum
    case numEmptyFail
    case invalidNumFail
}

@frozen
enum CalculateTpye {
    case plus
    case minus
    case mulitplus
    case divis
}

protocol HomeViewModelInput {
    func firstTextFieldStartTyping(num: Int)
    func secondTextFieldStartTyping(num: Int)
    func plusButtonDidTap()
    func minusButtonDidTap()
    func multiplusButtonDidTap()
    func divisButtonDidTap()
}

protocol HomeViewModelOutput {
    var calculatorStatus: ((CalculatorResult) -> Void)? { get set }
}

protocol HomeViewModelInputOutput: HomeViewModelInput, HomeViewModelOutput {}

final class HomeViewModel: HomeViewModelInputOutput {
    
    private var isFirstTextFieldFull: Bool = false
    private var firstTextFieldNum: Int = 0
    private var secondTextFieldNum: Int = 0
    private var isSecondTextFieldFull: Bool = false
    private var homeViewUseCase: HomeViewUseCase
    
    // MARK: - Output
    
    var calculatorStatus: ((CalculatorResult) -> Void)?
    var status: CalculatorResult? {
        didSet {
            if let calculatorStatus = calculatorStatus,
               let status = status {
                calculatorStatus(status)
            }
        }
    }
    
    init(useCase: HomeViewUseCase) {
        self.homeViewUseCase = useCase
    }
    
}

extension HomeViewModel {
    
    // MARK: - Input
    
    func firstTextFieldStartTyping(num: Int) {
        isFirstTextFieldFull = true
        firstTextFieldNum = num
        calculatorStatus?(.didGetfirstNum)
    }
    
    func secondTextFieldStartTyping(num: Int) {
        isSecondTextFieldFull = true
        secondTextFieldNum = num
        calculatorStatus?(.didGetfirstNum)
    }
    
    func plusButtonDidTap() {
        status = homeViewUseCase.checkSuccess(
            isFirstTextFieldFull: isFirstTextFieldFull,
            isSecondTextFieldFull: isSecondTextFieldFull,
            firstNum: firstTextFieldNum,
            secondNum: secondTextFieldNum,
            calculateType: .plus)
    }
    
    func minusButtonDidTap() {
        status = homeViewUseCase.checkSuccess(
            isFirstTextFieldFull: isFirstTextFieldFull,
            isSecondTextFieldFull: isSecondTextFieldFull,
            firstNum: firstTextFieldNum,
            secondNum: secondTextFieldNum,
            calculateType: .minus)
    }
    
    func multiplusButtonDidTap() {
        status = homeViewUseCase.checkSuccess(
            isFirstTextFieldFull: isFirstTextFieldFull,
            isSecondTextFieldFull: isSecondTextFieldFull,
            firstNum: firstTextFieldNum,
            secondNum: secondTextFieldNum,
            calculateType: .mulitplus)
    }
    
    func divisButtonDidTap() {
        status = homeViewUseCase.checkSuccess(
            isFirstTextFieldFull: isFirstTextFieldFull,
            isSecondTextFieldFull: isSecondTextFieldFull,
            firstNum: firstTextFieldNum,
            secondNum: secondTextFieldNum,
            calculateType: .divis)
    }
}
