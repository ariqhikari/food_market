part of 'pages.dart';

class GeneralPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onBackButtonPressed;
  final Widget child;
  final Color backColor;

  GeneralPage({
    this.title = 'Title',
    this.subTitle = 'Sub Title',
    this.onBackButtonPressed,
    this.child,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        body: Container(
          color: backColor ?? Colors.white,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        onBackButtonPressed != null
                            ? GestureDetector(
                                onTap: () {
                                  onBackButtonPressed();
                                },
                                child: Container(
                                  width: defaultMargin,
                                  height: defaultMargin,
                                  margin: EdgeInsets.only(right: 26),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/back_arrow.png'),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: blackFontStyle1),
                            Text(
                              subTitle,
                              style: greyFontStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: defaultMargin,
                    color: 'FAFAFC'.toColor(),
                  ),
                  child ?? SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
