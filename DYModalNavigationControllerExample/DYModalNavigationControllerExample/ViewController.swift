//
//  ViewController.swift
//  DYModalNavigationControllerExample
//
//  Created by Dominik Butz on 4/4/2019.
//  Copyright © 2019 Duoyun. All rights reserved.
//

import UIKit
import DYModalNavigationController


enum Examples: Int, CaseIterable  {
  
    case smallFixedSizeSlide01, smallFixedSizeSlide02, smallFixedSizeSlide03, adaptableLargeSizeFade01, custom
    
    func title()->String {
        
        switch self {
        case .smallFixedSizeSlide01:
            return "Small Fixed Size Slide with shadow"
        case .smallFixedSizeSlide02:
            return "Small Fixed Size Slide with background blur"
        case .smallFixedSizeSlide03:
            return "Small Fixed Size Slide with background dim"
        case .adaptableLargeSizeFade01:
            return "Adaptable Large Size Fade with shadow"
        case .custom:
            return "Custom Example"
        }
    }
    

}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var navController: DYModalNavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 400)
        let imageView = UIImageView(frame: frame)
        imageView.image = #imageLiteral(resourceName: "yorkie")
        imageView.contentMode = .scaleAspectFit
        tableView.tableHeaderView = imageView

    }
    
    func contentVC()->UIViewController {
        
         let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController")
        contentVC!.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapContentVCCancelButton(_:)))
        return contentVC!
    }

    
    @objc func didTapContentVCCancelButton(_ sender: UIBarButtonItem) {
        
        self.navController.dismiss(animated: true, completion: nil)
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Examples.allCases.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = Examples(rawValue: indexPath.row)?.title()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let size = CGSize(width: 300, height: 200)
        var settings = DYModalNavigationControllerSettings()
       
        switch indexPath.row {
            
        case 0:
            self.navController = DYModalNavigationController(rootViewController: contentVC(), fixedSize: size, settings: nil)
        case 1:
             settings.slideInDirection = .right
             settings.slideOutDirection = .right
             settings.backgroundEffect = .blur
            self.navController = DYModalNavigationController(rootViewController: contentVC(), fixedSize: size, settings: settings)
        case 2:
            settings.slideInDirection = .bottom
            settings.slideOutDirection = .right
            settings.backgroundEffect = .dim
            settings.appearTransitionDuration  = 2.0
            self.navController = DYModalNavigationController(rootViewController: contentVC(), fixedSize: size, settings: settings)
        case 3:
            settings.animationType  = .fadeInOut
            settings.shadowOpacity = 0.8
             self.navController = DYModalNavigationController(rootViewController: contentVC(), fixedSize: nil, settings: settings)
        case 4:
            settings.animationType = .custom
            self.navController = DYModalNavigationController(rootViewController: contentVC(), fixedSize: size, settings: settings, customPresentationAnimation: { (transitionContext) in
                self.foldOut(transitionContext: transitionContext, navController: self.navController)
            }, customDismissalAnimation: { (transitionContext) in
                
                self.foldIn(transitionContext: transitionContext, navController: self.navController)
            })
            
        default:
            print("not defined")
        }

        self.present(self.navController!, animated: true, completion: nil)
        
        
    }
    
    func foldOut(transitionContext: UIViewControllerContextTransitioning, navController: DYModalNavigationController) {
        
        let toView = transitionContext.view(forKey: .to)!
        let container = transitionContext.containerView
        // starting transform:
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0).concatenating(CGAffineTransform(scaleX: 0.0, y: 1.0))
  
        container.addSubview(toView)
        
        UIView.animate(withDuration: navController.transitionDuration(using: transitionContext), animations: { () -> Void in
            toView.transform =  CGAffineTransform.identity
          
        }, completion: { completed in
             transitionContext.completeTransition(completed)
        })
        
    }
    
    func foldIn(transitionContext: UIViewControllerContextTransitioning, navController: DYModalNavigationController)  {
        
         let fromView  = transitionContext.view(forKey: .from)
        
        UIView.animate(withDuration: navController.transitionDuration(using: transitionContext), animations: { () -> Void in
            
            fromView!.transform = CGAffineTransform(scaleX: 1.0, y: 0.01)
            
        }, completion: { completed in
             transitionContext.completeTransition(completed)
        })
        
    }
    
    
}
