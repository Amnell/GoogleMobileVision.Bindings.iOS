//
//  ViewController.swift
//  DemoProjectiOS
//
//  Created by Mathias Amnell on 2019-10-16.
//  Copyright © 2019 Forefront Consulting AB. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileVision_Xamarin

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var photoPreviewImageView: UIImageView!

    var session: AVCaptureSession!

    var sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let videoOutput = AVCaptureVideoDataOutput()
    let videoView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(videoView)
        videoView.frame = view.bounds
        videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoView.backgroundColor = .red
        view.addSubview(videoView)

        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo

        let backCamera =  AVCaptureDevice.default(for: AVMediaType.video)!
        let input: AVCaptureDeviceInput = try! AVCaptureDeviceInput(device: backCamera)


        if session.canAddInput(input) {
            session.addInput(input)

            videoOutput.alwaysDiscardsLateVideoFrames = true
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))

            if session.canAddOutput(videoOutput) {
                session!.addOutput(videoOutput)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspect
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                videoView.layer.addSublayer(videoPreviewLayer!)
                videoPreviewLayer?.frame = videoView.bounds
            }
        }

        session.startRunning()
    }

    let wrapper = GoogleMobileVisionWrapper()

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let ciimage : CIImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let image: UIImage = self.convert(cmage: ciimage) else { return }

        print(wrapper.detectTextLines(in: image))
    }

    // Convert CIImage to CGImage
    func convert(cmage:CIImage) -> UIImage?
    {
        let context: CIContext = CIContext.init(options: nil)
        guard let cgImage: CGImage = context.createCGImage(cmage, from: cmage.extent) else { return nil }
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}
