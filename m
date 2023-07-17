Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531AC756361
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGQMz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 08:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGQMz1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 08:55:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01736E47;
        Mon, 17 Jul 2023 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689598527; x=1721134527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFjSGVzAb16V95A9zQhmH/l3kdP7s0g4O6C6hLY90VQ=;
  b=PeIVtbi5B63FMyemJI+BPCTjLzEHfhfsgf7c22qIQO5Ji5vYGS7+41RP
   BXud/9DHpujTHk1E/eTqDrv8qIk1kWu3lGhvZ3DxBOE7i0Oyazpiv0zsR
   /o6nQ5y5bx9m8P4eZI0igHXLafmqwyrkOh7CbTSkc+yfMUsO9ypqnUKdM
   QM0I54YPwY9xbb0hcdr6GL8dOMQ915d3QtgNhmDaGB9Ux4FtBVvH2yZlt
   h8s9ZVHyfXaiHQ9BpKNF0HJt1iuEDuvo4gqMmgmJNuK9D8lNmOlm3g49H
   zPg2jfMQL9f2e9XSYVxqgOQ3CPHFUf9Fl3ZkClOOK5vpU9Zy7RQJxheJb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429680689"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429680689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793234538"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793234538"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 05:55:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E84D5516; Mon, 17 Jul 2023 15:55:23 +0300 (EEST)
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
Subject: [PATCH v3 3/4] arm64: smccc: Replace custom COUNT_ARGS() & CONCATENATE() implementations
Date:   Mon, 17 Jul 2023 15:55:20 +0300
Message-Id: <20230717125521.43176-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
References: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace custom implementation of the macros from args.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/arm-smccc.h | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

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
-- 
2.40.0.1.gaa8946217a0b

