part of 'pages.dart';

class PaymentPage extends StatefulWidget {
  final Transaction transaction;

  PaymentPage({this.transaction});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double orderItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;

    return GeneralPage(
      title: 'Payment',
      subTitle: 'You deserve better meal',
      backColor: 'FAFAFC'.toColor(),
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: [
          // * Item Ordered & Details Transaction
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * Item Ordered
                Text('Item Ordered', style: blackFontStyle3),
                SizedBox(height: 12),
                Row(
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
                            image: (widget.transaction.food.picturePath != null)
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        widget.transaction.food.picturePath),
                                  )
                                : null,
                          ),
                        ),
                        // * Title & Price
                        SizedBox(
                          width: orderItemWidth - 202, // (60 + 12 + 130)
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.transaction.food.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: blackFontStyle2,
                              ),
                              SizedBox(height: 4),
                              Text(
                                NumberFormat.currency(
                                        symbol: 'IDR ',
                                        decimalDigits: 0,
                                        locale: 'id-ID')
                                    .format(widget.transaction.food.price),
                                style: greyFontStyle.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // * Quantity
                    Text(
                      '${widget.transaction.quantity} items',
                      style: greyFontStyle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // * Details Transaction
                Text('Details Transaction', style: blackFontStyle3),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(widget.transaction.food.name,
                          style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        NumberFormat.currency(
                                symbol: 'IDR ',
                                decimalDigits: 0,
                                locale: 'id-ID')
                            .format(widget.transaction.total),
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('Driver', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        NumberFormat.currency(
                                symbol: 'IDR ',
                                decimalDigits: 0,
                                locale: 'id-ID')
                            .format(50000),
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('Tax 10%', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        NumberFormat.currency(
                                symbol: 'IDR ',
                                decimalDigits: 0,
                                locale: 'id-ID')
                            .format(widget.transaction.total * 0.1),
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('Total Price', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        NumberFormat.currency(
                                symbol: 'IDR ',
                                decimalDigits: 0,
                                locale: 'id-ID')
                            .format(widget.transaction.total +
                                (widget.transaction.total * 0.1) +
                                50000),
                        textAlign: TextAlign.right,
                        style: blackFontStyle3.copyWith(
                          color: '1ABC9C'.toColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // * Deliver Detail
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Deliver to:', style: blackFontStyle3),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('Name', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        widget.transaction.user.name,
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('Phone No.', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        widget.transaction.user.phoneNumber,
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('Address', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        widget.transaction.user.address,
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('House No.', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        widget.transaction.user.houseNumber,
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('City', style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text(
                        widget.transaction.user.city,
                        textAlign: TextAlign.right,
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // * Checkout Button
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(defaultMargin),
            child: Container(
              width: double.infinity,
              height: 45,
              child: isLoading
                  ? loadingIndicator
                  : RaisedButton(
                      elevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      hoverElevation: 0,
                      color: mainColor,
                      child: Text(
                        'Checkout Now',
                        style: blackFontStyle3.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        String paymentURL = await context
                            .read<TransactionCubit>()
                            .submitTransaction(widget.transaction.copyWith(
                                dateTime: DateTime.now(),
                                total: widget.transaction.total +
                                    (widget.transaction.total * 0.1).toInt() +
                                    50000));

                        if (paymentURL != null) {
                          Get.to(PaymentMethodPage(paymentURL));
                        } else {
                          Get.snackbar(
                            '',
                            '',
                            backgroundColor: 'D9435E'.toColor(),
                            icon: Icon(MdiIcons.closeCircleOutline,
                                color: Colors.white),
                            titleText: Text(
                              'Transaction Failed',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            messageText: Text(
                              'Please try again later.',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          );

                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
