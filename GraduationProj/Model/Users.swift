//
//  Users.swift
//  GraduationProj
//
//  Created by Naira Bassam on 04/04/2021.
//

import Foundation

struct User {
    let email: String
    let fullName:String
    let idNumber: String
    let password: String
    let uid: String
    
    init(uid: String, dictionary: [String: String]) {
        self.uid = uid
        self.email = dictionary["email"] ?? ""
        self.fullName = dictionary["fullName"] ?? ""
        self.idNumber = dictionary["idNumber"] ?? ""
        self.password = dictionary["password"] ?? ""
    }
}
