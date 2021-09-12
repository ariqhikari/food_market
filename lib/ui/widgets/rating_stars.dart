part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double rate;
  final double starSize;

  RatingStars({
    this.rate = 0,
    this.starSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rate.round();
    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        MdiIcons.star,
        color: index < numberOfStars ? mainColor : 'ECECEC'.toColor(),
        size: starSize,
      ),
    );

    widgets.add(SizedBox(width: 4));
    widgets.add(
      Text(
        rate.toString(),
        style: greyFontStyle.copyWith(fontSize: 13),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }
}
