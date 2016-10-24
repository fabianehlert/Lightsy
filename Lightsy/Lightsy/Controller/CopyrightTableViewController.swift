//
//  CopyrightTableViewController.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 24.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

class CopyrightTableViewController: UITableViewController {
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFooter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func setupFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 130))
        footer.backgroundColor = .clear
        
        let logo = UIImageView(frame: CGRect(x: (tableView.frame.size.width / 2) - 30, y: 0, width: 60, height: 60))
        logo.backgroundColor = .clear
        logo.contentMode = .scaleAspectFit
        logo.image = #imageLiteral(resourceName: "RoundAppIcon")
        
        footer.addSubview(logo)
        
        
        let nameLabel = UILabel(frame: CGRect(x: 15, y: 66, width: tableView.frame.size.width - 30, height: 20))
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = UIColor.darkGray
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        nameLabel.text = "Lightsy"
        nameLabel.textAlignment = .center
        
        footer.addSubview(nameLabel)
        
        
        let galaxyLabel = UILabel(frame: CGRect(x: 15, y: 91, width: tableView.frame.size.width - 30, height: 20))
        galaxyLabel.backgroundColor = .clear
        galaxyLabel.textColor = UIColor.lightGray
        galaxyLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        galaxyLabel.text = "Crafted with ❤️ in Milky Way Galaxy."
        galaxyLabel.textAlignment = .center
        
        footer.addSubview(galaxyLabel)
        
        
        let copyrightLabel = UILabel(frame: CGRect(x: 15, y: 109, width: tableView.frame.size.width - 30, height: 20))
        copyrightLabel.backgroundColor = .clear
        copyrightLabel.textColor = UIColor.lightGray
        copyrightLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        copyrightLabel.text = "©2016 Fabian Ehlert"
        copyrightLabel.textAlignment = .center
        
        footer.addSubview(copyrightLabel)


        tableView.tableFooterView = footer
    }
    
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                UIApplication.shared.openURL(URL(string: "https://www.fabianehlert.com")!)
            default:
                break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                UIApplication.shared.openURL(URL(string: "https://github.com/marmelroy/Interpolate")!)
            case 1:
                UIApplication.shared.openURL(URL(string: "https://icons8.com/")!)
            default:
                break
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: Actions
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
