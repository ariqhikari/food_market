part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  User user;
  File pictureFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Sign Up',
      subTitle: 'Register and eat',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Photo
            GestureDetector(
              onTap: () async {
                PickedFile pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  pictureFile = File(pickedFile.path);
                  setState(() {});
                }
              },
              child: Center(
                child: Container(
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
                      image: (pictureFile == null)
                          ? DecorationImage(
                              image: AssetImage('assets/photo.png'),
                            )
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(pictureFile),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            // * Full Name
            Text('Full Name', style: blackFontStyle2),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyle,
                  hintText: 'Type your full name',
                ),
              ),
            ),
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
                    hintText: 'Type your email address'),
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
            // * Continue Button
            Container(
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,
                color: mainColor,
                child: Text(
                  'Continue',
                  style: blackFontStyle3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  Get.to(AddressPage(
                    User(
                      name: nameController.text,
                      email: emailController.text,
                    ),
                    passwordController.text,
                    pictureFile,
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
