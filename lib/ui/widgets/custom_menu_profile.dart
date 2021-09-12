part of 'widgets.dart';

class CustomMenuProfile extends StatelessWidget {
  final String title;
  final Function onTap;

  CustomMenuProfile({
    @required this.title,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: blackFontStyle3),
          Container(
            width: defaultMargin,
            height: defaultMargin,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/right_arrow.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
