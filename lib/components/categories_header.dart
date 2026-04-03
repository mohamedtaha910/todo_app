import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/models/category_model.dart';

class CategoriesHeader extends StatelessWidget {
  final String formattedDate;
  final CategoryModel category;

  const CategoriesHeader({
    super.key,
    required this.formattedDate,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// Background Container
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
            color: category.color,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          height: 200,
          width: double.infinity,
          // color: kSecondaryColor,
        ),

        /// Ellipse 1
        Positioned(
          top: 55,
          left: 0,
          child: SvgPicture.asset(
            'assets/picture/Ellipse 1.svg',
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),

        /// Ellipse 2
        Positioned(
          top: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/picture/Ellipse 2.svg',
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),

        /// Header Title
        Positioned(
          top: 70,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  category.iconPath,
                  colorFilter: ColorFilter.mode(
                    Colors.black54,
                    BlendMode.srcIn,
                  ),
                  height: category.name == 'Work' ? 32 : 24,
                ),
              ),
              SizedBox(width: 12),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        /// Date
        Positioned(
          top: 22,
          // right: MediaQuery.of(context).size.width / 2 - 55,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),

        /// Back Button
        Positioned(
          top: 10,
          left: 15,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                // padding: EdgeInsets.only(left: 6, right: 8 , top: 8, bottom: 8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_back_ios, color: Colors.black54 , size: 18,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
