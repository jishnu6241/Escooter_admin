import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  RideBloc() : super(RideInitialState()) {
    on<RideEvent>((event, emit) async {
      emit(RideLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('ride');
      SupabaseQueryBuilder profileTable = supabaseClient.from('profile');
      SupabaseQueryBuilder hubTable = supabaseClient.from('hub');
      SupabaseQueryBuilder scooterTable = supabaseClient.from('scooter');
      List<dynamic> temp = await queryTable
          .select('*')
          .eq('status', event.status)
          .order('created_at');

      List<Map<String, dynamic>> rides =
          temp.map((e) => e as Map<String, dynamic>).toList();

      for (int i = 0; i < rides.length; i++) {
        rides[i]['user'] = await profileTable
            .select('*')
            .eq('user_id', rides[i]['user_id'])
            .single();

        rides[i]['scooter'] = await scooterTable
            .select('*')
            .eq('id', rides[i]['scooter_id'])
            .single();

        rides[i]['start_hub'] = await hubTable
            .select('*')
            .eq('id', rides[i]['start_hub_id'])
            .single();

        if (rides[i]['end_hub_id'] != null) {
          rides[i]['end_hub'] = await hubTable
              .select('*')
              .eq('id', rides[i]['start_hub_id'])
              .single();
        } else {
          rides[i]['end_hub'] = null;
        }
      }
      emit(
        RideSuccessState(
          rides: rides,
        ),
      );
    });
  }
}
