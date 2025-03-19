import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<List<dynamic>>? csvData;
  Future<List<List<dynamic>>> processCsv(context) async {
    var result =
        await DefaultAssetBundle.of(context).loadString("files/orders.csv");
    return const CsvToListConverter().convert(result, eol: '\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: csvData == null
                  ? Container()
                  : DataTable(
                      columns: csvData![0]
                          .map((item) =>
                              DataColumn(label: Text(item.toString())))
                          .toList(),
                      rows:
                          List<DataRow>.generate(csvData!.length - 1, (index) {
                        return DataRow(
                            cells: csvData![index + 1]
                                .map((item) => DataCell(Text(item.toString())))
                                .toList());
                      })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        csvData = await processCsv(context);
        setState(() {

        });
      },
      child: const Icon(Icons.table_bar),),
    );
  }
}
