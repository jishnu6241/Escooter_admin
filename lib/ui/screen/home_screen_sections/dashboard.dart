import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "E scooter Admin Center",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            Wrap(
              spacing: 20,
              children: [
                CustomeDashboardBox(
                  label: "Hub",
                  amount: "100",
                  iconData: Icons.hub,
                ),
                CustomeDashboardBox(
                  label: "Scooter",
                  amount: "10000",
                  iconData: Icons.electric_moped,
                ),
                CustomeDashboardBox(
                  label: "Customers",
                  amount: "50000",
                  iconData: Icons.photo_camera_front,
                ),
                CustomeDashboardBox(
                  label: "Revenue",
                  amount: "\$ 1000000",
                  iconData: Icons.request_quote,
                ),
                CustomeDashboardBox(
                  label: "Employees",
                  amount: "2000",
                  iconData: Icons.badge,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomeDashboardBox extends StatelessWidget {
  final String label, amount;
  final IconData iconData;
  const CustomeDashboardBox({
    super.key,
    required this.label,
    required this.amount,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 170,
      child: Material(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  Icon(iconData),
                ],
              ),
              Text(
                amount,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
