# CaptureEventInteraction

This Swift package contains a class `CaptureEventInteraction` to help you interact with the Volumn Up and Volumn Down buttons in the camera app.

On iOS 17.2 or above, it uses ``AVCaptureEventInteraction`` otherwise it uses the external framework of `VolumeButtonHandler` to handle the event.

> When using ``AVCaptureEventInteraction`` on iOS 17.2, the events will be triggered only if the camera session is running.

NOTE:

> There is a [new API](https://developer.apple.com/documentation/SwiftUI/View/onCameraCaptureEvent(isEnabled:primaryAction:secondaryAction:)) on iOS 18. Prefer to use that API on iOS 18 or above.

## Documentation

Please visit the Swift DocC documentation here:

https://juniperphoton.github.io/CaptureEventInteraction/documentation/captureeventinteraction/
