using System;
using System.IO;
using System.Linq;
using NUnit.Framework;
using Xamarin.UITest;
using Xamarin.UITest.iOS;
using Xamarin.UITest.Queries;
using Query = System.Func<Xamarin.UITest.Queries.AppQuery, Xamarin.UITest.Queries.AppQuery>;

namespace Xamarin.SingleView.UITests
{
    [TestFixture]
    public class Tests
    {
        protected readonly Query LoginButton;
        protected readonly Query StatusLabel;
        protected readonly Query GigyaWebView;
        protected readonly Query CancelButton;

        protected iOSApp app;

        public Tests()
        {
            LoginButton = x => x.Marked(nameof(LoginButton));
            StatusLabel = x => x.Marked(nameof(StatusLabel));
            CancelButton = x => x.Marked("Cancel");
        }

        [SetUp]
        public void BeforeEachTest()
        {
            // TODO: If the iOS app being tested is included in the solution then open
            // the Unit Tests window, right click Test Apps, select Add App Project
            // and select the app projects that should be tested.
            //
            // The iOS project should have the Xamarin.TestCloud.Agent NuGet package
            // installed. To start the Test Cloud Agent the following code should be
            // added to the FinishedLaunching method of the AppDelegate:
            //
            //    #if ENABLE_TEST_CLOUD
            //    Xamarin.Calabash.Start();
            //    #endif
            app = ConfigureApp
                .iOS
                // TODO: Update this path to point to your iOS app and uncomment the
                // code if the app is not included in the solution.
                //.AppBundle ("../../../Xamarin.SingleView/bin/iPhoneSimulator/Debug/Xamarin.SingleView.app")
                //.DeviceIdentifier("4763BC2E-31B5-4AE6-B286-D5EDE73069F7")
                //.InstalledApp("com.microsoft.mobcat.Xamarin-SingleView.alstrakh")
                .StartApp();
        }

#if DEBUG
        //[Test]
        public void Repl()
        {
            app.Repl();
        }
#endif

        [Test]
        public void HappyPath()
        {
            app.WaitForElement(StatusLabel);
            app.WaitForElement(LoginButton);
            app.Screenshot("App loaded.");
            Assert.AreEqual(app.Query(StatusLabel).FirstOrDefault().Text, "Gigya initialized with domain: us1.gigya.com");

            app.Tap(LoginButton);
            app.WaitForElement(GigyaWebView);
            app.Screenshot("Login activated.");

            app.Tap(CancelButton);
            app.WaitForElement(LoginButton);
            app.Screenshot("Login cancelled.");
        }
    }
}
