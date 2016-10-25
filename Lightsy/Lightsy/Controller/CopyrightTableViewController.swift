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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction fileprivate func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
