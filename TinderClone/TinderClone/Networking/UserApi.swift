//
//  UserApi.swift
//  TinderClone
//
//  Created by Richard Price on 28/01/2021.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import ProgressHUD

struct UserApi {
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }

    func SignUp(withUsername: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email ?? "")
                let dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email ?? "",
                    USERNAME: withUsername,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "Welcome To TinderClone"
                ]
                //MARK:-handle image
                guard let imageSelected = image else {
                    ProgressHUD.showError(ERROR_EMPTY_PHOTO)
                    return
                }
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                    return
                }
                //MARK:-Firebase Storage
                let storageProfileRef = Reference().storageSpecifcProfile(uid: authData.user.uid)
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                StorageService.savePhoto(username: withUsername, uid: authData.user.uid, data: imageData, metadata: metaData, storageProfileRef: storageProfileRef, dict: dict) {
                    onSuccess()
                } onError: { (errorMessage) in
                    onError(errorMessage)
                }
            }
        }
    }
    
    func LogOut(onSuccess: @escaping() -> Void) {
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch {
            ProgressHUD.showError(error.localizedDescription)
        }
    }
}
