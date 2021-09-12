part of 'widgets.dart';

class FoodListItem extends StatelessWidget {
  final Food food;
  final double itemWidth;

  FoodListItem({
    @required this.food,
    @required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // * Image, Title & Price
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // * Image
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(8),
                image: (food.picturePath != null)
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(food.picturePath),
                      )
                    : null,
              ),
            ),
            // * Title & Price
            SizedBox(
              width: itemWidth - 202, // (60 + 12 + 130)
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: blackFontStyle2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    NumberFormat.currency(
                            symbol: 'IDR ', decimalDigits: 0, locale: 'id-ID')
                        .format(food.price),
                    style: greyFontStyle.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        // * Rating Stars
        RatingStars(rate: food.rate),
      ],
    );
  }
}
