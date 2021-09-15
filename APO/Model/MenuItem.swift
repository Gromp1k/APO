//
//  MenuItem.swift
//  APO
//
//  Created by Kacper on 16/08/2021.
//


import SwiftUI
struct MenuItem: Hashable{
    
    var hashValue:Int
    var title:String      // Title of MenuItem
    var actionType:MenuItemAction? = .undefined // Based on MIA gets proper function, if undefined : scroll up/down
    var isSelected:Bool = false   // will trigger if MIA .undefined : scroll up/down
    //var isNavLink:Bool
    var operations:[MenuItem]? = nil// category sub-buttons
    
    
}
