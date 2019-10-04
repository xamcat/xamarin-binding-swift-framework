using Foundation;
using UIKit;

namespace Binding
{
    // @interface SwiftFrameworkProxy : NSObject
    [BaseType(typeof(NSObject))]
    interface SwiftFrameworkProxy
    {
        // -(NSString * _Nonnull)initFor __attribute__((warn_unused_result)):(NSString * _Nonnull)apiKey;
        [Export("initForApiKey:")]
        string InitFor(string apiKey);

        // -(void)loginWithController:(UIViewController * _Nonnull)controller;
        [Export("loginWithController:")]
        void Login(UIViewController controller);
    }
}

