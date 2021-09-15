//
//  Alerts.swift
//  APO
//
//  Created by Kacper on 16/08/2021.
//

import SwiftUI

struct AlertItem : Identifiable{
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let unsuportredImageFormat = AlertItem(title:Text("Error"),
                                           message:Text("Image's format unsupported !"),
                                           buttonTitle:Text("Ok"))
}
