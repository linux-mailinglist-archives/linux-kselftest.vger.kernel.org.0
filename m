Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0D50A429
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390076AbiDUPcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390073AbiDUPcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F12427D9;
        Thu, 21 Apr 2022 08:29:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9226B210E8;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650554954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RV5rQtKD1L0kzu5MzZI5K9lX63PDvyISkNn1Gj3yB4c=;
        b=wg5OXcqUYEx1GH/gW/JMLrPS3wcK6OHp0zGR2Onv9lH29Ffx2JCbbHlPhOdCy7IP9lujZ5
        SF6bd294Wd65NceIvCOeyT1tUoxEW2/XHF9L2XrFSDXxDKkPlO2rjsYRCLJ3l6GQCbdBvY
        XQJZn8RonhFCJHN/C71W7lHTDV/82ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650554954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RV5rQtKD1L0kzu5MzZI5K9lX63PDvyISkNn1Gj3yB4c=;
        b=sNE19Ip2mfrijXTfQT6xNI2DCmza4USfwXmi/DKeDC3Yx5Zlk9KIO3B8idnt88U5tCj8zK
        WTzodxUrV9dktxDg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 8910B2C14E;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] selftests: firmware: Use smaller dictionary for XZ compression
Date:   Thu, 21 Apr 2022 17:29:05 +0200
Message-Id: <20220421152908.4718-3-tiwai@suse.de>
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

The xz -9 option leads to an unnecessarily too large dictionary that
isn't really suitable for the kernel firmware loader.  Pass the
dictionary size explicitly, instead.

While we're at it, make the xz command call defined in $RUN_XZ for
simplicity.

Fixes: 108ae07c5036 ("selftests: firmware: Add compressed firmware tests")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/firmware/fw_filesystem.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index c2a2a100114b..731f011def78 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -11,6 +11,8 @@ TEST_REQS_FW_SET_CUSTOM_PATH="yes"
 TEST_DIR=$(dirname $0)
 source $TEST_DIR/fw_lib.sh
 
+RUN_XZ="xz -C crc32 --lzma2=dict=2MiB"
+
 check_mods
 check_setup
 verify_reqs
@@ -410,9 +412,9 @@ test_request_firmware_nowait_custom()
 	RANDOM_FILE_PATH=$(setup_random_file)
 	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
 	if [ "$2" = "both" ]; then
-		xz -9 -C crc32 -k $RANDOM_FILE_PATH
+		$RUN_XZ -k $RANDOM_FILE_PATH
 	elif [ "$2" = "xzonly" ]; then
-		xz -9 -C crc32 $RANDOM_FILE_PATH
+		$RUN_XZ $RANDOM_FILE_PATH
 	fi
 	config_set_name $RANDOM_FILE
 	config_trigger_async
@@ -501,7 +503,7 @@ test_request_partial_firmware_into_buf_nofile 2 10
 test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
 
 # test with both files present
-xz -9 -C crc32 -k $FW
+$RUN_XZ -k $FW
 config_set_name $NAME
 echo
 echo "Testing with both plain and xz files present..."
-- 
2.31.1

