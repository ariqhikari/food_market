part of 'widgets.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int index) onTap;

  CustomTabBar({
    @required this.titles,
    this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 53,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: 'F2F2F2'.toColor(),
            margin: EdgeInsets.only(top: 48),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: titles
                .map(
                  (title) => Padding(
                    padding: EdgeInsets.only(left: defaultMargin, top: 16),
                    child: GestureDetector(
                      onTap: () {
                        if (onTap != null) {
                          onTap(titles.indexOf(title));
                        }
                      },
                      child: Column(
                        children: [
                          // * Title
                          Text(
                            title,
                            style: (titles.indexOf(title) == selectedIndex)
                                ? blackFontStyle3.copyWith(
                                    fontWeight: FontWeight.w500)
                                : greyFontStyle,
                          ),
                          // * Border
                          Container(
                            width: 40,
                            height: 3,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.5),
                              color: (titles.indexOf(title) == selectedIndex)
                                  ? blackColor
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
