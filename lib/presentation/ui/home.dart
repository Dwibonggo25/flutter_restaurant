import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission2_flutter_expert/data/models/restaurant_response.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/ui/bottom_sheets_search.dart';
import 'package:submission2_flutter_expert/presentation/widget/start_rating.dart';
import 'package:submission2_flutter_expert/shared/const/constant.dart';

class HomePageScreen extends StatefulWidget {
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

  void _initData() {
    context.read<HomePageBloc>().add(HomePageIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state){
          if (state is HomePageLoading){
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomePageHasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     _searchingField(context),
                    _listRestaurant(context, state.data)
                  ],
                ),
              ),
            );
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
                        color: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(data.rating.toString(),
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black)),
                      )
                    ],
                  ),

                ],
              ),
            )
          ],
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
                      "Cari Provider",
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

}





