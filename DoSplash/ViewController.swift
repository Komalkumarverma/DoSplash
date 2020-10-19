//
//  ViewController.swift
//  DoSplash
//
//  Created by Komal on 17/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bannerView : DSBannerView!;
    @IBOutlet weak var photoListView : DSPhotoListView!;

    var pageNumber : Int? = 1;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.photoListView.delegate = self;
        getPhotoList(page : pageNumber ?? 1, isLoadMore : false);
        getBannerList();
    }
    
    private func getPhotoList(page : Int,isLoadMore : Bool) {
        let dataProvider = DSDataProvider();
        dataProvider.delegate = self
        dataProvider.getDataForPhotoListFromNetwork(pageNumber : page, isLoadMore: isLoadMore )
    }
    
    private func getBannerList() {
        let dataProvider = DSDataProvider();
        dataProvider.delegate = self
        dataProvider.getDataForBannerListFromNetwork()

    }
}

extension ViewController : DSDataProviderDelegate {
    
    func bannerDataFetchSuccessfully(photoList: DSPhotoListInfo?) {
        bannerView.bannerArray.append(photoList!) ;
    }
    
    func dataFetchSuccessfully(photoList: [DSPhotoListInfo]?, isLoadMore: Bool) {
        self.pageNumber = (self.pageNumber ?? 1) + 1;
        if (isLoadMore == true) {
            photoListView.footerView?.stopAnimate()
            photoListView.photoArray.append(contentsOf: photoList ?? []);
            photoListView.isLoading = false;

            photoListView.photoCollectionView.reloadData();
        }else {
            photoListView.photoArray = photoList ?? [];
        }
    }
   
    func errorInDataFetch(error: Error?) {
    }
}

extension ViewController : DSPhotoListViewDelegate {
    
    func didSelectRowWithIndexPathObject(photoObjectInfo: DSPhotoListInfo) {
        navigateToDetailPage(photoObjectInfo: photoObjectInfo)
    }
    
    func navigateToDetailPage(photoObjectInfo: DSPhotoListInfo) {
        
        if let detailView = UINib.init(nibName: "DSPhotoDetailView", bundle: nil).instantiate(withOwner: self)[0] as? DSPhotoDetailView {
            detailView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            detailView.photoObj = photoObjectInfo;
            detailView.randerDataOnUI()
            self.view.addSubview(detailView)
        }
    }
    
    func didRefreshViewScrolledAtThresHold() {
        
        getPhotoList(page : pageNumber ?? 1, isLoadMore : true);
    }
}
