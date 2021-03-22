import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission2_flutter_expert/data/models/detil_restaurant_response.dart';
import 'package:submission2_flutter_expert/data/models/restorants_arguments.dart';
import 'package:submission2_flutter_expert/presentation/bloc/detail/detil_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/widget/start_rating.dart';
import 'package:submission2_flutter_expert/presentation/widget/state_empty_data.dart';

class DetailResturantScreen extends StatefulWidget {

  static const routeName = '/detil_page';

  final RestaurantArguments args;

  const DetailResturantScreen({@required this.args});

  @override
  _DetailResturantScreenState createState() => _DetailResturantScreenState();
}

class _DetailResturantScreenState extends State<DetailResturantScreen> {
  
  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    context.read<DetilPageBloc>().add(DetilPageIn(idRestaurant: widget.args.idRestaurant));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetilPageBloc, DetilPageState>(
        builder: (context, state){
          if (state is DetilPageLoading){
            return Center(child: CircularProgressIndicator());
          }
          if (state is DetilPageHasData){
            return _buildBody(context, state.data);
          }
          if (state is DetilPageError){
            return StateEmptyData(
                retry: _initData,
                message: "Terjadi error");
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DetilRestaurant data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: NetworkImage(
                      'https://restaurant-api.dicoding.dev/images/medium/${data.pictureId}',
                    ),
                    fit: BoxFit.fill),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 64,
                ),
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  )),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.white,),
                    SizedBox(width: 4,),
                    Text(
                        data.address,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    StarRating(
                      rating: data.rating,
                      color: Colors.orange,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(data.rating.toString(),
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.white)),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              "Review",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          _bodyReview(context, data.customerReviews),
        ],
      ),
    );
  }

  Widget _bodyReview(BuildContext context, List<CustomerReview> customerReviews) {
    if (customerReviews.isEmpty){
      return Text("No comment");
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: customerReviews.length,
          itemBuilder: (context, index){
            return _buildItem(context, customerReviews[index], index);
          }),
    );
  }

  Widget _buildItem(BuildContext context, CustomerReview customerReview, int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              customerReview.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            customerReview.date,
            style: TextStyle(
              fontStyle: FontStyle.italic,
                fontSize: 14,
                color: Colors.grey[30],
                fontWeight: FontWeight.w300
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(

            customerReview.review
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 2,
          )
        ],
      ),
    );
  }
}





