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
    private var markers = [GMSMarker]()
    private var markerView: MarkerInfoView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapVIew.delegate = self
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
        
        for (_, region) in psi.items {
            if region.latitude != 0 && region.longitude != 0 {
                let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(region.latitude), longitude: CLLocationDegrees(region.longitude))
                let marker = GMSMarker(position: position)
                marker.userData = region
                marker.map = self.mapVIew
                self.markers.append(marker)
            }
        }
        
    }
    
    func generateReadings(forRegion region:Region)->String {
        var readings = "Readings:\n"
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.roundingMode = .halfUp
        
        for (key, value) in region.readings {
            readings.append("  \(key): \(formatter.string(from: value as NSNumber)!)\n")
        }
        return readings
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



extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("MarkerInfoView", owner: self, options: nil)?.first as! MarkerInfoView
        let region = marker.userData as! Region
        infoWindow.contentLabel.text = self.generateReadings(forRegion: region)
        infoWindow.frame = CGRect(x: 0, y: 0, width: 260, height: 252)
        return infoWindow
    }
}

