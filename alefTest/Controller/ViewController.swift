//
//  ViewController.swift
//  alefTest
//
//  Created by Никита Ананьев on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    var humans:[Human] = []
    //MARK: Views
    
    //---------------
    //HeaderView views
    //---------------
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //---------------
    //BottomView views
    //---------------
    lazy var addChildButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 20
        return button
        
    }()
    lazy var removeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.cornerRadius = 20
        return button
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //---------------
    //MARK: LifeCycle
    //---------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        tableView.register(ChildTableViewCell.self, forCellReuseIdentifier: "ChildTableViewCell")
        
        addChildButton.addTarget(self, action: #selector(addChildModel), for: .touchUpInside)
        removeAllButton.addTarget(self, action: #selector(removeAllChildModel), for: .touchUpInside)
        setHeaderView()
        setBottomView()
        
    }
    
    
    //---------------
    //MARK: UI setting functions
    //---------------
    private func setHeaderView() {
        view.addSubview(headerView)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        headerView.addSubview(stackView)
        
        let sectionLabel = UILabel()
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.font = .boldSystemFont(ofSize: 25)
        sectionLabel.text = "Персональные данные"
        stackView.addArrangedSubview(sectionLabel)
        
        let nameTextField = CustomTextFieldView()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.setTitleLabel(text: "Имя")
        stackView.addArrangedSubview(nameTextField)
        
        let ageTextField = CustomTextFieldView()
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.setTitleLabel(text: "Возраст")
        ageTextField.textField.keyboardType = .numberPad
        stackView.addArrangedSubview(ageTextField)
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            stackView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: headerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    private func setBottomView() {
        view.addSubview(bottomView)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .lastBaseline
        bottomView.addSubview(stackView)
        
        let sectionLabel = UILabel()
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.font = .boldSystemFont(ofSize: 25)
        sectionLabel.text = "Дети (макс.5)"
        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(addChildButton)
        
        bottomView.addSubview(tableView)
        tableView.backgroundColor = .white
        bottomView.addSubview(removeAllButton)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leftAnchor.constraint(equalTo: bottomView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: bottomView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            removeAllButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -50),
            removeAllButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            removeAllButton.heightAnchor.constraint(equalTo: addChildButton.heightAnchor),
            removeAllButton.widthAnchor.constraint(equalTo: addChildButton.widthAnchor)
            
            
        ])

    }
    
    //---------------
    //MARK: funcs
    //---------------
    @objc func addChildModel() {
        if humans.count < 4 {
            humans.append(Human())
            tableView.reloadData()
            print(humans)
        } else if humans.count == 4 {
            humans.append(Human())
            tableView.reloadData()
            print(humans)
            addChildButton.layer.opacity = 0
            addChildButton.isUserInteractionEnabled = false
        }
        
        
    }
    @objc private func removeAllChildModel() {
        let optionMenu = UIAlertController()
        
        let deleteAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { delete in
            self.humans = []
            self.tableView.reloadData()
            self.addChildButton.layer.opacity = 1
            self.addChildButton.isUserInteractionEnabled = true
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    private func removeChildModel(index: Int) {
        
        tableView.reloadData()
        
        humans.remove(at: index)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        tableView.endUpdates()
        
        if humans.count < 5 {
            addChildButton.layer.opacity = 1
            addChildButton.isUserInteractionEnabled = true
        }
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        humans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildTableViewCell", for: indexPath) as! ChildTableViewCell
        cell.nameTextField.textField.delegate = self
        cell.ageTextField.textField.delegate = self
        
        cell.nameTextField.textField.tag = indexPath.row + 1
        cell.ageTextField.textField.tag = -(indexPath.row + 1)
        
        cell.human = humans[indexPath.row]
        
        cell.buttonTapCallback = {
            self.removeChildModel(index: indexPath.row)
        }
        
        return cell
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField.tag > 0 {
            humans[textField.tag - 1].name = text
        } else if textField.tag < 0 {
            humans[abs(textField.tag + 1)].age = Int(text)
        } else {
            assert(true)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.tag)
        if textField.tag < 0 {
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        }
        
        return true
    }
}

//---------------
//MARK: Keyboard
//---------------
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
