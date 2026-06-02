import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/modules/login_views/cubit/login_states.dart';
import 'package:sqflite/sqflite.dart';

import '../../../shared/network/local/shared_prefeence.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginHomeInitialStates());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isPassword = true;
  void changeIconEye() {
    isPassword = !isPassword;
    emit(LoginChangeIconEyeStates());
  }

  bool isDark = false;
  void loadTheme() {
    isDark = CacheHelper.getData(key: 'isDark') ?? false;
    emit(LoginThemeChangedState());
  }

  void changeMode(bool value) {
    isDark = value;

    CacheHelper.putData(key: 'isDark', value: isDark);

    emit(LoginChangeModeStates());
  }

  bool enterPassword = true;
  void changeEnterPassword() {
    enterPassword = !enterPassword;
    emit(LoginChangeEnterPasswordStates());
  }

  bool confirmPassword = true;
  void changeConfirmPassword() {
    confirmPassword = !confirmPassword;
    emit(LoginChangeConfirmPasswordStates());
  }

  Database? database;
  void createDataBase() {
    openDatabase(
      'users.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
              'CREATE TABLE users (id INTEGER PRIMARY KEY, userName TEXT, email Text, password Text,image Text)',
            )
            .then((value) {
              debugPrint('DataBase Is Creating Successfully');
            })
            .catchError((error) {
              debugPrint('Error When Creating DataBase ${error.toString()}');
            });
      },
      onOpen: (database) {
        this.database = database;
        debugPrint('DataBase Is Opening');
      },
    ).then((value) {
      database = value;
      emit(LoginCreateDataBaseStates());
    });
  }

  void insertDataBase({
    required String email,
    required String password,
    required String userName,
    String? image,
  }) {
    if (database == null) return;
    database!
        .transaction((txn) async {
          await txn.rawInsert(
            'INSERT INTO users(userName, email, password,image) VALUES(?, ?, ?,?)',
            [userName, email, password, null],
          );
        })
        .then((value) {
          debugPrint('DataBase Is Inserting Successfully');
          emit(LoginInsertDataBaseStates());
        })
        .catchError((error) {
          debugPrint(
            'Error When Inserting Data To DataBase ${error.toString()}',
          );
        });
  }

  String? emailController;

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    if (database == null) return false;
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE email =? AND password =? ',
      [email, password],
    );
    if (result.isNotEmpty) {
      emailController = email;
      return true;
    }
    return false;
  }

  Future<bool> checkEmail({required String email}) async {
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE email =?',
      [email],
    );
    return result.isNotEmpty;
  }

  Future<bool> checkPassword({required String password}) async {
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE password =?',
      [password],
    );
    return result.isNotEmpty;
  }

  String? userName;
  String? userImage;

  Future<void> getUserData() async {
    if (database == null || emailController == null) return;
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE email=?',
      [emailController],
    );
    if (result.isNotEmpty) {
      userName = result.first['userName'];
      userImage = result.first['image'];
      emit(LoginGetUserDataStates());
    }
  }

  bool isOldPassword = true;
  void changeIconEyeOld() {
    isOldPassword = !isOldPassword;
    emit(LoginChangeIconEyeOldState());
  }

  bool isNewPassword = true;
  void changeIconEyeNew() {
    isNewPassword = !isNewPassword;
    emit(LoginChangeIconEyeNewState());
  }

  bool isNewConfirmPassword = true;
  void changeIconEyeNewConfirm() {
    isNewConfirmPassword = !isNewConfirmPassword;
    emit(LoginChangeIconEyeNewConfirmState());
  }

  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE email=? AND password=? ',
      [emailController, oldPassword],
    );
    if (result.isNotEmpty) {
      await database!.rawUpdate('UPDATE users SET password=? WHERE email=?', [
        newPassword,
        emailController,
      ]);
      return true;
    }
    return false;
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();
  Future<void> updateProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      await database!.rawUpdate('UPDATE users SET image=? WHERE email=?', [
        pickedFile.path,
        emailController,
      ]);
      userImage = pickedFile.path;
      emit(LoginPickImageState());
    }
  }

  Future<void> getProfileImage() async {
    List<Map> result = await database!.rawQuery(
      'SELECT image FROM users WHERE email=?',
      [emailController],
    );

    if (result.isNotEmpty) {
      userImage = result.first['image'];

      emit(LoginGetImageState());
    }
  }
}
