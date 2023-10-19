# ios-webview-communication

Prototype demonstrating two-way communication between a webview (Reactjs app) and SwiftUI. i.e., execute native code from the webview JavaScript and execute webview JavaScript code from native.

# Use Case

You've are building a product that requires some sort of hardware functionality, like bluetooth, camera, or NFC but you are on a tight budget and can't afford to build and maintain a 100% native app. So, you build the common UI with Reactjs and use native code to handle the hardware functionality.