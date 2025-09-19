import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final double? height;

  const Header({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final canBack = Navigator.canPop(context);

    // Widget leading mặc định nếu không được cung cấp
    final Widget defaultLeading = canBack
        ? IconButton(
            onPressed: () => Navigator.pop(context),
            // Bạn có thể muốn thay đổi màu icon cho phù hợp với theme
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          )
        : const SizedBox(width: 48); // Placeholder để giữ cân bằng

    // Widget trailing mặc định nếu không được cung cấp
    final Widget defaultTrailing = const SizedBox(width: 48); // Placeholder
    final double defaultHeight = screenHeight * 0.25;

    return Container(
      height: height ?? defaultHeight,
      decoration: BoxDecoration(
        // Thay đổi màu sắc cho phù hợp với theme của bạn
        color: const Color(0xFF2E8A8A),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.fill(top: 0, child: Center(child: title)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        leading ?? defaultLeading,
                        trailing ?? defaultTrailing,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
