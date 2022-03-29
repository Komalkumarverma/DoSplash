//
//  CustomFooterView.swift
//  DoSplash
//
//  Created by Komal on 18/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//



import Foundation
import UIKit

class CustomFooterView : UICollectionReusableView {
    
    @IBOutlet weak var imageView : UIImageView!
    var isAnimatingFinal:Bool = false
    var currentTransform:CGAffineTransform?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareInitialAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setTransform(inTransform:CGAffineTransform, scaleFactor:CGFloat) {
        if isAnimatingFinal {
            return
        }
        self.currentTransform = inTransform
    }
    
    //reset the animation
    func prepareInitialAnimation() {
        self.isAnimatingFinal = false
    }
    
    func startAnimate() {
        self.isAnimatingFinal = true
        showSkeltonView();
    }
    
    func stopAnimate() {
        self.isAnimatingFinal = false
        hideSkeltonView();
    }
    
    func showSkeltonView() {
        
        self.imageView.showAnimatedGradientSkeleton()
            }
    
    func hideSkeltonView() {
        
        self.imageView.hideSkeleton()
    }
    
    
    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) { 
//            self.refreshControlIndicator?.transform = CGAffineTransform.identity
        }
    }
}
