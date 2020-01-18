import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_emp/widgets/profile_pic.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.employeeDetails);
  final employeeDetails;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'PROFILE'),
    Tab(text: 'PROJECT DETAILS'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Map<String, dynamic> emp = widget.employeeDetails;
    List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          backgroundColor: Colors.red,
          pinned: true,
          expandedHeight: 300,
          title: Text(
            "${emp["FirstName"]} ${emp["LastName"]}",
            style: TextStyle(letterSpacing: 1.2),
          ),
          centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
              background: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.red[700], Colors.grey[700]],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                profile(
                    photo: emp["EmployeePhoto"],
                    width: 120,
                    height: 120,
                    color: Colors.white),
                SizedBox(
                  height: 10,
                ),
                Text(
                  emp["Designation"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  emp["EmailID"],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          )),
        ),
        SliverPersistentHeader(
            delegate: _SilverAppBarDelegate(TabBar(
          indicatorWeight: 5,
          labelColor: Colors.red,
          indicatorColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          tabs: myTabs,
          controller: _tabController,
        )))
      ];
    }

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _sliverBuilder,
        body: TabBarView(controller: _tabController, children: <Widget>[
          ListView(
            children: <Widget>[
              TabScreen(
                empDetails: emp,
                buildCard: [
                  CardBuild(
                    title: "ABOUT ME",
                    listBuild: [
                      ListBuild(
                          name: emp["EmployeeID"],
                          icon: Icon(Icons.assignment_ind)),
                      ListBuild(name: emp["EmailID"], icon: Icon(Icons.email)),
                      ListBuild(name: emp["Mobile"], icon: Icon(Icons.phone)),
                      ListBuild(
                          name: emp["Date_of_birth"], icon: Icon(Icons.cake)),
                      ListBuild(name: emp["Address"], icon: Icon(Icons.home)),
                      ListBuild(
                          name: emp["LocationName"],
                          icon: Icon(Icons.location_on)),
                      ListBuild(name: emp["Gender"], icon: Icon(Icons.person)),
                    ],
                  ),
                  CardBuild(
                    title: "COMPANY DETAILS",
                    listBuild: [
                      ListBuild(
                        name: emp["Department"],
                        label: buildContainer("Department"),
                      ),
                      ListBuild(
                        name: emp["Designation"],
                        label: buildContainer("Designation"),
                      ),
                      ListBuild(
                        name: emp["Work_location"],
                        label: buildContainer("Work Location"),
                      ),
                      ListBuild(
                        name: emp["Dateofjoining"],
                        label: buildContainer("Date of joining"),
                      ),
                      ListBuild(
                        name: emp["Employee_type"],
                        label: buildContainer("Employment type"),
                      ),
                      ListBuild(
                        name: emp["Employeestatus"],
                        label: buildContainer("Status"),
                      ),
                    ],
                  ),
                  CardBuild(
                    title: "REPORTING",
                    listBuild: [
                      ListBuild(
                        name: emp["Reporting_To"],
                        label: buildContainer("Reporting Manager"),
                      ),
                      ListBuild(
                        name: emp["Business_HR"],
                        label: buildContainer("Business HR"),
                      )
                    ],
                  ),
                  CardBuild(
                    title: "EXPERIENCE",
                    listBuild: [
                      ListBuild(
                        name: emp["Actual_Experience"],
                        label: buildContainer("In Accion"),
                      ),
                      ListBuild(
                        name: emp["Previous_Experience"],
                        label: buildContainer("Previous"),
                      ),
                    ],
                  ),
                  CardBuild(
                    title: "Expertise",
                    listBuild: [
                      ListBuild(
                        name: emp["Expertise"],
                        label: buildContainer("Skills"),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          ListView(
            children: <Widget>[
              TabScreen(
                empDetails: emp,
                buildCard: [
                  CardBuild(
                    title: "PROJECT DETAILS",
                    listBuild: [
                      ListBuild(
                          name: emp["Project"],
                          label: buildContainer("Project Name"),
                  )
                ],
              )
            ],
          ),
        ]),
      ]),
    ),);
  }

  Container buildContainer(title) {
    return Container(
      width: 150,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            letterSpacing: 1,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  TabScreen({this.empDetails, this.buildCard});
  final Map<String, dynamic> empDetails;
  final List<Widget> buildCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white10, Colors.grey[200]])),
      child: Column(
        children: buildCard,
      ),
    );
  }
}

class CardBuild extends StatelessWidget {
  CardBuild({@required this.title, @required this.listBuild});
  final String title;
  final List<ListBuild> listBuild;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 13, right: 13, bottom: 13),
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(children: listBuild),
          ],
        ));
  }
}

class ListBuild extends StatelessWidget {
  const ListBuild({this.name, this.icon, this.label});
  final String name;
  final Widget label;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? icon : label,
      title: Text(
        name,
        style: TextStyle(
            color: Colors.black45,
            letterSpacing: 1,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _SilverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SilverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return  Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
