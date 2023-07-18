Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3107586BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGRVS5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjGRVSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:18:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4A1992;
        Tue, 18 Jul 2023 14:18:43 -0700 (PDT)
X-QQ-mid: bizesmtp62t1689715113t4aqmkoo
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:18:32 +0800 (CST)
X-QQ-SSF: 00200000000000D0X000B00A0000000
X-QQ-FEAT: eTp2eCgHrZnVchQBQHtIq1r0Chl0Y2QbztCX0TuLdQWRfW6TBfD0oOxr2ZGUl
        yeDiNZSVENj5aynfdi2NOfwTm0jEDkw5naUuGrqduIBj7DrVxkjq7hzmqe466uOcMmQ4Pwu
        UheYGug3IvwmwqNhO0f54gtD5CS3BqKxSYZsenHMTFf/s4z03vCgj7ZUqzXY8eRywSO+OWS
        I2bbHl1rsY8vhO5wagJxT4zU80r57W2C8xG3Prz2vxWKEQyWYDNwLPmwlY/0oa7JPlIi6Ct
        NLQlRXtazcamKO4G51OA+NdQE9LFeIj3+wi2vuM0ZaQc3OwR6Tzwjo44z5oybS/0jggoEeX
        c84ZB+ZfpFDm5HG45ZE7Np6rreJ6+cp9ChpV7qRly3xGJeCnGVwbYqt6fpZ1zrfZJofeqbY
        eLYGk1HeKtk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11777367648574905451
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 8/8] selftests/nolibc: add test support for powerpc64
Date:   Wed, 19 Jul 2023 05:18:32 +0800
Message-Id: <dc634a44cf1a132d607e2c83874cda6cd6d6283f.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Note, differs from little endian 64-bit PowerPC, vmlinux is used instead
of zImage, because big endian zImage [2] only boot on qemu with x-vof=on
(added from qemu v7.0) and a fixup patch [3] for qemu v7.0.51:

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html
[2]: https://github.com/linuxppc/issues/issues/402
[3]: https://lore.kernel.org/qemu-devel/20220504065536.3534488-1-aik@ozlabs.ru/

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index fbdf7fd9bf96..cced1d60ecf9 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -19,6 +19,7 @@ endif
 XARCH           ?= $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # ARCH is supported by kernel
+ARCH_powerpc64   = powerpc
 ARCH_powerpc64le = powerpc
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
@@ -30,6 +31,7 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
 IMAGE_powerpc    = vmlinux
+IMAGE_powerpc64  = vmlinux
 IMAGE_powerpc64le= arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
@@ -45,6 +47,7 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_powerpc    = pmac32_defconfig
+DEFCONFIG_powerpc64  = powernv_be_defconfig
 DEFCONFIG_powerpc64le= powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
@@ -65,6 +68,7 @@ QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_powerpc    = ppc
+QEMU_ARCH_powerpc64  = ppc64
 QEMU_ARCH_powerpc64le= ppc64le
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
@@ -79,6 +83,7 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_powerpc    = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_powerpc64  = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_powerpc64le= -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -95,6 +100,7 @@ else
 Q=@
 endif
 
+CFLAGS_powerpc64 = -m64 -mbig-endian -mmultiple -Wl,-EB,-melf64ppc
 CFLAGS_powerpc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
-- 
2.25.1

