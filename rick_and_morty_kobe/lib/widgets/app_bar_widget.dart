
import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBarColor,
      child: SafeArea(
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
  
  @override
  Size get preferredSize => Size.fromHeight(130.92);
}