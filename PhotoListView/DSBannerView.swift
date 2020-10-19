//
//  DSBannerView.swift
//  DoSplash
//
//  Created by Komal on 18/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import UIKit

class DSBannerView: UIView {
    
    @IBOutlet weak var bannerCollectionView : UICollectionView!;
    
    var bannerArray : [DSPhotoListInfo] = []{
        didSet{
            OperationQueue.main.addOperation {
                self.bannerCollectionView.reloadData();
            }
        }
    }
    
    override func awakeFromNib() {
        
        self.bannerCollectionView.delegate = self;
        self.bannerCollectionView.dataSource = self;
        self.bannerCollectionView.register(UINib(nibName: "DSPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSPhotoCollectionViewCell")
    }
    
    deinit {
        print("deinit deinit deinit")
        
    }
}

extension DSBannerView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (bannerArray.count == 0) {
            return 5;
        }
        return bannerArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSPhotoCollectionViewCell", for: indexPath) as? DSPhotoCollectionViewCell
        if (bannerArray.count > 0) {
            let bannerInfo =  self.bannerArray[indexPath.row];
            cell?.randerUIDataInfo(photoInfo: bannerInfo)
            cell?.profile_Image.isHidden = true;
        }else {
            cell?.showSkeltonView();
        }
        return cell ?? UICollectionViewCell();
        
    }
}

extension DSBannerView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: 200);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

