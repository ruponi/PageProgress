# PTPageIndicator

**PTPageIndicator** is a custom UIKit-based UI component that provides a visual representation of a segmented progress indicator. It's designed to be easily integrated into your iOS projects, allowing users to control and visualize progress across multiple segments.

## Features

- Dynamically adjustable number of segments.
- Ability to set and highlight the current segment.
- Customize progress within the current segment.

## Usage

### Basic Setup

1. **Import and Initialize:**

   You can use the `PTPageIndicator` directly in your view controller. Below is an example of how to initialize and configure the component.

   ```swift
   let pageIndicator = PTPageIndicator()
   ```

2. **Add the Indicator to Your View:**

   ```swift
   view.addSubview(pageIndicator)

   // Set up constraints or frame as needed
   pageIndicator.translatesAutoresizingMaskIntoConstraints = false
   NSLayoutConstraint.activate([
       pageIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       pageIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
       pageIndicator.widthAnchor.constraint(equalToConstant: 200),
       pageIndicator.heightAnchor.constraint(equalToConstant: 50)
   ])
   ```

3. **Adjust Segments and Progress:**

   You can easily configure the number of segments and set the current segment.

   ```swift
   pageIndicator.numberOfPages = 5  // Set the number of segments
   pageIndicator.currentPage = 2    // Highlight the current segment
   pageIndicator.progress = 0.5     // Set progress within the current segment
   ```

### Example of Control

To create a dynamic UI where users can control the progress indicator using steppers and sliders, you can add controls and bind them to the indicator:

```swift
// Example for stepper to increase/decrease the number of segments
segmentsStepper.addTarget(self, action: #selector(segmentsStepperChanged(_:)), for: .valueChanged)

// Example for slider to adjust the progress within the current segment
progressSlider.addTarget(self, action: #selector(progressSliderChanged(_:)), for: .valueChanged)
```

## Methods

- **numberOfPages**: The total number of segments in the progress indicator.
- **currentPage**: The index of the currently highlighted segment.
- **progress**: The progress within the current segment, typically a value between 0.0 and 1.0.

## Example

To see an example implementation, simply create a `PTPageIndicator` instance, configure its properties, and add it to your view as shown in the Basic Setup.

## Contributing

If you encounter any bugs or have feature suggestions, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
