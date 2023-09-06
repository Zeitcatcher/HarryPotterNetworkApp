//
//  ImageCacheManager.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 9/5/23.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
