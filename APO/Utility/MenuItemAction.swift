//
//  MenuItemActions.swift
//  APO
//
//  Created by Kacper on 18/08/2021.
//

import Foundation

/// Types of opperations which can make button in the menu
enum MenuItemAction{
    
    case undefined
    
    case//MARK: UIControllers
        openFile,
        saveFile,
        deleteFile,
        equalization
    
    case//MARK: convertion
        grayscale,
        negate,
        binary,
        tresh,
        treshAd,
        treshOt
    
    case//MARK: histogram
        openHistogram
    
    case//MARK: bitwise
       bitwiseOR,
       bitwiseAND,
       bitwiseNOT,
       bitwiseXOR
    
    case//MARK: blur
        blur,
        blurGaus,
        blurSobel,
        blurLapl,
        blurCanny
    
    case//MARK: morphology
        morphErode,
        morphDilate,
        morphOpen,
        morphClose,
        morphSkale
    
    case
        showHistogram,
        showLUT
}
