import 'package:flutter/material.dart';

class ThemeButton extends StatefulWidget {
  final Function() onPressed;
  final String buttonText;
  final Widget? icon;
  final bool isFullWidth;
  final bool enable;

  const ThemeButton({
    super.key,
    required this.onPressed,
    this.buttonText = '',
    this.icon,
    this.isFullWidth = false,
    this.enable = true,
  });

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isFullWidth
        ? ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: !widget.enable ? Colors.black12 : Colors.purple.shade50,
            ),
            child: widget.icon?? _buildButtonContent(),
          )
        : MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.purple.shade50,
            onPressed: widget.onPressed,
            child: widget.icon?? _buildButtonContent(),
          );
  }

  Widget _buildButtonContent() => Text(
    widget.buttonText,
    style: const TextStyle(
      color: Colors.deepPurple,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}
