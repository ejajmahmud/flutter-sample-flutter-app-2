import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/auth/auth_nav_cubit.dart';
import 'package:sample_flutter_app/data/repositories/auth_repository.dart';
import 'package:sample_flutter_app/helpers/forms/form_submission_status.dart';
import 'package:sample_flutter_app/helpers/forms/input_validator.dart';
import 'package:sample_flutter_app/views/pages/auth/register/register_bloc.dart';
import 'package:sample_flutter_app/views/widgets/components/form_inputs/primary_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sample_flutter_app/views/widgets/layouts/initial_layout.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterBloc(
          authRepo: context.read<AuthRepository>(),
          authNavCubit: context.read<AuthNavCubit>()),
      child: InitialLayout(
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
        child: registerForm());
  }

  Widget registerForm() {
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
            registerButton()
          ],
        ),
      ),
    );
  }

  Widget phoneField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return PrimaryTextField(
          icon: Icon(Icons.person),
          label: "Phone number",
          validator: (value) => InputValidator.validatePhone(value),
          //controller: phoneNumberController,
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterPhoneChanged(value),
          ));
    });
  }

  Widget passwordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return PrimaryTextField(
        icon: Icon(Icons.security),
        label: "Password",
        obscure: true,
        validator: (value) => InputValidator.validatePassword(value),
        //controller: phoneNumberController,
        onChanged: (value) => context.read<RegisterBloc>().add(
          RegisterPasswordChanged(value),
        ),
      );
    });
  }

  Widget registerButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      if (state.formStatus is FormSubmitting) {
        return CircularProgressIndicator();
      }
      return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            context.read<RegisterBloc>().add(RegisterSubmitted());
          }
        },
        child: Text("Register"),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
