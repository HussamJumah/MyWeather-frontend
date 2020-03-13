# MyWeather-frontend

## Credits
1. [Hussam Jumah](https://github.com/HussamJumah/)
2. [Greik Kadriu](https://github.com/Greik98)

## Running code (MacOS is required)

1. You need to have the backend deployed somewhere, you can start with localhost deployment. Clone backend from here: https://github.com/HussamJumah/MyWeather-backend
2. Download and install `xcode` >= 10.0 https://developer.apple.com/xcode/
3. Install `cocoapods` https://cocoapods.org/
4. Navigate to the app's root directory and run `pod install`
5. Navigate to MyWeather -> MyWeather -> Network
6. Run `nano API.swift` or use any text editor you are familiar with
7. Change line 12 to this `return URL(string: "http://localhost:3001")!` (Make sure to change the address of the URL if is deployed somewhere other than `localhost:3001`
8. If using nano then press `CTRL + X` then `Y` then `Enter`, if using any othere editor then just save and close
9. Open MyWeather.xcworkspace using `xcode`
10. Connect an iPhone
11. Run the app by pressing the play button from the top right
