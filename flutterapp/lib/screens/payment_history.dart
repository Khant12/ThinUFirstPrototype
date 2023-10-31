import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Payment {
  final String invoiceNumber;
  final double amount;
  final DateTime date;

  Payment(this.invoiceNumber, this.amount, this.date);
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xFF4D4DC6),
    ),
    home: PaymentHistoryPage(),
  ));
}

class PaymentHistoryPage extends StatefulWidget {
  final List<Payment> paymentHistory = [
    Payment('Invoice #001', 15000.00, DateTime(2023, 7, 1)),
    Payment('Invoice #002', 22500.00, DateTime(2023, 8, 1)),
    Payment('Invoice #003', 22500.00, DateTime(2023, 9, 3)),
    // Add more payment records as needed
  ];

  PaymentHistoryPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D4DC6),
        title: const Text('Payment History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPayments,
        child: ListView.builder(
          itemCount: widget.paymentHistory.length,
          itemBuilder: (context, index) {
            return PaymentItem(widget.paymentHistory[index],
                onTap: _viewPaymentDetails);
          },
        ),
      ),
    );
  }

  Future<void> _refreshPayments() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Update the payment history
      widget.paymentHistory.add(
        Payment('Invoice #004', 120.0, DateTime(2023, 10, 15)),
      );
    });
  }

  void _viewPaymentDetails(Payment payment) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PaymentDetailsSheet(payment);
      },
    );
  }
}

class PaymentItem extends StatelessWidget {
  final Payment payment;
  final Function(Payment) onTap;

  PaymentItem(this.payment, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title:
            Text(payment.invoiceNumber, style: const TextStyle(fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: ${formatCurrency(payment.amount, 'Ks')}', // Use Ks symbol for Kyats
              style: const TextStyle(color: Colors.blue),
            ),
            Text(
              'Date: ${DateFormat('dd/MM/yyyy').format(payment.date)}',
            ),
          ],
        ),
        onTap: () {
          onTap(payment);
        },
      ),
    );
  }
}

class PaymentDetailsSheet extends StatelessWidget {
  final Payment payment;

  PaymentDetailsSheet(this.payment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Number: ${payment.invoiceNumber}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Amount:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${formatCurrency(payment.amount, 'Ks')}', // Use Ks symbol for Kyats
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Date:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(payment.date),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Add more payment details here
        ],
      ),
    );
  }
}

String formatCurrency(double amount, String symbol) {
  final formatter = NumberFormat.currency(symbol: symbol);
  return formatter.format(amount);
}
