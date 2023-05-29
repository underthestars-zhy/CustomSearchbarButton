# CustomSearchbarButton

This package enables you to effortlessly incorporate UIKit SearchBar buttons into your SwiftUI SearchBar, enhancing its functionality.

## Installation

Requirement: iOS15+. CustomSearchbarButton can be installed through [Swift Package Manager](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

```swift
.package(url: "https://github.com/underthestars-zhy/CustomSearchbarButton", .upToNextMajor(from: "1.1.0"))
```

## Get Started

### Default Button

By using CustomSearchbarButton, you only need to add a simple modification to your view where you add `searchable` to add a custom SearchBar button.

```swift
.searchbarButton(image: UIImage(systemName: "...")!, type: .bookmark, visibility: .auto) {
    // some action
}
```

#### Button Type

CustomSearchBarButton supports four different types of buttons:

* Search (Cannot set visibility)
* Clear
* Bookbmark
* Result List

#### Visibilty

By adjusting the visibility setting, you can control the button's visibility based on specific conditions.

* Auto
* Visible
* Hidden

### Menu Button

CustomSearchbarButton enables you to add a menu button to the SearchBar, which will appear in the same position as the bookmark button.


```swift
.searchbarMenuButton(image: UIImage(systemName: "star")!, menu: createMenu(), mode: .always)
```

#### Mode

CustomSearchBarButton supports four different types of visibility rules:

* Always
* Never
* Unless Editing
* While Editing
