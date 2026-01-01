import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';

import '../../../../core/theme/app_color.dart';

class NewsWidget extends StatefulWidget {
  final NewsModel model;
  final bool isLeft;

  final Function() onTap;

  const NewsWidget({super.key, required this.model, required this.isLeft, required this.onTap});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  Offset offset=Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 200,
      width: double.infinity,
      child: Row(
        textDirection: widget.isLeft ? TextDirection.ltr : TextDirection.rtl,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(widget.model.image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.model.title,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Row(
                    textDirection: widget.isLeft ? TextDirection.ltr : TextDirection.rtl,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset:offset ,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if(widget.isLeft){
                              if(offset.dx<=-80){
                                return;
                              }
                              offset+=details.delta;
                              setState(() {});

                            }else{
                              if(offset.dx>=80){
                                return;
                              }
                              offset+=details.delta;
                              setState(() {});
                            }


                          },
                          onHorizontalDragEnd: (details) {
                            offset=Offset(0, 0);
                            setState(() {});
                            widget.onTap();
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColor.black,
                            child: widget.isLeft
                                ? Icon(
                              Icons.arrow_back_ios_new,
                                    color: AppColor.white,
                                  )
                                : Icon(
                              Icons.arrow_forward_ios_sharp,
                                    color: AppColor.white,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
