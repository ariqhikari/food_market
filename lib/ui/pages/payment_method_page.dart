part of 'pages.dart';

class PaymentMethodPage extends StatelessWidget {
  final String paymentURL;

  PaymentMethodPage(this.paymentURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IllustrationPage(
        title: 'Finish Your Payment',
        subTitle: 'Please select your favourite\npayment method',
        picturePath: 'assets/payment.png',
        buttonTitle1: 'Payment Method',
        buttonTap1: () async {
          await launch(paymentURL);
        },
        buttonTitle2: 'Go To Success Page',
        buttonSubTitle2: 'Continue?',
        buttonTap2: () {
          Get.to(SuccessOrderPage());
        },
      ),
    );
  }
}
