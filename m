Return-Path: <linux-kselftest+bounces-3903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A86844B39
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE62C290A6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B339FF3;
	Wed, 31 Jan 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lg8GqeAR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4639FE0;
	Wed, 31 Jan 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741311; cv=none; b=NXcqTw4NLcQwu9N6UCy7/ssIWo1ERdUHuozAAExV0zVxaiknoAGk5MipkDCnEDlVhtauvPJrUws3onWxMuPmc+GRUWvUq8U40QQcit6iJ4PpX93Yj37OvtPmRhaqUr3lfakNn6K8TL7UjLXwztOPsCXGAxeKYoXdqckO+VDA/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741311; c=relaxed/simple;
	bh=GA8LHxoaAEo0EwxcrTssv7MBsrZGuVs7qdoQXkq0RQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AZYqgKXVUI3NNJ5Tl28cPpstvpPB0EzOfyrBQbdAItI72c/lA184z/XAX5nLUEHJkI6iV8Wykv6/KMM95v0moNe0HPlFq/IYO5CUgbYNIiiThgO75/wq258glu8i4C1DanzvEv6rex7DyJOHLP60Qmh+H+ykPxRLF5W/fIUgW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lg8GqeAR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706741307;
	bh=GA8LHxoaAEo0EwxcrTssv7MBsrZGuVs7qdoQXkq0RQw=;
	h=From:Date:Subject:To:Cc:From;
	b=Lg8GqeAR4AL2ycD1m/1QC72XWvxhbS2aXksNxnHflZoZ8dQyE2mzeBIa5QUeyd6e1
	 opxlcl90JnPcXUuQYO4LKkVeoga6UTHGss9SZaj4tuURogSfAJar6JMDdNJudnPPdV
	 B7TOHAZBUt6P60MwpgrtAUHwc8kykb/xcheBH1LX5/0Yry6F1/YyqfUHNFA0uzTTG4
	 1hzJSpD9PKHZUndaaNnAaIl7YtrUbKz3l6YndsBHCdIagjId+DU1I0fb82hFqeAVfH
	 myM4ELhx+8VbaHn/OQiCcidpPAC/l4ownGBd1SDcGbsHfJjlIeoK/alR6SgahVi+UH
	 eWj1lgBBucCCw==
Received: from [192.168.1.211] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1DDDE3781182;
	Wed, 31 Jan 2024 22:48:25 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 31 Jan 2024 17:48:01 -0500
Subject: [PATCH] selftests: Add test to verify power supply properties
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-power-supply-kselftest-v1-1-7ead5645c004@collabora.com>
X-B4-Tracking: v=1; b=H4sIACDOumUC/x3MTQ5AMBBA4avIrE3SFiGuIhboYEJoOn4j7q6x/
 BbvPSDkmQTK6AFPBwuvS4COI+jGZhkI2QaDUSZV2hh060keZXduvnESmvuNZMMiSTOlc9u1toU
 QO089X/+4qt/3A7e03OxoAAAA
To: Shuah Khan <shuah@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Add a kselftest that verifies power supply properties from sysfs and
uevent. It checks whether they are present, readable and return valid
values.

This initial set of properties is not comprehensive, but rather the ones
that I was able to validate locally.

Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
To give an idea of the output of the test, here's a short (trimmed)
snippet:

TAP version 13
1..33
 # Testing device BAT0
ok 21 BAT0.sysfs.voltage_max # SKIP
 # Reported: '7600000' uV (7.6 V)
ok 22 BAT0.sysfs.voltage_min_design
 # Totals: pass:19 fail:0 xfail:0 xpass:0 skip:14 error:0

Some things noticed during the development of this patch which may or
may not need to be addressed:
- input_current_limit, input_voltage_limit reported -1 on one of the
  platforms, despite that value not being described in the ABI doc [1].
- voltage_min_design, voltage_max_design are missing in the ABI doc,
  though are mentioned in the rst documentation [2]
- the scope property is entirely undocumented

[1] Documentation/ABI/testing/sysfs-class-power 
[2] Documentation/power/power_supply_class.rst 
---
 MAINTAINERS                                        |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/power_supply/Makefile      |   4 +
 tools/testing/selftests/power_supply/helpers.sh    | 178 +++++++++++++++++++++
 .../power_supply/test_power_supply_properties.sh   | 114 +++++++++++++
 5 files changed, 298 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad5bec15bf0f..f8f620746934 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17524,6 +17524,7 @@ F:	Documentation/devicetree/bindings/power/supply/
 F:	drivers/power/supply/
 F:	include/linux/power/
 F:	include/linux/power_supply.h
+F:	tools/testing/selftests/power_supply/
 
 POWERNV OPERATOR PANEL LCD DISPLAY DRIVER
 M:	Suraj Jitindar Singh <sjitindarsingh@gmail.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c5b4574045b3..7e5960cda08c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -67,6 +67,7 @@ TARGETS += nsfs
 TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
+TARGETS += power_supply
 TARGETS += powerpc
 TARGETS += prctl
 TARGETS += proc
diff --git a/tools/testing/selftests/power_supply/Makefile b/tools/testing/selftests/power_supply/Makefile
new file mode 100644
index 000000000000..44f0658d3d2e
--- /dev/null
+++ b/tools/testing/selftests/power_supply/Makefile
@@ -0,0 +1,4 @@
+TEST_PROGS := test_power_supply_properties.sh
+TEST_FILES := helpers.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/power_supply/helpers.sh b/tools/testing/selftests/power_supply/helpers.sh
new file mode 100644
index 000000000000..1ec90d7c9108
--- /dev/null
+++ b/tools/testing/selftests/power_supply/helpers.sh
@@ -0,0 +1,178 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2022, 2024 Collabora Ltd
+SYSFS_SUPPLIES=/sys/class/power_supply
+
+calc() {
+	awk "BEGIN { print $* }";
+}
+
+test_sysfs_prop() {
+	PROP="$1"
+	VALUE="$2" # optional
+
+	PROP_PATH="$SYSFS_SUPPLIES"/"$DEVNAME"/"$PROP"
+	TEST_NAME="$DEVNAME".sysfs."$PROP"
+
+	if [ -z "$VALUE" ]; then
+		ktap_test_result "$TEST_NAME" [ -f "$PROP_PATH" ]
+	else
+		ktap_test_result "$TEST_NAME" grep -q "$VALUE" "$PROP_PATH"
+	fi
+}
+
+to_human_readable_unit() {
+	VALUE="$1"
+	UNIT="$2"
+
+	case "$VALUE" in
+		*[!0-9]* ) return ;; # Not a number
+	esac
+
+	if [ "$UNIT" = "uA" ]; then
+		new_unit="mA"
+		div=1000
+	elif [ "$UNIT" = "uV" ]; then
+		new_unit="V"
+		div=1000000
+	elif [ "$UNIT" = "uAh" ]; then
+		new_unit="Ah"
+		div=1000000
+	elif [ "$UNIT" = "uW" ]; then
+		new_unit="mW"
+		div=1000
+	elif [ "$UNIT" = "uWh" ]; then
+		new_unit="Wh"
+		div=1000000
+	else
+		return
+	fi
+
+	value_converted=$(calc "$VALUE"/"$div")
+	echo "$value_converted" "$new_unit"
+}
+
+_check_sysfs_prop_available() {
+	PROP=$1
+
+	PROP_PATH="$SYSFS_SUPPLIES"/"$DEVNAME"/"$PROP"
+	TEST_NAME="$DEVNAME".sysfs."$PROP"
+
+	if [ ! -e "$PROP_PATH" ] ; then
+		ktap_test_skip "$TEST_NAME"
+		return 1
+	fi
+
+	if ! cat "$PROP_PATH" >/dev/null; then
+		ktap_print_msg "Failed to read"
+		ktap_test_fail "$TEST_NAME"
+		return 1
+	fi
+
+	return 0
+}
+
+test_sysfs_prop_optional() {
+	PROP=$1
+	UNIT=$2 # optional
+
+	TEST_NAME="$DEVNAME".sysfs."$PROP"
+
+	_check_sysfs_prop_available "$PROP" || return
+	DATA=$(cat "$SYSFS_SUPPLIES"/"$DEVNAME"/"$PROP")
+
+	ktap_print_msg "Reported: '$DATA' $UNIT ($(to_human_readable_unit "$DATA" "$UNIT"))"
+	ktap_test_pass "$TEST_NAME"
+}
+
+test_sysfs_prop_optional_range() {
+	PROP=$1
+	MIN=$2
+	MAX=$3
+	UNIT=$4 # optional
+
+	TEST_NAME="$DEVNAME".sysfs."$PROP"
+
+	_check_sysfs_prop_available "$PROP" || return
+	DATA=$(cat "$SYSFS_SUPPLIES"/"$DEVNAME"/"$PROP")
+
+	if [ "$DATA" -lt "$MIN" ] || [ "$DATA" -gt "$MAX" ]; then
+		ktap_print_msg "'$DATA' is out of range (min=$MIN, max=$MAX)"
+		ktap_test_fail "$TEST_NAME"
+	else
+		ktap_print_msg "Reported: '$DATA' $UNIT ($(to_human_readable_unit "$DATA" "$UNIT"))"
+		ktap_test_pass "$TEST_NAME"
+	fi
+}
+
+test_sysfs_prop_optional_list() {
+	PROP=$1
+	LIST=$2
+
+	TEST_NAME="$DEVNAME".sysfs."$PROP"
+
+	_check_sysfs_prop_available "$PROP" || return
+	DATA=$(cat "$SYSFS_SUPPLIES"/"$DEVNAME"/"$PROP")
+
+	valid=0
+
+	OLDIFS=$IFS
+	IFS=","
+	for item in $LIST; do
+		if [ "$DATA" = "$item" ]; then
+			valid=1
+			break
+		fi
+	done
+	if [ "$valid" -eq 1 ]; then
+		ktap_print_msg "Reported: '$DATA'"
+		ktap_test_pass "$TEST_NAME"
+	else
+		ktap_print_msg "'$DATA' is not a valid value for this property"
+		ktap_test_fail "$TEST_NAME"
+	fi
+	IFS=$OLDIFS
+}
+
+dump_file() {
+	FILE="$1"
+	while read -r line; do
+		ktap_print_msg "$line"
+	done < "$FILE"
+}
+
+__test_uevent_prop() {
+	PROP="$1"
+	OPTIONAL="$2"
+	VALUE="$3" # optional
+
+	UEVENT_PATH="$SYSFS_SUPPLIES"/"$DEVNAME"/uevent
+	TEST_NAME="$DEVNAME".uevent."$PROP"
+
+	if ! grep -q "POWER_SUPPLY_$PROP=" "$UEVENT_PATH"; then
+		if [ "$OPTIONAL" -eq 1 ]; then
+			ktap_test_skip "$TEST_NAME"
+		else
+			ktap_print_msg "Missing property"
+			ktap_test_fail "$TEST_NAME"
+		fi
+		return
+	fi
+
+	if ! grep -q "POWER_SUPPLY_$PROP=$VALUE" "$UEVENT_PATH"; then
+		ktap_print_msg "Invalid value for uevent property, dumping..."
+		dump_file "$UEVENT_PATH"
+		ktap_test_fail "$TEST_NAME"
+	else
+		ktap_test_pass "$TEST_NAME"
+	fi
+}
+
+test_uevent_prop() {
+	__test_uevent_prop "$1" 0 "$2"
+}
+
+test_uevent_prop_optional() {
+	__test_uevent_prop "$1" 1 "$2"
+}
diff --git a/tools/testing/selftests/power_supply/test_power_supply_properties.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
new file mode 100755
index 000000000000..df272dfe1d2a
--- /dev/null
+++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2022, 2024 Collabora Ltd
+#
+# This test validates the power supply uAPI: namely, the files in sysfs and
+# lines in uevent that expose the power supply properties.
+#
+# By default all power supplies available are tested. Optionally the name of a
+# power supply can be passed as a parameter to test only that one instead.
+DIR="$(dirname "$(readlink -f "$0")")"
+
+. "${DIR}"/../kselftest/ktap_helpers.sh
+
+. "${DIR}"/helpers.sh
+
+count_tests() {
+	SUPPLIES=$1
+
+	# This needs to be updated every time a new test is added.
+	NUM_TESTS=33
+
+	total_tests=0
+
+	for i in $SUPPLIES; do
+		total_tests=$(("$total_tests" + "$NUM_TESTS"))
+	done
+
+	echo "$total_tests"
+}
+
+ktap_print_header
+
+SYSFS_SUPPLIES=/sys/class/power_supply/
+
+if [ $# -eq 0 ]; then
+	supplies=$(ls "$SYSFS_SUPPLIES")
+else
+	supplies=$1
+fi
+
+ktap_set_plan "$(count_tests "$supplies")"
+
+for DEVNAME in $supplies; do
+	ktap_print_msg Testing device "$DEVNAME"
+
+	if [ ! -d "$SYSFS_SUPPLIES"/"$DEVNAME" ]; then
+		ktap_test_fail "$DEVNAME".exists
+		ktap_exit_fail_msg Device does not exist
+	fi
+
+	ktap_test_pass "$DEVNAME".exists
+
+	test_uevent_prop NAME "$DEVNAME"
+
+	test_sysfs_prop type
+	SUPPLY_TYPE=$(cat "$SYSFS_SUPPLIES"/"$DEVNAME"/type)
+	# This fails on kernels < 5.8 (needs 2ad3d74e3c69f)
+	test_uevent_prop TYPE "$SUPPLY_TYPE"
+
+	test_sysfs_prop_optional usb_type
+
+	test_sysfs_prop_optional_range online 0 2
+	test_sysfs_prop_optional_range present 0 1
+
+	test_sysfs_prop_optional_list status "Unknown","Charging","Discharging","Not charging","Full"
+
+	# Capacity is reported as percentage, thus any value less than 0 and
+	# greater than 100 are not allowed.
+	test_sysfs_prop_optional_range capacity 0 100 "%"
+
+	test_sysfs_prop_optional_list capacity_level "Unknown","Critical","Low","Normal","High","Full"
+
+	test_sysfs_prop_optional model_name
+	test_sysfs_prop_optional manufacturer
+	test_sysfs_prop_optional serial_number
+	test_sysfs_prop_optional_list technology "Unknown","NiMH","Li-ion","Li-poly","LiFe","NiCd","LiMn"
+
+	test_sysfs_prop_optional cycle_count
+
+	test_sysfs_prop_optional_list scope "Unknown","System","Device"
+
+	test_sysfs_prop_optional input_current_limit "uA"
+	test_sysfs_prop_optional input_voltage_limit "uV"
+
+	# Technically the power-supply class does not limit reported values.
+	# E.g. one could expose an RTC backup-battery, which goes below 1.5V or
+	# an electric vehicle battery with over 300V. But most devices do not
+	# have a step-up capable regulator behind the battery and operate with
+	# voltages considered safe to touch, so we limit the allowed range to
+	# 1.8V-60V to catch drivers reporting incorrectly scaled values. E.g. a
+	# common mistake is reporting data in mV instead of µV.
+	test_sysfs_prop_optional_range voltage_now 1800000 60000000 "uV"
+	test_sysfs_prop_optional_range voltage_min 1800000 60000000 "uV"
+	test_sysfs_prop_optional_range voltage_max 1800000 60000000 "uV"
+	test_sysfs_prop_optional_range voltage_min_design 1800000 60000000 "uV"
+	test_sysfs_prop_optional_range voltage_max_design 1800000 60000000 "uV"
+
+	# current based systems
+	test_sysfs_prop_optional current_now "uA"
+	test_sysfs_prop_optional current_max "uA"
+	test_sysfs_prop_optional charge_now "uAh"
+	test_sysfs_prop_optional charge_full "uAh"
+	test_sysfs_prop_optional charge_full_design "uAh"
+
+	# power based systems
+	test_sysfs_prop_optional power_now "uW"
+	test_sysfs_prop_optional energy_now "uWh"
+	test_sysfs_prop_optional energy_full "uWh"
+	test_sysfs_prop_optional energy_full_design "uWh"
+	test_sysfs_prop_optional energy_full_design "uWh"
+done
+
+ktap_finished

---
base-commit: f6b014bd664b49fe4b9aecd63de4179f81753e42
change-id: 20240122-power-supply-kselftest-8345017dcbdb

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


