# multiple_select

[![License][license-image]][license-url] 
[![Pub](https://img.shields.io/pub/v/multiple_select.svg?style=flat-square)](https://pub.dartlang.org/packages/multiple_select)

A versatile and beautiful multi-drop-down component for App developers.🚀

![select.gif](./example/android/app/src/main/res/drawable/selector.gif)
## Getting Started

```yaml
dependencies:
 multiple_select: ^0.1.2
```

## Usage example

```dart
/// Simulate 15 data
List<MultipleSelectItem> elements = List.generate(
  15,
  (index) => MultipleSelectItem.build(
    value: index,
    display: '$index display',
    content: '$index content',
  ),
);

List _selectedValues = [];

MultipleDropDown(
          placeholder: '请选择',
          disabled: false,
          values: _selectedValues,
          elements: elements,
        )
```

## Contribute

We would ❤️ to see your contribution!

## License

Distributed under the MIT license. See ``LICENSE`` for more information.

## About

Created by Shusheng.

[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
