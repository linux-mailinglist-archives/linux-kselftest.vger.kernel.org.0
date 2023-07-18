Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00797586B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGRVQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjGRVQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:16:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0AFC0;
        Tue, 18 Jul 2023 14:16:30 -0700 (PDT)
X-QQ-mid: bizesmtp64t1689714981twgbl5jf
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:16:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: rZJGTgY0+YMsNn0tiH5GxXHDHMTndtl7NbvdEtTMLGzjdqSAfitYAYhrVd6EZ
        baHRqA5DNH5svwEJ5bD3QJG0h66n7aQdSH/X3KBDUIJ22MhRZuf16kRymoZYYB+tEkFZ+/y
        DJencGX8HQllTd8CI3W50ssf6GJFjtKjYnRQvEuoxGFPASGko1jyo9h2aMj1pHl2bfJ2COI
        jlkdCwk7VOkbmjTTKPUV37SfynaULuvrG/R198MIx9wVQbPPjuPvtUm69ctskRY1yFwiQs6
        PECDHee3muS9yLaSPb4QAjN0dTw5f9Chxtqk8/MVZJFnspIGcNQSUIGZq2E2u2Ub8U26Ogp
        Jb758x18DEVk5zMFBFSuIwYhhkfR/HYj7seXroVmVn2fxBL+DxHeS0C/kALaO9+gxpLlUG4
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8636731950875008413
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 6/8] selftests/nolibc: add test support for powerpc
Date:   Wed, 19 Jul 2023 05:16:19 +0800
Message-Id: <548df83f58d7d6e2f9278b05239dd57501aa3603.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
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

The default qemu-system-ppc g3beige machine [1] is used to run 32-bit
powerpc kernel.

The pmac32_defconfig is used with extra PMACZILOG console options to
enable normal print.

Note, zImage doesn't boot due to "qemu-system-ppc: Some ROM regions are
overlapping" error, so, vmlinux is used instead.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powermac.html

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile               | 4 ++++
 tools/testing/selftests/nolibc/configs/powerpc.config | 3 +++
 2 files changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/configs/powerpc.config

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index b17a82efe6de..9c375fab84e5 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -28,6 +28,7 @@ IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
+IMAGE_powerpc    = vmlinux
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -41,6 +42,7 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_powerpc    = pmac32_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -59,6 +61,7 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_powerpc    = ppc
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -71,6 +74,7 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_powerpc    = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
diff --git a/tools/testing/selftests/nolibc/configs/powerpc.config b/tools/testing/selftests/nolibc/configs/powerpc.config
new file mode 100644
index 000000000000..b1975f8253f7
--- /dev/null
+++ b/tools/testing/selftests/nolibc/configs/powerpc.config
@@ -0,0 +1,3 @@
+CONFIG_SERIAL_PMACZILOG=y
+CONFIG_SERIAL_PMACZILOG_TTYS=y
+CONFIG_SERIAL_PMACZILOG_CONSOLE=y
-- 
2.25.1

