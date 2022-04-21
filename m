Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0750A41B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390085AbiDUPcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390074AbiDUPcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD9B434A5;
        Thu, 21 Apr 2022 08:29:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B70351F752;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650554954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F84LWE6pmBGWn9jI5bFG+OFK1sWonzU5rO+gV0ksM64=;
        b=OtOOtqVigA0PQ9lMg1rsz6QwX3aM5bMPjeOLYNshgcPpL0R+FlnQeEnk25VtBS8IOwZOmQ
        Q3xg1j+mwqGvxaJtaq2xY0yX3BPhkZOkTwkxwT+uz8FagzS3kT+7tZrXcmNhYnZDGdj/Ii
        yTUUmbMfFFW9IZ8yRQjJz5k/ekUFH0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650554954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F84LWE6pmBGWn9jI5bFG+OFK1sWonzU5rO+gV0ksM64=;
        b=4mjA9lrdePaVSZhVjpBgVSfPtvML0clVYtkfbnIQ9EJhpISGZ8jqYYBs1azUAe1O4ePDO5
        VMhRGA6djR/GXxDA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id A063B2C14B;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 4/5] selftests: firmware: Simplify test patterns
Date:   Thu, 21 Apr 2022 17:29:07 +0200
Message-Id: <20220421152908.4718-5-tiwai@suse.de>
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

The test patterns are almost same in three sequential tests.
Make the unified helper function for improving the readability.

Link: https://lore.kernel.org/all/20210127154939.13288-1-tiwai@suse.de/
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../selftests/firmware/fw_filesystem.sh       | 106 +++++-------------
 1 file changed, 30 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index 3ac09b401a83..4a574be8b862 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -437,6 +437,32 @@ test_request_partial_firmware_into_buf()
 	echo "OK"
 }
 
+do_tests ()
+{
+	mode="$1"
+	suffix="$2"
+
+	for i in $(seq 1 5); do
+		test_batched_request_firmware$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_batched_request_firmware_into_buf$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_batched_request_firmware_direct$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_request_firmware_nowait_uevent$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_request_firmware_nowait_custom$suffix $i $mode
+	done
+}
+
 # Only continue if batched request triggers are present on the
 # test-firmware driver
 test_config_present
@@ -444,25 +470,7 @@ test_config_present
 # test with the file present
 echo
 echo "Testing with the file present..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware $i normal
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf $i normal
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct $i normal
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent $i normal
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom $i normal
-done
+do_tests normal
 
 # Partial loads cannot use fallback, so do not repeat tests.
 test_request_partial_firmware_into_buf 0 10
@@ -474,25 +482,7 @@ test_request_partial_firmware_into_buf 2 10
 # a hung task, which would require a hard reset.
 echo
 echo "Testing with the file missing..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom_nofile $i
-done
+do_tests nofile _nofile
 
 # Partial loads cannot use fallback, so do not repeat tests.
 test_request_partial_firmware_into_buf_nofile 0 10
@@ -508,49 +498,13 @@ $RUN_XZ -k $FW_INTO_BUF
 config_set_name $NAME
 echo
 echo "Testing with both plain and xz files present..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware $i both
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf $i both
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct $i both
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent $i both
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom $i both
-done
+do_tests both
 
 # test with only xz file present
 mv "$FW" "${FW}-orig"
 mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
 echo
 echo "Testing with only xz file present..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom $i xzonly
-done
+do_tests xzonly
 
 exit 0
-- 
2.31.1

