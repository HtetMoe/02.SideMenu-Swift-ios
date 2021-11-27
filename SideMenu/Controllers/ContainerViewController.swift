//
//  ViewController.swift
//  SideMenu
//  Created by Htet on 28/08/2021.
//  https://www.youtube.com/watch?v=1hzPFAYcuUI

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState : MenuState = .closed
    
    var navVC : UINavigationController?
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController() // default vc
    
    lazy var infoVC    = InfoViewController()
    lazy var settingVC = SettingViewController()
    
    //A lazy var is a property whose initial value is not calculated until the first time it's called
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground //UIColor(red: 1.00, green: 0.72, blue: 0.72, alpha: 1.00)
        
        addChildVCs()
    }
    
    private func addChildVCs() {
        
        //Menu
        menuVC.deligate = self
        
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Home
        homeVC.deligate = self
        
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

//MARK-: HomeVCDeligate
extension ContainerViewController : HomeViewControllerDeligate{
    
    func menuBarButtonPressed() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion : (() -> Void)?){
        //annimate the menu
        switch menuState {
        case .closed:
            //open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            }
            completion: {[weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            //close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            }
            completion: {[weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async { // when click on 1 vc, close sideMenu
                        completion?()
                    }
                }
            }
        }
        
    }
}

//MARK-: MenuVCDeligate
extension ContainerViewController : MenuViewControllerDeligate {
   
    func didSelectMenuItem(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        
        switch menuItem{
        case .home    : self.resetToHome()
        case .setting  : self.addSetting()
        case .info    : self.addInfo()
        
        }
    }

    func addSetting(){ // replace in homeVC
        let vc = settingVC
        
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: self)
        homeVC.title = vc.title
    }
    
    func addInfo(){ // replace in homeVC
        let vc = infoVC
        
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: self)
        homeVC.title = vc.title
    }
    
    func resetToHome(){
        // remove info vc
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        
        //remove setting vc
        settingVC.view.removeFromSuperview()
        settingVC.didMove(toParent: nil)
        
        homeVC.title = "Home"
    }
}

