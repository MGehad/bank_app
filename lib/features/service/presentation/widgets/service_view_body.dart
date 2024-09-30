import 'package:bank_app/features/service/data/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Routing/Routing.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/functions.dart';
import '../../../../core/widgets/Loading_screen.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../navigation_screen/data/models/card_model.dart';
import '../../../navigation_screen/logic/home_screen_cubit.dart';
import '../../../navigation_screen/presentation/home/presentation/views/widgets/bank_card_design.dart';
import '../../../statistics/domain/cubits/statistics_cubit/statistics_cubit.dart';
import '../../../transaction_history/data/models/transaction_item_model.dart';
import '../../domain/cubits/get_cards_cubit/get_cards_cubit.dart';
import '../../domain/cubits/get_cards_cubit/get_cards_state.dart';

import '../../domain/cubits/service_cubit/service_cubit.dart';
import '../../domain/cubits/service_cubit/service_state.dart';
import 'amount_text_field.dart';
import 'payment_id_text_field.dart';
import 'service_drop_button_list.dart';

class ServiceViewBody extends StatefulWidget {
  ServiceModel service;
   ServiceViewBody({super.key, required this.service});

  @override
  State<ServiceViewBody> createState() => _ServiceViewBodyState();
}

class _ServiceViewBodyState extends State<ServiceViewBody> {
  int selectedCardIndex = 0;
  int serviceIndex = 0;
  TextEditingController idController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  PageController pageController = PageController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ServiceCubit(),
        ),
        BlocProvider(
          create: (context) => GetCardsCubit()..getAllCards(),
        ),
      ],
      child: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, sendMoneyState) async {
          if (sendMoneyState is ServiceSuccessState) {
            BlocProvider.of<HomeScreenCubit>(context).initialize();
            BlocProvider.of<StatisticsCubit>(context).initialize();
            GoRouter.of(context).pushReplacement(
              Routing.transactionHistoryView,
            );
          }
        },
        builder: (context, sendMoneyState) {
          return BlocBuilder<GetCardsCubit, GetCardsState>(
            builder: (context, getAllCardsState) {
              if (sendMoneyState is ServiceLoadingState) {
                return const LoadingScreen();
              } else if (getAllCardsState is GetCardsFailedState) {
                return ErrorScreen(
                  message: getAllCardsState.errMessage,
                  onPressed: () => GoRouter.of(context).pop(),
                );
              } else if (sendMoneyState is ServiceFailedState) {
                return ErrorScreen(
                  message: sendMoneyState.message,
                  onPressed: () => GoRouter.of(context).pop(),
                );
              } else if (getAllCardsState is GetCardsSuccessState) {
                return Form(
                  key: formKey,
                  autovalidateMode: autoValidateMode,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: ListView(
                      children: [
                        CustomAppBar(
                          appBarTitle: "Service",
                          leftIcon: Icons.arrow_back_ios_new_outlined,
                          onPressedLeft: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 35),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 220,
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: getAllCardsState.cards.length,
                                itemBuilder: (context, index) {
                                  final CardModel card =
                                      getAllCardsState.cards[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BankCardDesign(
                                      card: CardModel(
                                        cvv: card.cvv,
                                        cardNumber: card.cardNumber,
                                        cardHolderName: card.cardHolderName,
                                        expiryDate: card.expiryDate,
                                        cardType: card.cardType,
                                      ),
                                    ),
                                  );
                                },
                                onPageChanged: (index) {
                                  setState(() {
                                    selectedCardIndex = index;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            PaymentIdTextField(
                              textController: idController,
                            ),
                            const SizedBox(height: 16),
                            AmountTextField(
                              textController: amountController,
                            ),
                            const SizedBox(height: 16),
                           Card(
                             elevation: 2.0,
                             child: Row(children: [Icon(widget.service.icon,), Text(widget.service.name)],),
                           )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomAppButton(
                            title: 'Continue',
                            onPressed: () {
                              autoValidateMode = AutovalidateMode.always;
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<ServiceCubit>(context).sendMoney(
                                  id: idController.text,
                                  transactionItem: buildTransactionItemModel(),
                                  card: getAllCardsState.cards[selectedCardIndex],
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                );
              } else {
                return const LoadingScreen();
              }
            },
          );
        },
      ),
    );
  }

  TransactionItemModel buildTransactionItemModel() {
    return TransactionItemModel(
      type: Functions.getTransactionType(
        Constants.services[serviceIndex],
      ),
      amount: -double.parse(amountController.text),
    );
  }
}
