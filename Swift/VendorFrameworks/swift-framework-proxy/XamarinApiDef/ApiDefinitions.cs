using Foundation;
using SwiftFrameworkProxy;
using UIKit;

namespace Binding
{
	// @interface SwiftFrameworkProxy : NSObject
	[BaseType (typeof(NSObject))]
	interface SwiftFrameworkProxy
	{
		// -(NSString * _Nonnull)initForApiKey:(NSString * _Nonnull)apiKey __attribute__((objc_method_family("none"))) __attribute__((warn_unused_result));
		[Export ("initForApiKey:")]
		string InitForApiKey (string apiKey);

		// -(void)loginWithProvider:(enum GigyaSocialProvidersProxy)provider viewController:(UIViewController * _Nonnull)viewController;
		[Export ("loginWithProvider:viewController:")]
		void LoginWithProvider (GigyaSocialProvidersProxy provider, UIViewController viewController);
	}
}
