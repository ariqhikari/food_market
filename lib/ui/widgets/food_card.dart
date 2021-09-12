part of 'widgets.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  FoodCard(this.food);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 15,
            color: 'F2F2F2'.toColor(),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * Food Image
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              image: (food.picturePath != null)
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(food.picturePath),
                    )
                  : null,
            ),
          ),
          // * Title & Rating Stars
          Container(
            width: 176,
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: blackFontStyle2,
                ),
                SizedBox(height: 6),
                RatingStars(rate: food.rate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
