import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class PageSlider extends StatefulWidget {
  @override
  State<PageSlider> createState() => _PageSliderState();

  Widget page1;
  Widget page2;
  Widget page3;
  PageSlider({this.page1, this.page2, this.page3});
}

class _PageSliderState extends State<PageSlider> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [widget.page1, widget.page2, widget.page3],
    );
  }
}
