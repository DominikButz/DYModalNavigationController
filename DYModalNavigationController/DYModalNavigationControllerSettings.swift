//
//  DYModalNavigationControllerSettings.swift
//  DYModalNavigationController
//
//  Created by Dominik Butz on 6/4/2019.
//  Copyright © 2019 Duoyun. All rights reserved.
//

import Foundation

public struct DYModalNavigationControllerSettings {
    
    public var topMargin: CGFloat = 20.0
    public  var bottomMargin: CGFloat = 20.0
    public var leftMagin:CGFloat = 20.0
    public  var rightMargin: CGFloat = 20.0
    public var cornerRadius: CGFloat = 20.0
    public   var appearTransitionDuration: TimeInterval = 0.5
    public  var dismissTransitionDuration: TimeInterval = 0.5
    
    public var animationType: AnimationType = .slideInOut
    public  var slideInDirection: SlideDirection = .top
    public var slideOutDirection: SlideDirection = .bottom
    
    public var backgroundEffect: BackgroundEffect = .none
    public  var blurEffectStyle: UIBlurEffect.Style = .regular
    public var dimEffectColor: UIColor = UIColor.darkGray.withAlphaComponent(0.7)
    
    public  var shadowOpacity: Float = 0.6
    public var shadowRadius: CGFloat = 6.0
    public   var shadowOffset: CGSize = CGSize(width: -0.5, height: 0.5)
    public  var shadowColor:CGColor  =  UIColor.darkGray.cgColor
    
    public enum BackgroundEffect {
        case dim, blur, none
    }
    
   public  enum AnimationType {
        case slideInOut, fadeInOut, custom
    }
    
   public  enum SlideDirection {
        case left, right, top, bottom
    }

    public init() {
        // necessary because implicit init is always internal!
    }
    
}
