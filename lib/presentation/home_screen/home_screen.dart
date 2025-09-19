import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soldepay/models/card_balance.dart';
import 'package:soldepay/models/card_transaction.dart';
import 'package:soldepay/routes/app_routes.dart';
import 'package:soldepay/services/user_service.dart';
import 'package:soldepay/services/virtual_card_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? firstName;
  String? lastName;
  String? email;
  CardBalance? balance;
  bool isLoadingBalance = true;
  bool isTransactionLoading = true;
  List<CardTransaction> transactions = [];
  bool hasCheckedEmptyTransactions = true;

  final List<String> actionButtons = ['Add Money', 'Cards', 'Transactions'];
  final _virtualCardService = VirtualCardService();

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
    _loadBalance();
    _loadTransactions();
  }

  void _loadBalance() async {
    setState(() {
      isLoadingBalance = true;
    });

    CardBalance fetchCardBalance = await _virtualCardService.fetchCardBalance();
    setState(() {
      balance = fetchCardBalance;
      isLoadingBalance = false;
    });
  }

  void _loadTransactions() async {
    setState(() {
      isTransactionLoading = true;
      hasCheckedEmptyTransactions = false;
    });

    try {
      List<CardTransaction> fetchCardTransAction =
          await _virtualCardService.fetchCardTransactions();

      setState(() {
        transactions = fetchCardTransAction;
        isTransactionLoading = false;
        hasCheckedEmptyTransactions = true;
      });
    } catch (e) {
      print("Error fetching transactions: $e");
      setState(() {
        transactions = [];
        isTransactionLoading = false;
        hasCheckedEmptyTransactions = true;
      });
    }
  }

  void _loadRememberedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      email = prefs.getString('email') ?? '';
    });

    debugPrint("Saved user info: $firstName $lastName, Email: $email");
  }

  void _handleLogout() async {
    try {
      await UserService().logout();
      Navigator.of(context).pushNamed(AppRoutes.loginScreen);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 249, 249),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 200),
              child: _buildMainContent(),
            ),
            _buildBottomNavigationOverlay(),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        const SizedBox(height: 72),
        _buildAppBar(context),
        const SizedBox(height: 24),
        _buildBalanceCard(),
        const SizedBox(height: 16),
        _buildTransactionHistory(),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromARGB(255, 119, 158, 221),
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ${firstName ?? ''},',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.notifications, color: Colors.black),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'settings') {
                    Navigator.pushNamed(context, '/settings');
                  } else if (value == 'logout') {
                    _handleLogout(); // Call logout
                  }
                },
                icon: const Icon(Icons.more_vert, color: Colors.black),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Account Settings'),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Color(0xFFBE7A85), Color(0xFF3418A1)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total balance',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            isLoadingBalance
                ? 'Loading...'
                : "\$${balance?.amount.toStringAsFixed(2) ?? '0.00'}",
            style: const TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(actionButtons.length, (index) {
              IconData icon;
              VoidCallback? onTap;

              switch (actionButtons[index]) {
                case 'Add Money':
                  icon = Icons.attach_money;
                  onTap = () => Navigator.pushNamed(
                      context, AppRoutes.addMoneyScreen_mtn_momo);
                  break;
                case 'Cards':
                  icon = Icons.credit_card;
                  onTap = () =>
                      Navigator.pushNamed(context, AppRoutes.virtualCardScreen);
                  break;
                case 'Transactions':
                  icon = Icons.history;
                  onTap = () => Navigator.pushNamed(
                      context, AppRoutes.transactionsScreen);
                  break;
                default:
                  icon = Icons.star;
              }

              return GestureDetector(
                onTap: onTap,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(icon, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      actionButtons[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildSectionHeader('Transaction history', _onSeeAllTransactionsTap),
          const SizedBox(height: 16),
          isTransactionLoading
              ? const Center(child: CircularProgressIndicator())
              : transactions.isEmpty && hasCheckedEmptyTransactions
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          "No transactions found.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  : Column(
                      children: transactions.map((txn) {
                        return ListTile(
                          leading: Icon(
                            txn.amount >= 0
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: txn.amount >= 0 ? Colors.green : Colors.red,
                          ),
                          title: Text(txn.description),
                          subtitle: Text(
                            "${txn.status} • ${txn.date.toLocal().toString().split(' ')[0]}",
                          ),
                          trailing: Text(
                            "\$${txn.amount.toStringAsFixed(2)}",
                            style: TextStyle(
                              color:
                                  txn.amount >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
          const SizedBox(height: 128),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        GestureDetector(
          onTap: onTap,
          child: const Text('See All', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 56,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF252323),
            borderRadius: BorderRadius.circular(34),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: _buildNavItem(Icons.home, active: true, onTap: () {})),
              Expanded(
                  child: _buildNavItem(Icons.credit_card, onTap: () {
                Navigator.pushNamed(context, AppRoutes.virtualCardScreen);
              })),
              Expanded(
                  child: _buildNavItem(Icons.upload_file,
                      onTap: _goToDocumentUpload)),
              Expanded(
                  child: _buildNavItem(Icons.add_card,
                      onTap: _goToCreateVirtualCard)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon,
      {bool active = false, double? width, VoidCallback? onTap}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = width ?? screenWidth * 0.13;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: itemWidth,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(
          horizontal: itemWidth * 0.3,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: active ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: active ? Colors.white : Colors.black54,
          size: itemWidth * 0.3,
        ),
      ),
    );
  }

  // Actions
  void _onSeeAllRecentTap() {}
  void _onSeeAllTransactionsTap() {}

  void _goToDocumentUpload() {
    Navigator.pushNamed(context, AppRoutes.documentUploadScreen);
  }

  void _goToCreateVirtualCard() {
    Navigator.pushNamed(context, AppRoutes.virtualCardPaymentScreen);
  }
}

extension on String {
  toLocal() {}
}
