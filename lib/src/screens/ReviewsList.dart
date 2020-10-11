import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Review.dart';
import 'package:flutter_movie/src/Widgets/AppContainer.dart';
import 'package:flutter_movie/src/Widgets/ExpandableWidget.dart';

class ReviewsList extends StatefulWidget {
  final List<Review> reviews;

  const ReviewsList(this.reviews);

  @override
  State<StatefulWidget> createState() {
    return _ReviewsListState();
  }
}

class _ReviewsListState extends State<ReviewsList> {
  int selectedIdx;

  void _goToDetails(int idx) {
    setState(() {
      if (idx == selectedIdx) {
        return selectedIdx = null;
      }
      selectedIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Отзывы'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            for (var i = 0; i < widget.reviews.length; i++) ...[
              Card(
                key: Key('_review_${widget.reviews[i].id}'),
                elevation: 4,
                child: Material(
                  child: InkWell(
                    onTap: () => _goToDetails(i),
                    child: AppContainer(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 7.5),
                            child: Text(
                              widget.reviews[i].author,
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          ExpandableWidget(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                            minHeight: 99.5,
                            withFade: true,
                            open: i == selectedIdx,
                            child: Text(widget.reviews[i].content),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 7.5)
            ],
          ],
        ),
      ),
    );
  }
}
