//
//  ViewController.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 30/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dispatcher = NetworkDispatcher(serverConfig: ServerConfig.appConfig)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PollutantStandardIndexOperation().perform(onDispatcher: dispatcher, completionHandler: { response in
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

