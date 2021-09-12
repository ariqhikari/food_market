part of 'pages.dart';

class EditAddressPage extends StatefulWidget {
  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  List<String> cities;
  String selectedCity;
  bool isLoading = false;

  TextEditingController phoneNumberController;
  TextEditingController addressController;
  TextEditingController houseNumberController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user.phoneNumber);
    addressController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user.address);
    houseNumberController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user.houseNumber);

    cities = ['Bandung', 'Jakarta', 'Bali', 'Surabaya'];
    selectedCity = (context.read<UserCubit>().state as UserLoaded).user.city;
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Edit Address',
      subTitle: 'Edit your address',
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
            // * Update Address Button
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
                        'Update My Profile',
                        style: blackFontStyle3.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () async {
                        User user =
                            (context.read<UserCubit>().state as UserLoaded)
                                .user
                                .copyWith(
                                  phoneNumber: phoneNumberController.text,
                                  address: addressController.text,
                                  houseNumber: houseNumberController.text,
                                  city: selectedCity,
                                );

                        setState(() {
                          isLoading = true;
                        });

                        bool result =
                            await context.read<UserCubit>().updateAddress(user);

                        if (result == true) {
                          Get.offAll(MainPage(initialPage: 2));
                        } else {
                          Get.snackbar(
                            '',
                            '',
                            backgroundColor: 'D9435E'.toColor(),
                            icon: Icon(MdiIcons.closeCircleOutline,
                                color: Colors.white),
                            titleText: Text(
                              'Update Address Failed',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            messageText: Text(
                              (context.read<UserCubit>().state as UserLoaded)
                                  .message,
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
