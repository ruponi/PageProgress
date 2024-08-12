//
//  ProgressIndicatorView.swift
//  PageProgress
//
//  Created by Ruslan Ponomarenko on 8/12/24.
//

import Foundation
import UIKit

class ProgressIndicatorView: UIView {
    
    // MARK: - UI Elements
    lazy var progressIndicator: PTPageIndicator = {
        let indicator = PTPageIndicator(numberOfPages: 5)
        indicator.numberOfPages = 5 // Default number of segments
        indicator.currentPage = 0 // Default current segment
        indicator.activePageColor = .blue
        indicator.defaultPageColor = .gray
        return indicator
    }()
    
    lazy var segmentsStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = Double(progressIndicator.numberOfPages)
        stepper.addTarget(self, action: #selector(segmentsStepperChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    lazy var currentSegmentStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = Double(progressIndicator.numberOfPages - 1)
        stepper.value = Double(progressIndicator.currentPage)
        stepper.addTarget(self, action: #selector(currentSegmentStepperChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    lazy var progressSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = Float(progressIndicator.currentProgress)
        slider.addTarget(self, action: #selector(progressSliderChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    lazy var segmentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Segments: \(Int(segmentsStepper.value))"
        return label
    }()
    
    lazy var currentSegmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Segment: \(Int(currentSegmentStepper.value))"
        return label
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress: \(progressSlider.value)"
        return label
    }()

    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupView() {
        [
            progressIndicator,
            segmentsStepper,
            currentSegmentStepper,
            progressSlider,
            segmentsLabel,
            currentSegmentLabel,
            progressLabel
        ].forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        self.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            // Progress Indicator constraints
            progressIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            progressIndicator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            progressIndicator.heightAnchor.constraint(equalToConstant: 20),
            
            // Segments Stepper constraints
            segmentsStepper.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            segmentsStepper.topAnchor.constraint(equalTo: progressIndicator.bottomAnchor, constant: 20),

            // Segments Label constraints
            segmentsLabel.leadingAnchor.constraint(equalTo: segmentsStepper.trailingAnchor, constant: 10),
            segmentsLabel.centerYAnchor.constraint(equalTo: segmentsStepper.centerYAnchor),

            // Current Segment Stepper constraints
            currentSegmentStepper.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            currentSegmentStepper.topAnchor.constraint(equalTo: segmentsStepper.bottomAnchor, constant: 20),

            // Current Segment Label constraints
            currentSegmentLabel.leadingAnchor.constraint(equalTo: currentSegmentStepper.trailingAnchor, constant: 10),
            currentSegmentLabel.centerYAnchor.constraint(equalTo: currentSegmentStepper.centerYAnchor),

            // Progress Slider constraints
            progressSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            progressSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            progressSlider.topAnchor.constraint(equalTo: currentSegmentStepper.bottomAnchor, constant: 20),

            // Progress Label constraints
            progressLabel.leadingAnchor.constraint(equalTo: progressSlider.leadingAnchor),
            progressLabel.topAnchor.constraint(equalTo: progressSlider.bottomAnchor, constant: 10)
        ])
    }

    // MARK: - Actions
    @objc private func segmentsStepperChanged(_ sender: UIStepper) {
        let pages = Int(sender.value)
        progressIndicator.numberOfPages = pages
        segmentsLabel.text = "Segments: \(pages)"
        if currentSegmentStepper.value > Double(pages) {
            currentSegmentStepper.value = Double(pages - 1)
        }
        currentSegmentStepper.maximumValue = Double(pages - 1)
        
    }

    @objc private func currentSegmentStepperChanged(_ sender: UIStepper) {
        let currentPage  = Int(sender.value)
        progressIndicator.currentPage = currentPage
        currentSegmentLabel.text = "Current Segment: \(currentPage)"
    }

    @objc private func progressSliderChanged(_ sender: UISlider) {
        let progress = sender.value
        progressIndicator.currentProgress = Float(progress)
        progressLabel.text = "Progress: \(progress)"
    }
}
