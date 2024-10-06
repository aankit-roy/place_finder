import 'package:flutter/material.dart';

class AppColors {
  // Primary Color (used for app bars, buttons, etc.)
  static const Color primaryColor = Color(0xFF6200EE); // Deep Purple

  // Accent or Secondary Color (used for highlighting)
  static const Color accentColor = Color(0xFF03DAC5); // Teal

  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light Gray
  static const Color cardColor = Color(0xFFFFFFFF); // White for cards or containers
  static const Color whiteColor = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textColor = Color(0xFF212121); // Almost Black for readability
  static const Color secondaryTextColor = Color(0xFF757575); // Grey for less emphasized text
  static const Color errorColor = Color(0xFFB00020); // Red for errors

  // Button Colors
  static const Color buttonColor = primaryColor; // Same as primary color for consistency
  static const Color buttonTextColor = Color(0xFFFFFFFF); // White for contrast on buttons

  // Icon Colors
  static const Color iconColor = Color(0xFF424242); // Dark gray for icons
  static const Color selectedIconColor = primaryColor; // Primary color for selected state

  // Divider Color
  static const Color dividerColor = Color(0xFFBDBDBD); // Light Gray for dividers

  // Input Field Colors
  static const Color inputFieldBackground = Color(0xFFF2F2F2); // Light background for input fields
  static const Color inputFieldBorder = Color(0xFF9E9E9E); // Neutral gray for borders
  static const Color inputFieldFocusedBorder = primaryColor; // Highlighted border for active field

  // Scaffold Background (for the overall app background)
  static const Color scaffoldBackgroundColor = Color(0xFFF5F5F5); // Light Gray

  // Shadow Color
  static const Color shadowColor = Color(0x29000000); // Light transparent black for shadows

  // Success and Warning Colors
  static const Color successColor = Color(0xFF4CAF50); // Green for success messages
  static const Color warningColor = Color(0xFFFFC107); // Amber for warnings
}