Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC976BE0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHATrG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHATrG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:47:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E1B4;
        Tue,  1 Aug 2023 12:47:03 -0700 (PDT)
X-QQ-mid: bizesmtp90t1690919213t1ni6cdi
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:46:52 +0800 (CST)
X-QQ-SSF: 00200000000000E0X000000A0000000
X-QQ-FEAT: clvrxl8qrW51+LD8EODvemrNk0ru6bTwmEfs55sMwNm3INJ28xS74bBaNSCfu
        pwcJMPZy+EWXeMLOdanTNCOMeF9QfJNiiJxvmsNVuVFQyhpY/NhHUoPL1cbrXjFHEjDdFhL
        +U1fOKtRSjX1JiTxbvTdKtPORooY+0jaBb2Jo5ECcg/pdb3igm51WYXN04dACqzSFmAMUTA
        9efLpdTBTe0RiUl7/j/4EGWyPxZAIoy5YcTQD99UckWULoqsH9SDcCKbkJQKHrRkNzOLqe7
        1dwu5efA6dABqXA3Q22jW++0NK2d2i/dBHT55Bc+yAhVEdxcTm3ZNmq1LSLx2I5qZCen/uq
        rsPUgsMwth2bgh60GQJxzhBRVjsiTaszuSNs8sshn/nMzWvCxkxkcT1BUHChSBr8jJssxpq
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14255173392584887602
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 10/12] selftests/nolibc: add test support for ppc64
Date:   Wed,  2 Aug 2023 03:46:52 +0800
Message-Id: <78c00ef1bc4abe88d46415a396a7648c3e0885cc.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690916314.git.falcon@tinylab.org>
References: <cover.1690916314.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
ppc64 variant for big endian 64-bit PowerPC, users can pass ARCH=ppc64
to test it.

The powernv machine of qemu-system-ppc64 is used with
powernv_be_defconfig.

As the document [1] shows:

  PowerNV (as Non-Virtualized) is the “bare metal” platform using the
  OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can be
  used as an hypervisor OS, running KVM guests, or simply as a host OS.

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
  instructions. Those instructions do not work when the processor is in
  little-endian mode (except PPC740/PPC750), so, we only enable it
  for big endian powerpc.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html
[2]: https://github.com/linuxppc/issues/issues/402
[3]: https://lore.kernel.org/qemu-devel/20220504065536.3534488-1-aik@ozlabs.ru/

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230722121019.GD17311@1wt.eu/
Link: https://lore.kernel.org/lkml/20230719043353.GC5331@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8ec2ae33fdcd..ef4b8ba83898 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -38,6 +38,7 @@ XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
 ARCH_ppc         = powerpc
+ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
@@ -49,6 +50,7 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
 IMAGE_ppc        = vmlinux
+IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
@@ -64,6 +66,7 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
+DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
@@ -85,6 +88,7 @@ QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
+QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64le
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
@@ -99,6 +103,7 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -115,6 +120,7 @@ else
 Q=@
 endif
 
+CFLAGS_ppc64 = -m64 -mbig-endian -Wl,-EB,-melf64ppc -mmultiple -mno-vsx
 CFLAGS_ppc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
-- 
2.25.1

