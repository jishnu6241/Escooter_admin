import 'package:escooter_admin/blocs/withdraw_request/withdraw_request_bloc.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:escooter_admin/ui/widgets/withdraw_request_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawRequestScreen extends StatefulWidget {
  const WithdrawRequestScreen({super.key});

  @override
  State<WithdrawRequestScreen> createState() => _WithdrawRequestScreenState();
}

class _WithdrawRequestScreenState extends State<WithdrawRequestScreen> {
  String status = 'pending';

  WithdrawRequestBloc withdrawRequestBloc = WithdrawRequestBloc();

  void getRequests() {
    withdrawRequestBloc.add(
      GetAllWithdrawRequestEvent(
        status: status,
      ),
    );
  }

  @override
  void initState() {
    getRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WithdrawRequestBloc>.value(
      value: withdrawRequestBloc,
      child: BlocConsumer<WithdrawRequestBloc, WithdrawRequestState>(
        listener: (context, state) {
          if (state is WithdrawRequestFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getRequests();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoSlidingSegmentedControl(
                    backgroundColor: Colors.green[50]!,
                    thumbColor: Colors.black,
                    groupValue: status,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    children: {
                      'pending': Text(
                        'Pending',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      'paid': Text(
                        'Withdrawed',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    },
                    onValueChanged: (value) {
                      status = value!;
                      setState(() {});
                    },
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is WithdrawRequestSuccessState
                        ? state.requests.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.requests.length,
                                    (index) => WithdrawRequestCard(
                                      withdrawRequestBloc: withdrawRequestBloc,
                                      withdrawRequest: state.requests[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No requests found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
