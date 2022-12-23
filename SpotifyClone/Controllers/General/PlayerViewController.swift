//
//  PlayerViewController.swift
//  SpotifyClone
//
//  Created by melih arik on 12/5/22.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.delegate = self
        configureBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom + 10,
            width: view.width - 20,
            height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15
        )
    }
    
    public func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    
}
