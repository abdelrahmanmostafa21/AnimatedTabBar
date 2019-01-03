//
//  AnimatedTabBarController.swift
//  TabBarTest
//
//  Created by Alberto García-Muñoz on 30/12/2018.
//  Copyright © 2018 Alberto García-Muñoz. All rights reserved.
//

import UIKit

open class AnimatedTabBarController: UIViewController {
    open var tabBar : AnimatedTabBar!
    open var contentView : UIView!
    open weak var delegate: AnimatedTabBarDelegate?
    
    private var heightConstraint : NSLayoutConstraint!
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        addContentView()
        addTabBar()
        contentView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        heightConstraint = NSLayoutConstraint(item: tabBar,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1,
                                              constant: heightOfStackView+bottomSafeAreaHeight)
        
        tabBar.addConstraint(heightConstraint)
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [weak self] (_) in
            self?.heightConstraint.constant = heightOfStackView+bottomSafeAreaHeight
            }, completion: nil)
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    private func addTabBar() {
        let tabBar = AnimatedTabBar()
        tabBar.containerView = contentView
        tabBar.backgroundColor = SoundTabBarAppearance.shared.backgroundColor
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = delegate
        tabBar.clipsToBounds = true
        view.addSubview(tabBar)
        
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.tabBar = tabBar
    }
    
    private func addContentView() {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.contentView = contentView
    }
}
