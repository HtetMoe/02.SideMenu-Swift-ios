//
//  HomeViewController.swift
//  SideMenu
//  Created by Htet on 28/08/2021.

import UIKit

protocol HomeViewControllerDeligate : AnyObject{
    func menuBarButtonPressed()
}

class HomeViewController: UIViewController {
    weak var deligate : HomeViewControllerDeligate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = UIColor(red: 1.00, green: 0.72, blue: 0.72, alpha: 1.00)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName : "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(menuBarButtonPressed))
    }
    
    @objc func menuBarButtonPressed() {
        deligate?.menuBarButtonPressed()
    }
    
}
