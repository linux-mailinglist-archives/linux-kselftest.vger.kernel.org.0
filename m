Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4673D1FA
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFYQNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFYQNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:13:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF418D;
        Sun, 25 Jun 2023 09:13:45 -0700 (PDT)
X-QQ-mid: bizesmtp62t1687709616tzy4rqig
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:13:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: IV30oiqrgAbOfnJiGwL0dLz5UNsInBixLxruPzcz1JdYKW91p3ui4yAH+JKDY
        HQKHcMsMzV7Nrt2LT0lOsKzUTJ0H9bt/KtrowcD3Pfllvf6wEiJnFhxCUg9KKvLIKIyFTpZ
        Qc7xqQfgMj13ozkOMYLJkvEmyX8wmvWwF48GzR2LQHHHVpjLN3vSx+h1LcsT5iWoGFVPXoJ
        RvNpGhcDVu0px1OGCdiLeqj6wUYSomUpNfUkyCIqAisVI0JthFgsE4ylvqwrwVCDLndbNYR
        o3JXtkq+Lp+rbXJ4NW0V0ORgwNEh/lv2+GFWOJMzmqPNUW/A4kN5ir6l6Edo/IVLSFqaWlD
        p6W0vN+6xNVMrW/NhLD/dL57AyXiA9bIMyEfb9iLvINukdCZso=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15177638908459309453
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 02/22] selftests/nolibc: print result to the screen too
Date:   Mon, 26 Jun 2023 00:13:14 +0800
Message-Id: <b7f022af937fe359d8fb8e1667dd6481933509e9.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
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

printing the running log to the screen helps users to learn what
happens, especially to find potential issues immediately.

If want to silence a lot, simply pass a QUIET_RUN=1 is enough.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 0b66b7a79cea..3300b5ab7de3 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -98,6 +98,14 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
+# allow silence the running test log
+QUIET_RUN ?= 0
+ifeq ($(QUIET_RUN),0)
+LOG_OUTPUT = | tee "$(CURDIR)/run.out"
+else
+LOG_OUTPUT = > "$(CURDIR)/run.out"
+endif
+
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("%d test(s) passed, %d skipped, %d failed.\n", p, s, f); \
 		printf("See all results in %s\n", ARGV[1]); }'
@@ -157,7 +165,7 @@ libc-test: nolibc-test.c
 
 # qemu user-land test
 run-user: nolibc-test
-	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
+	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test $(LOG_OUTPUT) || :
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 initramfs: nolibc-test
@@ -173,12 +181,12 @@ kernel: initramfs
 
 # run the tests after building the kernel
 run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) $(LOG_OUTPUT)
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) $(LOG_OUTPUT)
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 clean:
-- 
2.25.1

