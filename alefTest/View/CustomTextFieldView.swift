//
//  CustomTextFieldView.swift
//  alefTest
//
//  Created by Никита Ананьев on 24.10.2022.
//

import UIKit

class CustomTextFieldView: UIView {
    
    enum KeyboardMode {
        case string, numbers
    }
    
    //MARK: Variables
    
    private var keyboardMode = KeyboardMode.string
    
    // MARK: Views
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.contentMode = .scaleToFill
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        return stackView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        return view
    }()

    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backgroundView)
        setupLayout()
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),

            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -5),
            stackView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -15)
            
            
        ])
    }

    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    func setKeyboardMode(mode: KeyboardMode){
       keyboardMode = mode
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

}
