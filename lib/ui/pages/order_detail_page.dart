part of 'pages.dart';

class OrderDetailPage extends StatefulWidget {
  final Transaction transaction;

  OrderDetailPage(this.transaction);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
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
            margin: EdgeInsets.only(bottom: defaultMargin),
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
          // * Order Status
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Status:', style: blackFontStyle3),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: Text('#${widget.transaction.code}',
                          style: greyFontStyle),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width / 2 - defaultMargin,
                      child: (widget.transaction.status ==
                              TransactionStatus.pending)
                          ? Text(
                              'Pending',
                              textAlign: TextAlign.right,
                              style: blackFontStyle3.copyWith(
                                color: 'D9435E'.toColor(),
                              ),
                            )
                          : (widget.transaction.status ==
                                  TransactionStatus.paid)
                              ? Text(
                                  'Paid',
                                  textAlign: TextAlign.right,
                                  style: blackFontStyle3.copyWith(
                                    color: '1ABC9C'.toColor(),
                                  ),
                                )
                              : (widget.transaction.status ==
                                      TransactionStatus.on_delivery)
                                  ? Text(
                                      'On Delivery',
                                      textAlign: TextAlign.right,
                                      style: blackFontStyle3.copyWith(
                                        color: '1ABC9C'.toColor(),
                                      ),
                                    )
                                  : (widget.transaction.status ==
                                          TransactionStatus.delivered)
                                      ? Text(
                                          'Delivered',
                                          textAlign: TextAlign.right,
                                          style: blackFontStyle3.copyWith(
                                            color: '1ABC9C'.toColor(),
                                          ),
                                        )
                                      : Text(
                                          'Cancelled',
                                          textAlign: TextAlign.right,
                                          style: blackFontStyle3.copyWith(
                                            color: 'D9435E'.toColor(),
                                          ),
                                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // * Cancel Order Button
          (widget.transaction.status == TransactionStatus.paid)
              ? Container(
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
                            color: 'D9435E'.toColor(),
                            child: Text(
                              'Cancel My Order',
                              style: blackFontStyle3.copyWith(
                                color: Colors.white,
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

                              await context
                                  .read<TransactionCubit>()
                                  .changeStatusTransaction(
                                    widget.transaction.copyWith(
                                      status: TransactionStatus.cancelled,
                                    ),
                                  );
                              TransactionState state =
                                  context.read<TransactionCubit>().state;

                              if (state is TransactionLoaded) {
                                Get.back();
                              } else {
                                Get.snackbar(
                                  '',
                                  '',
                                  backgroundColor: 'D9435E'.toColor(),
                                  icon: Icon(MdiIcons.closeCircleOutline,
                                      color: Colors.white),
                                  titleText: Text(
                                    'Cancel Order Failed',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  messageText: Text(
                                    'Please try again later.',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                );

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                          ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
