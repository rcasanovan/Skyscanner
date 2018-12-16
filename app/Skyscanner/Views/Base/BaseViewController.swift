//
//  BaseViewController.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let titleLabel: UILabel = UILabel()
    
    public var showTitle: Bool = false {
        didSet {
            titleLabel.isHidden = !showTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    public func showLoader(_ show: Bool, status: String? = nil) {
        if let status = status {
            show == true ? SVProgressHUD.show(withStatus: status) : SVProgressHUD.dismiss()
            return
        }
        show == true ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
    
}

// MARK: - Setup views
extension BaseViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel.textColor = .black()
        titleLabel.textAlignment = .center
        titleLabel.text = "Under construction"
        titleLabel.isHidden = true
    }
    
}

// MARK: - Layout & constraints
extension BaseViewController {
    
    private struct Layout {
        
        static let leading: CGFloat = 12.0
        static let trailing: CGFloat = 12.0
        
        struct TitleLabel {
            static let height: CGFloat = 19.0
        }
        
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        
        view.addConstraintsWithFormat("H:|-\(Layout.leading)-[v0]-\(Layout.trailing)-|", views: titleLabel)
        view.addConstraintsWithFormat("V:[v0(\(Layout.TitleLabel.height))]", views: titleLabel)
        let centerConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        view.addConstraint(centerConstraint)
    }
    
    /**
     * Show alert
     *
     * - parameters:
     *      -title: title for the aler
     *      -message: message for the alert
     *      -actionTitle: action title for the alert
     */
    public func showAlertWith(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
}

