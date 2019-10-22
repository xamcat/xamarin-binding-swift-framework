using System;
using Foundation;
using UIKit;

namespace Binding
{
	// @interface GigyaAccountProxy : NSObject
	[BaseType (typeof(NSObject))]
	interface GigyaAccountProxy
	{
		// @property (copy, nonatomic) NSString * _Nullable lastLogin;
		[NullAllowed, Export ("lastLogin")]
		string LastLogin { get; set; }
	}

	// @interface NetworkErrorProxy : NSObject
	[BaseType (typeof(NSObject))]
	interface NetworkErrorProxy
	{
		// @property (copy, nonatomic) NSString * _Nullable errorMessage;
		[NullAllowed, Export ("errorMessage")]
		string ErrorMessage { get; set; }
	}

	// @interface SwiftFrameworkProxy : NSObject
	[BaseType (typeof(NSObject))]
	interface SwiftFrameworkProxy
	{
		// -(NSString * _Nonnull)initForApiKey:(NSString * _Nonnull)apiKey __attribute__((objc_method_family("none"))) __attribute__((warn_unused_result));
		[Export ("initForApiKey:")]
		string InitForApiKey (string apiKey);

		// -(void)loginWithProvider:(enum GigyaSocialProvidersProxy)provider viewController:(UIViewController * _Nonnull)viewController completion:(void (^ _Nonnull)(GigyaAccountProxy * _Nullable, NetworkErrorProxy * _Nullable))completion;
		[Export ("loginWithProvider:viewController:completion:")]
		void LoginWithProvider (GigyaSocialProvidersProxy provider, UIViewController viewController, Action<GigyaAccountProxy, NetworkErrorProxy> completion);
	}
}
