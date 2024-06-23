// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import AVFoundation
import AVKit
import SwiftUI

#if canImport(VolumeButtonHandler)
import VolumeButtonHandler
#endif

/// A class to manage the press events of the Volume Up and Volume Down buttons.
///
/// On iOS 17.2 or above, it uses ``AVCaptureEventInteraction`` otherwise it uses the external framework of VolumeButtonHandler
/// to handle the event.
///
/// When using ``AVCaptureEventInteraction`` on iOS 17.2, the events will be triggered only if the camera session is running.
public class CaptureEventInteraction {
    public var onVolumeUpTriggered: (() -> Void)? = nil
    public var onVolumeDownTriggered: (() -> Void)? = nil
    
#if canImport(VolumeButtonHandler)
    private var volumeHandler: VolumeButtonHandler? = nil
#endif
    
    /// Initialize the ``CaptureEventInteraction`` object with event callbacks.
    public init(
        onVolumeUpTriggered: (() -> Void)? = nil,
        onVolumeDownTriggered: (() -> Void)? = nil
    ) {
        self.onVolumeUpTriggered = onVolumeUpTriggered
        self.onVolumeDownTriggered = onVolumeDownTriggered
    }
    
    /// Register the interaction to a specific view which should be in the responder chain.
    @MainActor
    public func register(to view: UIView) {
        unregister(from: view)
        
        if #available(iOS 17.2, *) {
            setupAVCaptureEventInteraction(to: view)
        } else {
            setupVolumePressedHandler()
        }
    }
    
    /// Unregister the interaction to a specific view which should be in the responder chain.
    @MainActor
    public func unregister(from view: UIView) {
        if #available(iOS 17.2, *) {
            view.interactions.filter { $0 is AVCaptureEventInteraction }.forEach { interaction in
                view.removeInteraction(interaction)
            }
        } else {
#if canImport(VolumeButtonHandler)
            volumeHandler?.stopHandler()
            volumeHandler = nil
#endif
        }
    }
    
    @available(iOS 17.2, *)
    private func setupAVCaptureEventInteraction(to view: UIView) {
        // It seems that Apple has reversed the relationship between primary and secondary in AVCaptureEventInteraction with the volume up and down buttons,
        // which is inconsistent with the documentation.
        let interaction = AVCaptureEventInteraction(primary: { [weak self] event in
            if event.phase == .ended {
                self?.onVolumeDownTriggered?()
            }
        }, secondary: { [weak self] event in
            if event.phase == .ended {
                self?.onVolumeUpTriggered?()
            }
        })
        
        interaction.isEnabled = true
        view.addInteraction(interaction)
    }
    
    private func setupVolumePressedHandler() {
#if canImport(VolumeButtonHandler)
        volumeHandler = VolumeButtonHandler.volumeButtonHandler(upBlock: { [weak self] in
            self?.onVolumeUpTriggered?()
        }, downBlock: { [weak self] in
            self?.onVolumeDownTriggered?()
        })
        volumeHandler?.startHandler(disableSystemVolumeHandler: false)
#endif
    }
}
