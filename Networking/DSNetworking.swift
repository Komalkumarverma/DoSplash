//
//  DSNetworking.swift
//  DoSplash
//
//  Created by Komal on 17/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import Foundation
class DSNetworking: APIClient {
    let session: URLSession
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getPhotoListInfo(from appFeedType: AppInfo,pageNumber : Int, completion: @escaping (Result<[DSPhotoListInfo]?, APIError>) -> Void) {
        let endpoint = appFeedType
        let request = endpoint.request
        fetch(with: request, decode: { json -> [DSPhotoListInfo]? in
            guard let appFeedResult = json as? [DSPhotoListInfo] else { return  nil }
            return appFeedResult
        }, completion: completion)
    }
    
    func getBannerListInfo(from appFeedType: AppInfo, completion: @escaping (Result<DSPhotoListInfo?, APIError>) -> Void) {
        
        let endpoint = appFeedType
        let request = endpoint.request
        fetch(with: request, decode: { json -> DSPhotoListInfo? in
            guard let appFeedResult = json as? DSPhotoListInfo else { return  nil }
            return appFeedResult
        }, completion: completion)
    }
}
