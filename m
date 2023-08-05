Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E374C771187
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHESoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESoM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 14:44:12 -0400
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F81BE4;
        Sat,  5 Aug 2023 11:44:09 -0700 (PDT)
X-QQ-mid: bizesmtp81t1691261034tbgrmf1h
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 02:43:53 +0800 (CST)
X-QQ-SSF: 00200000000000E0X000B00A0000000
X-QQ-FEAT: aRJAvSRewFYU4SW2XrRMbeVjTtmWizIV2aT4qPHNUwsXnhy5ooszTAXsDyuid
        KPxZh/k6Tu3wnF7+7MSV1i5DmzWuqjNsXVelJGMecR+8kSgpDKQH9bNwbwA6S0aOTT+wOJ6
        r7yLn7NoBe0D0B56Z2bzxKLLQaN7Rr37cw4gapbooNST8jmWoG11rkfZw719q4kn73iLugy
        TQP2xKPdKaGem6Sz8Mi2mJjTmh//kcx3M3Xuf+fZSnq/fQv4OrHnlf/9kxCY2CnswtfAkVt
        ishKI8baPY9FDdWBzpCV1+rPtWizDnW86rlHYF0Fpin9oXU9016SLZ6TAjwFIS2e+/h0Fxc
        tr5b5xRceoo8EimWJ5BV2DE92VcyVb4ZK/xUXwG7aZp+CWxr3g96R8Ai80kmRCcjJGIXHF+
        ltxAbgVXkFU=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10814934079519102711
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 5/8] selftests/nolibc: add test support for ppc64le
Date:   Sun,  6 Aug 2023 02:43:53 +0800
Message-Id: <b7576fb55bf85ade0ef6d79c54d9f292d99e0320.1691259983.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691259983.git.falcon@tinylab.org>
References: <cover.1691259983.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
ppc64le variant for little endian 64-bit PowerPC, users can pass
XARCH=ppc64le to test it.

The powernv machine of qemu-system-ppc64le is used for there is just a
working powernv_defconfig.

As the document [1] shows:

  PowerNV (as Non-Virtualized) is the “bare metal” platform using the
  OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can be
  used as an hypervisor OS, running KVM guests, or simply as a host OS.

Notes,

- since the VSX support may be disabled in kernel side, to avoid
  "illegal instruction" errors due to missing VSX kernel support, let's
  simply let compiler not generate vector/scalar (VSX) instructions via
  the '-mno-vsx' option.

- little endian ppc64 prefers elfv2 to elfv1 if the toolchain (e.g. gcc
  13.1.0) supports it, let's align with kernel, otherwise, our elfv1
  binary will not run on kernel with elfv2 ABI.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230722120747.GC17311@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index cac501e0c7cf..586f278ddd66 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -35,6 +35,7 @@ XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
 ARCH_ppc         = powerpc
+ARCH_ppc64le     = powerpc
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -45,6 +46,7 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
 IMAGE_ppc        = vmlinux
+IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -59,6 +61,7 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
+DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -75,6 +78,7 @@ QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
+QEMU_ARCH_ppc64le    = ppc64le
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -88,6 +92,7 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -104,6 +109,7 @@ Q=@
 endif
 
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
+CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
-- 
2.25.1

