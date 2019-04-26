//
//  StateOfMindController.swift
//  Marilyn
//
//  Created by Tatsuya Moriguchi on 4/18/19.
//  Copyright © 2019 Becko's Inc. All rights reserved.
//

import UIKit

class StateOfMindViewController: UIViewController {

    @IBOutlet weak var stateOfMindRatePicker: UIPickerView!
    @IBOutlet weak var stateOfMindInfo: UITextView!
    override func viewDidLayoutSubviews() {
        stateOfMindInfo.setContentOffset(.zero, animated: true)
    }
    
    @IBOutlet weak var stateOfMindDescPicker: UIPickerView!
    
    @IBAction func saveStateOfMindOnPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }

    

}

