Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9654CB805
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 08:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiCCHoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 02:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCHoZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 02:44:25 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3257154D01;
        Wed,  2 Mar 2022 23:43:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0V66atZ3_1646293404;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V66atZ3_1646293404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 15:43:33 +0800
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
Subject: [PATCH v3 1/2] AARCH64: Add gcc Shadow Call Stack support
Date:   Wed,  2 Mar 2022 23:43:23 -0800
Message-Id: <20220303074323.86282-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220303073340.86008-1-ashimida@linux.alibaba.com>
References: <20220303073340.86008-1-ashimida@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shadow call stacks will be available in GCC >= 12, this patch makes
the corresponding kernel configuration available when compiling
the kernel with the gcc.

Note that the implementation in GCC is slightly different from Clang.
With SCS enabled, functions will only pop x30 once in the epilogue,
like:

   str     x30, [x18], #8
   stp     x29, x30, [sp, #-16]!
   ......
-  ldp     x29, x30, [sp], #16	  //clang
+  ldr     x29, [sp], #16	  //GCC
   ldr     x30, [x18, #-8]!

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ce09ab17ddd21f73ff2caf6eec3b0ee9b0e1a11e

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 arch/Kconfig                 | 19 ++++++++++---------
 arch/arm64/Kconfig           |  2 +-
 include/linux/compiler-gcc.h |  4 ++++
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..cbbe824fe8b2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -599,21 +599,22 @@ config STACKPROTECTOR_STRONG
 config ARCH_SUPPORTS_SHADOW_CALL_STACK
 	bool
 	help
-	  An architecture should select this if it supports Clang's Shadow
-	  Call Stack and implements runtime support for shadow stack
+	  An architecture should select this if it supports the compiler's
+	  Shadow Call Stack and implements runtime support for shadow stack
 	  switching.
 
 config SHADOW_CALL_STACK
-	bool "Clang Shadow Call Stack"
-	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
+	bool "Shadow Call Stack"
+	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	help
-	  This option enables Clang's Shadow Call Stack, which uses a
-	  shadow stack to protect function return addresses from being
-	  overwritten by an attacker. More information can be found in
-	  Clang's documentation:
+	  This option enables the compiler's Shadow Call Stack, which
+	  uses a shadow stack to protect function return addresses from
+	  being overwritten by an attacker. More information can be found
+	  in the compiler's documentation:
 
-	    https://clang.llvm.org/docs/ShadowCallStack.html
+	  - Clang: https://clang.llvm.org/docs/ShadowCallStack.html
+	  - GCC: https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options
 
 	  Note that security guarantees in the kernel differ from the
 	  ones documented for user space. The kernel must store addresses
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 09b885cc4db5..b7145337efae 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1255,7 +1255,7 @@ config HW_PERF_EVENTS
 config ARCH_HAS_FILTER_PGPROT
 	def_bool y
 
-# Supported by clang >= 7.0
+# Supported by clang >= 7.0 or GCC >= 12.0.0
 config CC_HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
 
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index ccbbd31b3aae..deff5b308470 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -97,6 +97,10 @@
 #define KASAN_ABI_VERSION 4
 #endif
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
+#endif
+
 #if __has_attribute(__no_sanitize_address__)
 #define __no_sanitize_address __attribute__((no_sanitize_address))
 #else
-- 
2.17.1

