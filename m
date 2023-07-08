Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAA74BE2A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGHP05 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGHP05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:26:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D990;
        Sat,  8 Jul 2023 08:26:54 -0700 (PDT)
X-QQ-mid: bizesmtp83t1688830004tyw675ms
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:26:42 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: +ynUkgUhZJmVRUXV+L2xeVyf6+vqmM7j9a2ASDPK312opbgF4bOwDsoGStEyF
        OXQxMtEdNxFS7Ym41TWHTCmiKwVLZyWlxLECcbgdfVdGQPGC7pqNGVKtK/L+64tubQblPP7
        oczPdTp8NDntGYKd/lgVkGmpshZVJ4DKHKsE9NofnaAC48iM6oo1wfJd6mq88fmii3W1kbs
        dRxpVsWe5Hoqs/YKlCXHrfRmP6kqBWSpGi6UVkiJ7tiYEt15r9BgLZW0KkHOFpmDp5irziD
        KRKgA4lBunL75GYf4Fr1fv4MirIxsqdRnfbUdcemPNoLl4ctqsZ7ujufvavhYLxXXY7F2sD
        QWAIFaAj76zc+ISdWwRE/bNlf6udwxpzKsPqHbJ0fZfQMYF5S7cnMq+3op7U8F0grLoRRVX
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16386265970965724467
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 01/12] tools/nolibc: rename arch-<ARCH>.h to <ARCH>/arch.h
Date:   Sat,  8 Jul 2023 23:26:42 +0800
Message-Id: <ef34ee3cc8cb0e4f8ce7c7c9975a0e8d14473a84.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the architecture specific arch.h has two parts, one is the
syscall declarations for sys.h, another is the _start code definition
for startup support.

The coming crt.h will provide the startup support with a new common
_start_c(), it will replace most of the assembly _start code and shrink
the original _start code to be minimal, as a result, _start_c() and the
left minimal _start code will work together to provide the startup
support, therefore, the left _start code will be only required by crt.h.

So, the syscall declarations part of arch.h can be split to sys_arch.h
and the _start code part of arch.h can be split to crt_arch.h and then,
they should only be included in sys.h and crt.h respectively.

At the same time, the architecture specific arch-<ARCH>.h should be
split to <ARCH>/crt.h and <ARCH>/sys.h.

As a preparation, this creates the architecture specific directory and
moves tools/include/nolibc/arch-<ARCH>.h to
tools/include/nolibc/<ARCH>/arch.h.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/Makefile                    | 10 +++++-----
 .../nolibc/{arch-aarch64.h => aarch64/arch.h}    |  6 +++---
 tools/include/nolibc/arch.h                      | 16 ++++++++--------
 tools/include/nolibc/{arch-arm.h => arm/arch.h}  |  6 +++---
 .../include/nolibc/{arch-i386.h => i386/arch.h}  |  6 +++---
 .../{arch-loongarch.h => loongarch/arch.h}       |  6 +++---
 .../include/nolibc/{arch-mips.h => mips/arch.h}  |  6 +++---
 .../nolibc/{arch-riscv.h => riscv/arch.h}        |  6 +++---
 .../include/nolibc/{arch-s390.h => s390/arch.h}  |  6 +++---
 .../nolibc/{arch-x86_64.h => x86_64/arch.h}      |  6 +++---
 10 files changed, 37 insertions(+), 37 deletions(-)
 rename tools/include/nolibc/{arch-aarch64.h => aarch64/arch.h} (99%)
 rename tools/include/nolibc/{arch-arm.h => arm/arch.h} (99%)
 rename tools/include/nolibc/{arch-i386.h => i386/arch.h} (99%)
 rename tools/include/nolibc/{arch-loongarch.h => loongarch/arch.h} (99%)
 rename tools/include/nolibc/{arch-mips.h => mips/arch.h} (99%)
 rename tools/include/nolibc/{arch-riscv.h => riscv/arch.h} (99%)
 rename tools/include/nolibc/{arch-s390.h => s390/arch.h} (98%)
 rename tools/include/nolibc/{arch-x86_64.h => x86_64/arch.h} (99%)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 64d67b080744..ce21ace8210e 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -24,7 +24,7 @@ Q=@
 endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
-arch_file := arch-$(nolibc_arch).h
+arch_file := $(nolibc_arch)/arch.h
 all_files := \
 		compiler.h \
 		ctype.h \
@@ -70,11 +70,11 @@ headers:
 	$(Q)cp $(all_files) $(OUTPUT)sysroot/include/
 	$(Q)if [ "$(ARCH)" = "x86" ]; then      \
 		sed -e                          \
-		  's,^#ifndef _NOLIBC_ARCH_X86_64_H,#if !defined(_NOLIBC_ARCH_X86_64_H) \&\& defined(__x86_64__),' \
-		  arch-x86_64.h;                \
+		  's,^#ifndef _NOLIBC_X86_64_ARCH_H,#if !defined(_NOLIBC_X86_64_ARCH_H) \&\& defined(__x86_64__),' \
+		  x86_64/arch.h;                \
 		sed -e                          \
-		  's,^#ifndef _NOLIBC_ARCH_I386_H,#if !defined(_NOLIBC_ARCH_I386_H) \&\& !defined(__x86_64__),' \
-		  arch-i386.h;                  \
+		  's,^#ifndef _NOLIBC_I386_ARCH_H,#if !defined(_NOLIBC_I386_ARCH_H) \&\& !defined(__x86_64__),' \
+		  i386/arch.h;                  \
 	elif [ -e "$(arch_file)" ]; then        \
 		cat $(arch_file);               \
 	else                                    \
diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/aarch64/arch.h
similarity index 99%
rename from tools/include/nolibc/arch-aarch64.h
rename to tools/include/nolibc/aarch64/arch.h
index 6227b77a4a09..7d38da13c72b 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/aarch64/arch.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_ARCH_AARCH64_H
-#define _NOLIBC_ARCH_AARCH64_H
+#ifndef _NOLIBC_AARCH64_ARCH_H
+#define _NOLIBC_AARCH64_ARCH_H
 
 #include "compiler.h"
 
@@ -201,4 +201,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 	);
 	__builtin_unreachable();
 }
-#endif /* _NOLIBC_ARCH_AARCH64_H */
+#endif /* _NOLIBC_AARCH64_ARCH_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 82b43935650f..f98616f5b219 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -16,21 +16,21 @@
 #define _NOLIBC_ARCH_H
 
 #if defined(__x86_64__)
-#include "arch-x86_64.h"
+#include "x86_64/arch.h"
 #elif defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__)
-#include "arch-i386.h"
+#include "i386/arch.h"
 #elif defined(__ARM_EABI__)
-#include "arch-arm.h"
+#include "arm/arch.h"
 #elif defined(__aarch64__)
-#include "arch-aarch64.h"
+#include "aarch64/arch.h"
 #elif defined(__mips__) && defined(_ABIO32)
-#include "arch-mips.h"
+#include "mips/arch.h"
 #elif defined(__riscv)
-#include "arch-riscv.h"
+#include "riscv/arch.h"
 #elif defined(__s390x__)
-#include "arch-s390.h"
+#include "s390/arch.h"
 #elif defined(__loongarch__)
-#include "arch-loongarch.h"
+#include "loongarch/arch.h"
 #endif
 
 #endif /* _NOLIBC_ARCH_H */
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arm/arch.h
similarity index 99%
rename from tools/include/nolibc/arch-arm.h
rename to tools/include/nolibc/arm/arch.h
index 4d4887a5f04b..473d2c000740 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arm/arch.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_ARCH_ARM_H
-#define _NOLIBC_ARCH_ARM_H
+#ifndef _NOLIBC_ARM_ARCH_H
+#define _NOLIBC_ARM_ARCH_H
 
 #include "compiler.h"
 
@@ -267,4 +267,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 	__builtin_unreachable();
 }
 
-#endif /* _NOLIBC_ARCH_ARM_H */
+#endif /* _NOLIBC_ARM_ARCH_H */
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/i386/arch.h
similarity index 99%
rename from tools/include/nolibc/arch-i386.h
rename to tools/include/nolibc/i386/arch.h
index 4c6b7c04e2e7..66052742763e 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/i386/arch.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_ARCH_I386_H
-#define _NOLIBC_ARCH_I386_H
+#ifndef _NOLIBC_I386_ARCH_H
+#define _NOLIBC_I386_ARCH_H
 
 #include "compiler.h"
 
@@ -221,4 +221,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 	__builtin_unreachable();
 }
 
-#endif /* _NOLIBC_ARCH_I386_H */
+#endif /* _NOLIBC_I386_ARCH_H */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/loongarch/arch.h
similarity index 99%
rename from tools/include/nolibc/arch-loongarch.h
rename to tools/include/nolibc/loongarch/arch.h
index 8aa7724fe38e..63fee1e8f4d9 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/loongarch/arch.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2023 Loongson Technology Corporation Limited
  */
 
-#ifndef _NOLIBC_ARCH_LOONGARCH_H
-#define _NOLIBC_ARCH_LOONGARCH_H
+#ifndef _NOLIBC_LOONGARCH_ARCH_H
+#define _NOLIBC_LOONGARCH_ARCH_H
 
 #include "compiler.h"
 
@@ -197,4 +197,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 	__builtin_unreachable();
 }
 
-#endif /* _NOLIBC_ARCH_LOONGARCH_H */
+#endif /* _NOLIBC_LOONGARCH_ARCH_H */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/mips/arch.h
similarity index 99%
rename from tools/include/nolibc/arch-mips.h
rename to tools/include/nolibc/mips/arch.h
index a2bfdf57b957..1581b721b714 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/mips/arch.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_ARCH_MIPS_H
-#define _NOLIBC_ARCH_MIPS_H
+#ifndef _NOLIBC_MIPS_ARCH_H
+#define _NOLIBC_MIPS_ARCH_H
 
 #include "compiler.h"
 
@@ -250,4 +250,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 	__builtin_unreachable();
 }
 
-#endif /* _NOLIBC_ARCH_MIPS_H */
+#endif /* _NOLIBC_MIPS_ARCH_H */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/riscv/arch.h
similarity index 99%
rename from tools/include/nolibc/arch-riscv.h
rename to tools/include/nolibc/riscv/arch.h
index cd958b2f4b1b..de68759f5959 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/riscv/arch.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_ARCH_RISCV_H
-#define _NOLIBC_ARCH_RISCV_H
+#ifndef _NOLIBC_RISCV_ARCH_H
+#define _NOLIBC_RISCV_ARCH_H
 
 #include "compiler.h"
 
@@ -214,4 +214,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 	__builtin_unreachable();
 }
 
-#endif /* _NOLIBC_ARCH_RISCV_H */
+#endif /* _NOLIBC_RISCV_ARCH_H */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/s390/arch.h
similarity index 98%
rename from tools/include/nolibc/arch-s390.h
rename to tools/include/nolibc/s390/arch.h
index a644ecd361c0..a7b512e81234 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/s390/arch.h
@@ -3,8 +3,8 @@
  * s390 specific definitions for NOLIBC
  */
 
-#ifndef _NOLIBC_ARCH_S390_H
-#define _NOLIBC_ARCH_S390_H
+#ifndef _NOLIBC_S390_ARCH_H
+#define _NOLIBC_S390_ARCH_H
 #include <asm/signal.h>
 #include <asm/unistd.h>
 
@@ -234,4 +234,4 @@ pid_t sys_fork(void)
 }
 #define sys_fork sys_fork
 
-#endif /* _NOLIBC_ARCH_S390_H */
+#endif /* _NOLIBC_S390_ARCH_H */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/x86_64/arch.h
similarity index 99%
rename from tools/include/nolibc/arch-x86_64.h
rename to tools/include/nolibc/x86_64/arch.h
index e69113742a99..602791c3461a 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/x86_64/arch.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_ARCH_X86_64_H
-#define _NOLIBC_ARCH_X86_64_H
+#ifndef _NOLIBC_X86_64_ARCH_H
+#define _NOLIBC_X86_64_ARCH_H
 
 #include "compiler.h"
 
@@ -217,4 +217,4 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 	__builtin_unreachable();
 }
 
-#endif /* _NOLIBC_ARCH_X86_64_H */
+#endif /* _NOLIBC_X86_64_ARCH_H */
-- 
2.25.1

