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

		// -(void)loginWith:(enum GigyaSocialProvidersProxy)provider viewController:(UIViewController * _Nonnull)viewController;
		[Export ("loginWith:viewController:")]
		void LoginWith (GigyaSocialProvidersProxy provider, UIViewController viewController);
	}
}
