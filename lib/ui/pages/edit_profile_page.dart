part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File pictureFile;
  bool isLoading = false;

  TextEditingController nameController;
  TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user.name);
    emailController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user.email);
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Edit Profile',
      subTitle: 'Edit your profile',
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (pictureFile == null)
                              ? NetworkImage((context.read<UserCubit>().state
                                      as UserLoaded)
                                  .user
                                  .picturePath)
                              : FileImage(pictureFile),
                        )),
                  ),
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
              child: AbsorbPointer(
                child: TextField(
                  controller: emailController,
                  style: greyFontStyle,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: greyFontStyle,
                      hintText: 'Type your email address'),
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
            // * Update Profile Button
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
                                .copyWith(name: nameController.text);

                        setState(() {
                          isLoading = true;
                        });

                        bool result = await context
                            .read<UserCubit>()
                            .updateProfile(user, pictureFile: pictureFile);

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
                              'Update Profile Failed',
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
