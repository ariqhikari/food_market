part of 'pages.dart';

class IllustrationPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final String picturePath;
  final String buttonTitle1;
  final String buttonTitle2;
  final String buttonSubTitle2;
  final Function buttonTap1;
  final Function buttonTap2;

  IllustrationPage({
    @required this.title,
    @required this.subTitle,
    @required this.picturePath,
    @required this.buttonTitle1,
    this.buttonTitle2,
    this.buttonSubTitle2,
    @required this.buttonTap1,
    this.buttonTap2,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 150
                      : 75,
                  bottom: 50),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(picturePath)),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: blackFontStyle3.copyWith(fontSize: 20),
            ),
            SizedBox(height: 6),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: greyFontStyle.copyWith(fontWeight: FontWeight.w300),
            ),
            Container(
              width: 200,
              height: 45,
              margin: EdgeInsets.only(top: 30, bottom: 20),
              child: RaisedButton(
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: mainColor,
                child: Text(
                  buttonTitle1,
                  style: blackFontStyle3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  if (buttonTap1 != null) {
                    buttonTap1();
                  }
                },
              ),
            ),
            (buttonTitle2 != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buttonSubTitle2 ?? 'Subtitle 2',
                        style: greyFontStyle,
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          if (buttonTap2 != null) {
                            buttonTap2();
                          }
                        },
                        child: Text(buttonTitle2 ?? 'Title 2',
                            style: mainFontStyle),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 75),
          ],
        ),
      ],
    );
  }
}
