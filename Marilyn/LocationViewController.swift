//
//  LocationViewController.swift
//  Marilyn
//
//  Created by Tatsuya Moriguchi on 4/26/19.
//  Copyright © 2019 Becko's Inc. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var locationPicker: UIPickerView!
    @IBAction func saveOnPressed(_ sender: Any) {
        

            
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // animated: true returns warning "Swift Unbalanced calls to begin/end appearance transitions for"
        self.navigationController?.popToRootViewController(animated: false)
        
        if let tabBarController = appDelegate.window!.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = 0
            }
     
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
