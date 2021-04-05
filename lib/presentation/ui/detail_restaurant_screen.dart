import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:submission2_flutter_expert/data/models/detil_restaurant_response.dart';
import 'package:submission2_flutter_expert/data/models/restorants_arguments.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/presentation/bloc/detail/detail_page_local_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/detail/detil_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/widget/state_empty_data.dart';

class DetailResturantScreen extends StatefulWidget {

  static const routeName = '/detil_page';

  final RestaurantArguments args;

  const DetailResturantScreen({@required this.args});

  @override
  _DetailResturantScreenState createState() => _DetailResturantScreenState();
}

class _DetailResturantScreenState extends State<DetailResturantScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    context.read<DetilPageBloc>().add(DetilPageIn(idRestaurant: widget.args.idRestaurant));
    context.read<DetailLocalBloc>().add(DetailLocalIn(id: widget.args.idRestaurant));
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<DetailLocalBloc, DetailLocalState>(
            listener: (context, state){
              if(state is GetDetailSuccess){
                setState(() {
                  _isFavorite = state.data.isFavorite ? true : false;
                });
              }
              if(state is UpdateFavoriteSucccess){
                _showMessage("Berhasil di update");
              }
            },
          )
        ],
        child: BlocBuilder<DetilPageBloc, DetilPageState>(
          builder: (context, state){
            if (state is DetilPageLoading){
              return Center(child: CircularProgressIndicator());
            }
            if (state is DetilPageHasData){
              return Scaffold(
                body: _buildBody(context, state.data),
              );
            }
            if (state is DetilPageError){
              return StateEmptyData(
                  retry: _initData,
                  message: "Terjadi error");
            }
            print("State kemana $state");
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
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 50,
                            color: Color(0xFF12153D).withOpacity(0.2))
                      ],
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://restaurant-api.dicoding.dev/images/medium/${data.pictureId}"
                          ))
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 32,
                  left: 32,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              data.address,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow,),
                                      Text(data.rating.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _setInFavorite(data, _isFavorite);
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                    });
                                  },
                                  child: Icon(_isFavorite? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50))
            ),
            child: Text(
              data.description,
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              "Review",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              textAlign: TextAlign.justify,
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
      height: MediaQuery.of(context).size.height/2,
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

  void _setInFavorite(DetilRestaurant data, bool isFavorite) {
    var dataFavorite = RestaurantEntityData(id: data.id, name: data.name, description: data.description, pictureId: data.pictureId, city: data.city, rating: data.rating, isFavorite: !isFavorite);
    context.read<DetailLocalBloc>().add(SetDataFavorite(data: dataFavorite));
  }

  void _showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}








