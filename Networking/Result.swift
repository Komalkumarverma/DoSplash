//
//  Result.swift
//  CarFitDemo
//
//  Created by Komal on 01/07/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
