#!/bin/sh

no_pub=$1

rm -rf coverage/*

flutter test --coverage --suppress-analytics $no_pub

# "lib/features/XYZ/*" \
# "lib/core/*" \

lcov \
--directory lib/ \
--remove coverage/lcov.info \
"example/*" \
"lib/ui/*" \
"*service_locator.dart" \
"*failure.dart" \
"*_event.dart" \
"*.freezed.dart" \
"*_state.dart" \
"*mock.dart" \
"*.pb.dart" \
"*.pbenum.dart" \
"*.pbjson.dart" \
-o coverage/new_lcov.info

genhtml coverage/new_lcov.info \
-o coverage/html

            # genhtml coverage/new_lcov.info \
            # -o coverage/html

            # ## Run Dart tests and output them at directory `./coverage`:
            # dart run test --coverage=./coverage

            # ## Activate pacakge `coverage` (if needed):
            # dart pub global activate coverage

            # ## Format collected coverage to LCOV (only for directory "lib")
            # pub global run coverage:format_coverage \
            # --packages=.packages \
            # --report-on=lib \
            # --lcov \
            # -o ./coverage/lcov.info \
            # -i ./coverage

            # ## Generate LCOV report:
            # genhtml \
            # -o ./coverage/report ./coverage/lcov.info

## Open the HTML coverage report:
# open ./coverage/html/index.html