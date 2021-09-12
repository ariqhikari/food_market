part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Sign In',
      subTitle: 'Find your best ever meal',
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Email Address
            Text('Email Address', style: blackFontStyle2),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyle,
                  hintText: 'Type your email address',
                ),
              ),
            ),
            // * Password
            Text('Password', style: blackFontStyle2),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6, bottom: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyle,
                  hintText: 'Type your password',
                ),
              ),
            ),
            // * Sign In Button
            Container(
              width: double.infinity,
              height: 45,
              margin: EdgeInsets.only(bottom: 20),
              child: isLoading
                  ? loadingIndicator
                  : RaisedButton(
                      elevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      hoverElevation: 0,
                      color: mainColor,
                      child: Text(
                        'Sign In',
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

                        await context.read<UserCubit>().signIn(
                            emailController.text, passwordController.text);
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
                              'Sign In Failed',
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
            // * Sign Up Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Start fresh now?',
                  style: greyFontStyle,
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.to(SignUpPage());
                  },
                  child: Text('Sign Up', style: mainFontStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
