import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mayur_traders_flutter_app/widgets/custom_dropdown.dart';
import 'package:mayur_traders_flutter_app/widgets/custom_table.dart';
import 'package:mayur_traders_flutter_app/widgets/custom_text_field.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/get_users_list_model.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_loader_indicator.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  var usersListResponse = ''' {
  "status": 200,
  "message": "Data fetched successfully",
  "data": [
    {
      "id": 1,
      "userId": "MT0001",
      "userProfile": "",
      "userName": "Maruti Ramu Patil",
      "userRole": "Admin",
      "userContact": "6362229299",
      "vehicle_number":"",
      "userAddress": "kallehol",
      "userEmail": "",
      "joined_date": "04/09/2024",
      "Relieve_date": "14/09/2025",
      "is_active": "1"
    },
     {
      "id": 2,
      "userId": "MT0002",
      "userProfile": "",
      "userName": "Mayur Patil",
      "userRole": "Admin",
      "userContact": "7795896750",
      "vehicle_number":"",
      "userAddress": "",
      "userEmail": "",
      "joined_date": "04/09/2024",
      "Relieve_date": "14/09/2025",
      "is_active": "1"
    },
     {
      "id": 3,
      "userId": "MT0003",
      "userProfile": "",
      "userName": "Sarita Ingale",
      "userRole": "Manager",
      "userContact": "9789564345",
      "vehicle_number":"",
      "userAddress": "",
      "userEmail": "",
      "joined_date": "04/09/2024",
      "Relieve_date": "14/09/2025",
      "is_active": "1"
    },
    {
      "id": 4,
      "userId": "MT0004",
      "userProfile": "",
      "userName": "Revappa",
      "userRole": "Shop Worker",
      "userContact": "8719564345",
      "vehicle_number":"",
      "userAddress": "",
      "userEmail": "",
      "joined_date": "04/09/2024",
      "Relieve_date": "14/09/2025",
      "is_active": "1"
    },
    {
      "id": 5,
      "userId": "MT0005",
      "userProfile": "",
      "userName": "Dyaneshwar",
      "userRole": "Driver",
      "userContact": "8786564345",
      "vehicle_number":"BH22KA1234",
      "userAddress": "",
      "userEmail": "",
      "joined_date": "04/09/2024",
      "Relieve_date": "14/09/2025",
      "is_active": "1"
    }
  ]
}''';

  List<UsersList> usersList = [];
  List<UsersList> foundUsersList = [];

  bool _isLoading = false;

  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsersListApi();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool filterUsers(UsersList user, String query) {
    final lowerQuery = query.toLowerCase();
    return user.userId.toLowerCase().contains(lowerQuery) ||
        user.userName.toLowerCase().contains(lowerQuery) ||
        user.userRole.toLowerCase().contains(lowerQuery) ||
        user.userContact.toLowerCase().contains(lowerQuery) ||
        user.vehicleNumber.toLowerCase().contains(lowerQuery) ||
        user.userAddress.toLowerCase().contains(lowerQuery) ||
        user.userEmail.toLowerCase().contains(lowerQuery) ||
        user.joinedDate.toLowerCase().contains(lowerQuery) ||
        (user.isActive == '1' ? 'yes' : 'no').contains(lowerQuery);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper.builder(
      Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        drawer: kIsWeb ? CustomDrawer() : null,
        body: _isLoading
            ? const LoaderIndicatorWidget(
                message: 'Fetching Users please wait...',
              )
            : CustomTable<UsersList>(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('User ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Role')),
                  DataColumn(label: Text('Contact')),
                  DataColumn(label: Text('Vehicle Number')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Joined Date')),
                  DataColumn(label: Text('Active')),
                ],
                rows: foundUsersList,
                hasSearch: true,
                dataCellBuilder: (user) => [
                  DataCell(Text(user.id.toString())),
                  DataCell(Text(user.userId)),
                  DataCell(Text(user.userName)),
                  DataCell(Text(user.userRole)),
                  DataCell(Text(user.userContact)),
                  DataCell(Text(user.vehicleNumber)),
                  DataCell(Text(user.userAddress)),
                  DataCell(Text(user.userEmail)),
                  DataCell(Text(user.joinedDate)),
                  DataCell(Text(user.isActive == '1' ? 'Yes' : 'No')),
                ],
                actions: [
                  CustomAction<UsersList>(
                    icon: Icons.visibility,
                    onPressed: (context, user) {
                      // Handle view action
                    },
                  ),
                  CustomAction<UsersList>(
                    icon: Icons.edit,
                    onPressed: (context, user) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return UserForm(
                          user: user, // Pass the appropriate user object here
                          onSave: () {
                            // Handle the save operation
                            Navigator.of(context).pop();
                          },
                        );
                      }));
                    },
                  ),
                  CustomAction<UsersList>(
                    icon: Icons.delete,
                    onPressed: (context, user) {
                      // Handle delete action
                    },
                  ),
                ],
                filterFunction: filterUsers,
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: UserForm(
                        onSave: () {
                          // Handle the save operation
                          Navigator.of(context).pop();
                        },
                      ),
                    ));
            /* Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                    position: offsetAnimation,
                    child: UserForm(
                      onSave: () {
                        // Handle the save operation
                        Navigator.of(context).pop();
                      },
                    ));
              },
            ));*/
          },
          child: const Icon(Icons.add),
        ),
      ),
      breakpoints: [
        const ResponsiveBreakpoint.resize(350, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(600, name: TABLET),
        const ResponsiveBreakpoint.resize(800, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
      ],
    );
  }

  Future<void> fetchUsersListApi() async {
    setState(() {
      _isLoading = true;
    });
    var resData = getUsersListResponseModelFromJson(usersListResponse);
    if (resData.status == 200) {
      usersList = resData.data ?? [];
      foundUsersList = usersList;
    }
    setState(() {
      _isLoading = false;
    });
  }
}

class UserForm extends StatefulWidget {
  final UsersList? user;
  final VoidCallback onSave;

  const UserForm({Key? key, this.user, required this.onSave}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late TextEditingController _idController;
  late TextEditingController _userIdController;
  late TextEditingController _userNameController;
  late TextEditingController _userRoleController;
  late TextEditingController _userContactController;
  late TextEditingController _vehicleNumberController;
  late TextEditingController _userAddressController;
  late TextEditingController _userEmailController;
  late TextEditingController _joinedDateController;
  late TextEditingController _isActiveController;

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  var rolesOptions = ["Admin", "Manager", "Shop Worker", "Driver"];
  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data if available
    _idController =
        TextEditingController(text: widget.user?.id.toString() ?? '');
    _userIdController = TextEditingController(text: widget.user?.userId ?? '');
    _userNameController =
        TextEditingController(text: widget.user?.userName ?? '');
    _userRoleController =
        TextEditingController(text: widget.user?.userRole ?? '');
    _userContactController =
        TextEditingController(text: widget.user?.userContact ?? '');
    _vehicleNumberController =
        TextEditingController(text: widget.user?.vehicleNumber ?? '');
    _userAddressController =
        TextEditingController(text: widget.user?.userAddress ?? '');
    _userEmailController =
        TextEditingController(text: widget.user?.userEmail ?? '');
    _joinedDateController =
        TextEditingController(text: widget.user?.joinedDate ?? '');
    _isActiveController =
        TextEditingController(text: widget.user?.isActive ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnMainAxisAlignment: MainAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              columnFlex: 1,
              child: SizedBox(
                width: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? double.infinity
                    : 400,
                child: Form(
                  key: userFormKey,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            label: 'ID',
                            controller: _idController,
                            isRequired: false,
                            isDateField: false,
                            isTimeField: false,
                          ),
                          CustomTextField(
                            label: 'User ID',
                            controller: _userIdController,
                            isRequired: true,
                            isDateField: false,
                            isTimeField: false,
                          ),
                          CustomTextField(
                            label: 'Name',
                            controller: _userNameController,
                            isRequired: true,
                            isDateField: false,
                            isTimeField: false,
                          ),
                          CustomDropdown(
                            label: 'Role',
                            controller: _userRoleController,
                            onChange: (onChange) {},
                            isRequired: true,
                            options: rolesOptions,
                          ),
                          CustomTextField(
                            label: 'Contact',
                            controller: _userContactController,
                            isRequired: true,
                            isDateField: false,
                            isTimeField: false,
                          ),
                          CustomTextField(
                            label: 'Vehicle Number',
                            controller: _vehicleNumberController,
                            isRequired: false,
                            isDateField: false,
                            isTimeField: false,
                          ),
                          CustomTextField(
                            label: 'Address',
                            controller: _userAddressController,
                            isRequired: false,
                            isDateField: false,
                            isTimeField: false,
                          ),
                          CustomTextField(
                            label: 'Email',
                            controller: _userEmailController,
                            isRequired: false,
                            isDateField: false,
                            isTimeField: false,
                          ),
                          CustomTextField(
                            label: 'Joined Date',
                            controller: _joinedDateController,
                            isRequired: false,
                            isDateField: true,
                            isTimeField: false,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Handle save
                              widget.onSave();
                            },
                            child: Text(widget.user == null
                                ? 'Add User'
                                : 'Update User'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
