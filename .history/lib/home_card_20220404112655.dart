import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glim_pay_app/app/modules/auth/controllers/index.dart';
import 'package:glim_pay_app/app/modules/core/components/money.dart';
import 'package:glim_pay_app/app/modules/core/index.dart';
import 'package:glim_pay_app/app/modules/history/controllers/history_controller.dart';
import 'package:glim_pay_app/app/modules/payaccount/controllers/payaccount_controller.dart';
import 'package:glim_pay_app/app/routes/app_pages.dart';

import '../../controllers/home_controller.dart';

class HomeCard extends GetView<HomeController> {
  HomeCard({
    Key? key,
  }) : super(key: key);

  final AuthController auth_controller = Get.find();
  final HistoryController history = Get.find();

  final AuthController auth = Get.find();
  final PayaccountController payController = Get.put(PayaccountController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(115, 120, 230, 1),
            Color.fromRGBO(115, 120, 230, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wallet Balance",
              style: Theme.of(context).textTheme.headline6!,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                      child: MoneyWidget(
                        amount: history.balance,
                        style: Theme.of(context).textTheme.headline4,
                        currency:
                            auth_controller.account.paymentConfig.currency,
                        isFloor: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                ///primary: Color.fromRGBO(38, 50, 56, 1),
                primary: Theme.of(context).primaryColorDark,
              ),
              label: Text(
                "Withdraw",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                payController.accountExists(auth.account);
                Get.toNamed(Routes.PAYACCOUNT);
              },
              icon: Image.asset(
                'assets/icons/money-withdrawal-2.png',
                height: 20,
                width: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
