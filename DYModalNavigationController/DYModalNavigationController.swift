//
//  MiniNavigationController.swift
//  Flat Chat
//
//  Created by Dominik Butz on 30/3/2019.
//  Copyright © 2019 Duoyun. All rights reserved.
//

import UIKit

public class DYModalNavigationController: UINavigationController, UIViewControllerTransitioningDelegate {


    fileprivate var settings: DYModalNavigationControllerSettings!

    fileprivate var isPresenting = false
    
    fileprivate var backgroundEffectView: UIView?
    
    fileprivate var fixedSize: CGSize?
    
    
    /// Initializer of a DYModalNavigationController
    ///
    /// - Parameters:
    ///  - rootViewController: the first view controller of the nav controller stack
    ///  - fixedSize: the size of the navigation controller instance view. If this optional is set, the top, left and right margins (see settings) will be ignored and the nav controller will be centered horizontally in its parent view controller view. Set a fixed size, if the nav controller should not change its size when changing the screen orientation.
    ///   - settings: instance of a  DYModalNavigationControllerSettings struct. if set to nil, the default values will be used instead.
  public init(rootViewController: UIViewController, fixedSize: CGSize?, settings: DYModalNavigationControllerSettings?) {
        
        super.init(rootViewController: rootViewController)
        
        self.settings = settings ?? DYModalNavigationControllerSettings()
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = .overCurrentContext
        if let _ = fixedSize {
            self.preferredContentSize = fixedSize!
            self.fixedSize = fixedSize
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = true
        
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.isPresenting = false
        
        return self
    }
    
}



extension DYModalNavigationController: UIViewControllerAnimatedTransitioning {
  
    fileprivate func createBlurView(_ frame:CGRect)->UIView{
        let blurEffect = UIBlurEffect(style: self.settings.blurEffectStyle)
        let blurredView = UIVisualEffectView(effect: blurEffect)
        blurredView.frame = frame
        blurredView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredView.alpha = 0
        return blurredView
        
    }
    
    fileprivate func createDimView(_ frame: CGRect) -> UIView {
        
        let dimView = UIView(frame: frame)
        dimView.backgroundColor = self.settings.dimEffectColor
        dimView.alpha = 0
        dimView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return dimView
    }
    
    
    fileprivate func getbackgroundEffectView(_ frame:CGRect)->UIView? {
        
        var effectView:UIView?
        
        switch self.settings.backgroundEffect {
            case .blur:
                effectView  = self.createBlurView(frame)
            case .dim:
                effectView  = self.createDimView(frame)
            case .none:
                effectView = nil
            
        }
        
        return effectView
    }
    
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.isPresenting ? settings.appearTransitionDuration : settings.dismissTransitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if self.isPresenting {
            self.present(with: transitionContext)
        } else {
            self.dismiss(with: transitionContext)
        }
        
    }
    
   fileprivate func present(with transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        // can be nil if set to none in settings
       self.backgroundEffectView = self.getbackgroundEffectView(container.bounds)
        if let _  = self.backgroundEffectView {
            container.addSubview(self.backgroundEffectView!)
        }
        
        let toView = transitionContext.view(forKey: .to)!
//        let toViewController = transitionContext.viewController(forKey: .to)!
        // Configure the layout
        do {
            toView.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(toView)
            
            // Specify a minimum bottom margin
            let bottom = max(self.settings.bottomMargin - toView.safeAreaInsets.bottom, 0)
            container.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: bottom).isActive = true
            
            if self.fixedSize != nil {
                // center horizontally
                container.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: toView.centerXAnchor, constant: 0).isActive  = true
                //set height and width
                toView.heightAnchor.constraint(equalToConstant: fixedSize!.height).isActive = true
                toView.widthAnchor.constraint(equalToConstant: fixedSize!.width).isActive = true

                
            } else {
                // no fixed size, use margin constraints instead
                container.safeAreaLayoutGuide.topAnchor.constraint(equalTo: toView.topAnchor, constant: -self.settings.topMargin).isActive = true
                container.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: -settings.leftMagin).isActive = true
                container.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: settings.rightMargin).isActive = true
                
            }
            
     

        }
        // Apply some styling
        do {
            toView.layer.masksToBounds = true
            toView.layer.cornerRadius = settings.cornerRadius
            
            // shadow only works properly if there is no effect view
           if settings.backgroundEffect == .none {
                container.layer.shadowOpacity = settings.shadowOpacity
               container.layer.shadowRadius = settings.shadowRadius
                container.layer.shadowOffset = settings.shadowOffset
                container.layer.shadowColor =  settings.shadowColor
            }
        }
        // Perform the animation
        do {
            container.layoutIfNeeded()

            switch settings.animationType {
                case .slideInOut:
                    self.animateSlideIn(transitionContext: transitionContext)
                case .fadeInOut:
                    self.animateFadeIn(transitionContext: transitionContext)
            }

        }
    
        
    }
    
   fileprivate func dismiss(with transitionContext: UIViewControllerContextTransitioning) {
        
        switch settings.animationType {
            case .slideInOut:
                self.animateSlideOut(transitionContext: transitionContext)
            case .fadeInOut:
                self.animateFadeOut(transitionContext: transitionContext)
        }
    
    }
    
    
    //MARK: Animations
    
    fileprivate func animateSlideIn(transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: .to)!
        let container = transitionContext.containerView
        
        let originalOriginY = toView.frame.origin.y
        
        let originalOriginX = toView.frame.origin.x
        
        switch settings.slideInDirection {
        case .top:
            toView.frame.origin.y += container.frame.height - toView.frame.minY
        case .bottom:
            toView.frame.origin.y -= container.frame.height + toView.frame.minY
        case .left:
            toView.frame.origin.x  += container.frame.width - toView.frame.minX
        case .right:
            toView.frame.origin.x -= container.frame.width + toView.frame.minX
    
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            
            self.backgroundEffectView?.alpha  = 1.0
            
            switch self.settings.slideInDirection {
            case .top, .bottom:
                  toView.frame.origin.y = originalOriginY
            case .left, .right:
                toView.frame.origin.x = originalOriginX
            }
            
          
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
        
    }
    
    
    fileprivate func animateSlideOut(transitionContext: UIViewControllerContextTransitioning) {
      
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.backgroundEffectView?.alpha = 0
            
            switch self.settings.slideOutDirection {
                case .top:
                     fromView.frame.origin.y -= container.frame.height + fromView.frame.minY
                case .bottom:
                     fromView.frame.origin.y += container.frame.height - fromView.frame.minY
                case .left:
                    fromView.frame.origin.x -= container.frame.width + fromView.frame.minX
                 case .right:
                    fromView.frame.origin.x += container.frame.width - fromView.frame.minX
            }

        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
    
    fileprivate func animateFadeIn(transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: .to)!

        toView.alpha = 0
       
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.backgroundEffectView?.alpha  = 1.0
           toView.alpha = 1.0
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
        
    }
    
    fileprivate func animateFadeOut(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.backgroundEffectView?.alpha = 0
            fromView.alpha = 0
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
        
    }
    

}


