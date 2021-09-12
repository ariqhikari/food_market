part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Header
            Container(
              width: double.infinity,
              height: 108,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                  defaultMargin, 30, defaultMargin, defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Food Market', style: blackFontStyle1),
                      Text(
                        "Let's get some foods",
                        style: greyFontStyle.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(MainPage(initialPage: 2));
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .picturePath)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // * List of Food
            Container(
              width: double.infinity,
              height: 261,
              padding: EdgeInsets.all(defaultMargin),
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (_, state) => (state is FoodLoaded)
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.foods.length,
                        itemBuilder: (_, index) => Container(
                          margin: (state.foods[index] != state.foods.last)
                              ? EdgeInsets.only(right: defaultMargin)
                              : null,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(FoodDetailPage(
                                transaction: Transaction(
                                  food: state.foods[index],
                                  user: (context.read<UserCubit>().state
                                          as UserLoaded)
                                      .user,
                                ),
                                onBackButtonPressed: () {
                                  Get.back();
                                },
                              ));
                            },
                            child: FoodCard(
                              state.foods[index],
                            ),
                          ),
                        ),
                      )
                    : Center(child: loadingIndicator),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  // * List of Food (Tabs)
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        CustomTabBar(
                          titles: ['New Taste', 'Popular', 'Recommended'],
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
                  // * List Food
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: defaultMargin, vertical: 16),
                    child:
                        BlocBuilder<FoodCubit, FoodState>(builder: (_, state) {
                      if (state is FoodLoaded) {
                        List<Food> foods = state.foods
                            .where((food) =>
                                food.types.contains((selectedIndex == 0)
                                    ? FoodType.new_food
                                    : (selectedIndex == 1)
                                        ? FoodType.popular
                                        : FoodType.recommended))
                            .toList();

                        return Column(
                          children: foods
                              .map((food) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: (foods.indexOf(food) !=
                                                foods.lastIndex)
                                            ? 16
                                            : 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(FoodDetailPage(
                                          transaction: Transaction(
                                            food: food,
                                            user: (context
                                                    .read<UserCubit>()
                                                    .state as UserLoaded)
                                                .user,
                                          ),
                                          onBackButtonPressed: () {
                                            Get.back();
                                          },
                                        ));
                                      },
                                      child: FoodListItem(
                                        food: food,
                                        itemWidth: listItemWidth,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      } else {
                        return Center(child: loadingIndicator);
                      }
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ],
    );
  }
}
