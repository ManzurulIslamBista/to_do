import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do/repositories/page_index_tracker.dart';

class SubIntroPage extends StatefulWidget {
  String asset_location = '';
  String title = '';
  String subTitle = '';
  int currentPageIndex;
  SubIntroPage(
      {Key? key,
      required this.asset_location,
      required this.title,
      required this.subTitle,
      required this.currentPageIndex})
      : super(key: key);

  @override
  State<SubIntroPage> createState() => _SubIntroPageState();
}

class _SubIntroPageState extends State<SubIntroPage> {
  Widget _buildImage(String imagePath) {
    return SvgPicture.asset(
      imagePath,
      semanticsLabel: 'uptodo SVG Image',
      height: MediaQuery.of(context).size.height / 2.3,
      width: 100,
      fit: BoxFit.fitHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: _buildImage(widget.asset_location),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height > 500
                ? MediaQuery.of(context).size.height / 20
                : MediaQuery.of(context).size.height / 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PageIndexTracker(currentIndex: widget.currentPageIndex == 0),
            PageIndexTracker(currentIndex: widget.currentPageIndex == 1),
            PageIndexTracker(currentIndex: widget.currentPageIndex == 2),
          ],
        ),
        Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height > 500
                    ? MediaQuery.of(context).size.height / 20
                    : MediaQuery.of(context).size.height / 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xDEFFFFFF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height > 500
                    ? MediaQuery.of(context).size.height / 20
                    : MediaQuery.of(context).size.height / 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Text(
                        widget.subTitle,
                        style: const TextStyle(
                          color: Color(0xDEFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
