import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class UserManagementSection extends StatelessWidget {
  const UserManagementSection({super.key});

  get searchController => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "USER MANAGEMENT",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  width: 200,
                ),
                SizedBox(
                  width: 600,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 6, top: 6),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "Search",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
