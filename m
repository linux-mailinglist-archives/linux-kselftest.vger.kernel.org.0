Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389BE57A93A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbiGSVp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiGSVpx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:53 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A56027CDE;
        Tue, 19 Jul 2022 14:45:35 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj6jM002596;
        Tue, 19 Jul 2022 23:45:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 15/17] selftests/nolibc: add a "run" target to start the kernel in QEMU
Date:   Tue, 19 Jul 2022 23:44:47 +0200
Message-Id: <20220719214449.2520-17-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "run" target will build the kernel and start it in QEMU. The
"rerun" target will not have the kernel dependency and will just try
to start QEMU. The QEMU architecture used to start the kernel is
derived from the configured ARCH. This might need to be improved
for archs which include different variants under the same name
(mips vs mipsel, +/-64, riscv32 vs riscv64). This could be tested
for i386, x86, arm, arm64, mips and riscv (the later two reporting
issues on some tests).

It is possible to pass a test specification for nolibc-test in the TEST
variable, which will be passed as-is as NOLIBC_TEST.

On success, the number of successful tests is printed. On failure, failed
lines are individually printed.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index c104719eae8b..7c1f5360f454 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -31,6 +31,27 @@ DEFCONFIG_mips    = malta_defconfig
 DEFCONFIG_riscv   = defconfig
 DEFCONFIG         = $(DEFCONFIG_$(ARCH))
 
+# optional tests to run (default = all)
+TEST =
+
+# QEMU_ARCH: arch names used by qemu
+QEMU_ARCH_i386    = i386
+QEMU_ARCH_x86     = x86_64
+QEMU_ARCH_arm64   = aarch64
+QEMU_ARCH_arm     = arm
+QEMU_ARCH_mips    = mipsel  # works with malta_defconfig
+QEMU_ARCH_riscv   = riscv64
+QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
+
+# QEMU_ARGS : some arch-specific args to pass to qemu
+QEMU_ARGS_i386    = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x86     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm64   = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips    = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv   = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS         = $(QEMU_ARGS_$(ARCH))
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -61,8 +82,20 @@ defconfig:
 kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
+# run the tests after building the kernel
+run: kernel
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+
+# re-run the tests from an existing kernel
+rerun:
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+
 clean:
 	$(call QUIET_CLEAN, nolibc-test)
 	$(Q)rm -f nolibc-test
 	$(call QUIET_CLEAN, initramfs)
 	$(Q)rm -rf initramfs
+	$(call QUIET_CLEAN, run.out)
+	$(Q)rm -rf run.out
-- 
2.17.5

