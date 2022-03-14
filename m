Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAF4D863F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Mar 2022 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiCNNzR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Mar 2022 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiCNNzQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Mar 2022 09:55:16 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA634665D;
        Mon, 14 Mar 2022 06:54:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V7AmGzm_1647266032;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V7AmGzm_1647266032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 21:53:59 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, shuah@kernel.org,
        ashimida@linux.alibaba.com, mark.rutland@arm.com, ojeda@kernel.org,
        akpm@linux-foundation.org, elver@google.com,
        luc.vanoostenryck@gmail.com, samitolvanen@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/2] lkdtm: Add Shadow Call Stack tests
Date:   Mon, 14 Mar 2022 06:53:29 -0700
Message-Id: <20220314135329.80621-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220303074339.86337-1-ashimida@linux.alibaba.com>
References: <20220303074339.86337-1-ashimida@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for SCS (Shadow Call Stack) based backward CFI.

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 arch/arm64/include/asm/compiler.h       | 18 ++++++
 drivers/misc/lkdtm/cfi.c                | 84 +++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c               |  1 +
 drivers/misc/lkdtm/lkdtm.h              |  1 +
 include/linux/compiler-clang.h          |  1 +
 include/linux/compiler-gcc.h            |  2 +
 include/linux/compiler_types.h          |  4 ++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 8 files changed, 112 insertions(+)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index dc3ea4080e2e..96590fb4a8de 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -8,6 +8,24 @@
 #define ARM64_ASM_PREAMBLE
 #endif
 
+#ifndef __ASSEMBLY__
+#ifdef __KERNEL__
+
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+
+#ifdef CONFIG_ARM64_BTI_KERNEL
+# define __no_ptrauth __attribute__((target("branch-protection=bti")))
+#elif defined(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET)
+# define __no_ptrauth __attribute__((target("branch-protection=none")))
+#elif defined(CONFIG_CC_HAS_SIGN_RETURN_ADDRESS)
+# define __no_ptrauth __attribute__((target("sign-return-address=none")))
+#endif
+
+#endif /* CONFIG_ARM64_PTR_AUTH_KERNEL */
+
+#endif /* __KERNEL__ */
+#endif /* __ASSEMBLY__ */
+
 /*
  * The EL0/EL1 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index c9aeddef1044..468ba2f26f74 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -41,3 +41,87 @@ void lkdtm_CFI_FORWARD_PROTO(void)
 	pr_err("FAIL: survived mismatched prototype function call!\n");
 	pr_expected_config(CONFIG_CFI_CLANG);
 }
+
+#ifdef CONFIG_ARM64
+/*
+ * This function is used to modify its return address. The PAC needs to be turned
+ * off here to ensure that the modification of the return address will not be blocked.
+ */
+static noinline __no_ptrauth
+void lkdtm_scs_set_lr(unsigned long *expected, unsigned long *addr)
+{
+	/* Use of volatile is to make sure final write isn't seen as a dead store. */
+	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+
+	/* Make sure we've found the right place on the stack before writing it. */
+	if (*ret_addr == expected)
+		*ret_addr = addr;
+}
+
+/* Function with __noscs attribute attempts to modify its return address. */
+static noinline __no_ptrauth __noscs
+void lkdtm_noscs_set_lr(unsigned long *expected, unsigned long *addr)
+{
+	/* Use of volatile is to make sure final write isn't seen as a dead store. */
+	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+
+	/* Make sure we've found the right place on the stack before writing it. */
+	if (*ret_addr == expected)
+		*ret_addr = addr;
+}
+#else
+static inline void lkdtm_noscs_set_lr(unsigned long *expected, unsigned long *addr) { }
+static inline void lkdtm_scs_set_lr(unsigned long *expected, unsigned long *addr) { }
+#endif
+
+static volatile unsigned int force_label;
+
+/*
+ * This first checks whether a function with the __noscs attribute under
+ * the current platform can directly modify its return address, and if so,
+ * checks whether scs takes effect.
+ */
+void __no_optimize lkdtm_CFI_BACKWARD_SHADOW(void)
+{
+	void *array[] = {&&unexpected, &&expected, &&good_scs, &&bad_scs};
+
+	if (force_label && (force_label < sizeof(array))) {
+		/*
+		 * Call them with "NULL" first to avoid
+		 * arguments being treated as constants in -02.
+		 */
+		lkdtm_noscs_set_lr(NULL, NULL);
+		lkdtm_scs_set_lr(NULL, NULL);
+		goto *array[force_label];
+	}
+
+	/* Keep labels in scope to avoid compiler warnings. */
+	do {
+		/* Verify the "normal" condition of LR corruption working. */
+		pr_info("Trying to corrupt lr in a function without scs protection ...\n");
+		lkdtm_noscs_set_lr(&&unexpected, &&expected);
+
+unexpected:
+		/*
+		 * If lr cannot be modified, the following check is meaningless,
+		 * returns directly.
+		 */
+		pr_err("XPASS: Unexpectedly survived lr corruption without scs?!\n");
+		break;
+
+expected:
+		pr_info("ok: lr corruption redirected without scs.\n");
+
+		/* Verify that SCS is in effect. */
+		pr_info("Trying to corrupt lr in a function with scs protection ...\n");
+		lkdtm_scs_set_lr(&&good_scs, &&bad_scs);
+
+good_scs:
+		pr_info("ok: scs takes effect.\n");
+		break;
+
+bad_scs:
+		pr_err("FAIL: return address rewritten!\n");
+		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
+	} while (0);
+}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index f69b964b9952..7af7268b82e4 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -178,6 +178,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_KERNEL),
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(CFI_BACKWARD_SHADOW),
 	CRASHTYPE(FORTIFIED_OBJECT),
 	CRASHTYPE(FORTIFIED_SUBOBJECT),
 	CRASHTYPE(FORTIFIED_STRSCPY),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index d6137c70ebbe..a66fba949ab5 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -157,6 +157,7 @@ void lkdtm_STACKLEAK_ERASING(void);
 
 /* cfi.c */
 void lkdtm_CFI_FORWARD_PROTO(void);
+void lkdtm_CFI_BACKWARD_SHADOW(void);
 
 /* fortify.c */
 void lkdtm_FORTIFIED_OBJECT(void);
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 3c4de9b6c6e3..2db37db36651 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -68,3 +68,4 @@
 
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
 #define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
+#define __no_optimize	__attribute__((optnone))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index deff5b308470..28d1b0ec6656 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -162,3 +162,5 @@
 #if GCC_VERSION < 90100
 #undef __alloc_size__
 #endif
+
+#define __no_optimize	__attribute__((optimize("-O0")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3c1795fdb568..f5ad83f7ea2f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -257,6 +257,10 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
+#ifndef __no_ptrauth
+# define __no_ptrauth
+#endif
+
 #ifndef __cficanonical
 # define __cficanonical
 #endif
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 6b36b7f5dcf9..12df67a3b419 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -73,6 +73,7 @@ USERCOPY_STACK_BEYOND
 USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
+CFI_BACKWARD_SHADOW ok: scs takes effect
 FORTIFIED_STRSCPY
 FORTIFIED_OBJECT
 FORTIFIED_SUBOBJECT
-- 
2.17.1

