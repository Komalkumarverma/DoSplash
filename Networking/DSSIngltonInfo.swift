//
//  DSSIngltonInfo.swift
//  DoSplash
//
//  Created by Komal on 19/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import UIKit

class DSSIngltonInfo: NSObject {
    
    static let shared = DSSIngltonInfo()
    var pageNumber: Int? =  1;
    private override init() { }
}
