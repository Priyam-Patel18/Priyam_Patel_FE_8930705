//
//  ViewController.swift
//  Priyam_Patel_FE_8930705
//
//  Created by PRIYAM PATEL on 11/04/24.
//

import UIKit
import MapKit

class MainVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var mapUI: MKMapView!
    @IBOutlet weak var Temperature: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var WeatherLogo: UIImageView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.delegate = self
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "My Final", style: .plain, target: nil, action: nil)
            manager.delegate = self
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
            mapUI.delegate = self
            mapUI.showsUserLocation = true
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let sender = sender as? UIButton else { return }
            if sender.tag == 2 {
                if let destination = segue.destination as? UITabBarController {
                    destination.selectedIndex = 1
                }
            } else if sender.tag == 3 {
                if let destination = segue.destination as? UITabBarController {
                    destination.selectedIndex = 2
                }
            }
        }
        
        func updateUI(with data: WeatherModel) {
            Temperature.text = "\(Int(data.main.temp))°C"
            WindSpeed.text = "Wind: \(data.wind.speed)Km/h"
            Humidity.text = "Humidity: \(data.main.humidity)"
            WeatherLogo.image = UIImage(systemName: mapWeatherConditionToSymbol(data.weather.first?.id ?? 0))
        }
    }

    extension MainVC: MKMapViewDelegate {
        // Implement map view delegate methods if needed
    }

    extension MainVC: CLLocationManagerDelegate {
        func locationManager(_ lManager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                lManager.requestLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapUI.setRegion(region, animated: true)
            fetchWeatherData(for: location.coordinate)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error fetching location: \(error.localizedDescription)")
        }
    }

    extension MainVC {
        private func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
            let apiKey = "11236f9599cc5b465ed891b6d43d862c"
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric")!
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.updateUI(with: weatherData)
                    }
                } catch {
                    print("Error decoding weather data: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
