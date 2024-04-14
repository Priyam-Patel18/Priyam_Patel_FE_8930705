//
//  LocationTableViewCell.swift
//  Priyam_Patel_FE_8930705
//
//  Created by PRIYAM PATEL on 11/04/24.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCitynme: UILabel!
    @IBOutlet weak var lblTravel: UILabel!
    @IBOutlet weak var lblModeofTravel: UILabel!
    @IBOutlet weak var lblEndPoint: UILabel!
    @IBOutlet weak var lblStartPoint: UILabel!
    
    func setup(data: DirectionsData) {
        lblCitynme.text = data.cityName ?? ""
        lblTravel.text = data.distance ?? ""
        lblModeofTravel.text = data.method
        lblEndPoint.text = data.endPoint ?? ""
        lblStartPoint.text = data.startPoint ?? ""
    }

}
