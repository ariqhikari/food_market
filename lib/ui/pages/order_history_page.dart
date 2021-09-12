part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(builder: (_, state) {
      if (state is TransactionLoaded) {
        if (state.transactions.length == 0) {
          return IllustrationPage(
            title: 'Ouch! Hungry',
            subTitle: 'Seems like you have not\nordered any food yet',
            picturePath: 'assets/love_burger.png',
            buttonTitle1: 'Find Foods',
            buttonTap1: () {
              Get.offAll(MainPage());
            },
          );
        } else {
          double listItemWidth =
              MediaQuery.of(context).size.width - 2 * defaultMargin;

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<TransactionCubit>().getTransactions();
            },
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 108,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                          defaultMargin, 30, defaultMargin, defaultMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Orders', style: blackFontStyle1),
                          Text(
                            'Wait for the best meal',
                            style: greyFontStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: defaultMargin),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          // * List of Order (Tabs)
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                CustomTabBar(
                                  titles: ['In Progress', 'Past Orders'],
                                  selectedIndex: selectedIndex,
                                  onTap: (index) {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          // * List Order
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 16),
                            child: Builder(builder: (_) {
                              List<Transaction> transactions = (selectedIndex ==
                                      0)
                                  ? state.transactions
                                      .where((transaction) =>
                                          transaction.status ==
                                              TransactionStatus.on_delivery ||
                                          transaction.status ==
                                              TransactionStatus.pending ||
                                          transaction.status ==
                                              TransactionStatus.paid)
                                      .toList()
                                  : state.transactions
                                      .where((transaction) =>
                                          transaction.status ==
                                              TransactionStatus.delivered ||
                                          transaction.status ==
                                              TransactionStatus.cancelled)
                                      .toList();

                              return Column(
                                children: transactions
                                    .map((transaction) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: (transactions.indexOf(
                                                          transaction) !=
                                                      transactions.lastIndex)
                                                  ? 16
                                                  : 0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (transaction.status ==
                                                  TransactionStatus.pending) {
                                                await launch(
                                                    transaction.paymentURL);
                                              } else {
                                                Get.to(OrderDetailPage(
                                                    transaction));
                                              }
                                            },
                                            child: OrderListItem(
                                              transaction: transaction,
                                              itemWidth: listItemWidth,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ],
            ),
          );
        }
      } else {
        return Center(child: loadingIndicator);
      }
    });
  }
}
