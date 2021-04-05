import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission2_flutter_expert/data/models/restorants_arguments.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/presentation/bloc/favorite/favorite_local_bloc.dart';
import 'package:submission2_flutter_expert/presentation/ui/detail_restaurant_screen.dart';
import 'package:submission2_flutter_expert/presentation/widget/start_rating.dart';
import 'package:submission2_flutter_expert/presentation/widget/state_empty_data.dart';
import 'package:submission2_flutter_expert/shared/const/constant.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite_page';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    super.initState();

    _initData();
  }

  _initData(){
    context.read<FavoriteLocalBloc>().add(FavoriteLocalIn());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<FavoriteLocalBloc, FavoriteLocalState>(
              listener: (context, state){
                print("Kesini cuy? $state");
                if(state is UpdateLocalSuccess){
                  return _initData();
                }
                if(state is FavoriteLocalError){
                  return StateEmptyData(
                      retry: _initData,
                      message: "Terjadi error");
                }
              }
          )
        ],
        child: BlocBuilder<FavoriteLocalBloc, FavoriteLocalState> (
          builder: (context, state){
            if(state is FavoriteLocalInital){
              return Center(child: CircularProgressIndicator());
            }
            if(state is FavoriteLocalNoData){
              return StateEmptyData(
                  retry: _initData,
                  message: "Tidak punya data");
            }
            if (state is FavoriteLocalHasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Favorite"),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      _listFavoriteResturant(context, state.data),
                    ],
                  ),
                ),
              );
            }
            if(state is FavoriteLocalError){
              return StateEmptyData(
                  retry: _initData,
                  message: "Terjadi error");
            }
            return Container();
          },
        ),
    );
  }

  Widget _listFavoriteResturant(BuildContext context, List<RestaurantEntityData> data) {
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

  Widget _buildItemRestaurant(BuildContext context, RestaurantEntityData data, int index) {
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
                      GestureDetector(
                        onTap: (){
                          _updateFavorite(data.id);
                        },
                        child: Icon(data.isFavorite ? Icons.favorite: Icons.favorite_border_outlined, color: Colors.red,),
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

  void _updateFavorite(String id) {
    context.read<FavoriteLocalBloc>().add(DeleteFavorite(id: id));
  }

  void _navigateToDetil(BuildContext context, String id) {
    print("Id restaurant: $id");
    Navigator.pushNamed(context, DetailResturantScreen.routeName, arguments: RestaurantArguments(idRestaurant: id) );
  }
}



