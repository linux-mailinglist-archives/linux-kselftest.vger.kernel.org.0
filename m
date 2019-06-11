Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8583CB5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390673AbfFKM0n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 08:26:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390603AbfFKM0h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 08:26:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06CE1B030;
        Tue, 11 Jun 2019 12:26:36 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2.5 3/3] selftests: firmware: Add compressed firmware tests
Date:   Tue, 11 Jun 2019 14:26:26 +0200
Message-Id: <20190611122626.28059-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190611122626.28059-1-tiwai@suse.de>
References: <20190611122626.28059-1-tiwai@suse.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds the test cases for checking compressed firmware load.
Two more cases are added to fw_filesystem.sh:
- Both a plain file and an xz file are present, and load the former
- Only an xz file is present, and load without '.xz' suffix

The tests are enabled only when CONFIG_FW_LOADER_COMPRESS is enabled
and xz program is installed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/firmware/fw_filesystem.sh | 73 +++++++++++++++++++----
 tools/testing/selftests/firmware/fw_lib.sh        |  7 +++
 tools/testing/selftests/firmware/fw_run_tests.sh  |  1 +
 3 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index a4320c4b44dc..f901076aa2ea 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -153,13 +153,18 @@ config_set_read_fw_idx()
 
 read_firmwares()
 {
+	if [ "$1" = "xzonly" ]; then
+		fwfile="${FW}-orig"
+	else
+		fwfile="$FW"
+	fi
 	for i in $(seq 0 3); do
 		config_set_read_fw_idx $i
 		# Verify the contents are what we expect.
 		# -Z required for now -- check for yourself, md5sum
 		# on $FW and DIR/read_firmware will yield the same. Even
 		# cmp agrees, so something is off.
-		if ! diff -q -Z "$FW" $DIR/read_firmware 2>/dev/null ; then
+		if ! diff -q -Z "$fwfile" $DIR/read_firmware 2>/dev/null ; then
 			echo "request #$i: firmware was not loaded" >&2
 			exit 1
 		fi
@@ -246,17 +251,17 @@ test_request_firmware_nowait_custom_nofile()
 
 test_batched_request_firmware()
 {
-	echo -n "Batched request_firmware() try #$1: "
+	echo -n "Batched request_firmware() $2 try #$1: "
 	config_reset
 	config_trigger_sync
-	read_firmwares
+	read_firmwares $2
 	release_all_firmware
 	echo "OK"
 }
 
 test_batched_request_firmware_direct()
 {
-	echo -n "Batched request_firmware_direct() try #$1: "
+	echo -n "Batched request_firmware_direct() $2 try #$1: "
 	config_reset
 	config_set_sync_direct
 	config_trigger_sync
@@ -266,7 +271,7 @@ test_batched_request_firmware_direct()
 
 test_request_firmware_nowait_uevent()
 {
-	echo -n "Batched request_firmware_nowait(uevent=true) try #$1: "
+	echo -n "Batched request_firmware_nowait(uevent=true) $2 try #$1: "
 	config_reset
 	config_trigger_async
 	release_all_firmware
@@ -275,11 +280,16 @@ test_request_firmware_nowait_uevent()
 
 test_request_firmware_nowait_custom()
 {
-	echo -n "Batched request_firmware_nowait(uevent=false) try #$1: "
+	echo -n "Batched request_firmware_nowait(uevent=false) $2 try #$1: "
 	config_reset
 	config_unset_uevent
 	RANDOM_FILE_PATH=$(setup_random_file)
 	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
+	if [ "$2" = "both" ]; then
+		xz -9 -C crc32 -k $RANDOM_FILE_PATH
+	elif [ "$2" = "xzonly" ]; then
+		xz -9 -C crc32 $RANDOM_FILE_PATH
+	fi
 	config_set_name $RANDOM_FILE
 	config_trigger_async
 	release_all_firmware
@@ -294,19 +304,19 @@ test_config_present
 echo
 echo "Testing with the file present..."
 for i in $(seq 1 5); do
-	test_batched_request_firmware $i
+	test_batched_request_firmware $i normal
 done
 
 for i in $(seq 1 5); do
-	test_batched_request_firmware_direct $i
+	test_batched_request_firmware_direct $i normal
 done
 
 for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent $i
+	test_request_firmware_nowait_uevent $i normal
 done
 
 for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom $i
+	test_request_firmware_nowait_custom $i normal
 done
 
 # Test for file not found, errors are expected, the failure would be
@@ -329,4 +339,47 @@ for i in $(seq 1 5); do
 	test_request_firmware_nowait_custom_nofile $i
 done
 
+test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
+
+# test with both files present
+xz -9 -C crc32 -k $FW
+config_set_name $NAME
+echo
+echo "Testing with both plain and xz files present..."
+for i in $(seq 1 5); do
+	test_batched_request_firmware $i both
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_direct $i both
+done
+
+for i in $(seq 1 5); do
+	test_request_firmware_nowait_uevent $i both
+done
+
+for i in $(seq 1 5); do
+	test_request_firmware_nowait_custom $i both
+done
+
+# test with only xz file present
+mv "$FW" "${FW}-orig"
+echo
+echo "Testing with only xz file present..."
+for i in $(seq 1 5); do
+	test_batched_request_firmware $i xzonly
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_direct $i xzonly
+done
+
+for i in $(seq 1 5); do
+	test_request_firmware_nowait_uevent $i xzonly
+done
+
+for i in $(seq 1 5); do
+	test_request_firmware_nowait_custom $i xzonly
+done
+
 exit 0
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 1cbb12e284a6..f236cc295450 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -50,6 +50,7 @@ check_setup()
 {
 	HAS_FW_LOADER_USER_HELPER="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)"
 	HAS_FW_LOADER_USER_HELPER_FALLBACK="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)"
+	HAS_FW_LOADER_COMPRESS="$(kconfig_has CONFIG_FW_LOADER_COMPRESS=y)"
 	PROC_FW_IGNORE_SYSFS_FALLBACK="0"
 	PROC_FW_FORCE_SYSFS_FALLBACK="0"
 
@@ -84,6 +85,12 @@ check_setup()
 	fi
 
 	OLD_FWPATH="$(cat /sys/module/firmware_class/parameters/path)"
+
+	if [ "$HAS_FW_LOADER_COMPRESS" = "yes" ]; then
+		if ! which xz 2> /dev/null > /dev/null; then
+			HAS_FW_LOADER_COMPRESS=""
+		fi
+	fi
 }
 
 verify_reqs()
diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
index cffdd4eb0a57..8e14d555c197 100755
--- a/tools/testing/selftests/firmware/fw_run_tests.sh
+++ b/tools/testing/selftests/firmware/fw_run_tests.sh
@@ -11,6 +11,7 @@ source $TEST_DIR/fw_lib.sh
 
 export HAS_FW_LOADER_USER_HELPER=""
 export HAS_FW_LOADER_USER_HELPER_FALLBACK=""
+export HAS_FW_LOADER_COMPRESS=""
 
 run_tests()
 {
-- 
2.16.4

