//
//  MenuView.swift
//  Habits
//
//  Created by Alexander Thompson on 11/5/21.
//

import UIKit

protocol SettingsPush {
    func pushSettings(row: Int)
}

class SideMenuVC: UIViewController {
    
    
    //MARK: - Properties
    
    let emailFeedback = EmailFeedback()
    let tableView = UITableView()
    var delegate: SettingsPush?
    
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.backgroundColor    = BackgroundColors.secondaryBackground
        tableView.frame              = view.bounds
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.estimatedRowHeight = 70
        tableView.separatorStyle     = .none
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseID)
        view.addSubview(tableView)
    }
    
}

//MARK: - TableView - UITableViewDelegate, UITableViewDataSource
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPage.menuTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell             = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseID) as! MenuCell
        if indexPath.row < 7 { // TODO: -  stops nil error due to limited gradients. implement a better way to do this.
            cell.cellImage.image = UIImage(systemName: menuPage.menuImages[indexPath.row])?.addTintGradient(colors: gradients.array[indexPath.row])
        } else {
            cell.cellImage.image = UIImage(systemName: menuPage.menuImages[indexPath.row])?.addTintGradient(colors: gradients.array[indexPath.row - 7])
        }
        cell.cellLabel.text  = menuPage.menuTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)! as! MenuCell
        currentCell.cellImage.bounceAnimation()
        
        // TODO: - move all this to a func with enum?
        switch indexPath.row {
        case 0: shareApp()
        case 1: let urlStr = "\(SocialMedia.appLink)?action=write-review"
            guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        case 2: emailFeedback.newEmail()
        case 3: delegate?.pushSettings(row: 3)
        case 4: guard let url = URL(string: SocialMedia.privacyPolicyURL) else { return }
            UIApplication.shared.open(url)
            
        case 5: delegate?.pushSettings(row: 5)
        case 6:delegate?.pushSettings(row: 6)
        case 7: if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
        default: print("error")
            
        }
    }
    
    //MARK: - Share Functionality
    
    func shareApp() {
        if let urlString = NSURL(string: SocialMedia.appLink) {
            let activityItems = [urlString]
            
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}