part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> account = [
      CustomMenuProfile(
        title: 'Edit Profile',
        onTap: () {
          Get.to(EditProfilePage());
        },
      ),
      SizedBox(height: 10),
      CustomMenuProfile(
        title: 'Home Address',
        onTap: () {
          Get.to(EditAddressPage());
        },
      ),
      SizedBox(height: 10),
      CustomMenuProfile(
        title: 'Security',
        onTap: () {},
      ),
      SizedBox(height: 10),
      CustomMenuProfile(
        title: 'Payments',
        onTap: () {},
      ),
      SizedBox(height: 10),
      CustomMenuProfile(
        title: 'Sign Out',
        onTap: () async {
          bool result = await context.read<UserCubit>().signOut();

          if (result == true) {
            Get.offAll(SignInPage());
          }
        },
      ),
    ];
    List<Widget> foodMarket = [
      CustomMenuProfile(
        title: 'Rate App',
        onTap: () {},
      ),
      SizedBox(height: 10),
      CustomMenuProfile(
        title: 'Help Center',
        onTap: () {},
      ),
      SizedBox(height: 10),
      CustomMenuProfile(
        title: 'Privacy & Policy',
        onTap: () {},
      ),
      SizedBox(height: 10),
      CustomMenuProfile(
        title: 'Terms & Conditions',
        onTap: () {},
      ),
    ];

    return ListView(
      children: [
        Column(
          children: [
            // * Profile Detail
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 102, vertical: 26),
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/photo_border.png'),
                      ),
                    ),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              (context.read<UserCubit>().state as UserLoaded)
                                  .user
                                  .picturePath),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    (context.read<UserCubit>().state as UserLoaded).user.name,
                    textAlign: TextAlign.center,
                    style: blackFontStyle2.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 6),
                  Text(
                    (context.read<UserCubit>().state as UserLoaded).user.email,
                    textAlign: TextAlign.center,
                    style: greyFontStyle.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // * List of Menu (Tabs)
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        CustomTabBar(
                          titles: ['Account', 'Food Market'],
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
                  // * List Menu
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: defaultMargin, vertical: 16),
                    child: Column(
                      children: (selectedIndex == 0 ? account : foodMarket),
                    ),
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
