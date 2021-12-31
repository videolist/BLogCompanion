//
//  RenderingPostViewController.swift
//  BlogCompanion
//
//  Created by Vadim on 12/30/21.
//

import UIKit
import CoreImage.CIFilterBuiltins

class RenderingPostViewController: PostBaseViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var renderView: RenderView!
    @IBOutlet weak var metalSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private lazy var inputImage = {
        CIImage(image: UIImage(named: "Butterfly")!)!
    }()

    private lazy var targetImage: CIImage = {
        CIImage(image: UIImage(named: "Bug")!)!
    }()

    private lazy var swipeFilter: CISwipeTransition & CIFilter = {
        let filter = CIFilter.swipeTransition()
        filter.targetImage = targetImage
            .scaledAndCropped(filling: inputImage.extent)
        filter.extent = inputImage.extent
        return filter
    }()

    @IBAction func switchAction(_ sender: UISwitch) {
        renderView.isHidden = !sender.isOn
        imageView.isHidden = sender.isOn
        render()
    }

    private func render() {
        guard let outputImage = inputImage
                .applying(filter: swipeFilter)?
                .clampedToExtent()
                .applying(filter: CIFilter.motionBlur())?
                .cropped(to: inputImage.extent)
        else {
                    return
                }

        if metalSwitch.isOn {
            renderView.image = outputImage
        } else {
            imageView.image = UIImage(ciImage: outputImage)
        }


    }

    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: imageView)
        swipeFilter.time = Float(max(0, min(1, point.x / imageView.frame.width)))
        render()
    }
}
