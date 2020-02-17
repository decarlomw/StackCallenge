//
//  DetailViewController.swift
//  StackQuestions
//
//  Created by Decarlo Williams on 2/16/20.
//  Copyright © 2020 Decarlo Williams. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    // Setting default URL incase url doesn't come from view controller
    var link = URL(string : "https://www.stackoverflow.com")
    
    @IBOutlet var webView: WKWebView!
    
    private var observation: NSKeyValueObservation? = nil
   
        // Progress view reflecting the current loading progress of the web view.
        let progressView = UIProgressView(progressViewStyle: .default)

        // The observation object for the progress of the web view (we only receive notifications until it is deallocated).
        private var estimatedProgressObserver: NSKeyValueObservation?

        // MARK: - Public methods

        override func viewDidLoad() {
            super.viewDidLoad()
     
            // Setting image for Navigation View
            
             let imageView = UIImageView(image: #imageLiteral(resourceName: "TitleImage"))
             imageView.frame = CGRect(x: 0, y: -5, width: 170, height: 45)
             imageView.contentMode = .scaleAspectFit

             let titleView = UIView(frame: CGRect(x: 0, y: -5, width: 170, height: 45))

             titleView.addSubview(imageView)
             titleView.backgroundColor = .clear
             self.navigationItem.titleView = titleView
            
             setupProgressView()
             setupEstimatedProgressObserver()

            if let initialUrl = link {
                setupWebview(url: initialUrl)
            }
        }

        // MARK: - Private methods

        private func setupProgressView() {
            guard let navigationBar = navigationController?.navigationBar else { return }

            progressView.translatesAutoresizingMaskIntoConstraints = false
            navigationBar.addSubview(progressView)

            progressView.isHidden = true

            NSLayoutConstraint.activate([
                progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
                progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),

                progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                progressView.heightAnchor.constraint(equalToConstant: 2.0)
            ])
        }

        private func setupEstimatedProgressObserver() {
            estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
                self?.progressView.progress = Float(webView.estimatedProgress)
            }
        }

        private func setupWebview(url: URL) {
            let request = URLRequest(url: url)

            webView.navigationDelegate = self
            webView.load(request)
        }
    }

    // MARK: - WKNavigationDelegate

    extension DetailViewController: WKNavigationDelegate {
        func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
            if progressView.isHidden {
                // Make sure our animation is visible.
                progressView.isHidden = false
            }

            UIView.animate(withDuration: 0.33,
                           animations: {
                               self.progressView.alpha = 1.0
            })
        }

        func webView(_: WKWebView, didFinish _: WKNavigation!) {
            UIView.animate(withDuration: 0.33,
                           animations: {
                               self.progressView.alpha = 0.0
                           },
                           completion: { isFinished in
                               // Update `isHidden` flag accordingly:
                               //  - set to `true` in case animation was completly finished.
                               //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
                               self.progressView.isHidden = isFinished
            })
        }
        
        // Did this because progressView was displaying at time as the page didn't fully load
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(true)
            self.progressView.isHidden = true
        }
    }
