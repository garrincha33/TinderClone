//
//  StorageService.swift
//  TinderClone
//
//  Created by Richard Price on 11/02/2021.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import ProgressHUD

class StorageService {
    static func savePhoto(username: String, uid: String, data: Data, metadata: StorageMetadata, storageProfileRef: StorageReference, dict: Dictionary<String, Any>, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {

        storageProfileRef.putData(data, metadata: metadata) { (storageMetaData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            storageProfileRef.downloadURL { (url, error) in
                if let metaDataImageUrl = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges { (error) in
                            if let error = error {
                                ProgressHUD.showError(error.localizedDescription)
                            }
                        }
                    }
                    var dictTemp = dict
                    dictTemp[PROFILE_IMAGE_URL] = metaDataImageUrl
                    
                    //MARK:-Firebase Database
                    Reference().databaseSpecificUser(uid: uid).updateChildValues(dictTemp) { (error, ref) in
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
