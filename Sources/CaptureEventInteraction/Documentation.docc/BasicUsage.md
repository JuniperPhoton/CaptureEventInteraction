# Essential Usage

How to use ``CaptureEventInteraction`` to provide functionality to your app.

## For iOS 18 or above

``CaptureEventInteraction`` is made for the iOS prior to iOS 18.
On iOS 18, Apple has provided a new SwiftUI API to interact with the physical buttons:

Click here to view the [onCameraCaptureEvent(isEnabled:primaryAction:secondaryAction:)](https://developer.apple.com/documentation/SwiftUI/View/onCameraCaptureEvent(isEnabled:primaryAction:secondaryAction:)
) API for iOS 18.

## Prior to iOS 18

Starting iOS 17.2, Apple introduces a new API ``AVCaptureEventInteraction`` to help you interact with the Volume Up and Volume Down buttons in the camera app.

And there is a library named `VolumeButtonHandler`, which observes the `AVAudioSession` to detect the volume button events.
This approach is not recommended by Apple, as it may cause some other unexpected behaivor like the device's volume may be altered to non-silent mode.

This library encapulates the `AVCaptureEventInteraction` and `VolumeButtonHandler` and provides a unique way to interact with the volume buttons.

### Construct CaptureEventInteraction

First import and construct the ``CaptureEventInteraction`` instance.

```swift
import CaptureEventInteraction
```

```swift
private let captureEventInteraction = CaptureEventInteraction()
```

Please make sure there is a strong reference to this instance.

### Set the action for Volume Up and Down buttons

```swift
captureEventInteraction.onVolumeUpTriggered = { [weak self] in
    guard let self = self else { return }
    // do actions
}

captureEventInteraction.onVolumeDownTriggered = { [weak self] in
    guard let self = self else { return }
    // do actions
}
```
### Register this to a UIView

You can call the ``CaptureEventInteraction/register(to:)`` method to register the interaction to a view.

```
interaction.register(to: uiView)
```

Later if necessary you can unregister the interaction from the view.

```
interaction.unregister(from: uiView)
```
And that's it.

> Note: The ``CaptureEventInteraction/onVolumeUpTriggered`` and ``CaptureEventInteraction/onVolumeDownTriggered``
will only be triggered if the camera session is running.
