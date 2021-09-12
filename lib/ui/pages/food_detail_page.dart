part of 'pages.dart';

class FoodDetailPage extends StatefulWidget {
  final Function onBackButtonPressed;
  final Transaction transaction;

  FoodDetailPage({this.onBackButtonPressed, this.transaction});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // * Food Image
            Container(
              width: double.infinity,
              height: 330,
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                image: (widget.transaction.food.picturePath != null)
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(widget.transaction.food.picturePath),
                      )
                    : null,
              ),
            ),
            // * Back Arrow
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.onBackButtonPressed != null) {
                          widget.onBackButtonPressed();
                        }
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.only(top: defaultMargin, left: 12),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/back_arrow_white.png'),
                          ),
                        ),
                      ),
                    ),
                    // * Food Detail
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 230),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // * Title, Rating Stars & Quantity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // * Title & Rating Stars
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.transaction.food.name,
                                    style: blackFontStyle2,
                                  ),
                                  SizedBox(height: 6),
                                  RatingStars(
                                      rate: widget.transaction.food.rate),
                                ],
                              ),
                              // * Quantity
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity = max(1, quantity - 1);
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: blackColor),
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/btn_min.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        quantity.toString(),
                                        style: blackFontStyle2,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity = min(999, quantity + 1);
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: blackColor),
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/btn_add.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // * Desc
                          SizedBox(height: 12),
                          Text(
                            widget.transaction.food.description,
                            style: greyFontStyle.copyWith(height: 1.6),
                          ),
                          // * Ingredients
                          SizedBox(height: 16),
                          Text(
                            'Ingredients:',
                            style: blackFontStyle2,
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.transaction.food.ingredients,
                            style: greyFontStyle.copyWith(height: 1.6),
                          ),
                          SizedBox(height: 40),
                          // * Total Price & Next Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // * Total Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Price:',
                                    style: greyFontStyle.copyWith(fontSize: 13),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    NumberFormat.currency(
                                            symbol: 'IDR ',
                                            decimalDigits: 0,
                                            locale: 'id-ID')
                                        .format(widget.transaction.food.price *
                                            quantity),
                                    style:
                                        blackFontStyle2.copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                              // * Next Button
                              Container(
                                  width: 163,
                                  height: 45,
                                  child: RaisedButton(
                                    elevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    hoverElevation: 0,
                                    color: mainColor,
                                    child: Text(
                                      'Order Now',
                                      style: blackFontStyle3.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    onPressed: () {
                                      Get.to(PaymentPage(
                                          transaction:
                                              widget.transaction.copyWith(
                                        quantity: quantity,
                                        total: widget.transaction.food.price *
                                            quantity,
                                      )));
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
