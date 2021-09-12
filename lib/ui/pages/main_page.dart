part of 'pages.dart';

class MainPage extends StatefulWidget {
  final initialPage;

  MainPage({this.initialPage = 0});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    selectedPage = widget.initialPage;
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    context.read<FoodCubit>().getFoods();
    context.read<TransactionCubit>().getTransactions();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        body: Container(
          color: 'FAFAFC'.toColor(),
          child: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedPage = index;
                  });
                },
                children: [
                  // * Food Page
                  FoodPage(),
                  // * Order Page
                  OrderHistoryPage(),
                  // * Profile Page
                  ProfilePage(),
                ],
              ),
              // * Bottom Navbar
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomNavbar(
                  selectedIndex: selectedPage,
                  onTap: (index) {
                    setState(() {
                      selectedPage = index;
                    });
                    pageController.jumpToPage(selectedPage);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
