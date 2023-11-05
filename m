Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D417E12FC
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjKEKKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 05:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEKKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 05:10:14 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11351E9;
        Sun,  5 Nov 2023 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699179007;
        bh=QJrkWdgI6pd5Nzom+uI7s0H64zVW61s2WGdjVOhleds=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Bxvsr1SZVKZ2jn8JpzY/4MS+dangbVT1VwRkMx6FSg4eLGZohnDVWKIzzzc1hcOJH
         UOGYBuiWCs/ipKUYRQl6DI6raCDubfXpvwMHxybv9mwSUMfsGgkYXhyco/SFXy6/PG
         G7g1nIvBnLEO2rvHurU8v4W0ZKfkMF12vnFzsmAA=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 11:10:00 +0100
Subject: [PATCH 6/6] selftests/nolibc: add configuration for mipso32be
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-mips-be-v1-6-6c2ad3e50a1f@weissschuh.net>
References: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
In-Reply-To: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699179006; l=3895;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QJrkWdgI6pd5Nzom+uI7s0H64zVW61s2WGdjVOhleds=;
 b=ItS8E7G1VosjhdiPN1Bjorlgt4ymAZJUqh6NsosQxdpnMI+REnwslVzzyLl3U0835fkGkHIR3
 lqW9F1p0JwSAjlFje4cDNHzS+Sz/iq2FNlHvo3bBjbsipDw96NYvTr3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow testing MIPS O32 big endian.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile     | 7 +++++++
 tools/testing/selftests/nolibc/run-tests.sh | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 02c074e73a28..316a8a1d09af 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -48,6 +48,7 @@ ARCH_ppc         = powerpc
 ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
 ARCH_mipso32le   = mips
+ARCH_mipso32be   = mips
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -57,6 +58,7 @@ IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mipso32le  = vmlinuz
+IMAGE_mipso32be  = vmlinuz
 IMAGE_ppc        = vmlinux
 IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
@@ -73,6 +75,7 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mipso32le  = malta_defconfig
+DEFCONFIG_mipso32be  = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
@@ -81,6 +84,7 @@ DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
+EXTRACONFIG_mipso32be = -d CONFIG_CPU_LITTLE_ENDIAN -e CONFIG_CPU_BIG_ENDIAN
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 
 # optional tests to run (default = all)
@@ -93,6 +97,7 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mipso32le  = mipsel  # works with malta_defconfig
+QEMU_ARCH_mipso32be  = mips
 QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64
@@ -115,6 +120,7 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mipso32le  = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mipso32be  = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -139,6 +145,7 @@ CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
 CFLAGS_mipso32le = -EL -mabi=32
+CFLAGS_mipso32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) \
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index fb825c05031a..d6d3721b5d84 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -14,7 +14,7 @@ cache_dir="${XDG_CACHE_HOME:-"$HOME"/.cache}"
 download_location="${cache_dir}/crosstools/"
 build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
 perform_download=0
-archs="i386 x86_64 arm64 arm mipso32le ppc ppc64 ppc64le riscv s390 loongarch"
+archs="i386 x86_64 arm64 arm mipso32le mipso32be ppc ppc64 ppc64le riscv s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:ph' -n "$0" -- "$@")
 

-- 
2.42.1

