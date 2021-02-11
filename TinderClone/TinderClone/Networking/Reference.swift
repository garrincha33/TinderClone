//
//  Reference.swift
//  TinderClone
//
//  Created by Richard Price on 11/02/2021.
//

import Foundation
import Firebase

let REF_USER = "users"
let URL_STORAGE_ROOT = "gs://tinderclone-c6e72.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"
let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let STATUS = "status"
let ERROR_EMPTY_PHOTO = "please choose your profile image"
let ERROR_EMPTY_USERNAME = "please enter a username"
let ERROR_EMPTY_EMAIL = "please choose a valid email address"
let ERROR_EMPTY_PASSWORD = "please enter a password"

class Reference {
    let databaseRoot: DatabaseReference = Database.database().reference()
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    //Storage Ref
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    
    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }
    func storageSpecifcProfile(uid: String) -> StorageReference {
        return storageProfile.child(uid)
    }
}
