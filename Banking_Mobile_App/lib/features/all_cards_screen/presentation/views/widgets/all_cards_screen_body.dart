import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/Loading_screen.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_app_button.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../add_new_card_page/presentation/add_card_page.dart';
import '../../../../navigation_screen/logic/home_screen_cubit.dart';
import '../../../../navigation_screen/presentation/home/presentation/views/widgets/bank_card_design.dart';

class AllCardsScreenBody extends StatefulWidget {
  const AllCardsScreenBody({super.key});

  @override
  State<AllCardsScreenBody> createState() => _AllCardsScreenBodyState();
}

class _AllCardsScreenBodyState extends State<AllCardsScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        if (state is HomeScreenSuccess) {
          final cards = state.homeModel.cards;
          return Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
            child: Column(
              children: [
                CustomAppBar(
                  appBarTitle: S.of(context).AllCards,
                  leftIcon: (canPop(context))
                      ? Icons.arrow_back_ios_new_outlined
                      : null,
                  onPressedLeft: (canPop(context))
                      ? () {
                          GoRouter.of(context).pop();
                        }
                      : null,
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return BankCardDesign(card: card);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomAppButton(
                    title: S.of(context).AddCard,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddCardScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomeScreenError) {
          return ErrorScreen(message: state.message);
        } else {
          return const LoadingScreen();
        }
      },
    );
  }

  bool canPop(BuildContext context) => GoRouter.of(context).canPop();
}
