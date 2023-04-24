import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitialState()) {
    on<UsersEvent>((event, emit) async {
      emit(UsersLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('profile');
      try {
        if (event is GetAllUsersEvent) {
          List<dynamic> temp = [];

          if (event.query != null) {
            temp = await queryTable
                .select('*')
                .ilike('name', '%${event.query}%')
                .order("created_at");
          } else {
            temp = await queryTable.select('*').order("created_at");
          }

          List<Map<String, dynamic>> users =
              temp.map((e) => e as Map<String, dynamic>).toList();
          emit(
            UsersSuccessState(
              users: users,
            ),
          );
        } else if (event is AddUsersEvent) {
          await queryTable.insert({
            'name': event.name,
            'phone': event.phone,
            'proof_doc_url': '',
            'bank_name': event.bankName,
            'bank_ac_no': event.accountNo,
            'bank_ifsc': event.bankIfsc,
            'user_id': supabaseClient.auth.currentUser!.id,
          });
          add(GetAllUsersEvent());
        } else if (event is EditUsersEvent) {
          await queryTable.update({
            'name': event.name,
            'phone': event.phone,
            'proof_doc_url': '',
            'bank_name': event.bankName,
            'bank_ac_no': event.accountNo,
            'bank_ifsc': event.bankIfsc,
          }).eq('user_id', supabaseClient.auth.currentUser!.id);

          add(GetAllUsersEvent());
        } else if (event is DeleteUsersEvent) {
          await queryTable.delete().eq('id', event.id);
          add(GetAllUsersEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(UsersFailureState());
      }
    });
  }
}
