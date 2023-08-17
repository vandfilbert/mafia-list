//
//  ColorAsset.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import SwiftUI

let colorAsset = ColorAsset()
class ColorAsset: NSObject {
    
    fileprivate override init() {
        super.init()
    }
    
    @objc class func sharedInstance() -> ColorAsset {
        return colorAsset
    }
    
    let lightGrey = Color(hex: "#F5F5F5")
    let lightGreyBackground = Color(hex: "#EFF1F4")
    let white = Color(hex: "#FFFFFF")
    let yellowRating = Color(hex: "#FDCC0D")
    
}
