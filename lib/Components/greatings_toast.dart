import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// A customizable button that can handle multiple taps (up to 10 taps) with
/// different callback functions for each number of taps.
class MultiTapButton extends StatefulWidget {
  /// The child widget to display inside the button.
  final Widget child;

  /// Callback for a single tap.
  final Function()? onSingleTap;

  /// Callback for a double tap (two taps).
  final Function()? onDoubleTap;

  /// Callback for a triple tap (three taps).
  final Function()? onTripleTap;

  /// Callback for four taps.
  final Function()? onFourTaps;

  /// Callback for five taps.
  final Function()? onFiveTaps;

  /// Callback for six taps.
  final Function()? onSixTaps;

  /// Callback for seven taps.
  final Function()? onSevenTaps;

  /// Callback for eight taps.
  final Function()? onEightTaps;

  /// Callback for nine taps.
  final Function()? onNineTaps;

  /// Callback for ten taps.
  final Function()? onTenTaps;

  /// Constructor for the [MultiTapButton] widget.
  const MultiTapButton({
    super.key,
    required this.child,
    this.onSingleTap,
    this.onDoubleTap,
    this.onTripleTap,
    this.onFourTaps,
    this.onFiveTaps,
    this.onSixTaps,
    this.onSevenTaps,
    this.onEightTaps,
    this.onNineTaps,
    this.onTenTaps,
  });

  @override
  _MultiTapButtonState createState() => _MultiTapButtonState();
}

class _MultiTapButtonState extends State<MultiTapButton> {
  int _tapCount = 0; // Tracks the number of taps.
  Timer? _tapTimer; // Timer to handle the delay between taps.

  /// This function handles each tap and determines the action based on
  /// the number of taps within a 500ms window.
  void _handleTap() {
    _tapCount++; // Increment the tap count on each tap.

    // Cancel the previous timer if it's still active to reset the tap window.
    _tapTimer?.cancel();

    // Start a new timer with a 500ms delay. If the user doesn't tap within this time,
    // the tap count is reset, and the corresponding action is triggered.
    _tapTimer = Timer(const Duration(milliseconds: 500), () {
      // Trigger the correct callback based on the tap count.
      switch (_tapCount) {
        case 1:
          widget.onSingleTap?.call(); // Single tap action.
          break;
        case 2:
          widget.onDoubleTap?.call(); // Double tap action.
          break;
        case 3:
          widget.onTripleTap?.call(); // Triple tap action.
          break;
        case 4:
          widget.onFourTaps?.call(); // Four taps action.
          break;
        case 5:
          widget.onFiveTaps?.call(); // Five taps action.
          break;
        case 6:
          widget.onSixTaps?.call(); // Six taps action.
          break;
        case 7:
          widget.onSevenTaps?.call(); // Seven taps action.
          break;
        case 8:
          widget.onEightTaps?.call(); // Eight taps action.
          break;
        case 9:
          widget.onNineTaps?.call(); // Nine taps action.
          break;
        case 10:
          widget.onTenTaps?.call(); // Ten taps action.
          break;
      }

      // Reset the tap count after triggering the action.
      _tapCount = 0;
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks.
    _tapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Wrap the child widget in a GestureDetector to listen for tap events.
    return GestureDetector(
      onTap: _handleTap, // Call the _handleTap function on each tap.
      child: widget.child, // Display the provided child widget.
    );
  }
}


void showToast(String msg,BuildContext context) {
  var themeColor = Theme.of(context).colorScheme;
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: themeColor.tertiary,
      gravity: ToastGravity.BOTTOM,
      textColor: themeColor.surface
  );
}