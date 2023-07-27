Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C70765D5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjG0Uay (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjG0Uaw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:30:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37BB30E4;
        Thu, 27 Jul 2023 13:30:42 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690489832t5sr73z5
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:30:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: pmyeiOl6PGn82x4eFXPNEITOuWWU+TvnNm56XXJBynRue1cBZR4uW6sldlrWd
        4avjCims+5xy9Qf/PYidPSKOOcbnAkxppQvdPEejuwpc4PM6jyWFcyZTUuDqVJdJ5JmoooI
        jL/XkwNL1y1hjcw8FyqydaCs4yicA/VuDE3SFw6wgCvkTXIyWQZt4DRiLIMNPr6eEUD+m72
        f+xek+riwnuTGiwPrYymmfQffQqEBn7xLjaQbhA9sfEOtixwjGr0uWR3dBgWyKcpPJduAeb
        K2hMuJGt0tN6UMAuv3o32/8NH0U0c6Xm8snJ0+XJly6iTA9nuPqlwdvO8mQAPAd/qr53uSM
        1WulUhXMoKeKR1ocG/O6MNH8ckx1LbDykelL+Evnc/anK0xbMA1VPoKqamurc2uMWMOEz1E
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6404872216917566907
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 08/12] selftests/nolibc: allow quit qemu-system when poweroff fails
Date:   Fri, 28 Jul 2023 04:30:31 +0800
Message-Id: <4b4d792299ca5356f8f5af5fc9a27c687b0e4e38.1690489039.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690489039.git.falcon@tinylab.org>
References: <cover.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

QEMU_TIMEOUT can be configured for every architecture based on their
time cost requirement of bios boot + kernel boot + test + poweroff.

By default, 10 seconds timeout is configured, this is enough for most of
the architectures, otherwise, customize one by architecture.

To tell users the test running progress in time, some critical running
status are also printed and detected.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230722130248.GK17311@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 30 +++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index a214745e0f3e..9a57de3b283c 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -105,6 +105,9 @@ QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
+# QEMU_TIMEOUT: some architectures can not poweroff normally, especially for tinyconfig
+QEMU_TIMEOUT           = $(or $(QEMU_TIMEOUT_$(XARCH)),10)
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -229,16 +232,39 @@ kernel: $(KERNEL_CONFIG)
 # common macros for qemu run/rerun targets
 QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
 
+TIMEOUT_CMD = t=$(QEMU_TIMEOUT); past=0; \
+	bios_timeout=$$(expr $$t - 7); kernel_timeout=$$(expr $$t - 5); init_timeout=$$(expr $$t - 3); test_timeout=$$(expr $$t - 1);              \
+	err=""; bios=0; kernel=0; init=0; test=0; poweredoff=0; panic=0;                                                                           \
+	echo "Running $(KERNEL_IMAGE) on qemu-system-$(QEMU_ARCH)";                                                                                \
+	while [ $$t -gt 0 ]; do                                                                                                                    \
+	    sleep 2; t=$$(expr $$t - 2); past=$$(expr $$past + 2);                                                                                 \
+	    if [ $$bios -eq 0 ] && grep -E "Linux version|Kernel command line|printk: console" "$(RUN_OUT)"; then bios=1; fi;                      \
+	    if [ $$bios -eq 1 -a $$kernel -eq 0 ] && grep -E "Run .* as init process" "$(RUN_OUT)"; then kernel=1; fi;                             \
+	    if [ $$kernel -eq 1 -a $$init -eq 0 ] && grep -E "Running test" "$(RUN_OUT)"; then init=1; fi;                                         \
+	    if [ $$init -eq 1 -a $$test -eq 0 ] && grep -E "Leaving init with final status|Exiting with status" "$(RUN_OUT)"; then test=1; fi;     \
+	    if [ $$init -eq 1 ] && grep -E "Kernel panic - not syncing: Attempted to kill init" "$(RUN_OUT)"; then err="test"; sleep 1; break; fi; \
+	    if [ $$test -eq 1 ] && grep -E "reboot: System halted|reboot: Power down" "$(RUN_OUT)"; then poweredoff=1; sleep 1; break; fi;         \
+	    if [ $$past -gt $$bios_timeout -a $$bios -eq 0 ]; then err="bios"; break; fi;                                                          \
+	    if [ $$past -gt $$kernel_timeout -a $$kernel -eq 0 ]; then err="kernel"; break; fi;                                                    \
+	    if [ $$past -gt $$init_timeout -a $$init -eq 0 ]; then err="init"; break; fi;                                                          \
+	    if [ $$past -gt $$test_timeout -a $$test -eq 0 ]; then err="test"; break; fi;                                                          \
+	done;                                                                                                                                      \
+	if [ -z "$$err" -a $$poweredoff -eq 0 -a $$panic -eq 0 ]; then err="qemu-system-$(QEMU_ARCH)"; fi;                                         \
+	if [ -n "$$err" ]; then echo "$$err may timeout, test failed"; tail -10 $(RUN_OUT); else echo "powered off, test finish"; fi;              \
+	pkill -15 qemu-system-$(QEMU_ARCH) || true
+
+TIMEOUT_QEMU_RUN = ($(QEMU_SYSTEM_RUN) > "$(RUN_OUT)" &); $(TIMEOUT_CMD)
+
 # run the tests after building the kernel
 PHONY += $(KERNEL_IMAGE)
 $(KERNEL_IMAGE): kernel
 run: $(KERNEL_IMAGE)
-	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
+	$(Q)$(TIMEOUT_QEMU_RUN)
 	$(Q)$(REPORT) "$(RUN_OUT)"
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
+	$(Q)$(TIMEOUT_QEMU_RUN)
 	$(Q)$(REPORT) "$(RUN_OUT)"
 
 # report with existing test log
-- 
2.25.1

