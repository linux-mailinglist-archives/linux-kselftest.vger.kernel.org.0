Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B677639B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjGZO6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjGZO6i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:58:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52322109;
        Wed, 26 Jul 2023 07:58:34 -0700 (PDT)
X-QQ-mid: bizesmtp80t1690383504t6indi1o
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 22:58:23 +0800 (CST)
X-QQ-SSF: 00200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3gx1YD2Y2f418atJWwTGw4XT79+ZSinD1pcTvQdp5vp8yaZAPG+u
        1dIO2RbMGkkhE3rpPrhTRe8MgIaCw8FPcA7QKZA+3UoqASQn50CYyKkYfKj8corHE2bYiJ4
        eZ5R32XDCRLR9jJRb7Lpk5WsLdMhTcjw8Pf44ZYWJRfBUWXXjwUkj/viXBJmwL7i9WxornL
        VG6ITcNFaZOYzjgScvBG55cKoGz0B67RU1ySgAhU8t4w73cvXq/n2VioN83mwCEeaEvoGci
        vv7KwRuaFtHXrCaIVA9YNeRT7opgR2ixS1w+vAf96+EM1+yhBMQW2sP4OMxC8aOaC0/oxbm
        FZehGxrsrPsSk/QtgDnXG2VROmYHV6dXBAD4Siw1707Ovyf/+UQr0mZmbCKu4brxTRMwMu8
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18102331507296563561
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 7/7] selftests/nolibc: add test support for ppc64
Date:   Wed, 26 Jul 2023 22:58:18 +0800
Message-Id: <b7368dbb0b41c5dca1dade08ed300f30b4d541f0.1690373704.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690373704.git.falcon@tinylab.org>
References: <cover.1690373704.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here adds test support for big endian 64-bit PowerPC.

The powernv machine of qemu-system-ppc64 is used with
powernv_be_defconfig.

As the document [1] shows:

  PowerNV (as Non-Virtualized) is the “bare metal” platform using the
  OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can be
  used as an hypervisor OS, running KVM guests, or simply as a host OS.

Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
ppc64 variant for big endian 64-bit PowerPC, users can pass ARCH=ppc64
to test it.

Notes,

- differs from little endian 64-bit PowerPC, vmlinux is used instead of
  zImage, because big endian zImage [2] only boot on qemu with x-vof=on
  (added from qemu v7.0) and a fixup patch [3] for qemu v7.0.51:

- since the VSX support may be disabled in kernel side, to avoid
  "illegal instruction" errors due to missing VSX kernel support, let's
  simply let compiler not generate vector/scalar (VSX) instructions via
  the '-mno-vsx' option.

- as 'man gcc' shows, '-mmultiple' is used to generate code that uses
  the load multiple word instructions and the store multiple word
  instructions. those instructions do not work when the processor is in
  little-endian mode (except PPC740/PPC750), so, we only enable it
  for big endian powerpc.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html
[2]: https://github.com/linuxppc/issues/issues/402
[3]: https://lore.kernel.org/qemu-devel/20220504065536.3534488-1-aik@ozlabs.ru/

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index cd46b97983a4..b751e9fdf30d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -22,6 +22,7 @@ XARCH           := $(or $(XARCH_$(ARCH)),$(ARCH))
 # ARCH is supported by kernel
 # map from user-input variant to kernel-supported
 ARCH_ppc         = powerpc
+ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
 override ARCH   := $(or $(ARCH_$(XARCH)),$(XARCH))
 
@@ -33,6 +34,7 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
 IMAGE_ppc        = vmlinux
+IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
@@ -48,6 +50,7 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
+DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
@@ -68,6 +71,7 @@ QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
+QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64le
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
@@ -82,6 +86,7 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -98,6 +103,7 @@ else
 Q=@
 endif
 
+CFLAGS_ppc64 = -m64 -mbig-endian -Wl,-EB,-melf64ppc -mmultiple -mno-vsx
 CFLAGS_ppc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
-- 
2.25.1

