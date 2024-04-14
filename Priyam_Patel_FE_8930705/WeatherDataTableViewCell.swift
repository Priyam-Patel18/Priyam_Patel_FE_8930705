//
//  WeatherDataTableViewCell.swift
//  Priyam_Patel_FE_8930705
//
//  Created by PRIYAM PATEL on 11/04/24.
//

import UIKit

class WeatherDataTableViewCell: UITableViewCell {

    @IBOutlet weak var lblWindspeed: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    

    func setup(data: WeatherCoreData) {
        lblWindspeed.text = "Wind: \(data.wind ?? "")"
        lblHumidity.text = "Humidity: \(data.humidity ?? "")"
        lblTemp.text = "Temp: \(data.temp ?? "")"
        lblTime.text = "Time: \(data.time ?? "")"
        lblDate.text = data.date ?? ""
        lblFrom.text = data.from ?? ""
        lblCity.text = data.cityName ?? ""
    }

}
