//
//  UIWindow+ConnectionBanner.swift
//  networkConnectionCheck
//
//  Created by eugene golovanov on 6/28/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit
let BOTTOM_BANNER_CONNECTION_VIEW_TAG : Int = 56
let GLOBAL_FRAME = UIScreen.mainScreen().bounds
let BANNER_HEIGHT:CGFloat = 35.0


extension UIWindow {
    
    
    //-------------------------------------------------------------------------------------------------------------------------
    //MARK: - Banner
    
    /**
     Method shows green bottom banner
     */
    func showConnectionBanner() {
        
        let masterView = self.subviews.first!
        masterView.layer.removeAllAnimations()
        self.cleanupConnectionBanner(masterView: masterView)
        
        //Banner itself
        let bannerFrame = CGRect(
            x: 0,
            y: masterView.frame.size.height,
            width: masterView.frame.size.width,
            height: BANNER_HEIGHT)
        let bannerView = UIView(frame: bannerFrame)
        
        bannerView.tag = BOTTOM_BANNER_CONNECTION_VIEW_TAG
        bannerView.backgroundColor = UIColor.orangeColor()
        bannerView.alpha = 0.4
        masterView.addSubview(bannerView)
        
        //TextFrame
        let textWidthMargin:CGFloat = 35.8
        let textFrame = CGRectMake(textWidthMargin,
                                   8.0,
                                   masterView.frame.size.width-textWidthMargin*2,
                                   BANNER_HEIGHT-16.5)
        //Textmessage
        let bannerTextview = UILabel(frame: textFrame)
        bannerTextview.text = "Internet Connection Lost"
        bannerTextview.textColor = UIColor.whiteColor()
        bannerTextview.textAlignment = NSTextAlignment.Center
        bannerTextview.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        bannerTextview.backgroundColor = UIColor.clearColor()
        bannerView.addSubview(bannerTextview)

        //Animation
        self.animateShowBanner(bannerView: bannerView, masterView: masterView)
    }
    
    /**
     Hides connection banner if its exists
     */
    func hideConnectionBanner() {
        let masterView = self.subviews.first!
        
        guard let bannerView = viewWithTag(BOTTOM_BANNER_CONNECTION_VIEW_TAG) else {
            print("banner does not exists wit tag, Ignoring")
            return
        }
        let fr = CGRectMake(0, 0, GLOBAL_FRAME.size.width, GLOBAL_FRAME.size.height)
        
    ////////ANIMATION START//////////
        UIView.animateWithDuration(0.5, animations: {
            
            //Window back to normal
            masterView.frame = fr
            masterView.layoutIfNeeded()
            
            //Hiding banner
            bannerView.transform = CGAffineTransformMakeTranslation(0, BANNER_HEIGHT)
            
        }) { (completed) in
            if completed {
                self.cleanupConnectionBanner(masterView: masterView)
                masterView.frame = GLOBAL_FRAME
            }
        }
    //////ANIMATION END//////////
    }
    
    //-------------------------------------------------------------------------------------------------------------------------
    //MARK: - Private Methods
    
    
    /**
     Method performs animation for banners
     */
    private func animateShowBanner(bannerView bannerView:UIView, masterView: UIView) {
        
        let fr = CGRectMake(0, 0, GLOBAL_FRAME.size.width, GLOBAL_FRAME.size.height - BANNER_HEIGHT)

    ////////ANIMATION START//////////
        UIView.animateWithDuration(0.5, animations: {
            //Animation 1
            
            //Window offset
            masterView.frame = fr
            masterView.layoutIfNeeded()
            
            //showing banner
            bannerView.frame.origin.y = fr.height
        })
    //////ANIMATION END//////////
    }
    
    
    /**
     Init main view in window before animation begin
     */
    private func cleanupConnectionBanner(masterView masterView: UIView) {
        for view:UIView in masterView.subviews {
            if view.viewWithTag(BOTTOM_BANNER_CONNECTION_VIEW_TAG) != nil {
                view.removeFromSuperview()
            }
        }
        print("Done with banner cleaning")
    }

    
    
}
