//
//  DSPhotoDetailView.swift
//  DoSplash
//
//  Created by Komal on 18/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//

import UIKit
import SDWebImage

class DSPhotoDetailView: UIView {

    
    @IBOutlet weak var profile_Image : UIImageView!;
    @IBOutlet weak var location_Lbl : UILabel!;
    @IBOutlet weak var desc_Lbl : UILabel!;
    @IBOutlet weak var name_Lbl : UILabel!;
    @IBOutlet weak var photo_Image : UIImageView!;

    var photoObj : DSPhotoListInfo?
    
    func randerDataOnUI() {
        photo_Image.sd_setImage(with: URL(string: photoObj?.urls?.regular ?? ""), placeholderImage: UIImage(named: "Splash Screen Image.png"))
        profile_Image.sd_setImage(with: URL(string: photoObj?.user?.profile_image?.small ?? ""), placeholderImage: nil)
        location_Lbl.text = photoObj?.user?.location ?? "Location Not Found"
        desc_Lbl.text = photoObj?.alt_description ?? "Description Not Found"
        name_Lbl.text = photoObj?.user?.name ?? "Name Not Found"
    }
    
    @IBAction func closeButtonAction() {
        self.removeFromSuperview()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
