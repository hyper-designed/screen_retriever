import 'dart:ui';

/// Description of a user display screen.
class Display {
  // Unique identifier associated with the display.
  final num id;
  final String? name;
  final Size size;
  final Offset? visiblePosition;
  final Size? visibleSize;
  final num? scaleFactor;
  final Rect? displayRect;
  final Rect? visibleRect;

  Display({
    required this.id,
    this.name,
    required this.size,
    this.visiblePosition,
    this.visibleSize,
    this.scaleFactor,
    this.displayRect,
  }): visibleRect = visiblePosition != null && visibleSize != null
      ? Rect.fromLTWH(
          visiblePosition.dx,
          visiblePosition.dy,
          visibleSize.width,
          visibleSize.height,
        )
      : null;

  factory Display.fromJson(Map<String, dynamic> json) {
    Offset? visiblePosition;
    Size? visibleSize;
    Rect? displayRect;

    if (json['visiblePosition'] != null) {
      visiblePosition = Offset(
        json['visiblePosition']['x'],
        json['visiblePosition']['y'],
      );
    }
    if (json['visibleSize'] != null) {
      visibleSize = Size(
        json['visibleSize']['width'],
        json['visibleSize']['height'],
      );
    }

    if (json['displayRect'] != null) {
      displayRect = Rect.fromLTWH(
        json['displayRect']['x'],
        json['displayRect']['y'],
        json['displayRect']['width'],
        json['displayRect']['height'],
      );
    }

    return Display(
      id: json['id'],
      name: json['name'],
      size: Size(
        json['size']['width'],
        json['size']['height'],
      ),
      visiblePosition: visiblePosition,
      visibleSize: visibleSize,
      scaleFactor: json.containsKey('scaleFactor') ? json['scaleFactor'] : null,
      displayRect: displayRect,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': {
        'width': size.width,
        'height': size.height,
      },
      'visiblePosition': visiblePosition != null
          ? {
              'x': visiblePosition!.dx,
              'y': visiblePosition!.dy,
            }
          : null,
      'visibleSize': visibleSize != null
          ? {
              'width': visibleSize!.width,
              'height': visibleSize!.height,
            }
          : null,
      'scaleFactor': scaleFactor,
      'displayRect': displayRect != null
          ? {
              'x': displayRect!.left,
              'y': displayRect!.top,
              'width': displayRect!.width,
              'height': displayRect!.height,
            }
          : null,
    };
  }
}
