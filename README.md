# multiple_select

[![License][license-image]][license-url] 
[![Pub](https://img.shields.io/pub/v/multiple_select.svg?style=flat-square)](https://pub.dartlang.org/packages/multiple_select)

A versatile and beautiful multi-drop-down component for App developers.🚀

![multiple_select.gif](https://upload-images.jianshu.io/upload_images/3646846-f8f6e3af37f70ac3.gif?imageMogr2/auto-orient/strip)

## Getting Started

```yaml
dependencies:
 multiple_select: ^0.1.4
```

## Usage example

#### MultipleSelect
```dart
MultipleSelect.showMultipleSelector(
                context,
                dataList: List.generate(15, (index) => MultipleSelectItem.build(value: index, display: '第$index项显示内容', content: '第$index项下拉内容')),
              ).then((selectedList) {
                if (selectedList != null) selectedList.forEach((item) => print(item.display));
              });
```

#### MultipleDropDown
```dart
MultipleDropDown(
          placeholder: '请选择',
          elements: List.generate(15, (index) => MultipleSelectItem.build(value: index, display: '第$index项显示内容', content: '第$index项下拉内容')),
          onConfirm: (elements) {
            elements.forEach((element) => print(element.display));
          },
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