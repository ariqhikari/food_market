part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final User user;
  final String password;
  final File pictureFile;

  AddressPage(this.user, this.password, this.pictureFile);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  bool isLoading = false;
  List<String> cities;
  String selectedCity;

  @override
  void initState() {
    super.initState();

    cities = ['Bandung', 'Jakarta', 'Bali', 'Surabaya'];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Address',
      subTitle: 'Make sure it’s valid',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 85),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Phone Number
            Text('Phone Number', style: blackFontStyle2),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyle,
                  hintText: 'Type your phone number',
                ),
              ),
            ),
            // * Address
            Text('Address', style: blackFontStyle2),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyle,
                  hintText: 'Type your address',
                ),
              ),
            ),
            // * House Number
            Text('House Number', style: blackFontStyle2),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: houseNumberController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyle,
                  hintText: 'Type your house number',
                ),
              ),
            ),
            // * City
            Text('City', style: blackFontStyle2),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6, bottom: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton(
                value: selectedCity,
                isExpanded: true,
                underline: SizedBox(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
                items: cities
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value, style: blackFontStyle3),
                        ))
                    .toList(),
              ),
            ),
            // * Sign Up Button
            Container(
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
                        'Sign Up Now',
                        style: blackFontStyle3.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () async {
                        User user = widget.user.copyWith(
                          phoneNumber: phoneNumberController.text,
                          address: addressController.text,
                          houseNumber: houseNumberController.text,
                          city: selectedCity,
                        );

                        setState(() {
                          isLoading = true;
                        });

                        await context.read<UserCubit>().signUp(
                              user,
                              widget.password,
                              pictureFile: widget.pictureFile,
                            );
                        UserState state = context.read<UserCubit>().state;

                        if (state is UserLoaded) {
                          Get.offAll(MainPage());
                        } else {
                          Get.snackbar(
                            '',
                            '',
                            backgroundColor: 'D9435E'.toColor(),
                            icon: Icon(MdiIcons.closeCircleOutline,
                                color: Colors.white),
                            titleText: Text(
                              'Sign Up Failed',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            messageText: Text(
                              (state as UserLoadingFailed).message,
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
          ],
        ),
      ),
    );
  }
}
