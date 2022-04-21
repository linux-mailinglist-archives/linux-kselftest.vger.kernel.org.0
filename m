Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406F650A426
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390088AbiDUPcL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDUPcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E1B434B5;
        Thu, 21 Apr 2022 08:29:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C615A1F753;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650554954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d86TMwuYfc0L/s5u+Dv/gmYIbvdOozC/SbPUZ7iVflk=;
        b=k16suIDQ+Ijvy7+enXqNR1V6q4/6Z3FoJs+dlXB/U6NwB2CDTbRYY6DbhpaS/oDSa51q4V
        uYd+0FXUtdFIjGLVBLQwiqk+tGt02sVlWtw09oBF7qM3Szn2b4HvpcE9yyZJN3rkK5h9LL
        8imV6wqcX4sIC8M2mvGKPa54217w20o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650554954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d86TMwuYfc0L/s5u+Dv/gmYIbvdOozC/SbPUZ7iVflk=;
        b=60qh+94NAoUUGT11rmhnBbmScZpGw3qX5SD+GEOa3WoC77B7T7ckipTQybZbTirHt3Xeff
        SZxwSI/oHTZZv1CA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id B23602C141;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 5/5] selftests: firmware: Add ZSTD compressed file tests
Date:   Thu, 21 Apr 2022 17:29:08 +0200
Message-Id: <20220421152908.4718-6-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220421152908.4718-1-tiwai@suse.de>
References: <20220421152908.4718-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's similar like XZ compressed files.  For the simplicity, both XZ
and ZSTD tests are done in a single function.  The format is specified
via $COMPRESS_FORMAT and the compression function is pre-defined.

Link: https://lore.kernel.org/r/20210127154939.13288-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../selftests/firmware/fw_filesystem.sh       | 76 ++++++++++++++-----
 tools/testing/selftests/firmware/fw_lib.sh    | 12 ++-
 2 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index 4a574be8b862..1a99aea0549e 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -12,6 +12,7 @@ TEST_DIR=$(dirname $0)
 source $TEST_DIR/fw_lib.sh
 
 RUN_XZ="xz -C crc32 --lzma2=dict=2MiB"
+RUN_ZSTD="zstd -q"
 
 check_mods
 check_setup
@@ -213,7 +214,7 @@ read_firmwares()
 	else
 		fwfile="$FW"
 	fi
-	if [ "$1" = "xzonly" ]; then
+	if [ "$1" = "componly" ]; then
 		fwfile="${fwfile}-orig"
 	fi
 	for i in $(seq 0 3); do
@@ -237,7 +238,7 @@ read_partial_firmwares()
 		fwfile="${FW}"
 	fi
 
-	if [ "$1" = "xzonly" ]; then
+	if [ "$1" = "componly" ]; then
 		fwfile="${fwfile}-orig"
 	fi
 
@@ -411,10 +412,8 @@ test_request_firmware_nowait_custom()
 	config_unset_uevent
 	RANDOM_FILE_PATH=$(setup_random_file)
 	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
-	if [ "$2" = "both" ]; then
-		$RUN_XZ -k $RANDOM_FILE_PATH
-	elif [ "$2" = "xzonly" ]; then
-		$RUN_XZ $RANDOM_FILE_PATH
+	if [ -n "$2" -a "$2" != "normal" ]; then
+		compress_"$2"_"$COMPRESS_FORMAT" $RANDOM_FILE_PATH
 	fi
 	config_set_name $RANDOM_FILE
 	config_trigger_async
@@ -490,21 +489,58 @@ test_request_partial_firmware_into_buf_nofile 0 5
 test_request_partial_firmware_into_buf_nofile 1 6
 test_request_partial_firmware_into_buf_nofile 2 10
 
-test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
+test_request_firmware_compressed ()
+{
+	export COMPRESS_FORMAT="$1"
 
-# test with both files present
-$RUN_XZ -k $FW
-$RUN_XZ -k $FW_INTO_BUF
-config_set_name $NAME
-echo
-echo "Testing with both plain and xz files present..."
-do_tests both
+	# test with both files present
+	compress_both_"$COMPRESS_FORMAT" $FW
+	compress_both_"$COMPRESS_FORMAT" $FW_INTO_BUF
 
-# test with only xz file present
-mv "$FW" "${FW}-orig"
-mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
-echo
-echo "Testing with only xz file present..."
-do_tests xzonly
+	config_set_name $NAME
+	echo
+	echo "Testing with both plain and $COMPRESS_FORMAT files present..."
+	do_tests both
+
+	# test with only compressed file present
+	mv "$FW" "${FW}-orig"
+	mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
+
+	config_set_name $NAME
+	echo
+	echo "Testing with only $COMPRESS_FORMAT file present..."
+	do_tests componly
+
+	mv "${FW}-orig" "$FW"
+	mv "${FW_INTO_BUF}-orig" "$FW_INTO_BUF"
+}
+
+compress_both_XZ ()
+{
+	$RUN_XZ -k "$@"
+}
+
+compress_componly_XZ ()
+{
+	$RUN_XZ "$@"
+}
+
+compress_both_ZSTD ()
+{
+	$RUN_ZSTD -k "$@"
+}
+
+compress_componly_ZSTD ()
+{
+	$RUN_ZSTD --rm "$@"
+}
+
+if test "$HAS_FW_LOADER_COMPRESS_XZ" = "yes"; then
+	test_request_firmware_compressed XZ
+fi
+
+if test "$HAS_FW_LOADER_COMPRESS_ZSTD" = "yes"; then
+	test_request_firmware_compressed ZSTD
+fi
 
 exit 0
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 5b8c0fedee76..3fa8282b053b 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -62,7 +62,8 @@ check_setup()
 {
 	HAS_FW_LOADER_USER_HELPER="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)"
 	HAS_FW_LOADER_USER_HELPER_FALLBACK="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)"
-	HAS_FW_LOADER_COMPRESS="$(kconfig_has CONFIG_FW_LOADER_COMPRESS=y)"
+	HAS_FW_LOADER_COMPRESS_XZ="$(kconfig_has CONFIG_FW_LOADER_COMPRESS_XZ=y)"
+	HAS_FW_LOADER_COMPRESS_ZSTD="$(kconfig_has CONFIG_FW_LOADER_COMPRESS_ZSTD=y)"
 	PROC_FW_IGNORE_SYSFS_FALLBACK="0"
 	PROC_FW_FORCE_SYSFS_FALLBACK="0"
 
@@ -98,9 +99,14 @@ check_setup()
 
 	OLD_FWPATH="$(cat /sys/module/firmware_class/parameters/path)"
 
-	if [ "$HAS_FW_LOADER_COMPRESS" = "yes" ]; then
+	if [ "$HAS_FW_LOADER_COMPRESS_XZ" = "yes" ]; then
 		if ! which xz 2> /dev/null > /dev/null; then
-			HAS_FW_LOADER_COMPRESS=""
+			HAS_FW_LOADER_COMPRESS_XZ=""
+		fi
+	fi
+	if [ "$HAS_FW_LOADER_COMPRESS_ZSTD" = "yes" ]; then
+		if ! which zstd 2> /dev/null > /dev/null; then
+			HAS_FW_LOADER_COMPRESS_ZSTD=""
 		fi
 	fi
 }
-- 
2.31.1

