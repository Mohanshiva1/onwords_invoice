import 'package:flutter/material.dart';
import 'package:onwords_invoice/widget/button_widget.dart';
import 'package:onwords_invoice/widget/title_widget.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'main.dart';
import 'model/customer.dart';
import 'model/invoice.dart';
import 'model/supplier.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController itermNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController vatController = TextEditingController();

  // TextEditingController nameController = TextEditingController();

  List productName = [];
  List productPrice = [];
  List productQun = [];
  List productVat = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                width: 550,
                height: 100,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Customer name'),
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Customer Address'),
                      controller: addressController,
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.white38,
                height: 600,
                width: 600,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Product name'),
                      controller: itermNameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'qun'),
                      controller: quantityController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'vat'),
                      controller: vatController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'price'),
                      controller: priceController,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            productName.add(itermNameController.text);
                            productPrice.add(priceController.text);
                            productQun.add(quantityController.text);
                            productVat.add(vatController.text);
                          });
                        },
                        child: Text("add")),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        buildRow(['Product','Quantity','Vat','Total'],isHeader: true)
                      ],
                    ),
                    SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: productName.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Table(
                                  border: TableBorder.all(),
                                  children: [
                                    buildRow([
                                      '${productName[index]}',
                                      '${productQun[index]}',
                                      '${productVat[index]}',
                                      '${productPrice[index]}',
                                    ]),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // TitleWidget(
              //   icon: Icons.picture_as_pdf,
              //   text: 'Generate Invoice',
              // ),

              const SizedBox(height: 48),

              ButtonWidget(
                text: 'Invoice PDF',
                onClicked: () async {
                  final date = DateTime.now();
                  final dueDate = date.add(Duration(days: 7));
                  final invoice = Invoice(
                    supplier: Supplier(
                      name: 'Onwords Smart Solution',
                      address: 'Pollachi, Coimbatore',
                      // paymentInfo: 'https://paypal.me/sarahfieldzz',
                    ),
                    customer: Customer(
                      name: '${nameController.text.toString()}',
                      address: '${addressController.text.toString()}',
                    ),
                    info: InvoiceInfo(
                      date: date,
                      dueDate: dueDate,
                      description: 'Description...',
                      number: '${DateTime.now().year}-9999',
                    ),
                    items: [

                  ],


                    // items: [
                    //   InvoiceItem(
                    //     description: 'Coffee',
                    //     date: DateTime.now(),
                    //     quantity: 3,
                    //     vat: 0.19,
                    //     unitPrice: 5.99,
                    //   ),
                    //   InvoiceItem(
                    //     description: 'Water',
                    //     date: DateTime.now(),
                    //     quantity: 8,
                    //     vat: 0.19,
                    //     unitPrice: 0.99,
                    //   ),
                    //   InvoiceItem(
                    //     description: 'Orange',
                    //     date: DateTime.now(),
                    //     quantity: 3,
                    //     vat: 0.19,
                    //     unitPrice: 2.99,
                    //   ),
                    //   InvoiceItem(
                    //     description: 'Apple',
                    //     date: DateTime.now(),
                    //     quantity: 8,
                    //     vat: 0.19,
                    //     unitPrice: 3.99,
                    //   ),
                    //   InvoiceItem(
                    //     description: 'Apple',
                    //     date: DateTime.now(),
                    //     quantity: 8,
                    //     vat: 0.19,
                    //     unitPrice: 3.99,
                    //   ),
                    //   InvoiceItem(
                    //     description: 'Mango',
                    //     date: DateTime.now(),
                    //     quantity: 1,
                    //     vat: 0.19,
                    //     unitPrice: 1.59,
                    //   ),
                    //   InvoiceItem(
                    //     description: 'Blue Berries',
                    //     date: DateTime.now(),
                    //     quantity: 5,
                    //     vat: 0.19,
                    //     unitPrice: 0.99,
                    //   ),
                    //   InvoiceItem(
                    //     description: 'Lemon',
                    //     date: DateTime.now(),
                    //     quantity: 4,
                    //     vat: 0.19,
                    //     unitPrice: 1.29,
                    //   ),
                    // ],
                  );

                  final pdfFile = await PdfInvoiceApi.generate(invoice);

                  PdfApi.openFile(pdfFile);
                },
              ),
            ],
          ),
        ),
      );

  TableRow buildRow(List<String> cells,{bool isHeader = false}) => TableRow(
        children: cells.map(
          (cell) {
            final style =TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            );
            return Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(cell,style: style,),
              ),
            );
          },
        ).toList(),
      );

  Widget buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: productName.length,
        itemBuilder: (context, ind) {
          return Table();
        });
  }
}
