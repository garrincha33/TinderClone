//
//  SignInController.swift
//  TinderClone
//
//  Created by Richard Price on 12/02/2021.
//

import UIKit
import ProgressHUD

class SignInController: UIViewController {
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16, height: 40)
        textField.placeholder = "Enter Email"
        textField.backgroundColor = .white
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16, height: 40)
        textField.placeholder = "Enter Password"
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 32
        button.addTarget(self, action: #selector(signInUser), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientlayer()
        setupNavigationBar()
        setupUI()
    }
    
    @objc private func signInUser() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        self.view.endEditing(true)
        ProgressHUD.show()
        Api.User.signIn(email: email, password: password) {
            ProgressHUD.dismiss()
            
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            print("signedIn user")
            
            guard let mainTabBarController = window?.rootViewController as? MainTabBarController else { return }
            
            mainTabBarController.setupTabBarControllers()
            self.dismiss(animated: true, completion: nil)
            
            
        } onError: { (errorMessage) in
            ProgressHUD.showError("password is incorrect or not valid")
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    //REFACTOR as also used in signup controller
    private func setupGradientlayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    @objc private func handleTextChange(textField: UITextField) {
        if textField == emailTextField {
            print("email changing ")
        } else {
            print("password changing")
        }
        let isFormValid = emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        signInButton.isEnabled = isFormValid
        if isFormValid {
            signInButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        } else {
            signInButton.backgroundColor = .lightGray
        }
    }
    private func setupUI() {
        let stack = VerticalStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton] )
        stack.spacing = 8
        view.addSubview(stack)
        stack.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
