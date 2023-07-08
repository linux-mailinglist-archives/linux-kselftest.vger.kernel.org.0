Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543B874BE2C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGHP2E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGHP2E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:28:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081D90;
        Sat,  8 Jul 2023 08:27:59 -0700 (PDT)
X-QQ-mid: bizesmtp64t1688830069t3f4s4z0
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:27:48 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 5q30pvLz2ieFIXb+tjFEowNd/SSn3BVGFKmYiPWKnKwS2aby9tbkXrD72pwFA
        5eR44ukBDRfi9cdCVi7+5U9NS5grhGYAjwbRnzjX915TSOiXFEkZgn6MM6ra8zDZc/tBa5g
        4u5vN6dg02hvJt7BTMaVFiamd6U0KE3o1PMs60EVFlakbKFHsZa9JlP32zecHAcDPTuLa9q
        zP2P2ARCpOIj1lJr2bdv4xUsW0ZIWqY7h67pXkd8yitPtKTMakcpFH5S/4Kq02BTupECizw
        bnqatWkWSAhjEyaNa5as/715prKhMsR4o1q9VQuBuFysL97tiDji4NRyVB6UVf1E3GBNC97
        i7rzCnbyBsybOe2gV2tKIKvrwShehBnW9NZ3sdNH+4HViwyB3m34+t8OjN51V3uRi3u3X4c
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7756912049918278529
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 02/12] tools/nolibc: split arch.h to crt.h and sys.h
Date:   Sat,  8 Jul 2023 23:27:48 +0800
Message-Id: <50fb6551e3845ad04bdf4563b71d3e7ecaf70641.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For each architecture, arch.h has the syscall declarations and the
_start code definition, let's split it to sys.h and crt.h respectively:

- local :   <ARCH>/arch.h -> <ARCH>/{sys.h, crt.h}
- global:          arch.h -> sys_arch.h, crt_arch.h

And then, we can include the architecture specific file to the common
file like this:

- crt.h: #include "crt_arch.h"
- sys.h: #include "sys_arch.h"

At last, the "arch.h" header can be removed from all of the other
headers, instead, we only need to include "sys.h" and "crt.h" on demand.

BTW, the following errors reported by scripts/checkpatch.pl are fixed:

    ERROR: space required after that ',' (ctx:VxV)
    #1327: FILE: tools/include/nolibc/x86_64/crt.h:17:
    +void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/Makefile                 | 36 +++++++----
 tools/include/nolibc/aarch64/crt.h            | 37 +++++++++++
 .../include/nolibc/aarch64/{arch.h => sys.h}  | 40 ++----------
 tools/include/nolibc/arch.h                   | 36 -----------
 tools/include/nolibc/arm/crt.h                | 53 +++++++++++++++
 tools/include/nolibc/arm/{arch.h => sys.h}    | 59 ++---------------
 tools/include/nolibc/crt.h                    | 16 +++++
 tools/include/nolibc/crt_arch.h               | 32 ++++++++++
 tools/include/nolibc/i386/crt.h               | 48 ++++++++++++++
 tools/include/nolibc/i386/{arch.h => sys.h}   | 51 ++-------------
 tools/include/nolibc/loongarch/crt.h          | 61 ++++++++++++++++++
 .../nolibc/loongarch/{arch.h => sys.h}        | 64 ++-----------------
 tools/include/nolibc/mips/crt.h               | 56 ++++++++++++++++
 tools/include/nolibc/mips/{arch.h => sys.h}   | 59 ++---------------
 tools/include/nolibc/nolibc.h                 |  2 +-
 tools/include/nolibc/riscv/crt.h              | 57 +++++++++++++++++
 tools/include/nolibc/riscv/{arch.h => sys.h}  | 60 ++---------------
 tools/include/nolibc/s390/crt.h               | 45 +++++++++++++
 tools/include/nolibc/s390/{arch.h => sys.h}   | 49 ++------------
 tools/include/nolibc/signal.h                 |  1 -
 tools/include/nolibc/stdio.h                  |  1 -
 tools/include/nolibc/stdlib.h                 |  2 +-
 tools/include/nolibc/sys.h                    |  2 +-
 tools/include/nolibc/sys_arch.h               | 32 ++++++++++
 tools/include/nolibc/time.h                   |  1 -
 tools/include/nolibc/unistd.h                 |  1 -
 tools/include/nolibc/x86_64/crt.h             | 44 +++++++++++++
 tools/include/nolibc/x86_64/{arch.h => sys.h} | 47 ++------------
 28 files changed, 539 insertions(+), 453 deletions(-)
 create mode 100644 tools/include/nolibc/aarch64/crt.h
 rename tools/include/nolibc/aarch64/{arch.h => sys.h} (82%)
 delete mode 100644 tools/include/nolibc/arch.h
 create mode 100644 tools/include/nolibc/arm/crt.h
 rename tools/include/nolibc/arm/{arch.h => sys.h} (81%)
 create mode 100644 tools/include/nolibc/crt.h
 create mode 100644 tools/include/nolibc/crt_arch.h
 create mode 100644 tools/include/nolibc/i386/crt.h
 rename tools/include/nolibc/i386/{arch.h => sys.h} (79%)
 create mode 100644 tools/include/nolibc/loongarch/crt.h
 rename tools/include/nolibc/loongarch/{arch.h => sys.h} (73%)
 create mode 100644 tools/include/nolibc/mips/crt.h
 rename tools/include/nolibc/mips/{arch.h => sys.h} (79%)
 create mode 100644 tools/include/nolibc/riscv/crt.h
 rename tools/include/nolibc/riscv/{arch.h => sys.h} (78%)
 create mode 100644 tools/include/nolibc/s390/crt.h
 rename tools/include/nolibc/s390/{arch.h => sys.h} (78%)
 create mode 100644 tools/include/nolibc/sys_arch.h
 create mode 100644 tools/include/nolibc/x86_64/crt.h
 rename tools/include/nolibc/x86_64/{arch.h => sys.h} (81%)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index ce21ace8210e..e23c816598dc 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -24,9 +24,13 @@ Q=@
 endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
-arch_file := $(nolibc_arch)/arch.h
+arch_files := \
+		$(nolibc_arch)/crt.h \
+		$(nolibc_arch)/sys.h
+
 all_files := \
 		compiler.h \
+		crt.h \
 		ctype.h \
 		errno.h \
 		nolibc.h \
@@ -68,19 +72,23 @@ headers:
 	$(Q)mkdir -p $(OUTPUT)sysroot
 	$(Q)mkdir -p $(OUTPUT)sysroot/include
 	$(Q)cp $(all_files) $(OUTPUT)sysroot/include/
-	$(Q)if [ "$(ARCH)" = "x86" ]; then      \
-		sed -e                          \
-		  's,^#ifndef _NOLIBC_X86_64_ARCH_H,#if !defined(_NOLIBC_X86_64_ARCH_H) \&\& defined(__x86_64__),' \
-		  x86_64/arch.h;                \
-		sed -e                          \
-		  's,^#ifndef _NOLIBC_I386_ARCH_H,#if !defined(_NOLIBC_I386_ARCH_H) \&\& !defined(__x86_64__),' \
-		  i386/arch.h;                  \
-	elif [ -e "$(arch_file)" ]; then        \
-		cat $(arch_file);               \
-	else                                    \
-		echo "Fatal: architecture $(ARCH) not yet supported by nolibc." >&2; \
-		exit 1;                         \
-	fi > $(OUTPUT)sysroot/include/arch.h
+	$(Q)for arch_file in $(arch_files); do                                 \
+		base_file=$$(basename $$arch_file);                            \
+		arch_header=$$(echo $$base_file | sed -e 's/\.h$$/_arch.h/g'); \
+		if [ "$(ARCH)" = "x86" ]; then                                 \
+			sed -e                                                 \
+			  's,^#ifndef _NOLIBC_X86_64_\([^_]*\)_H,#if !defined(_NOLIBC_X86_64_\1_H) \&\& defined(__x86_64__),' \
+			  x86_64/$$base_file;                                  \
+			sed -e                                                 \
+			  's,^#ifndef _NOLIBC_I386_\([^_]*\)_H,#if !defined(_NOLIBC_I386_\1_H) \&\& !defined(__x86_64__),' \
+			  i386/$$base_file;                                    \
+		elif [ -e "$$arch_file" ]; then                                \
+			cat $$arch_file;                                       \
+		else                                                           \
+			echo "Fatal: architecture $(ARCH) not yet supported by nolibc." >&2; \
+			exit 1;                                                \
+		fi > $(OUTPUT)sysroot/include/$$arch_header;                   \
+	done
 
 headers_standalone: headers
 	$(Q)$(MAKE) -C $(srctree) headers
diff --git a/tools/include/nolibc/aarch64/crt.h b/tools/include/nolibc/aarch64/crt.h
new file mode 100644
index 000000000000..6c81d81cf31f
--- /dev/null
+++ b/tools/include/nolibc/aarch64/crt.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * AARCH64 specific startup code for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_AARCH64_CRT_H
+#define _NOLIBC_AARCH64_CRT_H
+
+/* startup code */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+#ifdef _NOLIBC_STACKPROTECTOR
+		"bl __stack_chk_init\n"   /* initialize stack protector                     */
+#endif
+		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
+		"add x1, sp, 8\n"    /* argv (x1) = sp                                      */
+		"lsl x2, x0, 3\n"    /* envp (x2) = 8*argc ...                              */
+		"add x2, x2, 8\n"    /*           + 8 (skip null)                           */
+		"add x2, x2, x1\n"   /*           + argv                                    */
+		"adrp x3, environ\n"          /* x3 = &environ (high bits)                  */
+		"str x2, [x3, #:lo12:environ]\n" /* store envp into environ                 */
+		"mov x4, x2\n"       /* search for auxv (follows NULL after last env)       */
+		"0:\n"
+		"ldr x5, [x4], 8\n"  /* x5 = *x4; x4 += 8                                   */
+		"cbnz x5, 0b\n"      /* and stop at NULL after last env                     */
+		"adrp x3, _auxv\n"   /* x3 = &_auxv (high bits)                             */
+		"str x4, [x3, #:lo12:_auxv]\n" /* store x4 into _auxv                       */
+		"and sp, x1, -16\n"  /* sp must be 16-byte aligned in the callee            */
+		"bl main\n"          /* main() returns the status code, we'll exit with it. */
+		"mov x8, 93\n"       /* NR_exit == 93                                       */
+		"svc #0\n"
+	);
+	__builtin_unreachable();
+}
+#endif /* _NOLIBC_AARCH64_CRT_H */
diff --git a/tools/include/nolibc/aarch64/arch.h b/tools/include/nolibc/aarch64/sys.h
similarity index 82%
rename from tools/include/nolibc/aarch64/arch.h
rename to tools/include/nolibc/aarch64/sys.h
index 7d38da13c72b..b79d6a35ec37 100644
--- a/tools/include/nolibc/aarch64/arch.h
+++ b/tools/include/nolibc/aarch64/sys.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * AARCH64 specific definitions for NOLIBC
+ * AARCH64 specific syscall declarations for NOLIBC
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_AARCH64_ARCH_H
-#define _NOLIBC_AARCH64_ARCH_H
-
-#include "compiler.h"
+#ifndef _NOLIBC_AARCH64_SYS_H
+#define _NOLIBC_AARCH64_SYS_H
 
 /* The struct returned by the newfstatat() syscall. Differs slightly from the
  * x86_64's stat one by field ordering, so be careful.
@@ -171,34 +169,4 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-/* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
-{
-	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"   /* initialize stack protector                     */
-#endif
-		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
-		"add x1, sp, 8\n"    /* argv (x1) = sp                                      */
-		"lsl x2, x0, 3\n"    /* envp (x2) = 8*argc ...                              */
-		"add x2, x2, 8\n"    /*           + 8 (skip null)                           */
-		"add x2, x2, x1\n"   /*           + argv                                    */
-		"adrp x3, environ\n"          /* x3 = &environ (high bits)                  */
-		"str x2, [x3, #:lo12:environ]\n" /* store envp into environ                 */
-		"mov x4, x2\n"       /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"ldr x5, [x4], 8\n"  /* x5 = *x4; x4 += 8                                   */
-		"cbnz x5, 0b\n"      /* and stop at NULL after last env                     */
-		"adrp x3, _auxv\n"   /* x3 = &_auxv (high bits)                             */
-		"str x4, [x3, #:lo12:_auxv]\n" /* store x4 into _auxv                       */
-		"and sp, x1, -16\n"  /* sp must be 16-byte aligned in the callee            */
-		"bl main\n"          /* main() returns the status code, we'll exit with it. */
-		"mov x8, 93\n"       /* NR_exit == 93                                       */
-		"svc #0\n"
-	);
-	__builtin_unreachable();
-}
-#endif /* _NOLIBC_AARCH64_ARCH_H */
+#endif /* _NOLIBC_AARCH64_SYS_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
deleted file mode 100644
index f98616f5b219..000000000000
--- a/tools/include/nolibc/arch.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
-/*
- * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
- */
-
-/* Below comes the architecture-specific code. For each architecture, we have
- * the syscall declarations and the _start code definition. This is the only
- * global part. On all architectures the kernel puts everything in the stack
- * before jumping to _start just above us, without any return address (_start
- * is not a function but an entry point). So at the stack pointer we find argc.
- * Then argv[] begins, and ends at the first NULL. Then we have envp which
- * starts and ends with a NULL as well. So envp=argv+argc+1.
- */
-
-#ifndef _NOLIBC_ARCH_H
-#define _NOLIBC_ARCH_H
-
-#if defined(__x86_64__)
-#include "x86_64/arch.h"
-#elif defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__)
-#include "i386/arch.h"
-#elif defined(__ARM_EABI__)
-#include "arm/arch.h"
-#elif defined(__aarch64__)
-#include "aarch64/arch.h"
-#elif defined(__mips__) && defined(_ABIO32)
-#include "mips/arch.h"
-#elif defined(__riscv)
-#include "riscv/arch.h"
-#elif defined(__s390x__)
-#include "s390/arch.h"
-#elif defined(__loongarch__)
-#include "loongarch/arch.h"
-#endif
-
-#endif /* _NOLIBC_ARCH_H */
diff --git a/tools/include/nolibc/arm/crt.h b/tools/include/nolibc/arm/crt.h
new file mode 100644
index 000000000000..7b3b9e21e5c4
--- /dev/null
+++ b/tools/include/nolibc/arm/crt.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * ARM specific startup code for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_ARM_CRT_H
+#define _NOLIBC_ARM_CRT_H
+
+/* startup code */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+#ifdef _NOLIBC_STACKPROTECTOR
+		"bl __stack_chk_init\n"       /* initialize stack protector                          */
+#endif
+		"pop {%r0}\n"                 /* argc was in the stack                               */
+		"mov %r1, %sp\n"              /* argv = sp                                           */
+
+		"add %r2, %r0, $1\n"          /* envp = (argc + 1) ...                               */
+		"lsl %r2, %r2, $2\n"          /*        * 4        ...                               */
+		"add %r2, %r2, %r1\n"         /*        + argv                                       */
+		"ldr %r3, 1f\n"               /* r3 = &environ (see below)                           */
+		"str %r2, [r3]\n"             /* store envp into environ                             */
+
+		"mov r4, r2\n"                /* search for auxv (follows NULL after last env)       */
+		"0:\n"
+		"mov r5, r4\n"                /* r5 = r4                                             */
+		"add r4, r4, #4\n"            /* r4 += 4                                             */
+		"ldr r5,[r5]\n"               /* r5 = *r5 = *(r4-4)                                  */
+		"cmp r5, #0\n"                /* and stop at NULL after last env                     */
+		"bne 0b\n"
+		"ldr %r3, 2f\n"               /* r3 = &_auxv (low bits)                              */
+		"str r4, [r3]\n"              /* store r4 into _auxv                                 */
+
+		"mov %r3, $8\n"               /* AAPCS : sp must be 8-byte aligned in the            */
+		"neg %r3, %r3\n"              /*         callee, and bl doesn't push (lr=pc)         */
+		"and %r3, %r3, %r1\n"         /* so we do sp = r1(=sp) & r3(=-8);                    */
+		"mov %sp, %r3\n"
+
+		"bl main\n"                   /* main() returns the status code, we'll exit with it. */
+		"movs r7, $1\n"               /* NR_exit == 1                                        */
+		"svc $0x00\n"
+		".align 2\n"                  /* below are the pointers to a few variables           */
+		"1:\n"
+		".word environ\n"
+		"2:\n"
+		".word _auxv\n"
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_ARM_CRT_H */
diff --git a/tools/include/nolibc/arm/arch.h b/tools/include/nolibc/arm/sys.h
similarity index 81%
rename from tools/include/nolibc/arm/arch.h
rename to tools/include/nolibc/arm/sys.h
index 473d2c000740..79173f860948 100644
--- a/tools/include/nolibc/arm/arch.h
+++ b/tools/include/nolibc/arm/sys.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * ARM specific definitions for NOLIBC
+ * ARM specific syscall declarations for NOLIBC
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_ARM_ARCH_H
-#define _NOLIBC_ARM_ARCH_H
-
-#include "compiler.h"
+#ifndef _NOLIBC_ARM_SYS_H
+#define _NOLIBC_ARM_SYS_H
 
 /* The struct returned by the stat() syscall, 32-bit only, the syscall returns
  * exactly 56 bytes (stops before the unused array). In big endian, the format
@@ -69,7 +67,7 @@ struct sys_stat_struct {
  *
  * Also, ARM supports the old_select syscall if newselect is not available
  */
-#define __ARCH_WANT_SYS_OLD_SELECT
+#define __SYS_WANT_SYS_OLD_SELECT
 
 #if (defined(__THUMBEB__) || defined(__THUMBEL__)) && \
     !defined(NOLIBC_OMIT_FRAME_POINTER)
@@ -220,51 +218,4 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-/* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
-{
-	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"       /* initialize stack protector                          */
-#endif
-		"pop {%r0}\n"                 /* argc was in the stack                               */
-		"mov %r1, %sp\n"              /* argv = sp                                           */
-
-		"add %r2, %r0, $1\n"          /* envp = (argc + 1) ...                               */
-		"lsl %r2, %r2, $2\n"          /*        * 4        ...                               */
-		"add %r2, %r2, %r1\n"         /*        + argv                                       */
-		"ldr %r3, 1f\n"               /* r3 = &environ (see below)                           */
-		"str %r2, [r3]\n"             /* store envp into environ                             */
-
-		"mov r4, r2\n"                /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"mov r5, r4\n"                /* r5 = r4                                             */
-		"add r4, r4, #4\n"            /* r4 += 4                                             */
-		"ldr r5,[r5]\n"               /* r5 = *r5 = *(r4-4)                                  */
-		"cmp r5, #0\n"                /* and stop at NULL after last env                     */
-		"bne 0b\n"
-		"ldr %r3, 2f\n"               /* r3 = &_auxv (low bits)                              */
-		"str r4, [r3]\n"              /* store r4 into _auxv                                 */
-
-		"mov %r3, $8\n"               /* AAPCS : sp must be 8-byte aligned in the            */
-		"neg %r3, %r3\n"              /*         callee, and bl doesn't push (lr=pc)         */
-		"and %r3, %r3, %r1\n"         /* so we do sp = r1(=sp) & r3(=-8);                    */
-		"mov %sp, %r3\n"
-
-		"bl main\n"                   /* main() returns the status code, we'll exit with it. */
-		"movs r7, $1\n"               /* NR_exit == 1                                        */
-		"svc $0x00\n"
-		".align 2\n"                  /* below are the pointers to a few variables           */
-		"1:\n"
-		".word environ\n"
-		"2:\n"
-		".word _auxv\n"
-	);
-	__builtin_unreachable();
-}
-
-#endif /* _NOLIBC_ARM_ARCH_H */
+#endif /* _NOLIBC_ARM_SYS_H */
diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
new file mode 100644
index 000000000000..221b7c5346ca
--- /dev/null
+++ b/tools/include/nolibc/crt.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * C Run Time support for NOLIBC
+ * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
+ */
+
+#ifndef _NOLIBC_CRT_H
+#define _NOLIBC_CRT_H
+
+#include "compiler.h"
+#include "crt_arch.h"
+
+char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
+
+#endif /* _NOLIBC_CRT_H */
diff --git a/tools/include/nolibc/crt_arch.h b/tools/include/nolibc/crt_arch.h
new file mode 100644
index 000000000000..741402557bd0
--- /dev/null
+++ b/tools/include/nolibc/crt_arch.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+/* Below comes the architecture-specific code. For each architecture, we have
+ * the syscall declarations and the _start code definition. This is the global
+ * part for _start code definition.
+ */
+
+#ifndef _NOLIBC_CRT_ARCH_H
+#define _NOLIBC_CRT_ARCH_H
+
+#if defined(__x86_64__)
+#include "x86_64/crt.h"
+#elif defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__)
+#include "i386/crt.h"
+#elif defined(__ARM_EABI__)
+#include "arm/crt.h"
+#elif defined(__aarch64__)
+#include "aarch64/crt.h"
+#elif defined(__mips__) && defined(_ABIO32)
+#include "mips/crt.h"
+#elif defined(__riscv)
+#include "riscv/crt.h"
+#elif defined(__s390x__)
+#include "s390/crt.h"
+#elif defined(__loongarch__)
+#include "loongarch/crt.h"
+#endif
+
+#endif /* _NOLIBC_CRT_ARCH_H */
diff --git a/tools/include/nolibc/i386/crt.h b/tools/include/nolibc/i386/crt.h
new file mode 100644
index 000000000000..0b88f7c887ae
--- /dev/null
+++ b/tools/include/nolibc/i386/crt.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * i386 specific startup code for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_I386_CRT_H
+#define _NOLIBC_I386_CRT_H
+
+/* startup code */
+/*
+ * i386 System V ABI mandates:
+ * 1) last pushed argument must be 16-byte aligned.
+ * 2) The deepest stack frame should be set to zero
+ *
+ */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+#ifdef _NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"   /* initialize stack protector                    */
+#endif
+		"pop %eax\n"                /* argc   (first arg, %eax)                      */
+		"mov %esp, %ebx\n"          /* argv[] (second arg, %ebx)                     */
+		"lea 4(%ebx,%eax,4),%ecx\n" /* then a NULL then envp (third arg, %ecx)       */
+		"mov %ecx, environ\n"       /* save environ                                  */
+		"xor %ebp, %ebp\n"          /* zero the stack frame                          */
+		"mov %ecx, %edx\n"          /* search for auxv (follows NULL after last env) */
+		"0:\n"
+		"add $4, %edx\n"            /* search for auxv using edx, it follows the     */
+		"cmp -4(%edx), %ebp\n"      /* ... NULL after last env (ebp is zero here)    */
+		"jnz 0b\n"
+		"mov %edx, _auxv\n"         /* save it into _auxv                            */
+		"and $-16, %esp\n"          /* x86 ABI : esp must be 16-byte aligned before  */
+		"sub $4, %esp\n"            /* the call instruction (args are aligned)       */
+		"push %ecx\n"               /* push all registers on the stack so that we    */
+		"push %ebx\n"               /* support both regparm and plain stack modes    */
+		"push %eax\n"
+		"call main\n"               /* main() returns the status code in %eax        */
+		"mov %eax, %ebx\n"          /* retrieve exit code (32-bit int)               */
+		"movl $1, %eax\n"           /* NR_exit == 1                                  */
+		"int $0x80\n"               /* exit now                                      */
+		"hlt\n"                     /* ensure it does not                            */
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_I386_CRT_H */
diff --git a/tools/include/nolibc/i386/arch.h b/tools/include/nolibc/i386/sys.h
similarity index 79%
rename from tools/include/nolibc/i386/arch.h
rename to tools/include/nolibc/i386/sys.h
index 66052742763e..c626cf2b145a 100644
--- a/tools/include/nolibc/i386/arch.h
+++ b/tools/include/nolibc/i386/sys.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * i386 specific definitions for NOLIBC
+ * i386 specific syscall declarations for NOLIBC
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_I386_ARCH_H
-#define _NOLIBC_I386_ARCH_H
-
-#include "compiler.h"
+#ifndef _NOLIBC_I386_SYS_H
+#define _NOLIBC_I386_SYS_H
 
 /* The struct returned by the stat() syscall, 32-bit only, the syscall returns
  * exactly 56 bytes (stops before the unused array).
@@ -180,45 +178,4 @@ struct sys_stat_struct {
 	_eax;							\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-/* startup code */
-/*
- * i386 System V ABI mandates:
- * 1) last pushed argument must be 16-byte aligned.
- * 2) The deepest stack frame should be set to zero
- *
- */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
-{
-	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                    */
-#endif
-		"pop %eax\n"                /* argc   (first arg, %eax)                      */
-		"mov %esp, %ebx\n"          /* argv[] (second arg, %ebx)                     */
-		"lea 4(%ebx,%eax,4),%ecx\n" /* then a NULL then envp (third arg, %ecx)       */
-		"mov %ecx, environ\n"       /* save environ                                  */
-		"xor %ebp, %ebp\n"          /* zero the stack frame                          */
-		"mov %ecx, %edx\n"          /* search for auxv (follows NULL after last env) */
-		"0:\n"
-		"add $4, %edx\n"            /* search for auxv using edx, it follows the     */
-		"cmp -4(%edx), %ebp\n"      /* ... NULL after last env (ebp is zero here)    */
-		"jnz 0b\n"
-		"mov %edx, _auxv\n"         /* save it into _auxv                            */
-		"and $-16, %esp\n"          /* x86 ABI : esp must be 16-byte aligned before  */
-		"sub $4, %esp\n"            /* the call instruction (args are aligned)       */
-		"push %ecx\n"               /* push all registers on the stack so that we    */
-		"push %ebx\n"               /* support both regparm and plain stack modes    */
-		"push %eax\n"
-		"call main\n"               /* main() returns the status code in %eax        */
-		"mov %eax, %ebx\n"          /* retrieve exit code (32-bit int)               */
-		"movl $1, %eax\n"           /* NR_exit == 1                                  */
-		"int $0x80\n"               /* exit now                                      */
-		"hlt\n"                     /* ensure it does not                            */
-	);
-	__builtin_unreachable();
-}
-
-#endif /* _NOLIBC_I386_ARCH_H */
+#endif /* _NOLIBC_I386_SYS_H */
diff --git a/tools/include/nolibc/loongarch/crt.h b/tools/include/nolibc/loongarch/crt.h
new file mode 100644
index 000000000000..253d2fccea1e
--- /dev/null
+++ b/tools/include/nolibc/loongarch/crt.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * LoongArch specific startup code for NOLIBC
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef _NOLIBC_LOONGARCH_CRT_H
+#define _NOLIBC_LOONGARCH_CRT_H
+
+#if __loongarch_grlen == 32
+#define LONGLOG      "2"
+#define SZREG        "4"
+#define REG_L        "ld.w"
+#define LONG_S       "st.w"
+#define LONG_ADD     "add.w"
+#define LONG_ADDI    "addi.w"
+#define LONG_SLL     "slli.w"
+#define LONG_BSTRINS "bstrins.w"
+#else /* __loongarch_grlen == 64 */
+#define LONGLOG      "3"
+#define SZREG        "8"
+#define REG_L        "ld.d"
+#define LONG_S       "st.d"
+#define LONG_ADD     "add.d"
+#define LONG_ADDI    "addi.d"
+#define LONG_SLL     "slli.d"
+#define LONG_BSTRINS "bstrins.d"
+#endif
+
+/* startup code */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+#ifdef _NOLIBC_STACKPROTECTOR
+		"bl __stack_chk_init\n"               /* initialize stack protector                          */
+#endif
+		REG_L        " $a0, $sp, 0\n"         /* argc (a0) was in the stack                          */
+		LONG_ADDI    " $a1, $sp, "SZREG"\n"   /* argv (a1) = sp + SZREG                              */
+		LONG_SLL     " $a2, $a0, "LONGLOG"\n" /* envp (a2) = SZREG*argc ...                          */
+		LONG_ADDI    " $a2, $a2, "SZREG"\n"   /*             + SZREG (skip null)                     */
+		LONG_ADD     " $a2, $a2, $a1\n"       /*             + argv                                  */
+
+		"move          $a3, $a2\n"            /* iterate a3 over envp to find auxv (after NULL)      */
+		"0:\n"                                /* do {                                                */
+		REG_L        " $a4, $a3, 0\n"         /*   a4 = *a3;                                         */
+		LONG_ADDI    " $a3, $a3, "SZREG"\n"   /*   a3 += sizeof(void*);                              */
+		"bne           $a4, $zero, 0b\n"      /* } while (a4);                                       */
+		"la.pcrel      $a4, _auxv\n"          /* a4 = &_auxv                                         */
+		LONG_S       " $a3, $a4, 0\n"         /* store a3 into _auxv                                 */
+
+		"la.pcrel      $a3, environ\n"        /* a3 = &environ                                       */
+		LONG_S       " $a2, $a3, 0\n"         /* store envp(a2) into environ                         */
+		LONG_BSTRINS " $sp, $zero, 3, 0\n"    /* sp must be 16-byte aligned                          */
+		"bl            main\n"                /* main() returns the status code, we'll exit with it. */
+		"li.w          $a7, 93\n"             /* NR_exit == 93                                       */
+		"syscall       0\n"
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_LOONGARCH_CRT_H */
diff --git a/tools/include/nolibc/loongarch/arch.h b/tools/include/nolibc/loongarch/sys.h
similarity index 73%
rename from tools/include/nolibc/loongarch/arch.h
rename to tools/include/nolibc/loongarch/sys.h
index 63fee1e8f4d9..98d47b5823dc 100644
--- a/tools/include/nolibc/loongarch/arch.h
+++ b/tools/include/nolibc/loongarch/sys.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * LoongArch specific definitions for NOLIBC
+ * LoongArch specific syscall declarations for NOLIBC
  * Copyright (C) 2023 Loongson Technology Corporation Limited
  */
 
-#ifndef _NOLIBC_LOONGARCH_ARCH_H
-#define _NOLIBC_LOONGARCH_ARCH_H
-
-#include "compiler.h"
+#ifndef _NOLIBC_LOONGARCH_SYS_H
+#define _NOLIBC_LOONGARCH_SYS_H
 
 /* Syscalls for LoongArch :
  *   - stack is 16-byte aligned
@@ -143,58 +141,4 @@
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-#if __loongarch_grlen == 32
-#define LONGLOG      "2"
-#define SZREG        "4"
-#define REG_L        "ld.w"
-#define LONG_S       "st.w"
-#define LONG_ADD     "add.w"
-#define LONG_ADDI    "addi.w"
-#define LONG_SLL     "slli.w"
-#define LONG_BSTRINS "bstrins.w"
-#else /* __loongarch_grlen == 64 */
-#define LONGLOG      "3"
-#define SZREG        "8"
-#define REG_L        "ld.d"
-#define LONG_S       "st.d"
-#define LONG_ADD     "add.d"
-#define LONG_ADDI    "addi.d"
-#define LONG_SLL     "slli.d"
-#define LONG_BSTRINS "bstrins.d"
-#endif
-
-/* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
-{
-	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"               /* initialize stack protector                          */
-#endif
-		REG_L        " $a0, $sp, 0\n"         /* argc (a0) was in the stack                          */
-		LONG_ADDI    " $a1, $sp, "SZREG"\n"   /* argv (a1) = sp + SZREG                              */
-		LONG_SLL     " $a2, $a0, "LONGLOG"\n" /* envp (a2) = SZREG*argc ...                          */
-		LONG_ADDI    " $a2, $a2, "SZREG"\n"   /*             + SZREG (skip null)                     */
-		LONG_ADD     " $a2, $a2, $a1\n"       /*             + argv                                  */
-
-		"move          $a3, $a2\n"            /* iterate a3 over envp to find auxv (after NULL)      */
-		"0:\n"                                /* do {                                                */
-		REG_L        " $a4, $a3, 0\n"         /*   a4 = *a3;                                         */
-		LONG_ADDI    " $a3, $a3, "SZREG"\n"   /*   a3 += sizeof(void*);                              */
-		"bne           $a4, $zero, 0b\n"      /* } while (a4);                                       */
-		"la.pcrel      $a4, _auxv\n"          /* a4 = &_auxv                                         */
-		LONG_S       " $a3, $a4, 0\n"         /* store a3 into _auxv                                 */
-
-		"la.pcrel      $a3, environ\n"        /* a3 = &environ                                       */
-		LONG_S       " $a2, $a3, 0\n"         /* store envp(a2) into environ                         */
-		LONG_BSTRINS " $sp, $zero, 3, 0\n"    /* sp must be 16-byte aligned                          */
-		"bl            main\n"                /* main() returns the status code, we'll exit with it. */
-		"li.w          $a7, 93\n"             /* NR_exit == 93                                       */
-		"syscall       0\n"
-	);
-	__builtin_unreachable();
-}
-
-#endif /* _NOLIBC_LOONGARCH_ARCH_H */
+#endif /* _NOLIBC_LOONGARCH_SYS_H */
diff --git a/tools/include/nolibc/mips/crt.h b/tools/include/nolibc/mips/crt.h
new file mode 100644
index 000000000000..38df52d8ec16
--- /dev/null
+++ b/tools/include/nolibc/mips/crt.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * MIPS specific startup code for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_MIPS_CRT_H
+#define _NOLIBC_MIPS_CRT_H
+
+/* startup code, note that it's called __start on MIPS */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
+{
+	__asm__ volatile (
+		/*".set nomips16\n"*/
+		".set push\n"
+		".set    noreorder\n"
+		".option pic0\n"
+#ifdef _NOLIBC_STACKPROTECTOR
+		"jal __stack_chk_init\n" /* initialize stack protector                         */
+		"nop\n"                  /* delayed slot                                       */
+#endif
+		/*".ent __start\n"*/
+		/*"__start:\n"*/
+		"lw $a0,($sp)\n"        /* argc was in the stack                               */
+		"addiu  $a1, $sp, 4\n"  /* argv = sp + 4                                       */
+		"sll $a2, $a0, 2\n"     /* a2 = argc * 4                                       */
+		"add   $a2, $a2, $a1\n" /* envp = argv + 4*argc ...                            */
+		"addiu $a2, $a2, 4\n"   /*        ... + 4                                      */
+		"lui $a3, %hi(environ)\n"     /* load environ into a3 (hi)                     */
+		"addiu $a3, %lo(environ)\n"   /* load environ into a3 (lo)                     */
+		"sw $a2,($a3)\n"              /* store envp(a2) into environ                   */
+
+		"move $t0, $a2\n"             /* iterate t0 over envp, look for NULL           */
+		"0:"                          /* do {                                          */
+		"lw $a3, ($t0)\n"             /*   a3=*(t0);                                   */
+		"bne $a3, $0, 0b\n"           /* } while (a3);                                 */
+		"addiu $t0, $t0, 4\n"         /* delayed slot: t0+=4;                          */
+		"lui $a3, %hi(_auxv)\n"       /* load _auxv into a3 (hi)                       */
+		"addiu $a3, %lo(_auxv)\n"     /* load _auxv into a3 (lo)                       */
+		"sw $t0, ($a3)\n"             /* store t0 into _auxv                           */
+
+		"li $t0, -8\n"
+		"and $sp, $sp, $t0\n"   /* sp must be 8-byte aligned                           */
+		"addiu $sp,$sp,-16\n"   /* the callee expects to save a0..a3 there!            */
+		"jal main\n"            /* main() returns the status code, we'll exit with it. */
+		"nop\n"                 /* delayed slot                                        */
+		"move $a0, $v0\n"       /* retrieve 32-bit exit code from v0                   */
+		"li $v0, 4001\n"        /* NR_exit == 4001                                     */
+		"syscall\n"
+		/*".end __start\n"*/
+		".set pop\n"
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_MIPS_CRT_H */
diff --git a/tools/include/nolibc/mips/arch.h b/tools/include/nolibc/mips/sys.h
similarity index 79%
rename from tools/include/nolibc/mips/arch.h
rename to tools/include/nolibc/mips/sys.h
index 1581b721b714..13dfbf3e6a3d 100644
--- a/tools/include/nolibc/mips/arch.h
+++ b/tools/include/nolibc/mips/sys.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * MIPS specific definitions for NOLIBC
+ * MIPS specific syscall declarations for NOLIBC
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_MIPS_ARCH_H
-#define _NOLIBC_MIPS_ARCH_H
-
-#include "compiler.h"
+#ifndef _NOLIBC_MIPS_SYS_H
+#define _NOLIBC_MIPS_SYS_H
 
 /* The struct returned by the stat() syscall. 88 bytes are returned by the
  * syscall.
@@ -201,53 +199,4 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-/* startup code, note that it's called __start on MIPS */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
-{
-	__asm__ volatile (
-		/*".set nomips16\n"*/
-		".set push\n"
-		".set    noreorder\n"
-		".option pic0\n"
-#ifdef _NOLIBC_STACKPROTECTOR
-		"jal __stack_chk_init\n" /* initialize stack protector                         */
-		"nop\n"                  /* delayed slot                                       */
-#endif
-		/*".ent __start\n"*/
-		/*"__start:\n"*/
-		"lw $a0,($sp)\n"        /* argc was in the stack                               */
-		"addiu  $a1, $sp, 4\n"  /* argv = sp + 4                                       */
-		"sll $a2, $a0, 2\n"     /* a2 = argc * 4                                       */
-		"add   $a2, $a2, $a1\n" /* envp = argv + 4*argc ...                            */
-		"addiu $a2, $a2, 4\n"   /*        ... + 4                                      */
-		"lui $a3, %hi(environ)\n"     /* load environ into a3 (hi)                     */
-		"addiu $a3, %lo(environ)\n"   /* load environ into a3 (lo)                     */
-		"sw $a2,($a3)\n"              /* store envp(a2) into environ                   */
-
-		"move $t0, $a2\n"             /* iterate t0 over envp, look for NULL           */
-		"0:"                          /* do {                                          */
-		"lw $a3, ($t0)\n"             /*   a3=*(t0);                                   */
-		"bne $a3, $0, 0b\n"           /* } while (a3);                                 */
-		"addiu $t0, $t0, 4\n"         /* delayed slot: t0+=4;                          */
-		"lui $a3, %hi(_auxv)\n"       /* load _auxv into a3 (hi)                       */
-		"addiu $a3, %lo(_auxv)\n"     /* load _auxv into a3 (lo)                       */
-		"sw $t0, ($a3)\n"             /* store t0 into _auxv                           */
-
-		"li $t0, -8\n"
-		"and $sp, $sp, $t0\n"   /* sp must be 8-byte aligned                           */
-		"addiu $sp,$sp,-16\n"   /* the callee expects to save a0..a3 there!            */
-		"jal main\n"            /* main() returns the status code, we'll exit with it. */
-		"nop\n"                 /* delayed slot                                        */
-		"move $a0, $v0\n"       /* retrieve 32-bit exit code from v0                   */
-		"li $v0, 4001\n"        /* NR_exit == 4001                                     */
-		"syscall\n"
-		/*".end __start\n"*/
-		".set pop\n"
-	);
-	__builtin_unreachable();
-}
-
-#endif /* _NOLIBC_MIPS_ARCH_H */
+#endif /* _NOLIBC_MIPS_SYS_H */
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 1f8d821000ac..096a18b71923 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -93,8 +93,8 @@
 #define _NOLIBC_H
 
 #include "std.h"
-#include "arch.h"
 #include "types.h"
+#include "crt.h"
 #include "sys.h"
 #include "ctype.h"
 #include "signal.h"
diff --git a/tools/include/nolibc/riscv/crt.h b/tools/include/nolibc/riscv/crt.h
new file mode 100644
index 000000000000..1f81a2e47a48
--- /dev/null
+++ b/tools/include/nolibc/riscv/crt.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * RISCV (32 and 64) specific startup code for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_RISCV_CRT_H
+#define _NOLIBC_RISCV_CRT_H
+
+#if   __riscv_xlen == 64
+#define PTRLOG "3"
+#define SZREG  "8"
+#define REG_L  "ld"
+#define REG_S  "sd"
+#elif __riscv_xlen == 32
+#define PTRLOG "2"
+#define SZREG  "4"
+#define REG_L  "lw"
+#define REG_S  "sw"
+#endif
+
+/* startup code */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+		".option push\n"
+		".option norelax\n"
+		"lla   gp, __global_pointer$\n"
+		".option pop\n"
+#ifdef _NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"    /* initialize stack protector                          */
+#endif
+		REG_L" a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
+		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
+		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
+		"add   a2, a2, "SZREG"\n"    /*             + SZREG (skip null)                     */
+		"add   a2,a2,a1\n"           /*             + argv                                  */
+
+		"add   a3, a2, zero\n"       /* iterate a3 over envp to find auxv (after NULL)      */
+		"0:\n"                       /* do {                                                */
+		REG_L" a4, 0(a3)\n"          /*   a4 = *a3;                                         */
+		"add   a3, a3, "SZREG"\n"    /*   a3 += sizeof(void*);                              */
+		"bne   a4, zero, 0b\n"       /* } while (a4);                                       */
+		"lui   a4, %hi(_auxv)\n"     /* a4 = &_auxv (high bits)                             */
+		REG_S" a3, %lo(_auxv)(a4)\n" /* store a3 into _auxv                                 */
+
+		"lui   a3, %hi(environ)\n"   /* a3 = &environ (high bits)                           */
+		REG_S" a2,%lo(environ)(a3)\n"/* store envp(a2) into environ                         */
+		"andi  sp,a1,-16\n"          /* sp must be 16-byte aligned                          */
+		"call  main\n"               /* main() returns the status code, we'll exit with it. */
+		"li a7, 93\n"                /* NR_exit == 93                                       */
+		"ecall\n"
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_RISCV_CRT_H */
diff --git a/tools/include/nolibc/riscv/arch.h b/tools/include/nolibc/riscv/sys.h
similarity index 78%
rename from tools/include/nolibc/riscv/arch.h
rename to tools/include/nolibc/riscv/sys.h
index de68759f5959..aa15b86c919f 100644
--- a/tools/include/nolibc/riscv/arch.h
+++ b/tools/include/nolibc/riscv/sys.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * RISCV (32 and 64) specific definitions for NOLIBC
+ * RISCV (32 and 64) specific syscall declarations for NOLIBC
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_RISCV_ARCH_H
-#define _NOLIBC_RISCV_ARCH_H
-
-#include "compiler.h"
+#ifndef _NOLIBC_RISCV_SYS_H
+#define _NOLIBC_RISCV_SYS_H
 
 struct sys_stat_struct {
 	unsigned long	st_dev;		/* Device.  */
@@ -32,18 +30,6 @@ struct sys_stat_struct {
 	unsigned int	__unused5;
 };
 
-#if   __riscv_xlen == 64
-#define PTRLOG "3"
-#define SZREG  "8"
-#define REG_L  "ld"
-#define REG_S  "sd"
-#elif __riscv_xlen == 32
-#define PTRLOG "2"
-#define SZREG  "4"
-#define REG_L  "lw"
-#define REG_S  "sw"
-#endif
-
 /* Syscalls for RISCV :
  *   - stack is 16-byte aligned
  *   - syscall number is passed in a7
@@ -176,42 +162,4 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-/* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
-{
-	__asm__ volatile (
-		".option push\n"
-		".option norelax\n"
-		"lla   gp, __global_pointer$\n"
-		".option pop\n"
-#ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"    /* initialize stack protector                          */
-#endif
-		REG_L" a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
-		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
-		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
-		"add   a2, a2, "SZREG"\n"    /*             + SZREG (skip null)                     */
-		"add   a2,a2,a1\n"           /*             + argv                                  */
-
-		"add   a3, a2, zero\n"       /* iterate a3 over envp to find auxv (after NULL)      */
-		"0:\n"                       /* do {                                                */
-		REG_L" a4, 0(a3)\n"          /*   a4 = *a3;                                         */
-		"add   a3, a3, "SZREG"\n"    /*   a3 += sizeof(void*);                              */
-		"bne   a4, zero, 0b\n"       /* } while (a4);                                       */
-		"lui   a4, %hi(_auxv)\n"     /* a4 = &_auxv (high bits)                             */
-		REG_S" a3, %lo(_auxv)(a4)\n" /* store a3 into _auxv                                 */
-
-		"lui   a3, %hi(environ)\n"   /* a3 = &environ (high bits)                           */
-		REG_S" a2,%lo(environ)(a3)\n"/* store envp(a2) into environ                         */
-		"andi  sp,a1,-16\n"          /* sp must be 16-byte aligned                          */
-		"call  main\n"               /* main() returns the status code, we'll exit with it. */
-		"li a7, 93\n"                /* NR_exit == 93                                       */
-		"ecall\n"
-	);
-	__builtin_unreachable();
-}
-
-#endif /* _NOLIBC_RISCV_ARCH_H */
+#endif /* _NOLIBC_RISCV_SYS_H */
diff --git a/tools/include/nolibc/s390/crt.h b/tools/include/nolibc/s390/crt.h
new file mode 100644
index 000000000000..8580f615d525
--- /dev/null
+++ b/tools/include/nolibc/s390/crt.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * s390 specific startup code for NOLIBC
+ */
+
+#ifndef _NOLIBC_S390_CRT_H
+#define _NOLIBC_S390_CRT_H
+
+/* startup code */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+		"lg	%r2,0(%r15)\n"		/* argument count */
+		"la	%r3,8(%r15)\n"		/* argument pointers */
+
+		"xgr	%r0,%r0\n"		/* r0 will be our NULL value */
+		/* search for envp */
+		"lgr	%r4,%r3\n"		/* start at argv */
+		"0:\n"
+		"clg	%r0,0(%r4)\n"		/* entry zero? */
+		"la	%r4,8(%r4)\n"		/* advance pointer */
+		"jnz	0b\n"			/* no -> test next pointer */
+						/* yes -> r4 now contains start of envp */
+		"larl	%r1,environ\n"
+		"stg	%r4,0(%r1)\n"
+
+		/* search for auxv */
+		"lgr	%r5,%r4\n"		/* start at envp */
+		"1:\n"
+		"clg	%r0,0(%r5)\n"		/* entry zero? */
+		"la	%r5,8(%r5)\n"		/* advance pointer */
+		"jnz	1b\n"			/* no -> test next pointer */
+		"larl	%r1,_auxv\n"		/* yes -> store value in _auxv */
+		"stg	%r5,0(%r1)\n"
+
+		"aghi	%r15,-160\n"		/* allocate new stackframe */
+		"xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
+		"brasl	%r14,main\n"		/* ret value of main is arg to exit */
+		"lghi	%r1,1\n"		/* __NR_exit */
+		"svc	0\n"
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_S390_CRT_H */
diff --git a/tools/include/nolibc/s390/arch.h b/tools/include/nolibc/s390/sys.h
similarity index 78%
rename from tools/include/nolibc/s390/arch.h
rename to tools/include/nolibc/s390/sys.h
index a7b512e81234..041f4ecb7922 100644
--- a/tools/include/nolibc/s390/arch.h
+++ b/tools/include/nolibc/s390/sys.h
@@ -1,15 +1,13 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * s390 specific definitions for NOLIBC
+ * s390 specific syscall declarations for NOLIBC
  */
 
-#ifndef _NOLIBC_S390_ARCH_H
-#define _NOLIBC_S390_ARCH_H
+#ifndef _NOLIBC_S390_SYS_H
+#define _NOLIBC_S390_SYS_H
 #include <asm/signal.h>
 #include <asm/unistd.h>
 
-#include "compiler.h"
-
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
  * syscall returns 116 bytes and stops in the middle of __unused.
  */
@@ -162,45 +160,6 @@ struct sys_stat_struct {
 	_arg1;								\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-/* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
-{
-	__asm__ volatile (
-		"lg	%r2,0(%r15)\n"		/* argument count */
-		"la	%r3,8(%r15)\n"		/* argument pointers */
-
-		"xgr	%r0,%r0\n"		/* r0 will be our NULL value */
-		/* search for envp */
-		"lgr	%r4,%r3\n"		/* start at argv */
-		"0:\n"
-		"clg	%r0,0(%r4)\n"		/* entry zero? */
-		"la	%r4,8(%r4)\n"		/* advance pointer */
-		"jnz	0b\n"			/* no -> test next pointer */
-						/* yes -> r4 now contains start of envp */
-		"larl	%r1,environ\n"
-		"stg	%r4,0(%r1)\n"
-
-		/* search for auxv */
-		"lgr	%r5,%r4\n"		/* start at envp */
-		"1:\n"
-		"clg	%r0,0(%r5)\n"		/* entry zero? */
-		"la	%r5,8(%r5)\n"		/* advance pointer */
-		"jnz	1b\n"			/* no -> test next pointer */
-		"larl	%r1,_auxv\n"		/* yes -> store value in _auxv */
-		"stg	%r5,0(%r1)\n"
-
-		"aghi	%r15,-160\n"		/* allocate new stackframe */
-		"xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
-		"brasl	%r14,main\n"		/* ret value of main is arg to exit */
-		"lghi	%r1,1\n"		/* __NR_exit */
-		"svc	0\n"
-	);
-	__builtin_unreachable();
-}
-
 struct s390_mmap_arg_struct {
 	unsigned long addr;
 	unsigned long len;
@@ -234,4 +193,4 @@ pid_t sys_fork(void)
 }
 #define sys_fork sys_fork
 
-#endif /* _NOLIBC_S390_ARCH_H */
+#endif /* _NOLIBC_S390_SYS_H */
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index 137552216e46..687c4c13a1d9 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -8,7 +8,6 @@
 #define _NOLIBC_SIGNAL_H
 
 #include "std.h"
-#include "arch.h"
 #include "types.h"
 #include "sys.h"
 
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 0eef91daf289..ee5b3f3b79e6 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -10,7 +10,6 @@
 #include <stdarg.h>
 
 #include "std.h"
-#include "arch.h"
 #include "errno.h"
 #include "types.h"
 #include "sys.h"
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 902162f80337..2f9b4b3c6d26 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -8,8 +8,8 @@
 #define _NOLIBC_STDLIB_H
 
 #include "std.h"
-#include "arch.h"
 #include "types.h"
+#include "crt.h"
 #include "sys.h"
 #include "string.h"
 #include <linux/auxvec.h>
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index dee56894a811..e84ed57f3a63 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -23,7 +23,7 @@
 #include <linux/stat.h>  /* for statx() */
 #include <linux/prctl.h>
 
-#include "arch.h"
+#include "sys_arch.h"
 #include "errno.h"
 #include "types.h"
 
diff --git a/tools/include/nolibc/sys_arch.h b/tools/include/nolibc/sys_arch.h
new file mode 100644
index 000000000000..b073051c7713
--- /dev/null
+++ b/tools/include/nolibc/sys_arch.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+/* Below comes the architecture-specific code. For each architecture, we have
+ * the syscall declarations and the _start code definition. This is the global
+ * part for syscall declarations.
+ */
+
+#ifndef _NOLIBC_SYS_ARCH_H
+#define _NOLIBC_SYS_ARCH_H
+
+#if defined(__x86_64__)
+#include "x86_64/sys.h"
+#elif defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__)
+#include "i386/sys.h"
+#elif defined(__ARM_EABI__)
+#include "arm/sys.h"
+#elif defined(__aarch64__)
+#include "aarch64/sys.h"
+#elif defined(__mips__) && defined(_ABIO32)
+#include "mips/sys.h"
+#elif defined(__riscv)
+#include "riscv/sys.h"
+#elif defined(__s390x__)
+#include "s390/sys.h"
+#elif defined(__loongarch__)
+#include "loongarch/sys.h"
+#endif
+
+#endif /* _NOLIBC_SYS_ARCH_H */
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 84655361b9ad..127ac60706b2 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -8,7 +8,6 @@
 #define _NOLIBC_TIME_H
 
 #include "std.h"
-#include "arch.h"
 #include "types.h"
 #include "sys.h"
 
diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index e38f3660c051..219cc5ea319a 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -8,7 +8,6 @@
 #define _NOLIBC_UNISTD_H
 
 #include "std.h"
-#include "arch.h"
 #include "types.h"
 #include "sys.h"
 
diff --git a/tools/include/nolibc/x86_64/crt.h b/tools/include/nolibc/x86_64/crt.h
new file mode 100644
index 000000000000..6fede1235efc
--- /dev/null
+++ b/tools/include/nolibc/x86_64/crt.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * x86_64 specific startup code for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_X86_64_CRT_H
+#define _NOLIBC_X86_64_CRT_H
+
+/* startup code */
+/*
+ * x86-64 System V ABI mandates:
+ * 1) %rsp must be 16-byte aligned right before the function call.
+ * 2) The deepest stack frame should be zero (the %rbp).
+ *
+ */
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+#ifdef _NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"   /* initialize stack protector                          */
+#endif
+		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
+		"mov %rsp, %rsi\n"          /* argv[] (second arg, %rsi)                           */
+		"lea 8(%rsi,%rdi,8),%rdx\n" /* then a NULL then envp (third arg, %rdx)             */
+		"mov %rdx, environ\n"       /* save environ                                        */
+		"xor %ebp, %ebp\n"          /* zero the stack frame                                */
+		"mov %rdx, %rax\n"          /* search for auxv (follows NULL after last env)       */
+		"0:\n"
+		"add $8, %rax\n"            /* search for auxv using rax, it follows the           */
+		"cmp -8(%rax), %rbp\n"      /* ... NULL after last env (rbp is zero here)          */
+		"jnz 0b\n"
+		"mov %rax, _auxv\n"         /* save it into _auxv                                  */
+		"and $-16, %rsp\n"          /* x86 ABI : esp must be 16-byte aligned before call   */
+		"call main\n"               /* main() returns the status code, we'll exit with it. */
+		"mov %eax, %edi\n"          /* retrieve exit code (32 bit)                         */
+		"mov $60, %eax\n"           /* NR_exit == 60                                       */
+		"syscall\n"                 /* really exit                                         */
+		"hlt\n"                     /* ensure it does not return                           */
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_X86_64_CRT_H */
diff --git a/tools/include/nolibc/x86_64/arch.h b/tools/include/nolibc/x86_64/sys.h
similarity index 81%
rename from tools/include/nolibc/x86_64/arch.h
rename to tools/include/nolibc/x86_64/sys.h
index 602791c3461a..c761c97dccf8 100644
--- a/tools/include/nolibc/x86_64/arch.h
+++ b/tools/include/nolibc/x86_64/sys.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 /*
- * x86_64 specific definitions for NOLIBC
+ * x86_64 specific syscall declarations for NOLIBC
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
-#ifndef _NOLIBC_X86_64_ARCH_H
-#define _NOLIBC_X86_64_ARCH_H
-
-#include "compiler.h"
+#ifndef _NOLIBC_X86_64_SYS_H
+#define _NOLIBC_X86_64_SYS_H
 
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
  * syscall returns 116 bytes and stops in the middle of __unused.
@@ -180,41 +178,4 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
-/* startup code */
-/*
- * x86-64 System V ABI mandates:
- * 1) %rsp must be 16-byte aligned right before the function call.
- * 2) The deepest stack frame should be zero (the %rbp).
- *
- */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
-{
-	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                          */
-#endif
-		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
-		"mov %rsp, %rsi\n"          /* argv[] (second arg, %rsi)                           */
-		"lea 8(%rsi,%rdi,8),%rdx\n" /* then a NULL then envp (third arg, %rdx)             */
-		"mov %rdx, environ\n"       /* save environ                                        */
-		"xor %ebp, %ebp\n"          /* zero the stack frame                                */
-		"mov %rdx, %rax\n"          /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"add $8, %rax\n"            /* search for auxv using rax, it follows the           */
-		"cmp -8(%rax), %rbp\n"      /* ... NULL after last env (rbp is zero here)          */
-		"jnz 0b\n"
-		"mov %rax, _auxv\n"         /* save it into _auxv                                  */
-		"and $-16, %rsp\n"          /* x86 ABI : esp must be 16-byte aligned before call   */
-		"call main\n"               /* main() returns the status code, we'll exit with it. */
-		"mov %eax, %edi\n"          /* retrieve exit code (32 bit)                         */
-		"mov $60, %eax\n"           /* NR_exit == 60                                       */
-		"syscall\n"                 /* really exit                                         */
-		"hlt\n"                     /* ensure it does not return                           */
-	);
-	__builtin_unreachable();
-}
-
-#endif /* _NOLIBC_X86_64_ARCH_H */
+#endif /* _NOLIBC_X86_64_SYS_H */
-- 
2.25.1

