import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_kobe/pages/home_page.dart';
import '../themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget appBarWidget(
  BuildContext context, {
  bool isSecondPage = false,
}) {
  return AppBar(
    toolbarHeight: 130.92,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 12.23, left: 12.23),
          child: Icon(
            isSecondPage ? Icons.arrow_back : Icons.menu,
            color: AppColors.white,
          ),
        ),
      ),
    ),
    flexibleSpace: SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 115, height: 76.99),
              Text(
                'RICK AND MORTY API',
                style: GoogleFonts.lato(
                  color: AppColors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.23, top: 12.23),
              child: Image.asset(
                'assets/images/trailing-icon.png',
                width: 31.46,
                height: 31.46,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
