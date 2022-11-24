//
//  ChildTableViewCell.swift
//  alefTest
//
//  Created by Никита Ананьев on 24.10.2022.
//

import UIKit

class ChildTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var buttonTapCallback: () -> ()  = { }

    
    var human = Human() {
        didSet {
            if let name = human.name {
                nameTextField.textField.text = "\(name)"
            } else {
                nameTextField.textField.text = ""
            }
            if let age = human.age {
                ageTextField.textField.text = "\(age)"
            } else {
                ageTextField.textField.text = ""
            }
        }
    }
    lazy var nameTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTitleLabel(text: "Имя")
        
        return textField
    }()
    lazy var ageTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTitleLabel(text: "Возраст")
        textField.textField.keyboardType = .numberPad
        
        return textField
    }()
    lazy var deleteChildButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
        
    }()
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(ageTextField)
        
        return stackView
    }()
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(deleteChildButton)
        stackView.alignment = .firstBaseline
        
        return stackView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 5),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -5),
            horizontalStackView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor, constant: 0),
            horizontalStackView.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor, constant: 0),
        ])
    }
    @objc func didTapButton() {
            buttonTapCallback()
        }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
