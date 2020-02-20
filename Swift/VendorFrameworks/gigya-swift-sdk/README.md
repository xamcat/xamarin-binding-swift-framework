# Xamarin.iOS Binding for a Swift Framework

Demo on how you can bind a swift framework without specific access to non-objc compatible framework apis and consume it in your Xamarin.iOS application

## Workspace has two parts

- Xcode projects with a Swift Framework, its Swift Framework Proxy and Single view application to consume both
- Xamarin projects with a Xamarin.iOS binding and Xamarin.iOS single view application to consume the binding

## Run

- To run the Swift demo app, open `Swift/Swift.SingleView/Swift.SingleView.xcodeproj` project in `Xcode 11` and run in using `iOS 13 Simulator`. The Framework proxy project is located in the same `Swift` folder and could be open as a separate Xcode project.
- To run the Xamarin demo app, open `Xamarin/Xamarin.SingleView.sln` solution in VS4Mac and run using `iOS 13 Simulator`. The Framework proxy iOS binding project is located in the same `Xamarin` folder and could be open using the same solution as the demo app.

## Build the fat framework

By default the framework is built for a selected configuration only. If you package the framework as is, it will supported on that platform and not the other. In order to support simulator and device, you want to build a fat framework. The idea is build the framework for each supported platform and then use the `lipo` tool to combine the output frameworks and create a single fat framework to be used by the Xamarin.iOS Binding.

In order to build a fat framework, please run from the root of the repo the following script, which automates all the manual steps fot you

```bash
./Swift/Scripts/build.fat.sh
```

The output fat framework will be stored at the `Swift/VendorFrameworks/swift-framework-proxy/SwiftProxyFramework.framework`. The same file path is used at the Xamarin.iOS Binding project to package the Xamarin binding library.
