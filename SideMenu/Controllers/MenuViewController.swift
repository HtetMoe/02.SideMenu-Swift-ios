//
//  MenuViewController.swift
//  SideMenu
//  Created by Htet on 28/08/2021.

import UIKit

protocol MenuViewControllerDeligate : AnyObject {
    func didSelectMenuItem(menuItem : MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var deligate : MenuViewControllerDeligate?
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case setting = "Setting"
        
        var imageName : String {
            switch self {
            case .home:
                return "house"
            case .setting :
                return "gearshape"
            case .info :
                return "info.circle"
            }
        }
    }
    private let tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.separatorStyle = UITableViewCell.SeparatorStyle.none // remove tb view sperator
      
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
       
        cell.backgroundColor             = .systemBackground
        cell.contentView.backgroundColor = .systemBackground
        cell.textLabel?.textColor        = .black
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .black
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = MenuOptions.allCases[indexPath.row]
        deligate?.didSelectMenuItem(menuItem: item)
    }

}
