Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226A273D28C
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjFYQqQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjFYQqP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:46:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D827B9;
        Sun, 25 Jun 2023 09:46:13 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687711564t4chllr1
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:46:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ao4JQgu0M3+P2mO/XdPQo3WMzS7AkUKvL5kFRZNSONL5c40x0ZX0LVB9bEsvW
        DlsKdmb+/rhmOhIqe+gdnrJxqGLJMYQee9Pen0KN20fqgNIo5wNfahNXi3Wyq6OSvfMW1ld
        GiQjMHOd4Qnp++RZ+a/NFg+/IPYfyUf8g/GLkjpUmQzoExt8XBn+S3ZM4xTx5GARdZhsLoi
        Zy1LNrxN2OfgSjd/3GsGsebmo8WcGJburzcOPtE1wgRAR1lGsi0xzZs5l7vv36loWeF4DDY
        Uuhu6PZwpjzVCvLj0KT+/iJ2sWr5XQ+0fhcj+fl91ChGrgJCBry4aiA/GThHOEWV+uKsJQN
        JDYHBPrtXQ4KagFeWiwMXI/mbvLrjUMN3+eY+swcaIT7jW5XhCXVtsKoZ/GBg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3366391044335302866
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 22/22] selftests/nolibc: detect bios existing to avoid hang
Date:   Mon, 26 Jun 2023 00:45:12 +0800
Message-Id: <ae3dabb001d41b3874c1a3ae9a2d76298806f167.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Without a right -bios option, riscv32 and loongarch will hang during
boot and therefore block the whole testing, this adds necessary
detection.

Before testing, the required bios should be downloaded at first, for a
future working qemu (without a manual -bios), we can simply clear the
QEMU_BIOS_<ARCH> to stop the detection.

By default, the bios should be downloaded and put into
tools/testing/selftests/nolibc/, otherwise, users should specify the
path via QEMU_BIOS_<ARCH>.

Without this patch, it is not possible to directly run tests for all
architectures, otherwise, we should pass our own 'ARCHS' and remove the
unsupported ones explicitly, which is not convenient.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 470923dc10e1..b529bb40444a 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -110,6 +110,14 @@ QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
 
+# QEMU_BIOS: bios used by qemu
+# https://github.com/loongson/Firmware/raw/main/LoongArchVirtMachine/edk2-loongarch64-code.fd
+QEMU_BIOS_loongarch ?= edk2-loongarch64-code.fd
+# https://gitlab.com/qemu-project/qemu/-/blob/master/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
+QEMU_BIOS_riscv32   ?= opensbi-riscv32-generic-fw_dynamic.bin
+QEMU_BIOS            = $(QEMU_BIOS_$(ARCH))
+QEMU_ARGS_BIOS       = $(if $(QEMU_BIOS),-bios $(QEMU_BIOS))
+
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -122,7 +130,7 @@ QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
+QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
@@ -167,9 +175,15 @@ endif
 # allow run tests on all architectures: run-user-all, run-all (=run-default-all), run-tiny-all
 ARCHS   ?= $(shell sed -ne 's/^DEFCONFIG_\([^ ]*\) .*/\1/p' $(CURDIR)/Makefile)
 GOALS   ?= run-user run-tiny run-default
+export $(foreach a, $(ARCHS), QEMU_BIOS_$a)
 RUN_ALL ?= _t=$@; t=$${_t%-all}; [ "$$t" = "run" ] && t=run-default; \
 	   if echo $(GOALS) | grep -wq "$$t"; then \
-		for a in $(ARCHS); do echo "Testing $$t for $${a}:"; make $$t ARCH=$$a; cp $(CURDIR)/run.out $(CURDIR)/run-$$a.out; done; \
+		for a in $(ARCHS); do \
+			echo "Testing $$t for $${a}:"; \
+			eval bios=\$${QEMU_BIOS_$$a}; \
+			if [ -n "$${bios}" -a ! -f "$${bios}" ]; then echo "\nIgnoring $$a test, no bios: $${bios} found."; exit 0; fi; \
+			make $$t ARCH=$$a; cp $(CURDIR)/run.out $(CURDIR)/run-$$a.out; \
+		done; \
 		echo "\n\nTesting summary of $$t:\n"; \
 		for a in $(ARCHS); do echo $${a}:; echo; $(REPORT) $(CURDIR)/run-$$a.out; echo; done; \
 	   else \
-- 
2.25.1

