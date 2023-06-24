# Xamarin.iOS Binding for a Swift Framework

Demo on how you can bind a Swift framework without specific access to non-Obj-C compatible framework APIs and consume it in your Xamarin.iOS application

## Workspace has two parts

- Xcode projects with a Swift Framework, its Swift Framework Proxy and Single view application to consume both
- Xamarin projects with a Xamarin.iOS binding and Xamarin.iOS single view application to consume the binding

## Run

- To run the Swift demo app, open `Swift/Swift.SingleView/Swift.SingleView.xcodeproj` project in `Xcode` and run using `iOS Simulator`. The Framework proxy project is located in the same `Swift` folder and could be open as a separate Xcode project.
- To run the Xamarin demo app, open `Xamarin/Xamarin.SingleView.sln` solution in VS4Mac and run using `iOS Simulator`. The Framework proxy iOS binding project is located in the same `Xamarin` folder and could be open using the same solution as the demo app.

## Build the .xcframework

By default the framework is built for a selected configuration only. If you package the framework as is, it will supported on that platform and not the other. In order to support simulator and device, you want to build a binary framework bundle (.xcframework). The idea is build the framework for each supported platform and then package them as a binary framework bundle to be used by the Xamarin.iOS Binding.

In order to build an .xcframework, please run from the root of the repo the following script, which automates all the manual steps fot you

```bash
./Swift/Scripts/build.xcframework.sh
```

The output fat framework will be stored at the `Swift/VendorFrameworks/swift-framework-proxy/SwiftProxyFramework.framework`. The same file path is used at the Xamarin.iOS Binding project to package the Xamarin binding library.
