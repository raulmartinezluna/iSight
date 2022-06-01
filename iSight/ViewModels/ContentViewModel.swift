//
//  ContentViewModel.swift
//  iSight
//
//  Created by Raul Martinez-Luna on 5/31/22.
//

import CoreImage
import AVFoundation

class ContentViewModel: ObservableObject {
  @Published var error: Error?
  @Published var frame: CGImage?

  var prescription:Float = 0
  var camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
  
  private let context = CIContext()
  
  private var prescriptionList:[Float] = [-3.25, -2.25, 1.25, -0.5, 0.5]
  private var focusList:[Float] = [0.47, 0.54, 0.80, 0.66, 0.73]
  
  private var model:PredictionModel! = nil

  private let cameraManager = CameraManager.shared
  private let frameManager = FrameManager.shared

  init() {
    createModel()
    setupSubscriptions()
  }
  
  func createModel() {
    self.model = PredictionModel(prescriptionArray: self.prescriptionList, focusArray: self.focusList)
  }

  func setupSubscriptions() {
    // swiftlint:disable:next array_init
    cameraManager.$error
      .receive(on: RunLoop.main)
      .map { $0 }
      .assign(to: &$error)

    frameManager.$current
      .receive(on: RunLoop.main)
      .compactMap { buffer in
        guard let image = CGImage.create(from: buffer) else {
          return nil
        }

        var currentPrescription:Float! = nil
        
        if self.prescription != currentPrescription {
            currentPrescription = self.prescription
            let focus = self.model.getPrediction(prescription: self.prescription)
            //print(self.prescription)
            //print(focus)
            if self.prescription == 0 {
              try! self.camera?.lockForConfiguration()
              self.camera?.focusMode = .continuousAutoFocus
              self.camera?.unlockForConfiguration()
            }
            else {
              try! self.camera?.lockForConfiguration()
              self.camera?.setFocusModeLocked(lensPosition: focus)
              self.camera?.unlockForConfiguration()
            }
        }
        return image
      }
      .assign(to: &$frame)
  }
}
