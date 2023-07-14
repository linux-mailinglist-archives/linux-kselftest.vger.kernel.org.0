Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB9753D2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 16:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbjGNOWq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjGNOWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 10:22:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A02D57;
        Fri, 14 Jul 2023 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689344564; x=1720880564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8gi0W6VgdCgIQNzzU6F2i4utOg/7MiKkJKT13Uo8zk=;
  b=j1XrNOao9zuwdvJgJBWh3T0dhh9F9o0mTRhiTXwr5oEX4dDt59Ibcczg
   jxJbn7+a5BRXSa0cGN1wYPpwctDh8C/01wzaBnon7W65EVXAvshuGTTD1
   mn6xLM6gOjCGOyvGrTNbLfETnx+ImlBiN+STYHW6F4l5G332Kdc0AkulL
   TKF9qHxEuqExbUbq/oqH3sm5xz/qoZjubFUxLIikbfBa8yGxs67keoeSl
   BJeJy7ue0iU9OqIVogP/OujPyWZNYTl4sKWBFa358ci+SG1Iq8MooYdly
   KMONlPuxdKtV5g4ENI82tU65mXB2FN0PTvFUiwYckFj3aN3pJMnDmfDoQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="431657590"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="431657590"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 07:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="725721623"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="725721623"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2023 07:22:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11E2B385; Fri, 14 Jul 2023 17:22:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/1] kernel.h: Split out COUNT_ARGS() and CONCATENATE() to args.h
Date:   Fri, 14 Jul 2023 17:22:37 +0300
Message-Id: <20230714142237.21836-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
The COUNT_ARGS() and CONCATENATE() macros may be used in some places
without need of the full kernel.h dependency train with it.

Here is the attempt on cleaning it up by splitting out these macros().

While at it, include new header where it's being used and drop custom
implementation of these macros and document how it works.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: converted existing users at the same time, documented (Andrew, Rasmus)
 arch/x86/include/asm/rmwcc.h      | 11 +++--------
 include/kunit/test.h              |  1 +
 include/linux/args.h              | 28 ++++++++++++++++++++++++++++
 include/linux/arm-smccc.h         | 27 ++++++++++-----------------
 include/linux/genl_magic_struct.h |  8 +++-----
 include/linux/kernel.h            |  7 -------
 include/linux/pci.h               |  2 +-
 include/trace/bpf_probe.h         |  2 ++
 8 files changed, 48 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/args.h

diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 7fa611216417..4b081e0d3306 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -2,12 +2,7 @@
 #ifndef _ASM_X86_RMWcc
 #define _ASM_X86_RMWcc
 
-/* This counts to 12. Any more, it will return 13th argument. */
-#define __RMWcc_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
-#define RMWcc_ARGS(X...) __RMWcc_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
-
-#define __RMWcc_CONCAT(a, b) a ## b
-#define RMWcc_CONCAT(a, b) __RMWcc_CONCAT(a, b)
+#include <linux/args.h>
 
 #define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
@@ -48,7 +43,7 @@ cc_label:	c = true;						\
 #define GEN_UNARY_RMWcc_3(op, var, cc)					\
 	GEN_UNARY_RMWcc_4(op, var, cc, "%[var]")
 
-#define GEN_UNARY_RMWcc(X...) RMWcc_CONCAT(GEN_UNARY_RMWcc_, RMWcc_ARGS(X))(X)
+#define GEN_UNARY_RMWcc(X...)	CONCATENATE(GEN_UNARY_RMWcc_, COUNT_ARGS(X))(X)
 
 #define GEN_BINARY_RMWcc_6(op, var, cc, vcon, _val, arg0)		\
 	__GEN_RMWcc(op " %[val], " arg0, var, cc,			\
@@ -57,7 +52,7 @@ cc_label:	c = true;						\
 #define GEN_BINARY_RMWcc_5(op, var, cc, vcon, val)			\
 	GEN_BINARY_RMWcc_6(op, var, cc, vcon, val, "%[var]")
 
-#define GEN_BINARY_RMWcc(X...) RMWcc_CONCAT(GEN_BINARY_RMWcc_, RMWcc_ARGS(X))(X)
+#define GEN_BINARY_RMWcc(X...)	CONCATENATE(GEN_BINARY_RMWcc_, COUNT_ARGS(X))(X)
 
 #define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, cc, clobbers...)	\
 	__GEN_RMWcc(op " %[var]\n\t" suffix, var, cc,			\
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 23120d50499e..107c81431634 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 
+#include <linux/args.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
diff --git a/include/linux/args.h b/include/linux/args.h
new file mode 100644
index 000000000000..8ff60a54eb7d
--- /dev/null
+++ b/include/linux/args.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_ARGS_H
+#define _LINUX_ARGS_H
+
+/*
+ * How do these macros work?
+ *
+ * In __COUNT_ARGS() _0 to _12 are just placeholders from the start
+ * in order to make sure _n is positioned over the correct number
+ * from 12 to 0 (depending on X, which is a variadic argument list).
+ * They serve no purpose other than occupying a position. Since each
+ * macro parameter must have a distinct identifier, those identifiers
+ * are as good as any.
+ *
+ * In COUNT_ARGS() we use actual integers, so __COUNT_ARGS() returns
+ * that as _n.
+ */
+
+/* This counts to 12. Any more, it will return 13th argument. */
+#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
+#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+
+/* Concatenate two parameters, but allow them to be expanded beforehand. */
+#define __CONCAT(a, b) a ## b
+#define CONCATENATE(a, b) __CONCAT(a, b)
+
+#endif	/* _LINUX_ARGS_H */
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f196c19f8e55..2865b14c2bba 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -5,6 +5,7 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
+#include <linux/args.h>
 #include <linux/init.h>
 #include <uapi/linux/const.h>
 
@@ -413,11 +414,6 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 #endif
 
-#define ___count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
-
-#define __count_args(...)						\
-	___count_args(__VA_ARGS__, 7, 6, 5, 4, 3, 2, 1, 0)
-
 #define __constraint_read_0	"r" (arg0)
 #define __constraint_read_1	__constraint_read_0, "r" (arg1)
 #define __constraint_read_2	__constraint_read_1, "r" (arg2)
@@ -475,14 +471,6 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 	__declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);		\
 	register typeof(a7) arg7 asm("r7") = __a7
 
-#define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
-#define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
-
-#define ___constraints(count)						\
-	: __constraint_read_ ## count					\
-	: smccc_sve_clobbers "memory"
-#define __constraints(count)	___constraints(count)
-
 /*
  * We have an output list that is not necessarily used, and GCC feels
  * entitled to optimise the whole sequence away. "volatile" is what
@@ -494,11 +482,13 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 		register unsigned long r1 asm("r1");			\
 		register unsigned long r2 asm("r2");			\
 		register unsigned long r3 asm("r3"); 			\
-		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
+		CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__));	\
 		asm volatile(SMCCC_SVE_CHECK				\
 			     inst "\n" :				\
 			     "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)	\
-			     __constraints(__count_args(__VA_ARGS__)));	\
+			     : CONCATENATE(__constraint_read_,		\
+					   COUNT_ARGS(__VA_ARGS__))	\
+			     : smccc_sve_clobbers "memory");		\
 		if (___res)						\
 			*___res = (typeof(*___res)){r0, r1, r2, r3};	\
 	} while (0)
@@ -542,8 +532,11 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
  */
 #define __fail_smccc_1_1(...)						\
 	do {								\
-		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
-		asm ("" : __constraints(__count_args(__VA_ARGS__)));	\
+		CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__));	\
+		asm ("" :						\
+		     : CONCATENATE(__constraint_read_,			\
+				   COUNT_ARGS(__VA_ARGS__))		\
+		     : smccc_sve_clobbers "memory");			\
 		if (___res)						\
 			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
 	} while (0)
diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index f81d48987528..a419d93789ff 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -14,14 +14,12 @@
 # error "you need to define GENL_MAGIC_INCLUDE_FILE before inclusion"
 #endif
 
+#include <linux/args.h>
 #include <linux/genetlink.h>
 #include <linux/types.h>
 
-#define CONCAT__(a,b)	a ## b
-#define CONCAT_(a,b)	CONCAT__(a,b)
-
-extern int CONCAT_(GENL_MAGIC_FAMILY, _genl_register)(void);
-extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
+extern int CONCATENATE(GENL_MAGIC_FAMILY, _genl_register)(void);
+extern void CONCATENATE(GENL_MAGIC_FAMILY, _genl_unregister)(void);
 
 /*
  * Extension of genl attribute validation policies			{{{2
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0b00e1aef33d..15d9496db169 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -419,13 +419,6 @@ ftrace_vprintk(const char *fmt, va_list ap)
 static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #endif /* CONFIG_TRACING */
 
-/* This counts to 12. Any more, it will return 13th argument. */
-#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
-#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
-
-#define __CONCAT(a, b) a ## b
-#define CONCATENATE(a, b) __CONCAT(a, b)
-
 /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ff7500772e6..eeb2e6f6130f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -23,7 +23,7 @@
 #ifndef LINUX_PCI_H
 #define LINUX_PCI_H
 
-
+#include <linux/args.h>
 #include <linux/mod_devicetable.h>
 
 #include <linux/types.h>
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 1f7fc1fc590c..e609cd7da47e 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -12,6 +12,8 @@
 #undef __perf_task
 #define __perf_task(t)	(t)
 
+#include <linux/args.h>
+
 /* cast any integer, pointer, or small struct to u64 */
 #define UINTTYPE(size) \
 	__typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
-- 
2.40.0.1.gaa8946217a0b

