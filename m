Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6690075869A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGRVL4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjGRVLx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:11:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7122C0;
        Tue, 18 Jul 2023 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714712; x=1721250712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6YP9TxD6vGbHE6fwGQXgx3yzQNMpeHCGRM/JjRREbQ=;
  b=UdkMCd7y3tNZhLv7jh27jr52I/CGQM+ldsNmlu/q79i/9sv0TMyZAsqB
   o/PNpaoujr+ifwsMbo8AQWPwTq6netWF89YEJ1MpEB7FQlCsMPu8S1Em5
   BkPvh9+eLn2cFiTyzDb2O8ghnBTmeYhR5dcP2JFqWABM12ProPkf74j4m
   +Zghajdwv57+o8JFoz5gKroYdy9Xeq33l31sEla6kJgSP3I0T/etAAn/1
   NaNscLJ7vwmlP29iyOx3bFG73YkOwh0u2QDLSHWJKkHsTnZgLtfWWmWOP
   uD/7nn+A+Knae6BQ1C0eOF4YZu0fZElxOg5CYpKLLG9tDsqQSvF6AEbl9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432495824"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="432495824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753469038"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="753469038"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 14:11:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CEA58370; Wed, 19 Jul 2023 00:11:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 3/4] arm64: smccc: Replace custom COUNT_ARGS() & CONCATENATE() implementations
Date:   Wed, 19 Jul 2023 00:11:46 +0300
Message-Id: <20230718211147.18647-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com>
References: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace custom implementation of the macros from args.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/arm-smccc.h | 69 ++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f196c19f8e55..7c67c17321d4 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -5,6 +5,7 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
+#include <linux/args.h>
 #include <linux/init.h>
 #include <uapi/linux/const.h>
 
@@ -413,31 +414,26 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 #endif
 
-#define ___count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
+#define __constraint_read_2	"r" (arg0)
+#define __constraint_read_3	__constraint_read_2, "r" (arg1)
+#define __constraint_read_4	__constraint_read_3, "r" (arg2)
+#define __constraint_read_5	__constraint_read_4, "r" (arg3)
+#define __constraint_read_6	__constraint_read_5, "r" (arg4)
+#define __constraint_read_7	__constraint_read_6, "r" (arg5)
+#define __constraint_read_8	__constraint_read_7, "r" (arg6)
+#define __constraint_read_9	__constraint_read_8, "r" (arg7)
 
-#define __count_args(...)						\
-	___count_args(__VA_ARGS__, 7, 6, 5, 4, 3, 2, 1, 0)
-
-#define __constraint_read_0	"r" (arg0)
-#define __constraint_read_1	__constraint_read_0, "r" (arg1)
-#define __constraint_read_2	__constraint_read_1, "r" (arg2)
-#define __constraint_read_3	__constraint_read_2, "r" (arg3)
-#define __constraint_read_4	__constraint_read_3, "r" (arg4)
-#define __constraint_read_5	__constraint_read_4, "r" (arg5)
-#define __constraint_read_6	__constraint_read_5, "r" (arg6)
-#define __constraint_read_7	__constraint_read_6, "r" (arg7)
-
-#define __declare_arg_0(a0, res)					\
+#define __declare_arg_2(a0, res)					\
 	struct arm_smccc_res   *___res = res;				\
 	register unsigned long arg0 asm("r0") = (u32)a0
 
-#define __declare_arg_1(a0, a1, res)					\
+#define __declare_arg_3(a0, a1, res)					\
 	typeof(a1) __a1 = a1;						\
 	struct arm_smccc_res   *___res = res;				\
 	register unsigned long arg0 asm("r0") = (u32)a0;			\
 	register typeof(a1) arg1 asm("r1") = __a1
 
-#define __declare_arg_2(a0, a1, a2, res)				\
+#define __declare_arg_4(a0, a1, a2, res)				\
 	typeof(a1) __a1 = a1;						\
 	typeof(a2) __a2 = a2;						\
 	struct arm_smccc_res   *___res = res;				\
@@ -445,7 +441,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 	register typeof(a1) arg1 asm("r1") = __a1;			\
 	register typeof(a2) arg2 asm("r2") = __a2
 
-#define __declare_arg_3(a0, a1, a2, a3, res)				\
+#define __declare_arg_5(a0, a1, a2, a3, res)				\
 	typeof(a1) __a1 = a1;						\
 	typeof(a2) __a2 = a2;						\
 	typeof(a3) __a3 = a3;						\
@@ -455,34 +451,26 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 	register typeof(a2) arg2 asm("r2") = __a2;			\
 	register typeof(a3) arg3 asm("r3") = __a3
 
-#define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
+#define __declare_arg_6(a0, a1, a2, a3, a4, res)			\
 	typeof(a4) __a4 = a4;						\
-	__declare_arg_3(a0, a1, a2, a3, res);				\
+	__declare_arg_5(a0, a1, a2, a3, res);				\
 	register typeof(a4) arg4 asm("r4") = __a4
 
-#define __declare_arg_5(a0, a1, a2, a3, a4, a5, res)			\
+#define __declare_arg_7(a0, a1, a2, a3, a4, a5, res)			\
 	typeof(a5) __a5 = a5;						\
-	__declare_arg_4(a0, a1, a2, a3, a4, res);			\
+	__declare_arg_6(a0, a1, a2, a3, a4, res);			\
 	register typeof(a5) arg5 asm("r5") = __a5
 
-#define __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res)		\
+#define __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res)		\
 	typeof(a6) __a6 = a6;						\
-	__declare_arg_5(a0, a1, a2, a3, a4, a5, res);			\
+	__declare_arg_7(a0, a1, a2, a3, a4, a5, res);			\
 	register typeof(a6) arg6 asm("r6") = __a6
 
-#define __declare_arg_7(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
+#define __declare_arg_9(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
 	typeof(a7) __a7 = a7;						\
-	__declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);		\
+	__declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);		\
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
@@ -494,11 +482,14 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 		register unsigned long r1 asm("r1");			\
 		register unsigned long r2 asm("r2");			\
 		register unsigned long r3 asm("r3"); 			\
-		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
+		CONCATENATE(__declare_arg_,				\
+			    COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__);	\
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
@@ -542,8 +533,12 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
  */
 #define __fail_smccc_1_1(...)						\
 	do {								\
-		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
-		asm ("" : __constraints(__count_args(__VA_ARGS__)));	\
+		CONCATENATE(__declare_arg_,				\
+			    COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__);	\
+		asm ("" :						\
+		     : CONCATENATE(__constraint_read_,			\
+				   COUNT_ARGS(__VA_ARGS__))		\
+		     : smccc_sve_clobbers "memory");			\
 		if (___res)						\
 			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
 	} while (0)
-- 
2.40.0.1.gaa8946217a0b

