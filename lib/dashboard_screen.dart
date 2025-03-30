import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isMobileMenuOpen = false;

  // Data Models
  final List<InventoryAlert> alerts = [
    InventoryAlert("Cotton Satin", "Critical low stock (50m left)", true),
    InventoryAlert("Batch #BL-2408", "Stitching delayed by vendor", false),
  ];

  final List<ProductionItem> productionItems = [
    ProductionItem("Blouse Batch #BL-2409", 75),
    ProductionItem("Nightie Batch #NT-2410", 32),
  ];

  final List<ChartData> inventoryData = [
    ChartData('Jan', 1200, 800),
    ChartData('Feb', 1900, 1200),
    ChartData('Mar', 1700, 1000),
  ];

  final List<NavItem> navItems = [
    NavItem(Icons.home, 'Dashboard'),
    NavItem(Icons.inventory, 'Raw Materials'),
    NavItem(Icons.factory, 'Production'),
    NavItem(Icons.checkroom, 'Finished Goods'),
    NavItem(Icons.local_shipping, 'Distribution'),
    NavItem(Icons.analytics, 'Reports'),
    NavItem(Icons.settings, 'Settings'),
  ];

  final List<StatCard> stats = [
    StatCard(Icons.inventory, '1,240', 'Raw Materials', Colors.blue),
    StatCard(Icons.timeline, '18', 'Active Batches', Colors.orange),
    StatCard(Icons.checkroom, '560', 'Finished Products', Colors.green),
    StatCard(Icons.warning, '5', 'Urgent Alerts', Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: const Text('Dashboard'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => setState(() => _isMobileMenuOpen = true),
              ),
            )
          : null,
      drawer: isMobile ? _buildDrawer() : null,
      body: Row(
        children: [
          if (!isMobile) _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildContentGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      color: const Color(0xFF2A5C8A),
      child: Column(
        children: [
          const SizedBox(height: 40),
          _buildLogo(),
          const SizedBox(height: 30),
          ..._buildNavItems(),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: const Color(0xFF2A5C8A),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildLogo(),
            const SizedBox(height: 30),
            ..._buildNavItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Icon(Icons.checkroom, color: Colors.white, size: 28),
          SizedBox(width: 10),
          Text(
            'TextilePro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems() {
    return navItems.map((item) {
      final index = navItems.indexOf(item);
      return ListTile(
        leading: Icon(item.icon, color: Colors.white),
        title: Text(
          item.label,
          style: const TextStyle(color: Colors.white),
        ),
        selected: _selectedIndex == index,
        selectedTileColor: Colors.white.withOpacity(0.15),
        onTap: () {
          setState(() {
            _selectedIndex = index;
            _isMobileMenuOpen = false;
          });
        },
      );
    }).toList();
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Dashboard Overview',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search inventory...',
                ),
              ),
            ),
            const SizedBox(width: 20),
            const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 2.5,
      children: stats.map((stat) {
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: stat.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(stat.icon, color: stat.color),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      stat.value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stat.label,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContentGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildAlertsCard(),
                    const SizedBox(height: 20),
                    _buildProductionCard(),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    _buildActivityCard(),
                    const SizedBox(height: 20),
                    _buildChartCard(),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              _buildAlertsCard(),
              const SizedBox(height: 20),
              _buildProductionCard(),
              const SizedBox(height: 20),
              _buildActivityCard(),
              const SizedBox(height: 20),
              _buildChartCard(),
            ],
          );
        }
      },
    );
  }

  Widget _buildAlertsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 10),
                Text(
                  'Inventory Alerts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              children: alerts.map((alert) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: alert.isCritical ? Colors.red : Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alert.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(alert.subtitle),
                            const SizedBox(height: 5),
                            const Text(
                              '2 hours ago',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductionCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.timeline, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Production Status',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              children: productionItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name),
                          Text('${item.progress}%'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      LinearProgressIndicator(
                        value: item.progress / 100,
                        backgroundColor: Colors.grey[200],
                        color: Colors.blue,
                        minHeight: 8,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard() {
    final activities = [
      ActivityItem(Icons.local_shipping, 'New shipment received', 
                  '200m Cotton Satin from ABC Fabrics', 'Today, 10:45 AM'),
      ActivityItem(Icons.task_alt, 'Quality check passed', 
                  'Batch #BL-2408 (50 blouses)', 'Today, 9:30 AM'),
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.history, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              children: activities.map((activity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(activity.icon, color: Colors.blue),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(activity.subtitle),
                            const SizedBox(height: 3),
                            Text(
                              activity.time,
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.show_chart, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Inventory Trend',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(inventoryData[value.toInt()].month),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: inventoryData.asMap().entries.map((e) {
                        return FlSpot(
                          e.key.toDouble(), 
                          e.value.rawMaterials
                        );
                      }).toList(),
                      isCurved: true,
                      color: const Color(0xFF2A5C8A),
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: inventoryData.asMap().entries.map((e) {
                        return FlSpot(
                          e.key.toDouble(), 
                          e.value.finishedGoods
                        );
                      }).toList(),
                      isCurved: true,
                      color: const Color(0xFFF5A623),
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data Models
class InventoryAlert {
  final String title;
  final String subtitle;
  final bool isCritical;

  InventoryAlert(this.title, this.subtitle, this.isCritical);
}

class ProductionItem {
  final String name;
  final int progress;

  ProductionItem(this.name, this.progress);
}

class NavItem {
  final IconData icon;
  final String label;

  NavItem(this.icon, this.label);
}

class StatCard {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  StatCard(this.icon, this.value, this.label, this.color);
}

class ActivityItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  ActivityItem(this.icon, this.title, this.subtitle, this.time);
}

class ChartData {
  final String month;
  final double rawMaterials;
  final double finishedGoods;

  ChartData(this.month, this.rawMaterials, this.finishedGoods);
}