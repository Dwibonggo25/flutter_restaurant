import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:submission2_flutter_expert/data/models/restaurant_response.dart';
import 'package:submission2_flutter_expert/data/models/restorants_arguments.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home/home_local_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home/home_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/ui/bottom_sheets_search.dart';
import 'package:submission2_flutter_expert/presentation/ui/detail_restaurant_screen.dart';
import 'package:submission2_flutter_expert/presentation/widget/start_rating.dart';
import 'package:submission2_flutter_expert/presentation/widget/state_empty_data.dart';
import 'package:submission2_flutter_expert/shared/const/constant.dart';
import 'package:submission2_flutter_expert/shared/helper/background_service.dart';
import 'package:submission2_flutter_expert/shared/helper/notification_helper.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/home_page';
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }


  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  void _initData() {
    context.read<HomePageBloc>().add(HomePageIn());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeLocalBloc, HomeLocalState>(
              listener: (event, state){
                if (state is UpdateFavoriteSucccess){
                  _showMessage("Ditambhkan ke favorite");
                }
                if(state is HomeLocalError){
                  _showMessage("Gagal ditambahkan");
                }
                print("statnya kemana $state");
              }
          )
        ],
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state){
            if (state is HomePageLoading){
              return Center(child: CircularProgressIndicator());
            }
            if (state is HomePageHasData) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _searchingField(context),
                        _listRestaurant(context, state.data)
                      ],
                    ),
                  )
                ),
              );
            }
            if (state is HomePageNoData){
              return StateEmptyData(
                  retry: _initData,
                  message: "Tidak punya data");
            }
            if (state is HomePageError){
              return StateEmptyData(
                  retry: _initData,
                  message: "Terjadi error");
            }
            return Container();
          },
        ),
    );
  }

  Widget _listRestaurant(BuildContext context, List<Restaurant> data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _buildItemRestaurant(context, data[index], index);
          }),
    );
  }

  Widget _buildItemRestaurant(BuildContext context, Restaurant data, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          _navigateToDetil(context, data.id);
        },
        child: Container (
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    Constant.BASE_IMAGE+data.pictureId,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(data.city,
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.grey)),
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
                                  fontSize: 16.0, color: Colors.black)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: (){
                        _saveDataToLocal(data);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add_box, color: Colors.red),
                          SizedBox(width: 4,),
                          Text("Tambah Favorite")
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }

  Widget _searchingField(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
        color: Colors.grey[100],
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: (){
             _showSearchBottomSheets(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 8, 16, 0),
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // _showSearchBottomSheets(context);
                      },
                    ),
                    Text(
                      "Cari Berdasarkan",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  void _showSearchBottomSheets(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return BottomSheetsSearch();
        });
  }

  _saveDataToLocal(Restaurant data){
    var dataFavorite = RestaurantEntityData(id: data.id, name: data.name, description: data.description, pictureId: data.pictureId, city: data.city, rating: data.rating, isFavorite: true);
    context.read<HomeLocalBloc>().add(InsertIn(data: dataFavorite));
  }

  void _navigateToDetil(BuildContext context, String id) {
    print("Id restaurant: $id");
    Navigator.pushNamed(context, DetailResturantScreen.routeName, arguments: RestaurantArguments(idRestaurant: id) );
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






