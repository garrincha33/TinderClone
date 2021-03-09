//
//  MainController.swift
//  TinderClone
//
//  Created by Richard Price on 26/01/2021.
//

import UIKit

class MainController: UIViewController {
    //MARK:- lables and buttons
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Create New Account"
        lable.textColor = .white
        return lable
    }()
    let subTitleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Here you can create new accounts or login if already registered"
        lable.textColor = .systemBlue
        return lable
    }()
    let orLable: UILabel = {
        let lable = UILabel()
        lable.text = "Or"
        lable.textColor = .white
        return lable
    }()
    let termsOfServiceLable: UILabel = {
        let lable = UILabel()
        lable.text = "Create New Account"
        lable.textColor = .systemBlue
        return lable
    }()
    let signInFaceBookButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Login Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.layer.cornerRadius = 16
        return button
    }()
    let signInGoogleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("Login Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.layer.cornerRadius = 16
        return button
    }()
    let signInNewAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Create a new account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(alreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setupGradientlayer()
        setupUI()
    }
    @objc private func alreadyHaveAccount() {
        let signUpController = SignupController()
        let navController = UINavigationController(rootViewController: signUpController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    private func setupUI() {
        let stackView = VerticalStackView(arrangedSubviews: [titleLable, signInFaceBookButton, signInGoogleButton, orLable, signInNewAccountButton])
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    private func setupGradientlayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
