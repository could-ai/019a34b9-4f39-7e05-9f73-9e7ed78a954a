import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'awel t36 Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      home: const HeadphoneControlScreen(),
    );
  }
}

class HeadphoneControlScreen extends StatefulWidget {
  const HeadphoneControlScreen({super.key});

  @override
  State<HeadphoneControlScreen> createState() => _HeadphoneControlScreenState();
}

class _HeadphoneControlScreenState extends State<HeadphoneControlScreen> {
  bool _isConnected = false;
  double _batteryLevel = 0.85; // 85%
  bool _isNoiseCancellationOn = true;

  void _connectDevice() {
    // Simulate connection
    setState(() {
      _isConnected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('awel t36 التحكم'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Device Image and Name
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(Icons.headphones, size: 80, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 16),
                    const Text(
                      'awel t36',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isConnected ? 'متصل' : 'غير متصل',
                      style: TextStyle(
                        fontSize: 16,
                        color: _isConnected ? Colors.greenAccent : Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Connection Button
            if (!_isConnected)
              ElevatedButton.icon(
                icon: const Icon(Icons.bluetooth_searching),
                label: const Text('الاتصال بالجهاز'),
                onPressed: _connectDevice,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            
            if (_isConnected) ...[
              // Battery Status Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نسبة البطارية',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            _getBatteryIcon(_batteryLevel),
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: _batteryLevel,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                              backgroundColor: Colors.grey[700],
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${(_batteryLevel * 100).toInt()}%',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Noise Cancellation Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: const Text(
                    'عزل الضوضاء',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  value: _isNoiseCancellationOn,
                  onChanged: (bool value) {
                    setState(() {
                      _isNoiseCancellationOn = value;
                    });
                  },
                  secondary: const Icon(Icons.hearing_disabled_outlined, size: 28),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getBatteryIcon(double level) {
    if (level > 0.9) return Icons.battery_full;
    if (level > 0.8) return Icons.battery_6_bar;
    if (level > 0.6) return Icons.battery_5_bar;
    if (level > 0.4) return Icons.battery_4_bar;
    if (level > 0.2) return Icons.battery_2_bar;
    return Icons.battery_alert;
  }
}
