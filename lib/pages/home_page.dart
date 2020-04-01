
import 'package:app/api/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController myMapController;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(25.69893, 32.6421);

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        infoWindow: InfoWindow(
          title: 'Historical City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    return _markers;
  }

  @override
  Widget build(BuildContext context) {
        final auth = Provider.of<AuthProvider>(context);


    void logOut(){
      auth.signOut(context);
    }

    return Scaffold(
            appBar: AppBar(
              title: Text('Maps With Marker'),
              backgroundColor: Colors.blue[900],
              actions: <Widget>[
                IconButton(icon: Icon(Icons.exit_to_app),onPressed: logOut)
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _mainLocation,
                      zoom: 10.0,
                    ),
                    markers: this.myMarker(),
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      setState(() {
                        myMapController = controller;
                      });
                    },
                  ),
                ),
              ],
            ));
    // return Scaffold(
    //     body: SafeArea(
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text("HomePage",style: TextStyle(fontSize: 30.0)),
    //         RaisedButton(
    //           child: Text("LogOut"),
    //           onPressed: (){
    //             us.signOut(context);
    //           },
    //         ),
    //         RaisedButton(
    //           child: Text("test"),
    //           onPressed: (){
    //             Navigator.pushReplacementNamed(context, "test");
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // ));
  }
}
