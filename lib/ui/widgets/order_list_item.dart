part of 'widgets.dart';

class OrderListItem extends StatelessWidget {
  final Transaction transaction;
  final double itemWidth;

  OrderListItem({
    @required this.transaction,
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
                image: (transaction.food.picturePath != null)
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(transaction.food.picturePath),
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
                    transaction.food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: blackFontStyle2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${transaction.quantity} items • ${NumberFormat.currency(symbol: 'IDR ', decimalDigits: 0, locale: 'id-ID').format(transaction.food.price)}',
                    style: greyFontStyle.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        // * Date & Status
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // * Date
              Text(
                convertDateTime(transaction.dateTime),
                style: greyFontStyle.copyWith(fontSize: 12),
              ),
              SizedBox(height: 2),
              (transaction.status == TransactionStatus.pending)
                  ? Text(
                      'Pending',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: 'D9435E'.toColor(),
                      ),
                    )
                  : (transaction.status == TransactionStatus.paid)
                      ? Text(
                          'Paid',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: '1ABC9C'.toColor(),
                          ),
                        )
                      : (transaction.status == TransactionStatus.on_delivery)
                          ? Text(
                              'On Delivery',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: '1ABC9C'.toColor(),
                              ),
                            )
                          : (transaction.status == TransactionStatus.delivered)
                              ? Text(
                                  'Delivered',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: '1ABC9C'.toColor(),
                                  ),
                                )
                              : Text(
                                  'Cancelled',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: 'D9435E'.toColor(),
                                  ),
                                ),
            ],
          ),
        ),
      ],
    );
  }

  String convertDateTime(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Now';
        break;
      default:
        month = 'Des';
    }

    return month + ' ${dateTime.day}, ${dateTime.hour}:${dateTime.minute}';
  }
}
