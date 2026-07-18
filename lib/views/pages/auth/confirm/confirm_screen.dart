import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/data/repositories/auth_repository.dart';
import 'package:sample_flutter_app/helpers/forms/form_submission_status.dart';
import 'package:sample_flutter_app/helpers/forms/input_validator.dart';
import 'package:sample_flutter_app/views/pages/auth/confirm/confirm_bloc.dart';
import 'package:sample_flutter_app/views/widgets/components/form_inputs/primary_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sample_flutter_app/views/widgets/layouts/initial_layout.dart';

class ConfirmScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ConfirmBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>()),
      child: InitialLayout(
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return BlocListener<ConfirmBloc, ConfirmState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
          if(formStatus is SubmissionSuccess){
            //_showSnackBar(context, "Success");
            //context.read<NavCubit>().navigate(context,"/home");
          }
        },
        child: confirmForm());
  }

  Widget confirmForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Form Field Section
            phoneField(),
            const SizedBox(height: 30),
            passwordField(),
            const SizedBox(height: 30),
            confirmButton()
          ],
        ),
      ),
    );
  }

  Widget phoneField() {
    return BlocBuilder<ConfirmBloc, ConfirmState>(builder: (context, state) {
      return PrimaryTextField(
          icon: Icon(Icons.person),
          label: "Phone number",
          validator: (value) => InputValidator.validatePhone(value),
          //controller: phoneNumberController,
          onChanged: (value) => context.read<ConfirmBloc>().add(
                ConfirmPhoneChanged(phone: value),
              ));
    });
  }

  Widget passwordField() {
    return BlocBuilder<ConfirmBloc, ConfirmState>(builder: (context, state) {
      return PrimaryTextField(
        icon: Icon(Icons.security),
        label: "Password",
        obscure: true,
        validator: (value) => InputValidator.validatePassword(value),
        //controller: phoneNumberController,
        onChanged: (value) => context.read<ConfirmBloc>().add(
              ConfirmPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget confirmButton() {
    return BlocBuilder<ConfirmBloc, ConfirmState>(builder: (context, state) {
      if (state.formStatus is FormSubmitting) {
        return CircularProgressIndicator();
      }
      return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            context.read<ConfirmBloc>().add(ConfirmSubmitted());
          }
        },
        child: Text("Confirm Registration"),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
