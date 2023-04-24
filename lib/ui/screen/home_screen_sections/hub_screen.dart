import 'package:escooter_admin/blocs/hub/hub_bloc.dart';
import 'package:escooter_admin/ui/widgets/add_edit_hub_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_button.dart';
import 'package:escooter_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:escooter_admin/ui/widgets/custom_search.dart';
import 'package:escooter_admin/ui/widgets/hub_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  HubBloc hubBloc = HubBloc();

  String? query;

  void getHubs() {
    hubBloc.add(GetAllHubEvent(
      query: query,
    ));
  }

  @override
  void initState() {
    getHubs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HubBloc>.value(
      value: hubBloc,
      child: BlocConsumer<HubBloc, HubState>(
        listener: (context, state) {
          if (state is HubFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getHubs();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomSearch(
                          onSearch: (search) {
                            query = search;
                            getHubs();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomButton(
                          label: 'Add Hub',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddEditHubDialog(
                                hubBloc: hubBloc,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is HubSuccessState
                        ? state.hubs.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.hubs.length,
                                    (index) => HubCard(
                                      hubBloc: hubBloc,
                                      hubDetails: state.hubs[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No hubs found.'))
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
