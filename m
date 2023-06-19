Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1902C734BF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjFSG4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 02:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFSG4g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 02:56:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC013D;
        Sun, 18 Jun 2023 23:56:34 -0700 (PDT)
X-QQ-mid: bizesmtp69t1687157784tkcpo91n
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 14:56:23 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 5q30pvLz2ifOL7+eKkGV+l+xNjgAcXo7/um90KtQZbwA/x9c6K+kVT3CD9yTU
        3Ob2lb03K+MuRZrzURo0i1xFpf1vU1LTevUHfFqRpCwWRGD0eIuTYiXqF/P3Ks3VQdyMgtJ
        c2pjERcLylH93SwqS70SlZ6Ab+BArIU2bblM2vTaW8mRG2mnPDGk+8T75SMT2mPK02g4aJr
        y7B9MuJaMsWw6q1mgOJl9sV0I+DySYEFkkkazGClZb6piKGGkHKuJRb36h76tOSq1TKbInd
        CJqO7AkYKMkbaW5cPKe4y76m4ZhAQuTiQc6yTX23eKND+7aFAQMWABXvEf2KA7ZoF9dKewk
        DSn942ARQjxWtCABXREZdc1QQXI0f52WOYL6k4Ex2Y5IQC4RRc7+wtlpylCCHxwVwe3HLti
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14674773114149374089
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 1/3] selftests/nolibc: add a standalone test report macro
Date:   Mon, 19 Jun 2023 14:56:22 +0800
Message-Id: <a9ffadbde0a0f529301acede3292b11680295b64.1687156560.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687156559.git.falcon@tinylab.org>
References: <cover.1687156559.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The run-user, run and rerun targets use the same test report script,
let's add a standalone test report macro for them.

This shrinks code lines and simplify the future maintainability.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZIB792FtG6ibOudp@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 1b7b3c82f8ad..262a9f21d1b4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -84,6 +84,10 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
+REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
+		END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
+		if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }'
+
 help:
 	@echo "Supported targets under selftests/nolibc:"
 	@echo "  all          call the \"run\" target below"
@@ -131,10 +135,7 @@ libc-test: nolibc-test.c
 # qemu user-land test
 run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
-	$(Q)awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
-	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
-	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
-	         $(CURDIR)/run.out
+	$(Q)$(REPORT) $(CURDIR)/run.out
 
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
@@ -150,18 +151,12 @@ kernel: initramfs
 # run the tests after building the kernel
 run: kernel
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
-	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
-	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
-	         $(CURDIR)/run.out
+	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
-	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
-	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
-	         $(CURDIR)/run.out
+	$(Q)$(REPORT) $(CURDIR)/run.out
 
 clean:
 	$(call QUIET_CLEAN, sysroot)
-- 
2.25.1

