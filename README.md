# CaptureEventInteraction

This Swift package contains a class `CaptureEventInteraction` to help you interact with the Volumn Up and Volumn Down buttons in the camera app.

On iOS 17.2 or above, it uses ``AVCaptureEventInteraction`` otherwise it uses the external framework of `VolumeButtonHandler` to handle the event.

> When using ``AVCaptureEventInteraction`` on iOS 17.2, the events will be triggered only if the camera session is running.

NOTE:

> There is a [new API](https://developer.apple.com/documentation/SwiftUI/View/onCameraCaptureEvent(isEnabled:primaryAction:secondaryAction:)) on iOS 18. Prefer to use that API on iOS 18 or above.

## Usage

Using `CaptureEventInteraction` is straightforward:

1. Construct the object with two callbacks: `onVolumeUpTriggered` and `onVolumeDownTriggered`. You also have the option to assign the callbacks later.
2. Call the `register(to:)` method, passing the root UIView of the current scene.
3. Ensure you call `unregister(from:)` when the interaction is no longer needed.

Code example:

```swift
private let captureEventInteraction = CaptureEventInteraction()

@MainActor 
private func setupVolumePressedHandler() {
    guard let view = UIApplication.shared.getWindowScene()?.getRootView() else {
        return
    }
    
    captureEventInteraction.onVolumeUpTriggered = { [weak self] in
        // handle event
    }
    captureEventInteraction.onVolumeDownTriggered = { [weak self] in
        // handle event
    }
    
    captureEventInteraction.register(to: view)
}
```

You can get your root `UIView` like this:

```swift
extension UIApplication {
    func getWindowScene() -> UIWindowScene? {
        let connectedScenes = UIApplication.shared.connectedScenes
        let windowScenes = connectedScenes.filter { $0 is UIWindowScene }
        return windowScenes.first as? UIWindowScene
    }
}

extension UIWindowScene {
    func getRootView() -> UIView? {
        return self.keyWindow?.rootViewController?.view
    }
}
```
