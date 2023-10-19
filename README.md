# ios-webview-communication

Prototype demonstrating two-way communication between a webview (Reactjs app) and SwiftUI. i.e., execute native code from the webview JavaScript and execute webview JavaScript code from native.

# Use Case

You've are building a product that requires some sort of hardware functionality, like bluetooth, camera, or NFC but you are on a tight budget and can't afford to build and maintain a 100% native app. So, you build the common UI with Reactjs and use native code to handle the hardware functionality.

# Requirements

- Xcode 15
- Nodejs LTS

# How to run

1. Clone the repo
2. `cd` to my-react-app, run `npm install`
3. run `npm run build`
4. run `npm run preview -- --host`
5. open ReactCommunication.xcodeproj in Xcode
6. Change the signing team to your team
7. Change the value of `reactAppURLString` in `ContentView.swift` to the URL from step 4
8. Run the app
9. tap some buttons to see the communication in action