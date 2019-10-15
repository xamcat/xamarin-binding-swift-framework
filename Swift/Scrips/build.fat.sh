# Builds a fat library for a given xcode project (framework)

echo "Define parameters"
IOS_SDK_VERSION="13.1" # xcodebuild -showsdks
SWIFT_PROJECT_NAME="SwiftFrameworkProxy"
SWIFT_PROJECT_PATH="Swift/$SWIFT_PROJECT_NAME/$SWIFT_PROJECT_NAME.xcodeproj"
SWIFT_BUILD_PATH="Swift/$SWIFT_PROJECT_NAME/build"
SWIFT_OUTPUT_PATH="Swift/VendorFrameworks/swift-framework-proxy"

echo "Build iOS framework for simulator and device"
xcodebuild -sdk iphonesimulator$IOS_SDK_VERSION -project "$SWIFT_PROJECT_PATH" -configuration Release
xcodebuild -sdk iphoneos$IOS_SDK_VERSION -project "$SWIFT_PROJECT_PATH" -configuration Release

echo "Create fat binaries for Release-iphoneos and Release-iphonesimulator configuration"
echo "Copy one build as a fat framework"
cp -R "$SWIFT_BUILD_PATH/Release-iphoneos" "$SWIFT_BUILD_PATH/Release-fat"

echo "Combine iphoneos + iphonesimulator configuration as fat libraries"
lipo -create -output "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME" "$SWIFT_BUILD_PATH/Release-iphoneos/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME" "$SWIFT_BUILD_PATH/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"

echo "Verify results"
lipo -info "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"

echo "Copy fat frameworks to the output folder"
mkdir "$SWIFT_OUTPUT_PATH"
cp -R "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework" "$SWIFT_OUTPUT_PATH"

echo "Done!"