//
//  SignupController.swift
//  TinderClone
//
//  Created by Richard Price on 27/01/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class SignupController: UIViewController {
    var imageForFirebase: UIImage? = nil
    
    //MARK:- Lables and buttons
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 300).isActive = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleAddImage), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(padding: 16, height: 40)
        textField.placeholder = "Enter Full Name"
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
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
    let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 32
        button.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        return button
    }()
    
    let signInLable: UILabel = {
        let lable = UILabel()
        lable.text = "Already have an account?"
        lable.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lable.textColor = .secondaryLabel
        return lable
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In Here", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        button.backgroundColor = .darkGray
        button.isEnabled = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(signInUser), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setupNavigationBar()
        setupGradientlayer()
        setupUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func handleAddImage() {
        print("123")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc private func handleTextChange(textField: UITextField) {
        if textField == fullNameTextField {
            print("fullname Changing")
        } else if textField == emailTextField {
            print("email changing")
        } else {
            print("password changing")
        }
        let isFormValid = fullNameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        
        registrationButton.isEnabled = isFormValid
        if isFormValid {
            registrationButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        } else {
            registrationButton.backgroundColor = .lightGray
        }
    }
    
    @objc private func signUpUser() {
        self.view.endEditing(true)
        //self.validateSignUpFields()
        self.signUp(onSuccess: {
            //switch views here
        }) { (error) in
            ProgressHUD.showError(error)
        }

    }
    
    @objc private func signInUser() {
        self.view.endEditing(true)
        let signInController = SignInController()
        self.navigationController?.pushViewController(signInController, animated: true)
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
        
        let signInStack = UIStackView(arrangedSubviews: [signInLable, signInButton])
        signInStack.alignment = .center
        signInStack.axis = .horizontal
        signInStack.spacing = 8
        view.addSubview(signInStack)
        signInStack.anchor(top: stack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 50, bottom: 0, right: 50))
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
