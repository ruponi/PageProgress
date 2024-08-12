//
//  PTPageIndicator.swift
//  PartyTiles
//
//  Created by Ruslan Ponomarenko on 5/23/24.
//  Copyright © 2024 ContagiousAtmosphere. All rights reserved.
//

import Foundation
import UIKit

/// A custom page indicator view that displays a series of segmented lines.
/// The active segment is highlighted in white, while inactive segments are blue.
class PTPageIndicator: UIView {
    
    /// The number of pages (segments) in the page indicator.
    var numberOfPages: Int {
        didSet {
            setupIndicator()
        }
    }
    /// The currently active page (segment).
    var currentPage: Int {
        didSet {
            updateIndicator()
        }
    }
    
    var currentProgress: Float {
        didSet {
            updateProgress()
        }
    }
    /// The active color of the line
    var activePageColor: UIColor = .white {
        didSet {
            setupIndicator()
        }
    }
    
    /// The Default color of the line
    var defaultPageColor: UIColor = .black.withAlphaComponent(0.6) {
        didSet {
            updateIndicator()
        }
    }
    
    private let stackView = UIStackView()
    
    /// Initializes a new PTPageIndicator with the specified number of pages and optional current page.
    ///
    /// - Parameters:
    ///   - numberOfPages: The total number of pages (segments).
    ///   - currentPage: The initially active page. Defaults to 0.
    init(numberOfPages: Int, currentPage: Int = 0) {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
        self.currentProgress = 0
        super.init(frame: .zero)
        setupStackView()
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        self.numberOfPages = 0
        self.currentPage = 0
        self.currentProgress = 0
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: stackView.superview!.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: stackView.superview!.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: stackView.superview!.leadingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    /// Configures the segmented lines based on the number of pages.
    private func setupIndicator() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<numberOfPages {
            let lineView = PTProgressView()
            lineView.defaultColor = defaultPageColor
            lineView.progressColor = activePageColor
            lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
            stackView.addArrangedSubview(lineView)
        }
        
        updateIndicator(animated: false)
    }
    
    private func updateProgress() {
        if stackView.arrangedSubviews.count > currentPage {
            if let currentView = stackView.arrangedSubviews[currentPage] as? PTProgressView {
                currentView.setProgress(currentProgress)
            }
        }
    }
    
    
    /// Updates the colors of the segmented lines based on the currently active page.
    /// - Parameter animated: Whether the update should be animated.
    private func updateIndicator(animated: Bool = true) {
        if currentPage > numberOfPages {
            currentPage = numberOfPages - 1
        }
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            let isPast = index <= currentPage
            guard let view = view as? PTProgressView else {
                return
            }
            view.setProgress(isPast ? 1.0 : 0)
        }
    }
}

//MARK:  - Progress View
class PTProgressView: UIView {
    
    // MARK: - Properties
    var defaultColor: UIColor = .gray {
        didSet {
            backgroundLayer.backgroundColor = defaultColor.cgColor
        }
    }
    
    var progressColor: UIColor = .white {
        didSet {
            progressLayer.backgroundColor = progressColor.cgColor
        }
    }
    
    private let progressLayer = CALayer()
    private let backgroundLayer = CALayer()
    private var progress: Float = 0
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .clear
        
        // Configure background layer
        backgroundLayer.frame = bounds
        backgroundLayer.backgroundColor = defaultColor.cgColor
        layer.addSublayer(backgroundLayer)
        
        // Configure progress layer
        progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: bounds.height)
        progressLayer.backgroundColor = progressColor.cgColor
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update layers' frames
        backgroundLayer.frame = bounds
        updateProgressLayer()
    }
    
    private func updateProgressLayer() {
        let targetWidth = bounds.width * CGFloat(progress)
        progressLayer.frame = CGRect(x: 0, y: 0, width: targetWidth, height: bounds.height)
    }
    
    // MARK: - Public Methods
    
    /// Updates the progress with animation.
    /// - Parameter progress: The progress value between 0.0 and 1.0.
    /// - Parameter animated: Whether the update should be animated.
    func setProgress(_ progress: Float, animated: Bool = true) {
        self.progress = max(0, min(1, progress)) // Clamp the value between 0 and 1
        
        let targetWidth = bounds.width * CGFloat(self.progress)
         
        if animated {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.1) // Smooth animation duration
            progressLayer.frame = CGRect(x: 0, y: 0, width: targetWidth, height: bounds.height)
            CATransaction.commit()
        } else {
            progressLayer.frame = CGRect(x: 0, y: 0, width: targetWidth, height: bounds.height)
        }
    }
    
    /// Clears the progress, resetting it to 0.
    func clearProgress(animated: Bool = false) {
        setProgress(0, animated: animated)
    }
}
