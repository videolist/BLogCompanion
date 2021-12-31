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

    override func viewDidLoad() {
        super.viewDidLoad()
        render(usingMetal: true)
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

    private func render(usingMetal: Bool) {
        guard let outputImage = inputImage
                .applying(filter: swipeFilter)?
                .clampedToExtent()
                .applying(filter: CIFilter.motionBlur())?
                .cropped(to: inputImage.extent)
        else {
                    return
                }

        if usingMetal {
            imageView.isHidden = true
            renderView.image = outputImage
        } else {
            imageView.isHidden = false
            imageView.image = UIImage(ciImage: outputImage)
        }


    }

    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: imageView)
        swipeFilter.time = Float(max(0, min(1, point.x / imageView.frame.width)))
        render(usingMetal: point.y < imageView.frame.height / 2)
    }
}
