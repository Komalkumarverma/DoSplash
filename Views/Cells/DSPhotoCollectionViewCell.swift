//
//  DSPhotoCollectionViewCell.swift
//  DoSplash
//
//  Created by Komal on 18/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

class DSPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photo_Image : UIImageView!;
    @IBOutlet weak var backView : UIImageView!;
    @IBOutlet weak var profile_Image : UIImageView!;
    @IBOutlet weak var info_Label : UILabel!;
    @IBOutlet weak var desc_Label : UILabel!;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func randerUIDataInfo(photoInfo : DSPhotoListInfo) {
        hideSkeltonView();
        backView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        backView.sd_imageIndicator?.startAnimatingIndicator()
        backView.sd_setImage(with: URL(string: photoInfo.urls?.small ?? ""), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
             // your rest code
            self.backView.sd_imageIndicator?.stopAnimatingIndicator()
        })
        photo_Image.sd_setImage(with: URL(string: photoInfo.urls?.full ?? ""), placeholderImage:nil)
        if ((photoInfo.user) != nil) {
            profile_Image.sd_setImage(with: URL(string: photoInfo.user?.profile_image?.small ?? ""), placeholderImage: nil)

        }
    }
    
    func showSkeltonView() {
        photo_Image.showAnimatedGradientSkeleton()
    }
    
    func hideSkeltonView() {
        photo_Image.hideSkeleton()
    }

}
