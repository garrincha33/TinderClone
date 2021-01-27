//
//  SignupController.swift
//  TinderClone
//
//  Created by Richard Price on 27/01/2021.
//

import UIKit
import  FirebaseAuth
import FirebaseDatabase

class SignupController: UIViewController {
    
    //MARK:- Lables and buttons
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 300).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16, height: 40)
        textField.placeholder = "Enter Full Name"
        textField.backgroundColor = .white
        return textField
    }()
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16, height: 40)
        textField.placeholder = "Enter Email"
        textField.backgroundColor = .white
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16, height: 40)
        textField.placeholder = "Enter Password"
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setupNavigationBar()
        setupGradientlayer()
        setupUI()
    }
    @objc private func signUpUser() {
        Auth.auth().createUser(withEmail: "test2email@gmail.com", password: "123456") { (authDataResult, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            if let authData = authDataResult {
                print(authData.user.email ?? "")
                let dict: Dictionary<String, Any> = [
                    "uid": authData.user.email ?? "",
                    "email": authData.user.email ?? "",
                    "profileImageUrl": "",
                    "status": "Welcome To TinderClone"
                ]
                Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict) { (error, ref) in
                    if error == nil {
                        print("finished")
                    }
                }
            }
        }
    }
    @objc private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(cancelAction))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    private func setupUI() {
        let stack = VerticalStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registrationButton])
        stack.spacing = 8
        view.addSubview(stack)
        stack.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    private func setupGradientlayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
