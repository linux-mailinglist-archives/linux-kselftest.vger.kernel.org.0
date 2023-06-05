Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A452B721CA9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 05:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjFEDtK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 23:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEDtJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 23:49:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E1FB8;
        Sun,  4 Jun 2023 20:49:06 -0700 (PDT)
X-QQ-mid: bizesmtp81t1685936936tm3qiisk
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 11:48:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: PS/N6jJLnDbUhcG1tckp2UkFkb6Y4PEy7Kf4nOh/3d2cGqfkeUq0q6+sKvs5r
        4d/2AhXp1+1Ke3XxAEpTe4xrbrIDxn6kk4nhbiHJNnZVr+RNd9/wfD9i5Gg/NvF44ptXKAf
        M7/nom8UB9c7Sel4L85G5RjmPuXwka10IPIQeZ37y7u2Hfk3Fk8yZIkoCkz89r30XOFk/fQ
        CboWKF/ON91qEsDHmEaJpy/YHJKw9vefCoivanIsUcYrZLxS/VnW/4VO3ap36W8i7vIuPGu
        FB4ZLSuv3PsjBuf8cs71QZ8o+IgsJDPqeRbQcHEy7NqFxHl7oEiwZosr8XuNoHHE3ODeXFC
        p/s1Jq3A6+bNSgZAzUcm+k/W2k64vxSIgijB2BtMEaXGClTr/tVw2Vy2qGk5A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17656311057048569074
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 1/4] selftests/nolibc: add a test-report target
Date:   Mon,  5 Jun 2023 11:48:52 +0800
Message-Id: <291c5437db94057a3b045a6f036b02658380b05b.1685936428.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685936428.git.falcon@tinylab.org>
References: <cover.1685936428.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A standalone test-report target is added to let the run, run-user and
rerun targets share them.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index be4159837494..8149ace2938a 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -127,14 +127,18 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
 
-# qemu user-land test
-run-user: nolibc-test
-	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
+test-report:
 	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
 	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
 	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
 	         $(CURDIR)/run.out
 
+# qemu user-land test
+_run-user: nolibc-test
+	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
+
+run-user: _run-user test-report
+
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
 	$(call QUIET_INSTALL, initramfs/init)
@@ -147,20 +151,16 @@ kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # run the tests after building the kernel
-run: kernel
+_run: kernel
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
-	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
-	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
-	         $(CURDIR)/run.out
+
+run: _run test-report
 
 # re-run the tests from an existing kernel
-rerun:
+_rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
-	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
-	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
-	         $(CURDIR)/run.out
+
+rerun: _rerun test-report
 
 clean:
 	$(call QUIET_CLEAN, sysroot)
-- 
2.25.1

