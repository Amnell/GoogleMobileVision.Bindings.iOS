# /bash/sh

sh GoogleMobileVision.Xamarin.iOS/build.sh
rm -rf "GoogleMobileVision.Xamarin.Bindings/GoogleMobileVision.Xamarin.Bindings/Frameworks/*"
cp -R "GoogleMobileVision.Xamarin.iOS/GeneratedFrameworks/Fat/" "GoogleMobileVision.Xamarin.Bindings/GoogleMobileVision.Xamarin.Bindings/Frameworks/"