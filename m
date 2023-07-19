Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11867596AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGSN1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSN1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:27:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53ACFD;
        Wed, 19 Jul 2023 06:27:19 -0700 (PDT)
X-QQ-mid: bizesmtp73t1689773230tl41c04k
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:27:09 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: IcCSTr/hHjObbBazmsx/eCk6zRHzb4DLLNT0pf/dPkYF5A5ior6pI6BCHSsR6
        Ls5QcnnivFHHZI0EX9chwHrUZo6HybXN+Cgzuoi7E6aZgU+1yfQ14crWCtNUDJ/gaGFW2uJ
        TKdt3NDsCDUgg5seMKn0J51fY8ToI5VZY/w04izFonbY4YFDEJIrnxYhSDjhxqDZ4ewz626
        vd3bJFiAcB5340nsQBeWRtHGS1WbMKXJCRkw9OxxBQ3cEBkwgvFsiBlpF9UEwYQ2aus0rLT
        sWs48u3OS58LBsGC0E7Glr5gfeuoGQ6FzjBbri/cuFKmF1qd8LRLfgW5SjbRd2cwRmtU52L
        D1VhjIeI9q7iCTQGy8HU+Khonc1Zm4NC1RI2YdoZIiKSFIuXtWXikEGBVIvUtwlYWB1rwQd
        PjYxYlvgGZQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11276070205488590152
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 09/14] selftests/nolibc: allow quit qemu-system when poweroff fails
Date:   Wed, 19 Jul 2023 21:27:08 +0800
Message-Id: <511b2f6009fb830b3f32b4be3dca99596c684fa3.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689759351.git.falcon@tinylab.org>
References: <cover.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel of some architectures can not poweroff qemu-system normally,
especially for tinyconfig.

Some architectures may have no kernel poweroff support, the others may
require more kernel config options and therefore slow down the
tinyconfig build and test. and also, it's very hard (and some even not
possible) to find out the exact poweroff related kernel config options
for every architecture.

Since the low-level poweroff support is heavily kernel & qemu dependent,
it is not that critical to both nolibc and nolibc-test, let's simply
ignore the poweroff required kernel config options for tinyconfig (and
even for defconfig) and quit qemu-system after a specified timeout or
with an expected system halt or poweroff string (these strings mean our
reboot() library routine is perfectly ok).

QEMU_TIMEOUT value can be configured for every architecture based on
their time cost requirement of boot+test+poweroff.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 541f3565e584..a03fab020ebe 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -93,6 +93,9 @@ QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
+# QEMU_TIMEOUT: some architectures can not poweroff normally, especially for tinyconfig
+QEMU_TIMEOUT             = $(QEMU_TIMEOUT_$(XARCH))
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -224,16 +227,32 @@ kernel: extconfig
 # common macros for qemu run/rerun targets
 QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
 
+ifneq ($(QEMU_TIMEOUT),)
+TIMEOUT_CMD = t=$(QEMU_TIMEOUT); \
+	while [ $$t -gt 0 ]; do                                                       \
+	    sleep 5; t=$$(expr $$t - 5); echo "detecting power off ...";              \
+	    if grep -qE "reboot: System halted|reboot: Power down" "$(RUN_OUT)"; then \
+		pkill -9 qemu-system-$(QEMU_ARCH);                                    \
+		echo "powered off, test finish"; t=1; break;                          \
+	    fi;                                                                       \
+	done;                                                                         \
+	if [ $$t -le 0 ]; then pkill -9 qemu-system-$(QEMU_ARCH); echo "qemu-system-$(QEMU_ARCH) timeout"; fi
+
+TIMEOUT_QEMU_RUN = ($(QEMU_SYSTEM_RUN) $(LOG_OUT) &); $(TIMEOUT_CMD)
+else
+TIMEOUT_QEMU_RUN = $(QEMU_SYSTEM_RUN) $(LOG_OUT)
+endif
+
 # run the tests after building the kernel
 PHONY += $(KERNEL_IMAGE)
 $(KERNEL_IMAGE): kernel
 run: $(KERNEL_IMAGE)
-	$(Q)$(QEMU_SYSTEM_RUN) $(LOG_OUT)
+	$(Q)$(TIMEOUT_QEMU_RUN)
 	$(Q)$(REPORT_RUN_OUT)
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)$(QEMU_SYSTEM_RUN) $(LOG_OUT)
+	$(Q)$(TIMEOUT_QEMU_RUN)
 	$(Q)$(REPORT_RUN_OUT)
 
 # report with existing test log
-- 
2.25.1

