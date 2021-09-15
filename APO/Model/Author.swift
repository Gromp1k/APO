//
//  Author.swift
//  APO
//
//  Created by Kacper on 16/08/2021.
//

import Foundation

struct Author {
    let name: String
    let album: String
    let profilePicture: String
    let description: String
    let github: String
    let linkedin: String
    
    
    static func exampleAuthor() -> Author {
        return Author(
            name: "Kacper Ducin",
            album: "17970",
            profilePicture: "mood",
            description: "iOS implementation of\nimage processing application",
            github: "https://github.com/KDucin",
            linkedin: "https://www.linkedin.com/in/kacper-ducin-789467183/"
        )
    }
}

/*
 
 import Foundation

 struct Author{
     var name: String
     var id: String
     var image: String
     var glabel: String
     var llabel: String
     var description: String
     var github: String
     var linkedin: String
     
 }

 */
