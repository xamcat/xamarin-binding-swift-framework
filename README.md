# Xamarin.iOS Binding for a Swift Framework

Demo on how you can bind a swift framework without specific access to non-objc compatible framework apis and consume it in your Xamarin.iOS application

# Workspace has two parts

- Xcode projects with a Swift Framework, its Swift Framework Proxy and Single view application to consume both
- Xamarin projects with a Xamarin.iOS binding and Xamarin.iOS single view application to consume the binding

# Run

- To run the Swift demo app, open `Swift/Swift.SingleView/Swift.SingleView.xcodeproj` project in `Xcode 11` and run in using `iOS 13 Simulator`. The Framework proxy project is located in the same `Swift` folder and could be open as a separate Xcode project.
- To run the Xamarin demo app, open `Xamarin/Xamarin.SingleView.sln` solution in VS4Mac and run using `iOS 13 Simulator`. The Framework proxy iOS binding project is located in the same `Xamarin` folder and could be open using the same solution as the demo app.

# Demo

<img src="SolutionItems/swift-proxy-xamarin-binding-init.png" alt="swift-proxy-xamarin-binding-init" height="350" style="display:inline-block;" />

<img src="SolutionItems/swift-proxy-xamarin-binding-login.png" alt="swift-proxy-xamarin-binding-login.png" height="350" style="display:inline-block;" />