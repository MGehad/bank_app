import 'package:flutter/material.dart';

import '../../../../../core/helpers/functions.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../data/models/month_model.dart';
import 'balance_chart.dart';
import 'current_balance.dart';
import 'transaction_section.dart';

class StatisticsViewBody extends StatelessWidget {
  const StatisticsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> lastSixMonthsBalance = [404, 1001, 700, 700, 110.6, 140];
    final List<String> lastSixMonthsDate = Functions.getLastSixMonths();
    const double currentBalance = 45045.58;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        children: [
          CustomAppBar(
            appBarTitle: "Statistics",
            rightIcon: Icons.notifications_none,
            onPressedRight: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const CurrentBalance(currentBalance: currentBalance),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: BalanceChart(
                      lastSixMonthsModel:
                          MonthModel.fromJsonBuildMonthModelList(
                        {
                          "lastSixMonthsDate": lastSixMonthsDate,
                          "lastSixMonthsBalance": lastSixMonthsBalance,
                        },
                      ),
                      maxBalance: Functions.getMaxBalance(lastSixMonthsBalance),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const TransactionSection()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
