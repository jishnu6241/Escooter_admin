import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'withdraw_request_event.dart';
part 'withdraw_request_state.dart';

class WithdrawRequestBloc
    extends Bloc<WithdrawRequestEvent, WithdrawRequestState> {
  WithdrawRequestBloc() : super(WithdrawRequestInitialState()) {
    on<WithdrawRequestEvent>((event, emit) async {
      emit(WithdrawRequestLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('withdraw_request');
      SupabaseQueryBuilder profileTable = supabaseClient.from('profile');
      try {
        if (event is GetAllWithdrawRequestEvent) {
          List<dynamic> temp = [];

          temp = await queryTable
              .select('*')
              .eq('status', event.status)
              .order("created_at");

          List<Map<String, dynamic>> withdrawRequests =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < withdrawRequests.length; i++) {
            withdrawRequests[i]['user'] = await profileTable
                .select('*')
                .eq('user_id', withdrawRequests[i]['user_id'])
                .single();
          }
          emit(
            WithdrawRequestSuccessState(
              requests: withdrawRequests,
            ),
          );
        } else if (event is AddWithdrawRequestEvent) {
          await queryTable.insert({
            'user_id': supabaseClient.auth.currentUser!.id,
          });
          add(GetAllWithdrawRequestEvent());
        } else if (event is UpdateWithdrawRequestStatusEvent) {
          await queryTable.update({
            'status': 'paid',
          }).eq('id', event.id);

          add(GetAllWithdrawRequestEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(WithdrawRequestFailureState());
      }
    });
  }
}
