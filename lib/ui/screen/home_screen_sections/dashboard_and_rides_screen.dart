import 'package:escooter_admin/blocs/dashboard_count/dashboard_count_bloc.dart';
import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:escooter_admin/ui/widgets/rider_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAndRidesScreen extends StatefulWidget {
  const DashboardAndRidesScreen({super.key});

  @override
  State<DashboardAndRidesScreen> createState() =>
      _DashboardAndRidesScreenState();
}

class _DashboardAndRidesScreenState extends State<DashboardAndRidesScreen> {
  DashboardCountBloc dashboardCountBloc = DashboardCountBloc();

  @override
  void initState() {
    dashboardCountBloc.add(DashboardCountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCountBloc>.value(
      value: dashboardCountBloc,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<DashboardCountBloc, DashboardCountState>(
                listener: (context, state) {
                  if (state is DashboardCountFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Failed',
                        message: state.message,
                        primaryButtonLabel: 'Ok',
                        primaryOnPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return state is DashboardCountSuccessState
                      ? Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            DashboardCard(
                              label: 'Total users',
                              title: state.dashbordCount['profiles'],
                              icon: Icons.people_outline,
                            ),
                            DashboardCard(
                              label: 'Total Scooters',
                              title: state.dashbordCount['scooters'],
                              icon: Icons.electric_moped_outlined,
                            ),
                            DashboardCard(
                              label: 'Total Hubs',
                              title: state.dashbordCount['hubs'],
                              icon: Icons.hub_outlined,
                            ),
                          ],
                        )
                      : state is DashboardCountLoadingState
                          ? const Center(
                              child: CustomProgressIndicator(),
                            )
                          : const SizedBox();
                },
              ),
              const Divider(
                height: 40,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Today\'s Rides',
                  style: GoogleFonts.notoSans(
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List<Widget>.generate(
                      10,
                      (index) => const RidesCard(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label, title;
  final IconData icon;
  const DashboardCard({
    super.key,
    required this.label,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
