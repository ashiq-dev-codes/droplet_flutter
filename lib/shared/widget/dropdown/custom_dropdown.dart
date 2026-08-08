import 'package:corextra/corextra.dart';
import 'package:droplet_flutter/shared/text_styles/app_text.dart';
import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.text,
    this.validator,
    this.labelText,
    this.itemBuilder,
    required this.items,
    required this.value,
    this.isLoading = false,
    required this.hintText,
    this.isDisabled = false,
    required this.onChanged,
    this.havingError = false,
    this.selectedItemBuilder,
  }) : assert(
         text != null || itemBuilder != null,
         'You must provide either text or itemBuilder',
       );
  final T? value;
  final List<T> items;
  final bool isLoading;
  final bool isDisabled;
  final bool havingError;
  final String? hintText;
  final String? labelText;
  final String Function(T? value)? text;
  final void Function(T? value) onChanged;
  final Widget Function(T? item)? itemBuilder;
  final String? Function(T? value)? validator;
  final Widget Function(T? item)? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDisabled
        ? Colors.grey.shade400
        : AppColors.paleGrayColor;
    final textColor = isDisabled ? Colors.grey.shade500 : AppColors.blackColor;

    return FormField<T>(
      validator: validator,
      initialValue: value,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isStringEmpty(labelText))
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 11, bottom: 5),
                child: Text(
                  labelText ?? '',
                  style: AppText.regular.textStyle(size: 13),
                ),
              ),
            Opacity(
              opacity: isDisabled ? 0.5 : 1,
              child: AbsorbPointer(
                absorbing: isLoading || isDisabled || havingError,
                child: DropdownButtonHideUnderline(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(width: 1, color: borderColor),
                    ),
                    child: DropdownButton<T>(
                      value: value,
                      elevation: 3,
                      isExpanded: true,
                      menuMaxHeight: 300,
                      padding: EdgeInsets.zero,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      onChanged: (value) {
                        onChanged(value);
                        state.didChange(value);
                      },
                      hint: isStringEmpty(hintText)
                          ? null
                          : Text(
                              hintText ?? '',
                              style: AppText.medium.textStyle(
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                      icon: isLoading
                          ? CupertinoActivityIndicator(radius: 9)
                          : havingError
                          ? Icon(
                              Icons.error,
                              size: 20,
                              color: AppColors.error600,
                            )
                          : Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 20,
                              color: textColor,
                            ),
                      items: List.generate(
                        items.length,
                        (int index) => DropdownMenuItem<T>(
                          value: items[index],
                          child:
                              itemBuilder?.call(items[index]) ??
                              Text(
                                text?.call(items[index]) ?? '',
                                style: AppText.regular.textStyle(
                                  size: 16,
                                  color: textColor,
                                ),
                              ),
                        ),
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return List.generate(
                          items.length,
                          (int index) => Align(
                            alignment: AlignmentDirectional.centerStart,
                            child:
                                selectedItemBuilder?.call(items[index]) ??
                                Text(
                                  text?.call(items[index]) ?? '',
                                  style: AppText.regular.textStyle(
                                    size: 16,
                                    color: textColor,
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 1, start: 13),
                child: Text(
                  state.errorText ?? '',
                  style: AppText.regular.textStyle(
                    size: 12,
                    color: AppColors.error800,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
