# GoogleMobileVision.Bindings.iOS
A wrapping framework to use GoogleMobileVision in a Bindings project in Xamarin

I've struggled with this quite a bit over the last couple of days, but I just got things working as I wanted it for my project. I created a framework in Xcode, using cocoapods for the GoogleMobileVision dependencies and then wrapped the functionality in an objective-c class named GoogleMobileVisionWrapper. I've only implemented text recognition, but I guess adding more functionality should be trivial.

Just run `build_and_copy_framework.sh` from the project directory to build the frameworks and add them to the `GoogleMobileVision.Xamarin.Bindings` project. Then just add the Bindings project to your Xamarin project and reference it from the iOS target.
Using the library is easy. Just use `GoogleMobileVisionWrapper().DetectTextInImage(image)`

# Binary size
Worth noting is that the build script creates fat frameworks. So make sure you do proper linking in your project to decrease the binary size.

# Help
I'm by no means fluent in bindings, so feel free to add pull request.
