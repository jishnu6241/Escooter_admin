import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'dashboard_count_event.dart';
part 'dashboard_count_state.dart';

class DashboardCountBloc
    extends Bloc<DashboardCountEvent, DashboardCountState> {
  DashboardCountBloc() : super(DashboardCountInitialState()) {
    on<DashboardCountEvent>((event, emit) async {
      emit(DashboardCountLoadingState());

      final SupabaseClient supabaseClient = Supabase.instance.client;

      PostgrestResponse scootersCount = await supabaseClient
          .from('scooter')
          .select('*', const FetchOptions(count: CountOption.exact));

      PostgrestResponse profilesCount = await supabaseClient
          .from('profile')
          .select('*', const FetchOptions(count: CountOption.exact));

      PostgrestResponse hubsCount = await supabaseClient
          .from('hub')
          .select('*', const FetchOptions(count: CountOption.exact));

      try {
        Map<String, dynamic> dashbordCount = {
          'scooters': scootersCount.count.toString(),
          'profiles': profilesCount.count.toString(),
          'hubs': hubsCount.count.toString(),
        };

        Logger().w(dashbordCount);

        emit(DashboardCountSuccessState(dashbordCount: dashbordCount));
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DashboardCountFailureState());
      }
    });
  }
}
