using System;
using UIKit;
using Binding;

namespace Xamarin.SingleView
{
    public partial class ViewController : UIViewController
    {
        private SwiftFrameworkProxy _proxy;

        public ViewController(IntPtr handle)
            : base(handle)
        {
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            btnLogin.TouchUpInside += btnLogin_Tap;
            _proxy = new SwiftFrameworkProxy();
            var result = _proxy.InitFor("APIKey");
            System.Diagnostics.Debug.WriteLine(result);
            lblMessage.Text = result;
        }

        private void btnLogin_Tap(object sender, EventArgs e)
        {
            _proxy.Login(this);
        }
    }
}