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
    
    
    
        
        
//        //BANNER CONSTRAINTS
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        
//        let bannerViewWidthConstraint = NSLayoutConstraint(item: bannerView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: masterView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
//        bannerView.addConstraint(bannerViewWidthConstraint)
//        
//        let bannerViewHeightConstraint = NSLayoutConstraint(item: bannerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: bannerHeight)
//        bannerView.addConstraint(bannerViewHeightConstraint)
//        
//        
//        let bannerViewCenterConstraint = NSLayoutConstraint(item: bannerView, attribute: NSLayoutAttribute.CenterX , relatedBy: NSLayoutRelation.Equal, toItem: masterView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant:  0)
//        masterView.addConstraint(bannerViewCenterConstraint)
//        
//        let bannerViewTopConstraint = NSLayoutConstraint(item: bannerView, attribute: NSLayoutAttribute.Top , relatedBy: NSLayoutRelation.Equal, toItem: masterView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant:  0)
//        masterView.addConstraint(bannerViewTopConstraint)

        
//        //Animation
//        self.animateBanner(bannerView: bannerView, masterView: masterView, bannerHeight: bannerHeight)
        
        

    
    /**
     Method shows green bottom banner
     */
    func showConnectionBanner() {
        
        
        let masterView = self.subviews.first!
        self.cleanupBanners(masterView: masterView)
        

        
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
        
        
        
        
        
//        masterView.layer.removeAllAnimations()
//        bannerView.layer.removeAllAnimations()

        //Animation
        self.animateBanner(bannerView: bannerView, masterView: masterView)
        
        
    }
    
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------
    //MARK: - Private Methods
    
    /**
     Method performs animation for banners
     */
    private func animateBanner(bannerView bannerView:UIView, masterView: UIView) {
        

        

        ////////ANIMATION START//////////
        
        let f = self.frame
        let fr = CGRectMake(0, 0, f.size.width, f.size.height - BANNER_HEIGHT)
        
        
        
        

        
        //Appearance animation
        UIView.animateWithDuration(0.5, animations: {
            //Animation 1
            
            //Window offset
            masterView.frame = fr
            masterView.layoutIfNeeded()
            
            //showing banner
            bannerView.frame.origin.y = fr.height


            
        }) { (completed) in
            if completed {
//                dispatch_after(dispatchTime, dispatch_get_main_queue()) {
//                    UIView.animateWithDuration(0.5, animations: {
//                        //Animation 2
//                        
//                        //Window offset
//                        masterView.frame = self.frame
//                        masterView.layoutIfNeeded()
//                        
//                        //showing banner
////                        bannerView.frame = CGRectOffset(bannerView.frame, 0, -bannerHeight)
//                        bannerView.transform = CGAffineTransformMakeTranslation(0, bannerHeight);
//                        
//                        
//
//                        
//                        }, completion: { (success) in
//                            if success {
////                                print("Done with banner animation, starting to remove used banner...")
//                                
//                                self.cleanupBanners(masterView: masterView)
//                                
//                            }
//                    })
//                }
            }
        }
        //////ANIMATION END//////////
    }

    
    
    func hideConnectionBanner() {

        
        let masterView = self.subviews.first!
        
        guard let bannerView = viewWithTag(BOTTOM_BANNER_CONNECTION_VIEW_TAG) else {
            print("banner does not exists wit tag")
            return
        }
        
        
        ////////ANIMATION START//////////
        
        let f = self.frame
        let fr = CGRectMake(0, 0, f.size.width, f.size.height)
        
        
        
        //Appearance animation
        UIView.animateWithDuration(0.5, animations: {
            //Animation 1
            
            //Window offset
            masterView.frame = fr
            masterView.layoutIfNeeded()
            
            
            bannerView.transform = CGAffineTransformMakeTranslation(0, BANNER_HEIGHT)
//            //showing banner
//            bannerView.frame.origin.y = fr.height
            
            
            
        }) { (completed) in
            if completed {
                self.cleanupBanners(masterView: masterView)
            }
        }
        //////ANIMATION END//////////
        
        
        
        
//        UIView.animateWithDuration(0.5) { 
//            bannerView.frame.origin.y = fr.height
//        }
        
        
        

    }
    
    
    
    
    
    private func cleanupBanners(masterView masterView: UIView) {
        for view:UIView in masterView.subviews {
            if view.viewWithTag(BOTTOM_BANNER_CONNECTION_VIEW_TAG) != nil {
                view.removeFromSuperview()
            }
        }
        print("Done with banner cleaning")
    }

    
    
    

    
    
    
}
