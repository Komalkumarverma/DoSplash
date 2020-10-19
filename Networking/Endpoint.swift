//
//  Endpoint.swift
//  CarFitDemo
//
//  Created by Komal on 01/07/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var page : Int? { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [
           URLQueryItem(name: "client_id", value: "6KAt53mfR1jDdu_BlfESy1zS88gnm4elyLlNu1iHkRk"),
           URLQueryItem(name: "page", value: String.init(format: "%d", page ?? 1))
        ]
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        return request
    }
}

enum AppInfo {
    
    case getPhotoListData
    case getRandomPhotoData
}

extension AppInfo: Endpoint {
    var page: Int? {
        return DSSIngltonInfo.shared.pageNumber;
    }
        
    var base: String {
        return "https://api.unsplash.com"
    }
    
    var path: String {
        
        switch self {
            
        case .getPhotoListData: return "/photos"
        case .getRandomPhotoData : return "/photos/random"
        }
    }
}








