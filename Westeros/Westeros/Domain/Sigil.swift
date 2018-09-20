//
//  Sigil.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 6/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

final class Sigil {
    // MARK: - Properties
    let description: String
    let image: UIImage
    
    // MARK: - Initialization
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
}
