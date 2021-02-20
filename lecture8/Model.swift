//
//  Model.swift
//  lecture8
//
//  Created by admin on 08.02.2021.
//

import Foundation


public struct Model: Codable{
    let timezone: String?
    let hourly: [Current]?
    let daily: [Daily]?
    let current: Current?
    let name: String?
}

struct Current: Codable {
    let temp: Double?
    let feels_like: Double?
    let weather: [Weather]?
}

struct Daily: Codable {
    let temp: Temp?
    let feels_like: Temp?
    let weather: [Weather]?
}

struct Temp: Codable {
    let day: Double?
}

struct Weather: Codable {
    let main: String?
    let description: String?
}

protocol CityApiProtocol {
    func gethost() -> String
}

struct CityApi: CityApiProtocol{
    func gethost() -> String {
        return startHost+"lat="+String(lat ?? 0)+"&lon="+String(lon ?? 0)+endHost
    }
    let cityName: String?
    let startHost: String = "https://api.openweathermap.org/data/2.5/onecall?"
    let lat: Double?
    let lon: Double?
    let endHost: String = "&exclude=minutely,alerts&appid=0e9477e67e53c8c91844f7d87860ae02&units=metric"
}


