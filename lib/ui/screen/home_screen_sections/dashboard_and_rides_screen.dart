import 'package:escooter_admin/ui/widgets/custom_card.dart';
import 'package:escooter_admin/ui/widgets/rider_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAndRidesScreen extends StatefulWidget {
  const DashboardAndRidesScreen({super.key});

  @override
  State<DashboardAndRidesScreen> createState() =>
      _DashboardAndRidesScreenState();
}

class _DashboardAndRidesScreenState extends State<DashboardAndRidesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                DashboardCard(
                  label: 'Total users',
                  title: '20',
                  icon: Icons.people_outline,
                ),
                DashboardCard(
                  label: 'Total Scooters',
                  title: '100',
                  icon: Icons.electric_moped_outlined,
                ),
                DashboardCard(
                  label: 'Total Hubs',
                  title: '30',
                  icon: Icons.hub_outlined,
                ),
              ],
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
