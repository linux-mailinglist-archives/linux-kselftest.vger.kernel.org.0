Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09776771489
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjHFLaX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjHFLaX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 07:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB319C;
        Sun,  6 Aug 2023 04:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD9160EF3;
        Sun,  6 Aug 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884DAC433C7;
        Sun,  6 Aug 2023 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691321421;
        bh=4rZYhkkYaqglyidOji7LtBcwDfefkF7WMmbfz85EO1o=;
        h=From:Date:Subject:To:Cc:From;
        b=hyf4n5a8zjNg9YAo9pdJA3a4/t3UlVbxnlPvuNodFDTtAX9p7lyjTgkF2kOQoIbzO
         7M1kA/3Ib3CA852hAcA2/G7/OYs3TXQuO+XU/EGowSYNam2DVY1oMRZJwwOsjzeFLQ
         Z4EHuA9fEhLpnOYk8EhFOZ3iyWHyy3775RWO4++XsejdngoQ1+eiv0Zo6d75+QBeMv
         usFEScOxOQMlUANu6GM5Fai0HTkN4jzq7tzGsOsz3Cm5ha9E6ITZdDm6OcYHJtxDBm
         RDiBVqiZs82AwcwVclm6iAbMTFB4p60U5E6R13JDmnFISe9jGbFxc5HduzihIIbWdq
         8mcVE8/TKH6EQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 06 Aug 2023 12:29:59 +0100
Subject: [PATCH] selftests/user_events: Reenable build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-kselftest-user-events-v1-1-9c5b368bd062@kernel.org>
X-B4-Tracking: v=1; b=H4sIADaEz2QC/x3MQQqDMBBG4avIrB2IqQXxKqULY/+pgxJLJoog3
 r3B5Vt87yRDUhj11UkJu5qusURTVzROQ/yC9VOavPMP17knz4ZFMizzVihjR8zGaANEOt8EJ1T
 sL0H0uL+v93X9AT0WneVnAAAA
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4rZYhkkYaqglyidOji7LtBcwDfefkF7WMmbfz85EO1o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkz4RK2tCf5fclmkoVI4Y9/GhB+acyqpm/d72G/
 53u5CAaFsiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZM+ESgAKCRAk1otyXVSH
 0M1mB/497nEozvx0TlOBZWs4r+hejz8DGxxWwn51BlQmoiJqnJvC1pQA9QBfixm6dON1TwsZUCq
 aafrEotyDjp+/zeIV0L1IrzML4xdq9P5/7WUjXIQIq4+ANiAOg7mrynqLxUMfNsal7RONEtfyyO
 DCKn2ENhd5/8WoVveyV2EDQr72XTNboU/XQlsCkt+2pT1bq8zBWb9CJxSuKe+eliURF8u/xpxvg
 CKFai2GDzRKy3Bf+lYIel1Wq84CO89TSk8d812nqweWkDIR1qEBrWO2WR77R4AebJQHDXyy/tcF
 OEFaZMquNp8TEPDCvPg62K0hxaOLv1+MFQWnD90XbBppn0G5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The user_events selftests were removed from the standard set of
selftests due to the uapi header it relies on having been temporarily
removed.  That header is now reinstated so we can reenable the tests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/Makefile             | 1 +
 tools/testing/selftests/user_events/Makefile | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 666b56f22a41..4e221bb620b4 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -89,6 +89,7 @@ TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += tty
 TARGETS += user
+TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
 TARGETS += x86
diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index 9e95bd41b0b4..10fcd0066203 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -2,14 +2,6 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDLIBS += -lrt -lpthread -lm
 
-# Note:
-# This test depends on <linux/user_events.h> exported in uapi
-# The following commit removed user_events.h out of uapi:
-# commit 5cfff569cab8bf544bab62c911c5d6efd5af5e05
-# tracing: Move user_events.h temporarily out of include/uapi
-# This test will not compile until user_events.h is added
-# back to uapi.
-
 TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test
 
 TEST_FILES := settings

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230805-kselftest-user-events-e4beff821b0f

Best regards,
-- 
Mark Brown <broonie@kernel.org>

