//
//  PostBaseViewController.swift
//  BlogCompanion
//
//  Created by Vadim on 12/30/21.
//

import UIKit
import SafariServices

class PostBaseViewController: UIViewController {

    let post: Post
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = post.rawValue

        let button = UIBarButtonItem(image: UIImage(systemName: "link.icloud"), style: .plain, target: self, action: #selector(openPost))
        navigationItem.rightBarButtonItem = button
    }

    @objc func openPost() {
        guard let url = post.postUrl else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
}
