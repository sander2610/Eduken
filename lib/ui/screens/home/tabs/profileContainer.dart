import 'package:eschool_teacher/cubits/authCubit.dart';
import 'package:eschool_teacher/ui/widgets/customUserProfileImageWidget.dart';
import 'package:eschool_teacher/ui/widgets/dynamicFieldListContainer.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/utils/assets.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({super.key});

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  Widget _buildProfileDetailsTile({
    required String label,
    required String value,
    required String iconUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1a212121),
                  offset: Offset(0, 10),
                  blurRadius: 16,
                ),
              ],
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(iconUrl),
          ),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    value.trim().isEmpty ? '-' : value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teacher = context.read<AuthCubit>().getTeacherDetails();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: UiUtils.getScrollViewBottomPadding(context),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.27,
              width: MediaQuery.sizeOf(context).width,
              child: Stack(
                children: [
                  ScreenTopBackgroundContainer(
                    heightPercentage: 0.2,
                    child: Text(
                      UiUtils.getTranslatedLabel(context, profileKey),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: UiUtils.screenTitleFontSize,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: MediaQuery.sizeOf(context).width * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: CustomUserProfileImageWidget(
                          profileUrl: teacher.image,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              teacher.getFullName(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.075,
              ),
              child: Divider(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.075,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      UiUtils.getTranslatedLabel(context, personalDetailsKey),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, emailKey),
                    value: teacher.email,
                    iconUrl: Assets.userProIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, phoneNumberKey),
                    value: teacher.mobile,
                    iconUrl: Assets.phoneCall,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, dateOfBirthKey),
                    value: DateTime.tryParse(teacher.dob) == null
                        ? teacher.dob
                        : UiUtils.formatDate(DateTime.tryParse(teacher.dob)!),
                    iconUrl: Assets.userProDobIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, genderKey),
                    value: teacher.gender,
                    iconUrl: Assets.gender,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(
                      context,
                      qualificationKey,
                    ),
                    value: teacher.qualification,
                    iconUrl: Assets.qualification,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(
                      context,
                      currentAddressKey,
                    ),
                    value: teacher.currentAddress,
                    iconUrl: Assets.userProAddressIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(
                      context,
                      permanentAddressKey,
                    ),
                    value: teacher.permanentAddress,
                    iconUrl: Assets.userProAddressIcon,
                  ),
                  if (teacher.dynamicFields?.isNotEmpty ?? false) ...[
                    Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.75),
                    ),
                    const SizedBox(height: 10),
                    DynamicFieldListContainer(
                      dynamicFields: teacher.dynamicFields!,
                    ),
                  ],
                  const SizedBox(height: 7.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
