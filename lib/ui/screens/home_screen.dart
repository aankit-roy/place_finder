import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:place_finder/model/provider/location_provider.dart';

import 'package:place_finder/ui/constants/app_colors.dart';
import 'package:place_finder/ui/screens/map_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _locationController = TextEditingController();

  String? _errorMessage;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bike.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.8),
            Colors.black.withOpacity(.3),
          ])),
          child: Padding(
            padding: EdgeInsets.all(26.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userInputText(context),
                SizedBox(height: 30.sp),
                showMeButton(provider, context),
                SizedBox(
                  height: 50.sp,
                ),
                Text(
                  "Discover a Better Place to Ride",
                  style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor),
                ),
                SizedBox(
                  height: 60.sp,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Container showMeButton(LocationProvider provider, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(colors: [
            AppColors.primaryColor,
            AppColors.accentColor,
          ])),
      child: MaterialButton(
        minWidth: double.infinity,
        child: const Text(
          "Show Me",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (_locationController.text.isEmpty) {
            setState(() {
              // _errorMessage = 'Please enter a location';
              NotificationFlushbar().show(context);
            });
          } else {
            setState(() {
              _errorMessage = null;
            });

            // Set the location in the provider
            provider.resetLocation();
            provider.location = _locationController.text;

            _navigateToNextScreen(context);
          }
        },
      ),
    );
  }

  Container userInputText(BuildContext context) {
    return Container(
      height: 40.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.sp), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: TextField(
          controller: _locationController,

          decoration: const InputDecoration(

            hintText: "Find Your Place",
            hintStyle: TextStyle(
                color: Colors.grey), // Change hint text color if needed
            // Remove the bottom underline
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: Icon(Icons.location_on,
                color: AppColors.errorColor), // Add location icon
          ),
          textInputAction: TextInputAction.done, // "Done" button on keyboard
          onSubmitted: (value) {
            // Navigate to the next screen when "Done" is pressed
            if (value.isNotEmpty) {
              _navigateToNextScreen(context);
            } else {

              NotificationFlushbar().show(context);

            }
          },
        ),
      ),
    );
  }

  Flushbar<dynamic> NotificationFlushbar() {
    return Flushbar(
                title:  "Empty",
                message:  "Please Enter you location",
                duration:  const Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                flushbarStyle: FlushbarStyle.GROUNDED,
                backgroundColor: AppColors.accentColor
            );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            child: const MapScreen(), type: PageTransitionType.bottomToTop));
  }
}
