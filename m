Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0E6D3C96
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 06:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDCEzl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDCEzk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 00:55:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357D6902A;
        Sun,  2 Apr 2023 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680497739; x=1712033739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QiABlPcf4IEH+I5tudzpH19X+ip8aQsWuAxBcqSPwt4=;
  b=Mk6p1a3e84DrH9CP0N34MPbUFckvZbm513/pBuKwTOBQs9485nLFWt01
   thn5lUAeA6kAT8N9DPDzjldvtc9Nidq8xukN1Dc3DUOIWMVcVIqD6aw9T
   cMrGoxLlf4RNsXtYWdfyPprmuzkLo2RkgS8mAlCFACaJdxuctgTxgPoBl
   7vrYE/0YLsFwGherh7Hgg1fU9keRwfo1H7onFetY2smXpN9SIH9g2miOv
   9YCnk0bIjwVGqYmZ5+kHHz1UQn+uGJO4sPNuvo581MxEF7EsC4wICmc7Y
   syBss+0YtEAgVo6e/pZCQU3Z0fJAupW8DJLZMX24QRnQDuKgK5bCq9BTu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="344362544"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="344362544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="829421517"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="829421517"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2023 21:55:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, luto@kernel.org, dave.hansen@intel.com,
        tglx@linutronix.de, bp@suse.de, jun.miao@windriver.com,
        chang.seok.bae@intel.com
Subject: [PATCH v1 1/4] selftests/x86: Fix the altstack free
Date:   Sun,  2 Apr 2023 21:43:37 -0700
Message-Id: <20230403044340.1312-2-chang.seok.bae@intel.com>
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

Some altstacks are freed up too early even before the test signal
delivery. Move the memory cleanup after a signal return.

Fixes: a051b2e56f2a ("selftests/x86: Fix error: variably modified 'altstack_data' at file scope")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Jun Miao <jun.miao@windriver.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
The issue was discovered by the altstack refactoring in this series
that replaces malloc()/free() with mmap()/munmap().
---
 tools/testing/selftests/x86/mov_ss_trap.c       | 17 ++++++++++-------
 .../testing/selftests/x86/single_step_syscall.c | 17 ++++++++++-------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index cc3de6ff9fba..6b9bf8dc3b60 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -142,8 +142,17 @@ static void handle_and_longjmp(int sig, siginfo_t *si, void *ctx_void)
 
 int main()
 {
+	stack_t stack = { };
 	unsigned long nr;
 
+	stack.ss_size = SIGSTKSZ;
+	stack.ss_sp = malloc(sizeof(char) * SIGSTKSZ);
+	if (!stack.ss_sp)
+		err(1, "malloc()");
+
+	if (sigaltstack(&stack, NULL) != 0)
+		err(1, "sigaltstack()");
+
 	asm volatile ("mov %%ss, %[ss]" : [ss] "=m" (ss));
 	printf("\tSS = 0x%hx, &SS = 0x%p\n", ss, &ss);
 
@@ -248,15 +257,8 @@ int main()
 	 */
 	if (sigsetjmp(jmpbuf, 1) == 0) {
 		printf("[RUN]\tMOV SS; SYSENTER\n");
-		stack_t stack = {
-			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
-			.ss_size = SIGSTKSZ,
-		};
-		if (sigaltstack(&stack, NULL) != 0)
-			err(1, "sigaltstack");
 		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
 		nr = SYS_getpid;
-		free(stack.ss_sp);
 		/* Clear EBP first to make sure we segfault cleanly. */
 		asm volatile ("xorl %%ebp, %%ebp; mov %[ss], %%ss; SYSENTER" : "+a" (nr)
 			      : [ss] "m" (ss) : "flags", "rcx"
@@ -281,6 +283,7 @@ int main()
 			);
 	}
 
+	free(stack.ss_sp);
 	printf("[OK]\tI aten't dead\n");
 	return 0;
 }
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 9a30f443e928..2d8e0edca23f 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -144,10 +144,19 @@ static void fast_syscall_no_tf(void)
 
 int main()
 {
+	stack_t stack = { };
 #ifdef CAN_BUILD_32
 	int tmp;
 #endif
 
+	stack.ss_size = SIGSTKSZ;
+	stack.ss_sp = malloc(sizeof(char) * SIGSTKSZ);
+	if (!stack.ss_sp)
+		err(1, "malloc()");
+
+	if (sigaltstack(&stack, NULL) != 0)
+		err(1, "sigaltstack()");
+
 	sethandler(SIGTRAP, sigtrap, 0);
 
 	printf("[RUN]\tSet TF and check nop\n");
@@ -208,17 +217,10 @@ int main()
 	if (sigsetjmp(jmpbuf, 1) == 0) {
 		unsigned long nr = SYS_getpid;
 		printf("[RUN]\tSet TF and check SYSENTER\n");
-		stack_t stack = {
-			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
-			.ss_size = SIGSTKSZ,
-		};
-		if (sigaltstack(&stack, NULL) != 0)
-			err(1, "sigaltstack");
 		sethandler(SIGSEGV, print_and_longjmp,
 			   SA_RESETHAND | SA_ONSTACK);
 		sethandler(SIGILL, print_and_longjmp, SA_RESETHAND);
 		set_eflags(get_eflags() | X86_EFLAGS_TF);
-		free(stack.ss_sp);
 		/* Clear EBP first to make sure we segfault cleanly. */
 		asm volatile ("xorl %%ebp, %%ebp; SYSENTER" : "+a" (nr) :: "flags", "rcx"
 #ifdef __x86_64__
@@ -238,5 +240,6 @@ int main()
 	/* Now make sure that another fast syscall doesn't set TF again. */
 	fast_syscall_no_tf();
 
+	free(stack.ss_sp);
 	return 0;
 }
-- 
2.17.1

