import 'package:flutter/material.dart';

class Subscription {
  final String title;
  final String monthlyPrice;
  final String yearlyPrice;
  final String description;
  final String duration;
  final int numberOfFeatures;

  Subscription(this.title, this.monthlyPrice, this.yearlyPrice,
      this.description, this.duration, this.numberOfFeatures);
}

class SubscriptionPlans extends StatelessWidget {
  final List<Subscription> subscriptions = [
    Subscription("Silver", "5 USD/month", "50 USD/year", "Enhanced features",
        "1 month", 10),
    Subscription("Gold", "10 USD/month", "100 USD/year",
        "Premium access to all features", "3 months", 15),
    Subscription("Platinum", "15 USD/month", "150 USD/year",
        "Exclusive benefits", "6 months", 20),
  ];

  SubscriptionPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose a Subscription Plan',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: subscriptions.map((subscription) {
                  return SubscriptionCard(subscription: subscription);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  SubscriptionCard({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSubscriptionDetails(context);
      },
      child: Card(
        color: Colors.white70,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.star,
                color: Colors.deepPurple,
                size: 40.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                subscription.title,
                style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Monthly: ${subscription.monthlyPrice}',
                style: const TextStyle(fontSize: 20.0, color: Colors.black87),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Yearly: ${subscription.yearlyPrice}',
                style: const TextStyle(fontSize: 20.0, color: Colors.black87),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Duration: ${subscription.duration}',
                style: const TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Features: ${subscription.numberOfFeatures} features',
                style: const TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
              const SizedBox(height: 10.0),
              Text(
                subscription.description,
                style: const TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
              const SizedBox(height: 10.0),
              Tooltip(
                message: 'Subscribe to ${subscription.title}',
                child: ElevatedButton(
                  onPressed: () {
                    _handleSubscriptionPurchase(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                  ),
                  child: const Text('Subscribe',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubscriptionDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SubscriptionDetails(subscription: subscription)),
    );
  }

  void _handleSubscriptionPurchase(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text('Processing subscription...'),
          ],
        ),
      ),
    );

    // Simulate a delay for subscription processing (replace with actual logic)
    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Subscription ${subscription.title} successful!'),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }
}

class SubscriptionDetails extends StatefulWidget {
  final Subscription subscription;

  SubscriptionDetails({required this.subscription});

  @override
  _SubscriptionDetailsState createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  bool showMonthly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/background.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.star,
                color: Colors.deepPurple,
                size: 40.0,
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.subscription.title,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              Text(
                showMonthly
                    ? 'Monthly: ${widget.subscription.monthlyPrice}'
                    : 'Yearly: ${widget.subscription.yearlyPrice}',
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Duration: ${widget.subscription.duration}',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Features: ${widget.subscription.numberOfFeatures} features',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.subscription.description,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _handleSubscriptionPurchase(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                ),
                child: const Text('Subscribe',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showMonthly = !showMonthly;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                child: Text(showMonthly ? 'Show Yearly' : 'Show Monthly',
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubscriptionPurchase(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text('Processing subscription...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Subscription ${widget.subscription.title} successful!'),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }
}
