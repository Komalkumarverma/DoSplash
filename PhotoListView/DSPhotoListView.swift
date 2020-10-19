//
//  DSPhotoListView.swift
//  DoSplash
//
//  Created by Komal on 18/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import UIKit

protocol DSPhotoListViewDelegate : class {
    func didSelectRowWithIndexPathObject(photoObjectInfo : DSPhotoListInfo)
    func didRefreshViewScrolledAtThresHold();
}

class DSPhotoListView: UIView {
    
    let footerViewReuseIdentifier = "RefreshFooterView"
    let cellReuseIdentifier = "DSPhotoCollectionViewCell"
    var footerView:CustomFooterView?
    var isLoading:Bool = false

    @IBOutlet weak var photoCollectionView : UICollectionView!;
    weak var delegate : DSPhotoListViewDelegate?;
    
    var photoArray : [DSPhotoListInfo] = []{
        didSet{
            OperationQueue.main.addOperation {
                self.isLoading = false
                self.photoCollectionView.reloadData();
            }
        }
    }
    
    override func awakeFromNib() {
        self.photoCollectionView.delegate = self;
        self.photoCollectionView.dataSource = self;
        self.photoCollectionView.register(UINib(nibName: "CustomFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)

        self.photoCollectionView.register(UINib(nibName: "DSPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    deinit {
        print("deinit deinit deinit")
        
    }
}

extension DSPhotoListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (photoArray.count == 0) {
            return 5;
        }
        return photoArray.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSPhotoCollectionViewCell", for: indexPath) as? DSPhotoCollectionViewCell
        if (photoArray.count > 0) {
            let bannerInfo =  self.photoArray[indexPath.row];
            cell?.randerUIDataInfo(photoInfo: bannerInfo)
            cell?.info_Label.isHidden = true;
            cell?.desc_Label.isHidden = true;

        }else {
            cell?.showSkeltonView();
            cell?.info_Label.isHidden = true;
            cell?.desc_Label.isHidden = true;
        }
        return cell ?? UICollectionViewCell();
        
    }
}

extension DSPhotoListView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: ((indexPath.row % 2 == 0) ? 205 : 408));
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoading {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath) as! CustomFooterView
            self.footerView = aFooterView
            self.footerView?.backgroundColor = UIColor.clear
            return aFooterView
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath)
            return headerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.prepareInitialAnimation()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.stopAnimate()
        }
    }
    
    //compute the scroll value and play witht the threshold to get desired effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold   = 10.0 ;
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        var triggerThreshold  = Float((diffHeight - frameHeight))/Float(threshold);
        triggerThreshold   =  min(triggerThreshold, 0.0)
        let pullRatio  = min(abs(triggerThreshold),1.0);
        self.footerView?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(pullRatio))
        if pullRatio >= 1 {
            self.footerView?.animateFinal()
        }
        print("pullRation:\(pullRatio)")
    }
    
    //compute the offset and call the load method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = abs(diffHeight - frameHeight);
        print("pullHeight:\(pullHeight)");
        if pullHeight == 0.0
        {
            guard let footerView = self.footerView, footerView.isAnimatingFinal else { return }
            print("load more trigger")
            self.isLoading = true
            self.footerView?.startAnimate()
            self.delegate?.didRefreshViewScrolledAtThresHold();
        }
    }
    
}

extension DSPhotoListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (photoArray.count > 0) {
            let bannerInfo =  self.photoArray[indexPath.row];
            self.delegate?.didSelectRowWithIndexPathObject(photoObjectInfo: bannerInfo)
        }else {
        }
    }
}
