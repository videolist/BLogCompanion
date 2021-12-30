//
//  Post.swift
//  BlogCompanion
//
//  Created by Vadim on 12/30/21.
//

import Foundation
import UIKit

enum Post: String, CaseIterable {
    case rednering = "Rendering"
    case onePixelOutputs = "One Pixel Outputs"

    private var baseUrl: URL? { URL(string: "https://filtermagicblog.com") }

    var postUrl: URL? {
        switch self {
        case .rednering:
            return baseUrl?.appendingPathComponent("2021/12/rendering/")
        case .onePixelOutputs:
            return baseUrl?.appendingPathComponent("2021/12/one-pixel/")
        }
    }

    var viewController: UIViewController {
        switch self {
        case .rednering:
            return RenderingPostViewController(post: self)
        case .onePixelOutputs:
            return OnePixelPostViewController(post: self)
        }
    }
}
