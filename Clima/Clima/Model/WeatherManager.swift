//
//  WeatherManager.swift
//  Clima
//
//  Created by ntubic on 27.11.2022..
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=81b90ff09337884d80c7e0e211438598&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
            //        1. create url
        
        if let url = URL(string: urlString) {
            //        2. create url session
            
            let session = URLSession(configuration: .default)
            
            //        3. give session a task
            
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = parseJson(safeData){
                        delegate?.didUpdateWeather(weatherManager: self,weather: weather)
                    }
                }
            }
            
            //        4. start task
            
            task.resume()
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            print(weather.temperatureString)
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
