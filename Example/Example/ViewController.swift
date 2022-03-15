//
//  ViewController.swift
//  Example
//
//  Created by Tomoya Hirano on 2020/04/02.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, TrackerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toggleView: UISwitch!
    var previewLayer: AVCaptureVideoPreviewLayer!
    @IBOutlet weak var xyLabel:UILabel!
    @IBOutlet weak var featurePoint: UIView!
    let camera = Camera()
    let tracker: HandTracker = HandTracker()!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera.setSampleBufferDelegate(self)
        camera.start()
        tracker.startGraph()
        tracker.delegate = self
        
//        previewLayer = AVCaptureVideoPreviewLayer(session: camera.session) as AVCaptureVideoPreviewLayer
//        previewLayer.frame = view.bounds
//        view.layer.addSublayer(previewLayer)
//        view.bringSubviewToFront(xyLabel)
//        view.bringSubviewToFront(featurePoint)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        tracker.processVideoFrame(pixelBuffer)

        DispatchQueue.main.async {
            if !self.toggleView.isOn {
                self.imageView.image = UIImage(ciImage: CIImage(cvPixelBuffer: pixelBuffer!))
            }
        }
    }
    
    func handTracker(_ handTracker: HandTracker!, didOutputLandmarks landmarks: [HTLandmark]!, didOutputWorldLandmarks landmarksWorld: [HTLandmark]!, didOutputHandness isRightHand: Bool, didOutputScore score: Float) {
        print([landmarks[0].x, landmarks[0].y, landmarks[0].z])
    }
        
    func handTracker(_ handTracker: HandTracker!, didOutputPixelBuffer pixelBuffer: CVPixelBuffer!) {
        DispatchQueue.main.async {
            if self.toggleView.isOn {
                self.imageView.image = UIImage(ciImage: CIImage(cvPixelBuffer: pixelBuffer))
            }
        }
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension CGFloat {
    func ceiling(toDecimal decimal: Int) -> CGFloat {
        let numberOfDigits = CGFloat(abs(pow(10.0, Double(decimal))))
        if self.sign == .minus {
            return CGFloat(Int(self * numberOfDigits)) / numberOfDigits
        } else {
            return CGFloat(ceil(self * numberOfDigits)) / numberOfDigits
        }
    }
}

extension Double {
    func ceiling(toDecimal decimal: Int) -> Double {
        let numberOfDigits = abs(pow(10.0, Double(decimal)))
        if self.sign == .minus {
            return Double(Int(self * numberOfDigits)) / numberOfDigits
        } else {
            return Double(ceil(self * numberOfDigits)) / numberOfDigits
        }
    }
}
