Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C506D3C99
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 06:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDCEzn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 00:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDCEzm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 00:55:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6861F903C;
        Sun,  2 Apr 2023 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680497740; x=1712033740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=euXEsNEkSUOAUq8daq1ZcEClIpm9HdmCSEM+8SwkCu8=;
  b=H1HMnAxFJ+cl1hGQu4oJmig6Lwh+ypyI+D1/9yuU6P2GSLT3UhKutJt2
   U+Gsfj3kee/62sf/Y0w1cqzU6l82UY2DtckAOBnZYE0xcdLwlo92X+/uS
   ltgIEuxWJA5TwDHfTARGqLOXKKM1xlt28DrRQUmoNTmN4dg4VPVnZPnIS
   HO4LNDGHYW5fNIuFYUBcR3pJ8JrSzdMcCthfE6F4K02PO1Yo+EcF3TofL
   2MOA8Tko9D4MZlbby8K2QR3E3iDk/FLIm9/ZGf2aPLnOqfYmw9KkOuzkw
   W8rlIlj8thx/LgsMkfmOoL6sS/Z15GE3dxvadF0Tk5lKtgZTuUsewGtT2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="344362558"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="344362558"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="829421527"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="829421527"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2023 21:55:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, luto@kernel.org, dave.hansen@intel.com,
        tglx@linutronix.de, bp@suse.de, jun.miao@windriver.com,
        chang.seok.bae@intel.com, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v1 4/4] selftests/x86: Refactor altstack setup code
Date:   Sun,  2 Apr 2023 21:43:40 -0700
Message-Id: <20230403044340.1312-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403044340.1312-1-chang.seok.bae@intel.com>
References: <20230403044340.1312-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sigaltstack setup code is almost the same across x86 tests. Most
of the test probably just needs a ready-to-use altstack instead of all
the setup code.

Refactor them to these helpers to simplify the test code:

- setup_sigaltstack()

  Allocate an altstack memory with a size more than the
  kernel-provided minimum. Then register the altstack via
  sigaltstack(2).

- cleanup_sigaltstack()

  Unregister the altstack and free up the memory.

Then, these two function calls are supposed to be enough for most
sigaltstack-needed test cases. But, when explicit sigaltstack() is
needed, another helper is available:

- init_sigaltstack()

  Do the same as setup_sigaltstack(), except for not invoking the
  sigaltstack syscall.

Finally, while here, ensure an altstack cleanup everywhere an altstack
is used.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
The patch is based on another series that fixes the sigaltstack test:
  https://lore.kernel.org/all/20230330233520.21937-2-chang.seok.bae@intel.com/

Considerably that fix should go first before this cleanup rework.
---
 tools/testing/selftests/x86/amx.c             | 42 ++++------
 tools/testing/selftests/x86/helpers.c         | 80 +++++++++++++++++++
 tools/testing/selftests/x86/helpers.h         |  4 +
 tools/testing/selftests/x86/mov_ss_trap.c     | 11 +--
 tools/testing/selftests/x86/sigaltstack.c     | 40 ++++------
 tools/testing/selftests/x86/sigreturn.c       | 10 +--
 .../selftests/x86/single_step_syscall.c       | 12 +--
 .../testing/selftests/x86/syscall_arg_fault.c | 11 +--
 8 files changed, 130 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 1e8e60b1f7b9..70e1d64e9c57 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -362,29 +362,11 @@ static void validate_xcomp_perm(enum expected_result exp)
 #  define AT_MINSIGSTKSZ	51
 #endif
 
-static void *alloc_altstack(unsigned int size)
+static void setup_altstack(stack_t *stack, enum expected_result exp)
 {
-	void *altstack;
-
-	altstack = mmap(NULL, size, PROT_READ | PROT_WRITE,
-			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
-
-	if (altstack == MAP_FAILED)
-		fatal_error("mmap() for altstack");
-
-	return altstack;
-}
-
-static void setup_altstack(void *addr, unsigned long size, enum expected_result exp)
-{
-	stack_t ss;
 	int rc;
 
-	memset(&ss, 0, sizeof(ss));
-	ss.ss_size = size;
-	ss.ss_sp = addr;
-
-	rc = sigaltstack(&ss, NULL);
+	rc = sigaltstack(stack, NULL);
 
 	if (exp == FAIL_EXPECTED) {
 		if (rc) {
@@ -401,7 +383,7 @@ static void test_dynamic_sigaltstack(void)
 {
 	unsigned int small_size, enough_size;
 	unsigned long minsigstksz;
-	void *altstack;
+	stack_t stack = { };
 
 	minsigstksz = getauxval(AT_MINSIGSTKSZ);
 	printf("\tAT_MINSIGSTKSZ = %lu\n", minsigstksz);
@@ -416,9 +398,9 @@ static void test_dynamic_sigaltstack(void)
 		return;
 	}
 
-	enough_size = minsigstksz * 2;
-
-	altstack = alloc_altstack(enough_size);
+	if (init_sigaltstack(&stack) != 0)
+		fatal_error("sigaltstack allocation failed.");
+	enough_size = stack.ss_size;
 	printf("\tAllocate memory for altstack (%u bytes).\n", enough_size);
 
 	/*
@@ -427,7 +409,8 @@ static void test_dynamic_sigaltstack(void)
 	 */
 	small_size = minsigstksz - xtiledata.size;
 	printf("\tAfter sigaltstack() with small size (%u bytes).\n", small_size);
-	setup_altstack(altstack, small_size, SUCCESS_EXPECTED);
+	stack.ss_size = small_size;
+	setup_altstack(&stack, SUCCESS_EXPECTED);
 	validate_req_xcomp_perm(FAIL_EXPECTED);
 
 	/*
@@ -436,7 +419,8 @@ static void test_dynamic_sigaltstack(void)
 	 * and thus ARCH_REQ_XCOMP_PERM should succeed.
 	 */
 	printf("\tAfter sigaltstack() with enough size (%u bytes).\n", enough_size);
-	setup_altstack(altstack, enough_size, SUCCESS_EXPECTED);
+	stack.ss_size = enough_size;
+	setup_altstack(&stack, SUCCESS_EXPECTED);
 	validate_req_xcomp_perm(SUCCESS_EXPECTED);
 
 	/*
@@ -446,7 +430,11 @@ static void test_dynamic_sigaltstack(void)
 	 * once XTILEDATA permission is established.
 	 */
 	printf("\tThen, sigaltstack() with small size (%u bytes).\n", small_size);
-	setup_altstack(altstack, small_size, FAIL_EXPECTED);
+	stack.ss_size = small_size;
+	setup_altstack(&stack, FAIL_EXPECTED);
+
+	stack.ss_size = enough_size;
+	cleanup_sigaltstack(&stack);
 }
 
 static void test_dynamic_state(void)
diff --git a/tools/testing/selftests/x86/helpers.c b/tools/testing/selftests/x86/helpers.c
index a6ecc42d359f..1f5b1e5a3d66 100644
--- a/tools/testing/selftests/x86/helpers.c
+++ b/tools/testing/selftests/x86/helpers.c
@@ -3,6 +3,15 @@
 #include <string.h>
 #include <err.h>
 
+#include <sys/auxv.h>
+#include <sys/mman.h>
+
+#include "helpers.h"
+
+#ifndef AT_MINSIGSTKSZ
+#  define AT_MINSIGSTKSZ	51
+#endif
+
 #include "helpers.h"
 
 void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
@@ -28,3 +37,74 @@ void clearhandler(int sig)
 	if (sigaction(sig, &sa, 0))
 		err(1, "sigaction");
 }
+
+#define ALTSTKSZ	8096
+
+static unsigned long get_sigaltstacksz(void)
+{
+	return getauxval(AT_MINSIGSTKSZ) + ALTSTKSZ;
+}
+
+/**
+ * init_sigalstack -- allocate an altstack without registration
+ * @stack:	stack_t pointer
+ * Returns:	0 if successful; otherwise, nonzero
+ *
+ * Unless testing with different sizes, setup_sigaltstack() should be
+ * enough to provide a ready-to-use stack
+ */
+int init_sigaltstack(stack_t *stack)
+{
+	if (!stack)
+		return -1;
+
+	if (stack->ss_size > 0 && stack->ss_sp > 0)
+		return 0;
+
+	stack->ss_size = get_sigaltstacksz();
+
+	stack->ss_sp = mmap(NULL, stack->ss_size, PROT_READ | PROT_WRITE,
+			    MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (stack->ss_sp == MAP_FAILED)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * setup_sigaltstack -- allocate and register an altstack
+ * @stack:	stack_t pointer
+ * Returns:	0 if successful; otherwise, nonzero
+ */
+int setup_sigaltstack(stack_t *stack)
+{
+	int rc;
+
+	rc = init_sigaltstack(stack);
+	if (rc)
+		return -1;
+
+	return sigaltstack(stack, NULL);
+}
+
+/**
+ * cleanup_sigaltstack -- unregister and free an altstack
+ * @stack:	stack_t pointer
+ * Returns:	None
+ */
+void cleanup_sigaltstack(stack_t *stack)
+{
+	size_t size;
+	void *sp;
+
+	if (!stack)
+		return;
+
+	size = stack->ss_size;
+	sp = stack->ss_sp;
+
+	stack->ss_flags = SS_DISABLE;
+	sigaltstack(stack, NULL);
+
+	munmap(sp, size);
+}
diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
index 35ff4df35397..a47ba1a2d929 100644
--- a/tools/testing/selftests/x86/helpers.h
+++ b/tools/testing/selftests/x86/helpers.h
@@ -5,6 +5,10 @@
 #include <signal.h>
 #include <asm/processor-flags.h>
 
+int init_sigaltstack(stack_t *stack);
+int setup_sigaltstack(stack_t *stack);
+void cleanup_sigaltstack(stack_t *stack);
+
 void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		int flags);
 
diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index cfec7a3e30b7..c9ffc8b3a214 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -133,13 +133,8 @@ int main()
 	stack_t stack = { };
 	unsigned long nr;
 
-	stack.ss_size = SIGSTKSZ;
-	stack.ss_sp = malloc(sizeof(char) * SIGSTKSZ);
-	if (!stack.ss_sp)
-		err(1, "malloc()");
-
-	if (sigaltstack(&stack, NULL) != 0)
-		err(1, "sigaltstack()");
+	if (setup_sigaltstack(&stack) != 0)
+		err(1, "sigaltstack");
 
 	asm volatile ("mov %%ss, %[ss]" : [ss] "=m" (ss));
 	printf("\tSS = 0x%hx, &SS = 0x%p\n", ss, &ss);
@@ -271,7 +266,7 @@ int main()
 			);
 	}
 
-	free(stack.ss_sp);
+	cleanup_sigaltstack(&stack);
 	printf("[OK]\tI aten't dead\n");
 	return 0;
 }
diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
index 7c2bd27908d5..6f753406ca91 100644
--- a/tools/testing/selftests/x86/sigaltstack.c
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -28,17 +28,6 @@ static bool sigalrm_expected;
 
 static unsigned long at_minstack_size;
 
-static int setup_altstack(void *start, unsigned long size)
-{
-	stack_t ss;
-
-	memset(&ss, 0, sizeof(ss));
-	ss.ss_size = size;
-	ss.ss_sp = start;
-
-	return sigaltstack(&ss, NULL);
-}
-
 static jmp_buf jmpbuf;
 
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
@@ -63,14 +52,14 @@ static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
 	}
 }
 
-static void test_sigaltstack(void *altstack, unsigned long size)
+static void test_sigaltstack(stack_t *stack)
 {
-	if (setup_altstack(altstack, size)) {
+	if (sigaltstack(stack, NULL)) {
 		/*
 		 * The kernel may return ENOMEM when the altstack size
 		 * is insufficient. Skip the test in this case.
 		 */
-		if (errno == ENOMEM && size < at_minstack_size) {
+		if (errno == ENOMEM && stack->ss_size < at_minstack_size) {
 			printf("[SKIP]\tThe running kernel disallows an insufficient size.\n");
 			return;
 		}
@@ -78,7 +67,7 @@ static void test_sigaltstack(void *altstack, unsigned long size)
 		err(1, "sigaltstack()");
 	}
 
-	sigalrm_expected = (size > at_minstack_size) ? true : false;
+	sigalrm_expected = (stack->ss_size > at_minstack_size) ? true : false;
 
 	sethandler(SIGSEGV, sigsegv, 0);
 	sethandler(SIGALRM, sigalrm, SA_ONSTACK);
@@ -97,19 +86,24 @@ static void test_sigaltstack(void *altstack, unsigned long size)
 
 int main(void)
 {
-	void *altstack;
+	unsigned long enough_size;
+	stack_t stack = { };
 
 	at_minstack_size = getauxval(AT_MINSIGSTKSZ);
 
-	altstack = mmap(NULL, at_minstack_size + SIGSTKSZ, PROT_READ | PROT_WRITE,
-			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
-	if (altstack == MAP_FAILED)
-		err(1, "mmap()");
+	if (init_sigaltstack(&stack) != 0)
+		err(1, "sigaltstack allocation failed.");
+	enough_size = stack.ss_size;
+
+	if ((ENFORCED_MINSIGSTKSZ + 1) < at_minstack_size) {
+		stack.ss_size = ENFORCED_MINSIGSTKSZ + 1;
+		test_sigaltstack(&stack);
+	}
 
-	if ((ENFORCED_MINSIGSTKSZ + 1) < at_minstack_size)
-		test_sigaltstack(altstack, ENFORCED_MINSIGSTKSZ + 1);
+	stack.ss_size = enough_size;
+	test_sigaltstack(&stack);
 
-	test_sigaltstack(altstack, at_minstack_size + SIGSTKSZ);
+	cleanup_sigaltstack(&stack);
 
 	return nerrs == 0 ? 0 : 1;
 }
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index b2282ca57e23..f9e06a13ad82 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -741,17 +741,13 @@ int main()
 {
 	int total_nerrs = 0;
 	unsigned short my_cs, my_ss;
+	stack_t stack = { };
 
 	asm volatile ("mov %%cs,%0" : "=r" (my_cs));
 	asm volatile ("mov %%ss,%0" : "=r" (my_ss));
 	setup_ldt();
 
-	stack_t stack = {
-		/* Our sigaltstack scratch space. */
-		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
-		.ss_size = SIGSTKSZ,
-	};
-	if (sigaltstack(&stack, NULL) != 0)
+	if (setup_sigaltstack(&stack) != 0)
 		err(1, "sigaltstack");
 
 	sethandler(SIGUSR1, sigusr1, 0);
@@ -849,6 +845,6 @@ int main()
 	total_nerrs += test_nonstrict_ss();
 #endif
 
-	free(stack.ss_sp);
+	cleanup_sigaltstack(&stack);
 	return total_nerrs ? 1 : 0;
 }
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 4c9b8fd7a41a..4e3224e52e30 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -126,13 +126,8 @@ int main()
 	int tmp;
 #endif
 
-	stack.ss_size = SIGSTKSZ;
-	stack.ss_sp = malloc(sizeof(char) * SIGSTKSZ);
-	if (!stack.ss_sp)
-		err(1, "malloc()");
-
-	if (sigaltstack(&stack, NULL) != 0)
-		err(1, "sigaltstack()");
+	if (setup_sigaltstack(&stack) != 0)
+		err(1, "sigaltstack");
 
 	sethandler(SIGTRAP, sigtrap, 0);
 
@@ -193,6 +188,7 @@ int main()
 	 */
 	if (sigsetjmp(jmpbuf, 1) == 0) {
 		unsigned long nr = SYS_getpid;
+
 		printf("[RUN]\tSet TF and check SYSENTER\n");
 		sethandler(SIGSEGV, print_and_longjmp,
 			   SA_RESETHAND | SA_ONSTACK);
@@ -217,6 +213,6 @@ int main()
 	/* Now make sure that another fast syscall doesn't set TF again. */
 	fast_syscall_no_tf();
 
-	free(stack.ss_sp);
+	cleanup_sigaltstack(&stack);
 	return 0;
 }
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 1149ac24921a..1b22ef548582 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -87,12 +87,9 @@ static void sigill(int sig, siginfo_t *info, void *ctx_void)
 
 int main()
 {
-	stack_t stack = {
-		/* Our sigaltstack scratch space. */
-		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
-		.ss_size = SIGSTKSZ,
-	};
-	if (sigaltstack(&stack, NULL) != 0)
+	stack_t stack = { };
+
+	if (setup_sigaltstack(&stack) != 0)
 		err(1, "sigaltstack");
 
 	sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
@@ -218,6 +215,6 @@ int main()
 	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
 #endif
 
-	free(stack.ss_sp);
+	cleanup_sigaltstack(&stack);
 	return 0;
 }
-- 
2.17.1

