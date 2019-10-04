// WARNING
//
// This file has been generated automatically by Visual Studio to store outlets and
// actions made in the UI designer. If it is removed, they will be lost.
// Manual changes to this file may not be handled correctly.
//
using Foundation;
using System.CodeDom.Compiler;

namespace Xamarin.SingleView
{
	[Register ("ViewController")]
	partial class ViewController
	{
		[Outlet]
		UIKit.UIButton btnLogin { get; set; }

		[Outlet]
		UIKit.UILabel lblMessage { get; set; }
		
		void ReleaseDesignerOutlets ()
		{
			if (lblMessage != null) {
				lblMessage.Dispose ();
				lblMessage = null;
			}

			if (btnLogin != null) {
				btnLogin.Dispose ();
				btnLogin = null;
			}
		}
	}
}
