//
//  ViewController.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 30/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import UIKit
import GoogleMaps
import MBProgressHUD

class ViewController: UIViewController {
    private let dispatcher = NetworkDispatcher(serverConfig: ServerConfig.appConfig)
    
    @IBOutlet weak var mapVIew: GMSMapView!
    var markers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let camera = GMSCameraPosition.camera(withLatitude: 1.35735, longitude: 103.82, zoom: 10.5)
        self.mapVIew.camera = camera
        self.loadPSI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private extension ViewController {
    
    func loadPSI() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        PollutantStandardIndexOperation().perform(onDispatcher: dispatcher, completionHandler: { response in
            MBProgressHUD.hide(for: self.view, animated: true)
            switch response {
            case .success(let psi):
                self.clearMarkers()
                self.populateMap(psi: psi as! PollutantStandardIndex)
            case .error(let error):
                self.showError(error: error)
            }
        })
    }
    
    func populateMap(psi: PollutantStandardIndex) {
        
    }
    
    func clearMarkers() {
        for marker in self.markers {
            marker.map = nil
        }
        self.markers.removeAll()
    }
    
    func showError(error: Error) {
        let alertController = UIAlertController(title: NSLocalizedString("Opps!", comment: ""), message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
