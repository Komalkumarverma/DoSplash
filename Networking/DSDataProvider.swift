//
//  DSDataProvider.swift
//  DoSplash
//
//  Created by Komal on 17/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import Foundation

protocol DSDataProviderDelegate : class {
    func dataFetchSuccessfully(photoList : [DSPhotoListInfo]?, isLoadMore : Bool)
    func bannerDataFetchSuccessfully(photoList : DSPhotoListInfo?)
    func errorInDataFetch(error : Error?)

}

class  DSDataProvider  {
    weak var delegate : DSDataProviderDelegate?;
    
    // For Get data from network call
    func getDataForPhotoListFromNetwork(pageNumber : Int = 1, isLoadMore : Bool)  {
        //API calls will goes here
        DSSIngltonInfo.shared.pageNumber = pageNumber;
        let client = DSNetworking()
        client.getPhotoListInfo(from: .getPhotoListData, pageNumber: pageNumber) { result in
            switch result {
            case .success(let appInfoResult):
                guard let appResults = appInfoResult else { return  }
                self.delegate?.dataFetchSuccessfully(photoList: appResults, isLoadMore: isLoadMore)
            case .failure(let error):
                print("the error \(error)")
                self.delegate?.errorInDataFetch(error: error)
            }
        }
    }
    
    func getDataForBannerListFromNetwork()  {
        //API calls will goes here
        let client = DSNetworking()
        client.getBannerListInfo(from: .getRandomPhotoData) { result in
            switch result {
            case .success(let appInfoResult):
                guard let appResults = appInfoResult else { return  }
                self.delegate?.bannerDataFetchSuccessfully(photoList: appResults)
            case .failure(let error):
                print("the error \(error)")
                self.delegate?.errorInDataFetch(error: error)
            }
        }
    }
}
