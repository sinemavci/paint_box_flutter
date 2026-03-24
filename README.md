# 🎨 paint_box_flutter

<p align="center">
  <img src="./assets/demo.gif" width="200" />
</p>

paint_box_flutter is a lightweight drawing component for Flutter that allows users to draw on a canvas with customizable brush settings.

## ⚙️ Installation
```sh
flutter pub add paint_box_flutter
```

## 🚀 Usage
```dart
import 'package:paint_box_flutter/paint_box_flutter_plugin.dart';

// ...

PaintBoxView(
    paintEditor: paintEditor1,
    onPaintBoxViewReady: () async {
        final _strokeColor = await paintEditor1.getStrokeColor();
        final _strokeSize = await paintEditor1.getStrokeSize();
        setState(() {
            strokeSize1 = _strokeSize;
            strokeColor1 = _strokeColor;
        });
    },
),
```


## Api Reference

#### 🧠 Core Concepts
PaintEditor

PaintEditor is the controller object used to interact with a specific PaintBoxRNView instance.

Each PaintBoxRNView must have its own PaintEditor instance.

#### ⚠️ Multiple PaintBox Support
You can use multiple paint boxes independently:

```dart
  final paintEditor1 = PaintEditor();
  final paintEditor2 = PaintEditor();
```

```dart
PaintBoxView(paintEditor: paintEditor1),
PaintBoxView(paintEditor: paintEditor2),
```

#### Undo
Reverts the last drawing action.

```dart
await paintEditor.undo();
```

#### Redo
Restores the last undone action.

```dart
await paintEditor.redo();
```

#### Reset
Clears the entire canvas.

```dart
await paintEditor.reset();
```

#### Import
| Param  | Type   | Required | Description     |
| ------ | ------ | -------- | --------------- |
| path   | String | ✅        | Image file path |
| width  | double | ❌        | Target width    |
| height | double | ❌        | Target height   |

```dart
Future<String> export({
  required String path,
  required double? width,
  required double ?height,
});
```

#### Export
```dart
Future<String> export({
  required String path,
  required String fileName,
  required MimeType mimeType,
});
```

```dart
enum MimeType {
  jpeg('jpeg'),
  png('png'),
  gif('gif'),
  tif('tif'),
  bmp('bmp'),
  pdf('pdf');
}
```

| Param    | Type     | Required | Description                 |
| -------- | -------- | -------- | --------------------------- |
| path     | String   | ✅        | Output directory path       |
| fileName | String   | ✅        | File name without extension |
| mimeType | MimeType | ✅        | Output format               |


#### Enable
```dart
Future<bool> isEnable();
Future<void> setEnable(bool value);
```


#### 🎨 Paint Mode
```dart
enum PaintMode {
  pen('PEN'),
  marker('MARKER'),
  bucket('BUCKET'),
  brush('BRUSH'),
  eraser('ERASER');
}
```

```dart
Future<PaintMode> getPaintMode();
void setPaintMode(PaintMode mode);
```

#### 🌈 Stroke Color
```dart
Future<Color> getStrokeColor();
Future<void> setStrokeColor(Color color);
```

Color Definition

```dart
class Color {
  constructor(double red, double green, double blue)
}
```

#### Stroke Size
```dart
Future<double> getStrokeSize();
Future<void> setStrokeSize(double size);
```

## ⚙️ Widget Parameters
| Prop            | Type        | Required | Description                 |
| --------------- | ----------- | -------- | --------------------------- |
| paintEditor     | PaintEditor | ✅        | Controller instance         |
| onPaintBoxReady | () => void  | ❌        | Called when canvas is ready |

## Best Practices
- Always create one PaintEditor per PaintBox
- Wait for onPaintBoxReady before calling methods
- Avoid very large stroke sizes (performance impact)