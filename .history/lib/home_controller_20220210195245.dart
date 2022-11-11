import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glim_pay_app/app/modules/auth/controllers/index.dart';
import 'package:glim_pay_app/app/modules/auth/models/preference_model.dart';
import 'package:glim_pay_app/app/modules/core/models/index.dart';

import '../../auth/models/account_model.dart';
import '../models/balance_model.dart';
import '../repository/home_repository.dart';

class HomeController extends GetxController {
  HomeRepository repo = new HomeRepository();
  Rx<BalanceModel> _balance = Rx<BalanceModel>(BalanceModel());
  AuthController auth_controller = Get.find();
  BalanceModel get balance => this._balance.value;
  final _accountEnterStatus = RequestStatus.draft.obs;
  RequestStatus get accountEnterStatus => _accountEnterStatus.value;
  RxString fieldname = 'Enter PAN ID'.obs;
  RxString fieldType = 'PAN'.obs;

  RequestStatus get addMoneyStatus => _addMoneyStatus.value;

  set accountEnterStatus(accountEnterStatus) {
    _accountEnterStatus.value = accountEnterStatus;
  }

  Rx<AccountModel> _account = Rx<AccountModel>(AccountModel());
  set account(value) => this._account.value = value;

  final count = 0.obs;

  var _balanceStatus = Rx<RequestStatus>(RequestStatus.loading);

  var _cardNumberStatus = Rx<RequestStatus>(RequestStatus.success);

  final _setPreferenceStatus = RequestStatus.success.obs;

  var _addMoneyStatus = Rx<RequestStatus>(RequestStatus.draft);

  void setIdField(String field, String type) {
    fieldname.value = field;
    fieldType.value = type;
    this.account = this.auth_controller.account.copyWith(idType: type);
  }

  RxBool _cardShown = false.obs;

  RxString accountNumber = "".obs;

  RxString _locked = "".obs;

  RxString _posStatus = "".obs;

  RxString _atmStatus = "".obs;

  RxString _ecomStatus = "".obs;

  RxString _contactlessStatus = "".obs;

  RxString _posLimit = "".obs;

  RxString _atmLimit = "".obs;

  RxString _ecomLimit = "".obs;

  RxString _contactlessLimit = "".obs;

  RxBool cardNumberShown = false.obs;

  RequestStatus get balanceStatus => _balanceStatus.value;

  RequestStatus get cardNumberStatus => _cardNumberStatus.value;

  RequestStatus get setPreferenceStatus => _setPreferenceStatus.value;

  RxString _expiryDate = "".obs;

  RxString _cardNo = "".obs;

  String get posStatus => _posStatus.value;

  String get atmStatus => _atmStatus.value;

  String get ecomStatus => _ecomStatus.value;

  String get contactlessStatus => _contactlessStatus.value;

  String get posLimit => _posLimit.value;

  String get atmLimit => _atmLimit.value;

  String get ecomLimit => _ecomLimit.value;

  String get contactlessLimit => _contactlessLimit.value;

  String get expiryDate => _expiryDate.value;

  String get cardNo => _cardNo.value;

  String get locked => _locked.value;

  bool get cardShown => _cardShown.value;

  set contactlessLimit(val) => this._contactlessLimit.value = val;

  set atmLimit(val) => this._atmLimit.value = val;

  set posLimit(val) => this._posLimit.value = val;

  set ecomLimit(val) => this._ecomLimit.value = val;

  setCardShown() {
    _cardShown.value = !_cardShown.value;
  }

  setEcomStatus(String val) async {
    _ecomStatus.value = val;
  }

  setAtmStatus(String val) async {
    _atmStatus.value = val;
  }

  setPosStatus(String val) async {
    _posStatus.value = val;
  }

  setContactlessStatus(String val) async {
    _contactlessStatus.value = val;
  }

  fetchCard(AccountModel account) async {
    try {
      _cardNumberStatus.value = RequestStatus.loading;
      if (cardNumberShown.value == false) {
        String fullCardNo = await repo.getCardList(account.uid);
        _cardNo.value = fullCardNo;
        cardNumberShown.value = true;
      } else {
        _cardNo.value = account.card.cardNo;
        cardNumberShown.value = false;
      }
      _cardNumberStatus.value = RequestStatus.success;
    } catch (e) {
      _cardNo.value = account.card.cardNo;
      _cardNumberStatus.value = RequestStatus.success;
      throw new Exception("No account found");
    }
  }

  setPreferences() async {
    try {
      _setPreferenceStatus.value = RequestStatus.loading;
      print(_setPreferenceStatus.value);
      PreferenceModel pref = auth_controller.account.pref.copyWith(
        atm: this.atmStatus,
        pos: this.posStatus,
        ecom: this.ecomStatus,
        contactless: this.contactlessStatus,
        atmLimit: this.atmLimit,
        posLimit: this.posLimit,
        ecomLimit: this.ecomLimit,
        contactlessLimit: this.contactlessLimit,
      );

      await repo.setPreference(pref);
      print(_setPreferenceStatus.value);
      _setPreferenceStatus.value = RequestStatus.success;
    } catch (e) {
      _setPreferenceStatus.value = RequestStatus.success;
      throw new Exception("Unable to set preference");
    }
  }

  addMoney(AccountModel account, double amount) async {
    try {
      _addMoneyStatus.value = RequestStatus.loading;
      await repo.addMoney(account, amount: amount);
      _addMoneyStatus.value = RequestStatus.success;
      await Get.to(TransferSuccessDialog());
    } catch (e) {
      _addMoneyStatus.value = RequestStatus.error;
      throw new Exception("Add money failed");
    }
  }

  lockCard(AccountModel account) async {
    try {
      await repo.lock(account.uid);
      _locked.value = "L";
    } catch (e) {
      throw new Exception("Lock Card failed");
    }
  }

  unlockCard(AccountModel account) async {
    try {
      await repo.unlock(account.uid);
      _locked.value = "UL";
    } catch (e) {
      throw new Exception("Add money failed");
    }
  }

  fetchBalance(AccountModel account) async {
    try {
      _balanceStatus.value = RequestStatus.loading;
      BalanceModel payaccount = await repo.getBalance(account.uid);
      _balance.value = payaccount;
      _balanceStatus.value = RequestStatus.success;
    } catch (e) {
      _balanceStatus.value = RequestStatus.loading;
      throw new Exception("No account found");
    }
  }

  reload(AccountModel account) async {
    _atmStatus.value = account.pref.atm;
    _posStatus.value = account.pref.pos;
    _ecomStatus.value = account.pref.ecom;
    _contactlessStatus.value = account.pref.contactless;

    _atmLimit.value = account.pref.atmLimit;
    _posLimit.value = account.pref.posLimit;
    _ecomLimit.value = account.pref.ecomLimit;

    _locked.value = account.card.locked;
    _cardNo.value = account.card.cardNo;
    var parts = account.card.expiryDate.split("/");
    if (parts.length > 2) {
      _expiryDate.value = (parts[0] + "/" + parts[2].substring(0, 2));
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

class TransferSuccessDialog extends StatelessWidget {
  const TransferSuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
            size: 40,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "Transfer has been successfully processed!",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 250,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () async {
            Get.back();
          },
          label: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              // Replace with a Row for horizontal icon + text
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
