import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class PersonalTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final String? errorText;
  final bool enabled;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Widget? icon;
  final double width;
  final bool isDense;
  final Widget? prefix;
  final double? padding;

  PersonalTextField(
      {required this.controller,
      this.isDense = false,
      this.labelText,
      this.hintText,
      this.errorText,
      this.onChanged,
      this.icon,
      this.obscureText = false,
      this.enabled = true,
      this.width = 400,
      this.prefix,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText == null
                ? Container()
                : Text(
                    labelText!,
                    style: TextStyle(
                        color: enabled ? null : Colors.white.withOpacity(0.5)),
                  ),
            labelText == null
                ? Container()
                : SizedBox(
                    height: 6,
                  ),
            HoverWidget(
              onHover: (PointerEnterEvent event) {},
              hoverChild: TextField(
                obscureText: obscureText,
                controller: controller,
                onChanged: (String? input) {
                  if (input != null && onChanged != null) {
                    onChanged!(input);
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: prefix,
                  isDense: isDense,
                  filled: true,
                  fillColor: Color(0xff2f2f2),
                  enabled: enabled,
                  errorText: errorText,
                  suffixIcon: icon,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              child: TextField(
                obscureText: obscureText,
                controller: controller,
                onChanged: (String? input) {
                  if (input != null && onChanged != null) {
                    onChanged!(input);
                  }
                },
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: prefix,
                  isDense: isDense,
                  enabled: enabled,
                  errorText: errorText,
                  suffixIcon: icon,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
