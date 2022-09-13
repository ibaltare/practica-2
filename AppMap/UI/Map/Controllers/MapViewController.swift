//
//  MapViewController.swift
//  AppMap
//
//  Created by Nicolas on 11/09/22.
//

import UIKit

protocol MapViewProtocol: AnyObject {
    
}
class MapViewController: UIViewController {

    
    var viewModel: MapViewModelProtocol?
    
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

extension MapViewController: MapViewProtocol {
    
}
