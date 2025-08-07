
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_kobe/pages/home_page.dart';
import '../themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';


PreferredSizeWidget appBarWidget(BuildContext context,
    {bool isSecondPage = false}) {
  return AppBar(
    toolbarHeight: kToolbarHeight * 2.2,
    backgroundColor: AppColors.appBarColor,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    leading: Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          if (currentRoute == HomePage.routeId) return;
          Navigator.pop(context);
        },
        child: Icon(
          isSecondPage ? Icons.arrow_back : Icons.menu,
          color: AppColors.white,
        ),
      ),
    ),
    actions: [
      Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(right: 16),
        child: Icon(
          Icons.person,
          color: AppColors.white,
        ),
      ),
    ],
    flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 13.98),
                child: Icon(Icons.menu_outlined, color: AppColors.white),
              ),
              Column(
                children: [
                  Image.asset('assets/images/logo.png', width: 115, height: 76.99),
                  Text('RICK AND MORTY API',style: GoogleFonts.lato( 
                        color: AppColors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.98),
                child: Image.asset('assets/images/trailing-icon.png', width: 31.46, height: 31.46),
              ),
            ],
          ),
        ),
      ),
    );
    }
  
