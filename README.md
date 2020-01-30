# Weather Forecast

Weather Forecast is an example iOS app that uses the OpenWeatherMap API to track weather for the next 5 days in Dublin

## Requirements

A MacOS device running XCode 10.2

## How to Build/Run

1. Make a clone of this repository in a folder on your Mac OS using your favourite git tool  
2. Open the project in XCode
3. Select any simulator as target, as the interface was created with Autolayout, but the iPhone 7/8 simulator is preffered 
4. Build and run!

Optional: If you want to run on the device, you will need to select a team and create a bundle id for the project.

## To do

- Better structure the code using a network manager for connections
- Fully understand how OpenWeatherMap API data works and if data doesn't change from day to day, save data into Core Data 
- Make the app beautiful
- Implement local notifications for various changes in terms of Weather
- Add Unit Tests and Interface Tests

## Pods Used

Alamofire - https://github.com/Alamofire/Alamofire

The pod was integrated into the project for easier download and to make sure the project is buildable in case Alamofire is getting updated
