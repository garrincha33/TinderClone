//
//  Signupcontroller+UIImagePicker.swift
//  TinderClone
//
//  Created by Richard Price on 28/01/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

extension SignupController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageForFirebase = image
            self.selectPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
     func signUp(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        ProgressHUD.show()
        Api.User.SignUp(withUsername: fullNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, image: imageForFirebase!) {
            ProgressHUD.dismiss()
            onSuccess()
        } onError: { (errorMessage) in
            onError(errorMessage)
        }
    }
}
