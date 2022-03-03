Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09BB4CB809
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiCCHoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 02:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCHoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 02:44:37 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6F1637FF;
        Wed,  2 Mar 2022 23:43:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0V66qjBS_1646293420;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V66qjBS_1646293420)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 15:43:46 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        ashimida@linux.alibaba.com, gregkh@linuxfoundation.org,
        linux@roeck-us.net, keescook@chromium.org,
        luc.vanoostenryck@gmail.com, elver@google.com,
        mark.rutland@arm.com, masahiroy@kernel.org, ojeda@kernel.org,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        samitolvanen@google.com, shuah@kernel.org, tglx@linutronix.de,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/2] lkdtm: Add Shadow Call Stack tests
Date:   Wed,  2 Mar 2022 23:43:39 -0800
Message-Id: <20220303074339.86337-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220303073340.86008-1-ashimida@linux.alibaba.com>
References: <20220303073340.86008-1-ashimida@linux.alibaba.com>
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

Add tests for SCS (Shadow Call Stack) based
backward CFI (as implemented by Clang and GCC).

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/core.c               |  2 +
 drivers/misc/lkdtm/lkdtm.h              |  4 ++
 drivers/misc/lkdtm/scs.c                | 67 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 5 files changed, 76 insertions(+)
 create mode 100644 drivers/misc/lkdtm/scs.c

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 2e0aa74ac185..e2fb17868af2 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -10,6 +10,7 @@ lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
 lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
 lkdtm-$(CONFIG_LKDTM)		+= cfi.o
+lkdtm-$(CONFIG_LKDTM)		+= scs.o
 lkdtm-$(CONFIG_LKDTM)		+= fortify.o
 lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index f69b964b9952..d0ce0bec117c 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -178,6 +178,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_KERNEL),
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(CFI_BACKWARD_SHADOW),
+	CRASHTYPE(CFI_BACKWARD_SHADOW_WITH_NOSCS),
 	CRASHTYPE(FORTIFIED_OBJECT),
 	CRASHTYPE(FORTIFIED_SUBOBJECT),
 	CRASHTYPE(FORTIFIED_STRSCPY),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index d6137c70ebbe..a23d32dfc10b 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -158,6 +158,10 @@ void lkdtm_STACKLEAK_ERASING(void);
 /* cfi.c */
 void lkdtm_CFI_FORWARD_PROTO(void);
 
+/* scs.c */
+void lkdtm_CFI_BACKWARD_SHADOW(void);
+void lkdtm_CFI_BACKWARD_SHADOW_WITH_NOSCS(void);
+
 /* fortify.c */
 void lkdtm_FORTIFIED_OBJECT(void);
 void lkdtm_FORTIFIED_SUBOBJECT(void);
diff --git a/drivers/misc/lkdtm/scs.c b/drivers/misc/lkdtm/scs.c
new file mode 100644
index 000000000000..5922a55a8844
--- /dev/null
+++ b/drivers/misc/lkdtm/scs.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This is for all the tests relating directly to Shadow Call Stack.
+ */
+#include "lkdtm.h"
+
+#ifdef CONFIG_ARM64
+/* Function clears its return address. */
+static noinline void lkdtm_scs_clear_lr(void)
+{
+	unsigned long *lr = (unsigned long *)__builtin_frame_address(0) + 1;
+
+	asm volatile("str xzr, [%0]\n\t" : : "r"(lr) : "x30");
+}
+
+/* Function with __noscs attribute clears its return address. */
+static noinline void __noscs lkdtm_noscs_clear_lr(void)
+{
+	unsigned long *lr = (unsigned long *)__builtin_frame_address(0) + 1;
+
+	asm volatile("str xzr, [%0]\n\t" : : "r"(lr) : "x30");
+}
+#endif
+
+/*
+ * This tries to call a function protected by Shadow Call Stack,
+ * which corrupts its own return address during execution.
+ * Due to the protection, the corruption will not take effect
+ * when the function returns.
+ */
+void lkdtm_CFI_BACKWARD_SHADOW(void)
+{
+#ifdef CONFIG_ARM64
+	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
+		pr_err("FAIL: kernel not built with CONFIG_SHADOW_CALL_STACK\n");
+		return;
+	}
+
+	pr_info("Trying to corrupt lr in a function with scs protection ...\n");
+	lkdtm_scs_clear_lr();
+
+	pr_err("ok: scs takes effect.\n");
+#else
+	pr_err("XFAIL: this test is arm64-only\n");
+#endif
+}
+
+/*
+ * This tries to call a function not protected by Shadow Call Stack,
+ * which corrupts its own return address during execution.
+ */
+void lkdtm_CFI_BACKWARD_SHADOW_WITH_NOSCS(void)
+{
+#ifdef CONFIG_ARM64
+	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
+		pr_err("FAIL: kernel not built with CONFIG_SHADOW_CALL_STACK\n");
+		return;
+	}
+
+	pr_info("Trying to corrupt lr in a function with attribute __noscs ...\n");
+	lkdtm_noscs_clear_lr();
+
+	pr_err("FAIL: __noscs attribute does not take effect!\n");
+#else
+	pr_err("XFAIL: this test is arm64-only\n");
+#endif
+}
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 6b36b7f5dcf9..c849765c8dcc 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -73,6 +73,8 @@ USERCOPY_STACK_BEYOND
 USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
+CFI_BACKWARD_SHADOW ok: scs takes effect
+CFI_BACKWARD_SHADOW_WITH_NOSCS
 FORTIFIED_STRSCPY
 FORTIFIED_OBJECT
 FORTIFIED_SUBOBJECT
-- 
2.17.1

