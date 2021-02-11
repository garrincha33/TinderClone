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
    func SignUp(withUsername: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email ?? "")
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email ?? "",
                    "username": withUsername,
                    "profileImageUrl": "",
                    "status": "Welcome To TinderClone"
                ]
                
                //MARK:-handle image
                guard let imageSelected = image else {
                    ProgressHUD.showError("please choose an image")
                    return
                }
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                    return
                }
                
                //MARK:-Firebase Storage
                let storageRef = Storage.storage().reference(forURL: "gs://tinderclone-c6e72.appspot.com")
                let storageProfileRef = storageRef.child("profile").child(authData.user.uid)
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                storageProfileRef.putData(imageData, metadata: metaData) { (storageMetaData, error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    storageProfileRef.downloadURL { (url, error) in
                        if let metaDataImageUrl = url?.absoluteString {
                            dict["profileImageUrl"] = metaDataImageUrl
                            
                            //MARK:-Firebase Database
                            Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict) { (error, ref) in
                                if error == nil {
                                    print("finished")
                                    onSuccess()
                                } else {
                                    onError(error!.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
