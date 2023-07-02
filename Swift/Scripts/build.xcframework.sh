# Builds an .xcframework for a given Xcode project

echo
echo "Define parameters"
IOS_SDK_VERSION="16.4" # xcodebuild -showsdks
SWIFT_PROJECT_NAME="SwiftFrameworkProxy"
SWIFT_PROJECT_PATH="../$SWIFT_PROJECT_NAME/$SWIFT_PROJECT_NAME.xcodeproj"
SWIFT_BUILD_PATH="../$SWIFT_PROJECT_NAME/build"
SWIFT_OUTPUT_PATH="../VendorFrameworks/swift-framework-proxy"
SIMULATOR_ARCHIVE_PATH="$SWIFT_BUILD_PATH/$SWIFT_PROJECT_NAME-simulator.xcarchive"
DEVICE_ARCHIVE_PATH="$SWIFT_BUILD_PATH/$SWIFT_PROJECT_NAME-ios.xcarchive"
XAMARIN_BINDING_PATH="../../Xamarin/SwiftFrameworkProxy.Binding"

echo
echo "Build iOS archives for simulator and device"
rm -Rf "$SWIFT_BUILD_PATH"

xcodebuild -project "$SWIFT_PROJECT_PATH" archive \
  -scheme "$SWIFT_PROJECT_NAME" \
  -configuration Release \
  -archivePath "$SIMULATOR_ARCHIVE_PATH" \
  -destination "generic/platform=iOS Simulator" \
  -derivedDataPath "$SWIFT_BUILD_PATH" \
  -IDECustomBuildProductsPath="" -IDECustomBuildIntermediatesPath="" \
  ENABLE_BITCODE=NO \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
  
xcodebuild -project "$SWIFT_PROJECT_PATH" archive \
   -scheme "$SWIFT_PROJECT_NAME" \
   -configuration Release \
   -archivePath "$DEVICE_ARCHIVE_PATH" \
   -destination "generic/platform=iOS" \
   -derivedDataPath "$SWIFT_BUILD_PATH" \
   -IDECustomBuildProductsPath="" -IDECustomBuildIntermediatesPath="" \
   ENABLE_BITCODE=NO \
   SKIP_INSTALL=NO \
   BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo
echo "Create .xcframework for device and simulator"
xcodebuild -create-xcframework \
    -framework "$SIMULATOR_ARCHIVE_PATH/Products/Library/Frameworks/$SWIFT_PROJECT_NAME.framework" \
    -framework "$DEVICE_ARCHIVE_PATH/Products/Library/Frameworks/$SWIFT_PROJECT_NAME.framework" \
    -output "$SWIFT_BUILD_PATH/$SWIFT_PROJECT_NAME.xcframework"

echo
echo "Copy .xcframework to the output folder"
rm -Rf "$SWIFT_OUTPUT_PATH"
mkdir "$SWIFT_OUTPUT_PATH"
cp -Rf "$SWIFT_BUILD_PATH/$SWIFT_PROJECT_NAME.xcframework" "$SWIFT_OUTPUT_PATH"

echo
echo "Generating binding api definition and structs"
sharpie bind --sdk=iphoneos$IOS_SDK_VERSION --output="$SWIFT_OUTPUT_PATH/XamarinApiDef" --namespace="Binding" --scope="$SWIFT_BUILD_PATH/$SWIFT_PROJECT_NAME.xcframework/ios-arm64/$SWIFT_PROJECT_NAME.framework/Headers/" "$SWIFT_BUILD_PATH/$SWIFT_PROJECT_NAME.xcframework/ios-arm64/$SWIFT_PROJECT_NAME.framework/Headers/$SWIFT_PROJECT_NAME-Swift.h"

echo
echo "Replace existing metadata with the updated"
rm -Rf "$XAMARIN_BINDING_PATH"
mkdir "$XAMARIN_BINDING_PATH"
cp -Rf "$SWIFT_OUTPUT_PATH/XamarinApiDef/" "$XAMARIN_BINDING_PATH/"

echo
echo "Done!"
