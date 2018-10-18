//
//  WeatherTableViewController.swift
//  CapTemp
//
//  Created by Alan Shih on 9/19/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    let client = ClientManager()
    var captechLocations = [Location]()
    var refreshCount = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize
        let imageView = UIImageView(image:UIImage(named: "CapTempHeader"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.initCapTechLocations()
        self.loadWeather()
        self.initRefreshControls()
        
    }
    
    private func initRefreshControls(){
        //Add Refresh Control
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        self.refreshControl?.addTarget(self, action: #selector(loadWeather), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }

    private func initCapTechLocations(){
        captechLocations.append(Location.init(name: "Atlanta", coordinate: (33.770877, -84.386142)))
        captechLocations.append(Location.init(name: "Baltimore", coordinate: (39.287039, -76.609315)))
        captechLocations.append(Location.init(name: "Charlotte", coordinate: (35.225716, -80.845662)))
        captechLocations.append(Location.init(name: "Chicago", coordinate: (41.879528, -87.636066)))
        captechLocations.append(Location.init(name: "Columbus", coordinate: (39.980720, -82.985586)))
        captechLocations.append(Location.init(name: "Denver", coordinate: (39.748819, -104.991766)))
        captechLocations.append(Location.init(name: "Orlando", coordinate: (28.538336, -81.379234)))
        captechLocations.append(Location.init(name: "Philadelphia", coordinate: (40.583282, -76.230524)))
        captechLocations.append(Location.init(name: "Reston", coordinate: (38.952290, -77.351010)))
        captechLocations.append(Location.init(name: "Richmond", coordinate: (37.519231, -77.473927)))
    }
    
    @objc private func loadWeather(){
        
        if(refreshCount == -1){
            self.refreshCount = 0
            for index in 0..<captechLocations.count {
                var location = captechLocations[index]
                client.getCurrentWeather(latitude: location.coordinate.0, longitude: location.coordinate.1) { (response, error) in
                    
                    self.refreshCount += 1
                    
                    if(response != nil){
                        location.weather = response
                        self.captechLocations[index] = location
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
                    } else {
                        print(error)
                    }
                    
                    if(self.refreshCount == 10){
                        self.refreshControl?.endRefreshing()
                        self.refreshCount = -1
                    }
                }
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.captechLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell

        let location = self.captechLocations[indexPath.row]
        cell.nameLabel.text = location.name
        
        guard let weather = location.weather else {
            return cell
        }
        
        
        cell.temperatureLabel.text = "\(Int(weather.current.temperature))°F"
        
        cell.conditionLabel.text = weather.current.summary
        
        if weather.forecast.count > 0{
            let today = weather.forecast[0]
            cell.highTempLabel.text = "H: \(Int(today.temperatureHigh))°F"
            cell.lowTempLabel.text = "L: \(Int(today.temperatureLow))°F"
            cell.sunsetTimeLabel.text = today.sunsetDateString
            cell.sunriseTimeLabel.text = today.sunriseDateString
            cell.percipTypeImageView.image = UIImage.init(named: today.getPercipitationTypeImage())
            cell.percipProbLabel.text = "\(Int(today.precipProbability*100))%"
            
        }
        cell.descriptionLabel.text = "\(weather.summary)"
        cell.weatherImageView?.image = UIImage.init(named: weather.current.getConditionImageName())
        
        
        return cell
    }
 

}


