Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA97E1325
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKELfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjKELfK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 06:35:10 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF97E1;
        Sun,  5 Nov 2023 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699184102;
        bh=IdJFXFy2rUhosoH8Z7h6MB9DWZTcM5ZHRroV78U+Fiw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aQnhtEh4oHnnVRhhOMGSxfSYjJY8wGO/yqMvBBwPv7MsQ+hUu15HzjWjM6EzPMXW0
         ghAOBZ/OpaLrcWc7aKgKMYdpV0uTb3lzcS/oqS2GWTNdZ9n2qKUIyRneCIpPFpjVrp
         GBmwNIxwKAt14r8Uz6lbBupZPeZo5RKYKzGEWbMg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 12:35:00 +0100
Subject: [PATCH v2 3/6] selftests/nolibc: use XARCH for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-mips-be-v2-3-4ec993cb5407@weissschuh.net>
References: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
In-Reply-To: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699184102; l=4274;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IdJFXFy2rUhosoH8Z7h6MB9DWZTcM5ZHRroV78U+Fiw=;
 b=ilBW37jFgjSgNWl7vowrgRQbusU+xSSnJUlYm4CP5feL39NDJ8YsItziynNCdK0syWRtcrgi4
 +8BzjAQeX7eDVyaAzOq7uwqnbvGyFDQcIKnZHAbY/NwPzRSW8Uk3Lte
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MIPS has many different configurations prepare the support of additional
ones by moving the build of MIPS to the generic XARCH infrastructure.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile     | 12 +++++++-----
 tools/testing/selftests/nolibc/run-tests.sh |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index c5df1617cbc3..71fa5fdd10b6 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -40,12 +40,14 @@ objtree ?= $(srctree)
 
 # configure default variants for target kernel supported architectures
 XARCH_powerpc    = ppc
+XARCH_mips       = mips32le
 XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
 ARCH_ppc         = powerpc
 ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
+ARCH_mips32le    = mips
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -54,7 +56,7 @@ IMAGE_x86_64     = arch/x86/boot/bzImage
 IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
-IMAGE_mips       = vmlinuz
+IMAGE_mips32le   = vmlinuz
 IMAGE_ppc        = vmlinux
 IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
@@ -70,7 +72,7 @@ DEFCONFIG_x86_64     = defconfig
 DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
-DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_mips32le   = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
@@ -88,7 +90,7 @@ QEMU_ARCH_x86_64     = x86_64
 QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
-QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_mips32le   = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64
@@ -110,7 +112,7 @@ QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips32le   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -134,7 +136,7 @@ CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
-CFLAGS_mips = -EL
+CFLAGS_mips32le = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) \
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 1bf020d49f54..8f2c3bc572cb 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -14,7 +14,7 @@ cache_dir="${XDG_CACHE_HOME:-"$HOME"/.cache}"
 download_location="${cache_dir}/crosstools/"
 build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
 perform_download=0
-archs="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390 loongarch"
+archs="i386 x86_64 arm64 arm mips32le ppc ppc64 ppc64le riscv s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:ph' -n "$0" -- "$@")
 

-- 
2.42.1

