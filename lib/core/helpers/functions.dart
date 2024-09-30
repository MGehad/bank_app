import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

import '../../features/navigation_screen/data/models/card_model.dart';
import '../../features/transaction_history/data/models/transaction_item_model.dart';
import '../styles/colors.dart';

class Functions {
  static List<String> getDateLastSixMonths() {
    DateTime now = DateTime.now();
    List<String> months = [];

    for (int i = 5; i >= 0; i--) {
      DateTime month = DateTime(now.year, now.month - i);
      months.add(DateFormat.MMM().format(month));
    }

    return months;
  }

  static String getCurrentMonth() {
    return DateFormat.MMM().format(DateTime.now());
  }

  static double getMaxBalance(List<double> last6MonthsBalance) {
    if (last6MonthsBalance.isEmpty) return 0;
    return last6MonthsBalance.reduce((a, b) => a > b ? a : b);
  }


  static Icon getTransactionIcon(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.spotify:
        return const Icon(
          FontAwesomeIcons.spotify,
          color: AppColors.green47,
        );
      case TransactionType.appleStore:
        return const Icon(FontAwesomeIcons.apple);
      case TransactionType.moneyTransfer:
        return const Icon(FontAwesomeIcons.moneyBillTransfer);
      case TransactionType.paypal:
        return const Icon(FontAwesomeIcons.paypal);
      case TransactionType.amazonPay:
        return const Icon(FontAwesomeIcons.amazonPay);
      case TransactionType.googlePlay:
        return const Icon(FontAwesomeIcons.googlePlay);
      case TransactionType.grocery:
        return const Icon(Icons.shopping_cart_outlined);
      case TransactionType.netflix:                            // New case for Netflix
        return const Icon(Icons.tv);
      case TransactionType.uber:                               // New case for Uber
        return const Icon(Icons.directions_car);
      case TransactionType.waterBill:                          // New case for Water Bill
        return const Icon(Icons.water);
      case TransactionType.homeInternet:                       // New case for Home Internet
        return const Icon(Icons.router);
      case TransactionType.mobileBill:                         // New case for Mobile Bill
        return const Icon(Icons.phone_android);
      case TransactionType.mobileRecharge:                     // New case for Mobile Recharge
        return const Icon(Icons.mobile_friendly);
      case TransactionType.socialInsurance:                    // New case for Social Insurance
        return const Icon(Icons.family_restroom);
      case TransactionType.fawryPay:                           // New case for Fawry Pay
        return const Icon(Icons.payment);
      case TransactionType.landline:                            // New case for Landline
        return const Icon(Icons.call);
      case TransactionType.electricity:                        // New case for Electricity
        return const Icon(Icons.electric_bolt);
      case TransactionType.financeAndBanks:                    // New case for Finance and Banks
        return const Icon(Icons.account_balance);
      case TransactionType.donations:                           // New case for Donations
        return const Icon(Icons.volunteer_activism);
      case TransactionType.games:                               // New case for Games
        return const Icon(Icons.gamepad);
      case TransactionType.gas:                                 // New case for Gas
        return const Icon(Icons.local_fire_department);
      case TransactionType.tickets:                             // New case for Tickets
        return const Icon(Icons.confirmation_num);
      case TransactionType.microfinance:                        // New case for Microfinance
        return const Icon(Icons.attach_money);
      case TransactionType.education:                           // New case for Education
        return const Icon(Icons.school);
      case TransactionType.saveGaza:                            // New case for Save Gaza
        return const Icon(Icons.flag);
      case TransactionType.dailyWaste:                          // New case for Daily Waste
        return const Icon(Icons.delete);
      case TransactionType.payments:                            // New case for Payments
        return const Icon(Icons.money);
      case TransactionType.unions:                              // New case for Unions
        return const Icon(Icons.badge);
      default:
        return const Icon(FontAwesomeIcons.moneyBillTransfer);
    }
  }



  static String getTransactionTitle(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.spotify:
        return "Spotify";
      case TransactionType.appleStore:
        return "Apple Store";
      case TransactionType.moneyTransfer:
        return "Money Transfer";
      case TransactionType.grocery:
        return "Grocery";
      case TransactionType.googlePlay:
        return "Google Play";
      case TransactionType.amazonPay:
        return "Amazon Pay";
      case TransactionType.paypal:
        return "Paypal";
      case TransactionType.netflix:                            // New case for Netflix
        return "Netflix";
      case TransactionType.uber:                               // New case for Uber
        return "Uber";
      case TransactionType.waterBill:                          // New case for Water Bill
        return "Water Bill";
      case TransactionType.homeInternet:                       // New case for Home Internet
        return "Home Internet";
      case TransactionType.mobileBill:                         // New case for Mobile Bill
        return "Mobile Bill";
      case TransactionType.mobileRecharge:                     // New case for Mobile Recharge
        return "Mobile Recharge";
      case TransactionType.socialInsurance:                    // New case for Social Insurance
        return "Social Insurance";
      case TransactionType.fawryPay:                           // New case for Fawry Pay
        return "Fawry Pay";
      case TransactionType.landline:                            // New case for Landline
        return "Landline";
      case TransactionType.electricity:                        // New case for Electricity
        return "Electricity";
      case TransactionType.financeAndBanks:                    // New case for Finance and Banks
        return "Finance and Banks";
      case TransactionType.donations:                           // New case for Donations
        return "Donations";
      case TransactionType.games:                               // New case for Games
        return "Games";
      case TransactionType.gas:                                 // New case for Gas
        return "Gas";
      case TransactionType.tickets:                             // New case for Tickets
        return "Tickets";
      case TransactionType.microfinance:                        // New case for Microfinance
        return "Microfinance";
      case TransactionType.education:                           // New case for Education
        return "Education";
      case TransactionType.saveGaza:                            // New case for Save Gaza
        return "Save Gaza";
      case TransactionType.dailyWaste:                          // New case for Daily Waste
        return "Daily Waste";
      case TransactionType.payments:                            // New case for Payments
        return "Payments";
      case TransactionType.unions:                              // New case for Unions
        return "Unions";
      default:
        return "Money Transfer";
    }
  }

  static String getTransactionSubTitle(TransactionType transactionType) {
    switch (transactionType) {
    // قسم الترفيه
      case TransactionType.spotify:
      case TransactionType.appleStore:
      case TransactionType.googlePlay:
      case TransactionType.netflix:
      case TransactionType.games:
        return "Entertainment"; // جميع خدمات الترفيه

    // قسم المرافق
      case TransactionType.waterBill:
      case TransactionType.electricity:
      case TransactionType.gas:
      case TransactionType.dailyWaste:
        return "Utilities"; // جميع خدمات المرافق

    // قسم الخدمات المالية
      case TransactionType.moneyTransfer:
      case TransactionType.paypal:
      case TransactionType.amazonPay:
      case TransactionType.financeAndBanks:
      case TransactionType.microfinance:
      case TransactionType.fawryPay:
      case TransactionType.donations:
      case TransactionType.payments:
        return "Financial Services"; // جميع خدمات المالية

    // قسم الاتصالات
      case TransactionType.homeInternet:
      case TransactionType.mobileBill:
      case TransactionType.landline:
      case TransactionType.mobileRecharge:
        return "Telecommunication"; // جميع خدمات الاتصالات

    // قسم التسوق
      case TransactionType.grocery:
        return "Shopping"; // جميع خدمات التسوق
      case TransactionType.amazonPay: // إعادة استخدام خدمات التسوق
        return "Shopping"; // إذا كنت تريد أن تتضمن خدمة أمازون أيضًا

    // قسم النقل
      case TransactionType.uber:
        return "Transport"; // خدمة النقل

      default:
        return "Transaction"; // القيمة الافتراضية
    }
  }


  static TransactionType getTransactionType(String transactionTitle) {
    switch (transactionTitle) {
      case "Spotify":
        return TransactionType.spotify;
      case "Apple Store":
        return TransactionType.appleStore;
      case "Money Transfer":
        return TransactionType.moneyTransfer;
      case "Grocery":
        return TransactionType.grocery;
      case "Google Play":
        return TransactionType.googlePlay;
      case "Amazon Pay":
        return TransactionType.amazonPay;
      case "Paypal":
        return TransactionType.paypal;
      case "Netflix":                              // New case for Netflix
        return TransactionType.netflix;
      case "Uber":                                 // New case for Uber
        return TransactionType.uber;
      case "Water Bill":                           // New case for Water Bill
        return TransactionType.waterBill;
      case "Home Internet":                        // New case for Home Internet
        return TransactionType.homeInternet;
      case "Mobile Bill":                          // New case for Mobile Bill
        return TransactionType.mobileBill;
      case "Mobile Recharge":                      // New case for Mobile Recharge
        return TransactionType.mobileRecharge;
      case "Social Insurance":                     // New case for Social Insurance
        return TransactionType.socialInsurance;
      case "Fawry Pay":                           // New case for Fawry Pay
        return TransactionType.fawryPay;
      case "Landline":                             // New case for Landline
        return TransactionType.landline;
      case "Electricity":                         // New case for Electricity
        return TransactionType.electricity;
      case "Finance and Banks":                    // New case for Finance and Banks
        return TransactionType.financeAndBanks;
      case "Donations":                            // New case for Donations
        return TransactionType.donations;
      case "Games":                                // New case for Games
        return TransactionType.games;
      case "Gas":                                  // New case for Gas
        return TransactionType.gas;
      case "Tickets":                              // New case for Tickets
        return TransactionType.tickets;
      case "Microfinance":                         // New case for Microfinance
        return TransactionType.microfinance;
      case "Education":                            // New case for Education
        return TransactionType.education;
      case "Save Gaza":                            // New case for Save Gaza
        return TransactionType.saveGaza;
      case "Daily Waste":                          // New case for Daily Waste
        return TransactionType.dailyWaste;
      case "Payments":                             // New case for Payments
        return TransactionType.payments;
      case "Unions":                               // New case for Unions
        return TransactionType.unions;
      default:
        return TransactionType.moneyTransfer;
    }
  }


  static String getCurrentDate() {
    DateTime date = DateTime.now();

    // Create a DateFormat instance
    DateFormat formatter = DateFormat('dd MMM yyyy');

    // Format the date
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static Future<double> calculateCurrentBalance(List<CardModel> cards) async {
    double currentBalance = 0;
    for (var card in cards) {
      currentBalance += card.cardBalance;
    }
    return currentBalance;
  }

  static List<TransactionItemModel> getToDayTransactions(
      List<TransactionItemModel> transactions) {
    List<TransactionItemModel> toDayTransactions = [];
    for (var trans in transactions) {
      if (trans.createdAt.day == DateTime.now().day) {
        toDayTransactions.add(trans);
      }
    }
    return toDayTransactions;
  }

  static List<TransactionItemModel> getLastDaysTransactions(
      List<TransactionItemModel> transactions, int days) {
    List<TransactionItemModel> toDayTransactions = [];
    List<DateTime> lastDaysDateTime = _getLastDaysDateTime(days);
    for (var trans in transactions) {
      for (var date in lastDaysDateTime) {
        if (trans.createdAt.day == date.day) {
          toDayTransactions.add(trans);
          break;
        }
      }
    }
    return toDayTransactions;
  }

  static List<DateTime> _getLastDaysDateTime(int days) {
    DateTime today = DateTime.now();
    List<DateTime> last7Days = [];
    if (days == 7) {
      last7Days = List.generate(
        6,
        (i) => today.subtract(
          Duration(days: i + 1),
        ),
      );
    } else {
      last7Days = List.generate(
        23,
        (i) => today.subtract(
          Duration(days: i + 7),
        ),
      );
    }

    return last7Days.reversed.toList();
  }

  static List<TransactionItemModel> searchInTransactions(
      List<TransactionItemModel> transactions, String title) {
    List<TransactionItemModel> searchResult = [];

    for (var trans in transactions) {
      if (getTransactionTitle(trans.type)
          .toLowerCase()
          .contains(title.toLowerCase())) {
        searchResult.add(trans);
      }
    }

    return searchResult;
  }

  static double getTransactionPercent(
      String type, List<TransactionItemModel> allTransactions) {
    int numOfTransactionType = 0;

    for (var trans in allTransactions) {
      if (type == getTransactionSubTitle(trans.type)) {
        numOfTransactionType++;
      }
    }

    double percent = numOfTransactionType / allTransactions.length;
    percent = (percent == 0) ? 0.00001 : percent;
    return percent * 100;
  }

  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  static IconData getNotificationIcon(String title) {
    switch (title) {
      case 'Payment Received':
        return Icons.monetization_on;
      case 'New Promotional Offer':
        return Icons.local_offer;
      default:
        return Icons.notification_important_outlined;
    }
  }

  static Future<bool> checkBiometricSupport() async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      // Check if the device supports biometric authentication
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        return false; // No biometric support at all
      }
      // Get the available biometric types
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      // Check if fingerprint is supported
      return availableBiometrics.contains(BiometricType.fingerprint) ||
          availableBiometrics.contains(BiometricType.strong);
    } catch (e) {
      return false; // Return false if any error occurs
    }
  }

  /// Get the device's current language as 'English' or 'Arabic' without using context
  static String getDeviceLanguage() {
    // Get the system locale
    Locale deviceLocale = PlatformDispatcher.instance.locale;

    // Check if the device language is Arabic ('ar'), otherwise return 'English'
    if (deviceLocale.languageCode == 'ar') {
      return 'العربية';
    } else {
      return 'English'; // Default to English for other languages
    }
  }
}
