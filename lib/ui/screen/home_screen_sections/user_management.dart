import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class UserManagementSection extends StatelessWidget {
  const UserManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "USER MANAGEMENT",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: DataTable2(
              columns: [
                DataColumn2(
                  label: Align(
                    child: Text(
                      "Name",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Align(
                    child: Text(
                      "Email",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Align(
                    child: Text(
                      "Phone Number",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                DataColumn2(
                  label: Align(
                    child: Text(
                      "ID Proof",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(
                    "Status",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  size: ColumnSize.S,
                ),
              ],
              rows: List<DataRow2>.generate(
                10,
                (index) => DataRow2(
                  cells: [
                    DataCell(
                      Text("Vishal"),
                    ),
                    DataCell(
                      Text("vishalvv122001@gmail.com"),
                    ),
                    DataCell(
                      Text("9744127828"),
                    ),
                    DataCell(
                      Text("123xxxxx"),
                    ),
                    DataCell(
                      Text("Active"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
