Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882AA595791
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 12:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiHPKIS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiHPKH5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 06:07:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B94BD13;
        Tue, 16 Aug 2022 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660642013; x=1692178013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZMuHGKocPEG0N6hjxJrrndY/OG6K8rAXCaYUpUbXKNA=;
  b=X9lpq0AtY7qXjZ5F95RLjSDFFDL2otcFEO6YKjKxeLHeGmuX7ZwFXHIN
   x7fEzUb6KdYfrERZZy6W2IN2hmyT5LmSuaeOQjQFEVnxLpmOw0vG2Tsxq
   adUkDVm3MFBd/QRrQr0Lz7vqldedwgS0PtR5Sgwa6vdvKI90EAwtUD+/r
   rHdHy2pdD4dlzGCZqW7XNy2rwqMHt7umDwHERDhuY2406bOGJRNV4kuZA
   Me1glGeZzIG3C5ZSmjkVhfR0BVeAps0PfJH1+/b7Kdz06lTn4+W3BVjps
   74wXVMci4B0aJu0p2Nlo1zQxsV5AJtBxxjpofAodB//okOMowBMJNsFxI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378462035"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="378462035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="635819684"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 02:26:49 -0700
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bae Chang Seok <chang.seok.bae@intel.com>
Subject: [PATCH v12 2/2] selftests/x86/xstate: Add xstate fork test for XSAVE feature
Date:   Tue, 16 Aug 2022 17:26:44 +0800
Message-Id: <362774a3bc7546fcb08f5a9b852e7e6ca2cfa11c.1660618469.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1660618469.git.pengfei.xu@intel.com>
References: <cover.1660618469.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to ensure that XSAVE works correctly, add XSAVE most basic fork
test:
1. The contents of these xstates in the child process should be the same as
   the contents of the xstate in the parent process after the fork syscall.
2. The contents of xstates in the parent process should not change after
   the context switch.

  [ Dave Hansen; Chang S. Bae; Shuah Khan: bunches of cleanups ]

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/x86/xstate.c         | 22 ++++++-
 tools/testing/selftests/x86/xstate.h         |  1 +
 tools/testing/selftests/x86/xstate_helpers.c | 67 ++++++++++++++++++++
 tools/testing/selftests/x86/xstate_helpers.h |  2 +
 4 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index 0f8348aa1f15..e3707f0ea597 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -39,7 +39,7 @@
 #include "xstate_helpers.h"
 #include "../kselftest.h"
 
-#define NUM_TESTS	1
+#define NUM_TESTS	3
 #define xstate_test_array_init(idx, init_opt, fill_opt)		\
 	do {							\
 		xstate_tests[idx].init = init_opt;		\
@@ -106,6 +106,25 @@ static void test_xstate_sig_handle(void)
 	compare_buf_result(valid_xbuf, compared_xbuf, case_name1);
 }
 
+static void test_xstate_fork(void)
+{
+	const char *case_name2 = "xstate of child process should be same as xstate of parent";
+	const char *case_name3 = "parent xstate should be same after context switch";
+
+	ksft_print_msg("[RUN]\tParent pid:%d check xstate around fork test.\n",
+		       getpid());
+	/* Child process xstate should be same as the parent process xstate. */
+	if (xstate_fork(valid_xbuf, compared_xbuf, xstate_info.mask,
+	    xstate_size)) {
+		ksft_test_result_pass("The case: %s.\n", case_name2);
+	} else {
+		ksft_test_result_fail("The case: %s.\n", case_name2);
+	}
+
+	/* The parent process xstate should not change after context switch. */
+	compare_buf_result(valid_xbuf, compared_xbuf, case_name3);
+}
+
 static void prepare_xstate_test(void)
 {
 	xstate_test_array_init(XFEATURE_FP, init_legacy_info,
@@ -124,6 +143,7 @@ static void prepare_xstate_test(void)
 			       fill_pkru_xstate_buf);
 
 	xstate_tests[XSTATE_CASE_SIG].xstate_case = test_xstate_sig_handle;
+	xstate_tests[XSTATE_CASE_FORK].xstate_case = test_xstate_fork;
 }
 
 static void test_xstate(void)
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index f0eb7a430905..872404e246a6 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -81,6 +81,7 @@ enum xfeature {
 
 enum xstate_case {
 	XSTATE_CASE_SIG,
+	XSTATE_CASE_FORK,
 	XSTATE_CASE_MAX,
 };
 
diff --git a/tools/testing/selftests/x86/xstate_helpers.c b/tools/testing/selftests/x86/xstate_helpers.c
index 461f5e9d16cb..64bd014de6d5 100644
--- a/tools/testing/selftests/x86/xstate_helpers.c
+++ b/tools/testing/selftests/x86/xstate_helpers.c
@@ -73,6 +73,22 @@ inline void fill_fp_mxcsr_xstate_buf(void *buf, uint32_t xfeature_num,
 	__xsave(buf, MASK_FP_SSE);
 }
 
+/*
+ * Because xstate like XMM, YMM registers are not preserved across function
+ * calls, so use inline function with assembly code only for fork syscall.
+ */
+static inline long __fork(void)
+{
+	long ret, nr = SYS_fork;
+
+	asm volatile("syscall"
+		     : "=a" (ret)
+		     : "a" (nr)
+		     : "rcx", "r11", "memory", "cc");
+
+	return ret;
+}
+
 /*
  * Because xstate like XMM, YMM registers are not preserved across function
  * calls, so use inline function with assembly code only to raise signal.
@@ -140,3 +156,54 @@ bool xstate_sig_handle(void *valid_xbuf, void *compared_xbuf, uint64_t mask,
 
 	return sigusr1_done;
 }
+
+bool xstate_fork(void *valid_xbuf, void *compared_xbuf, uint64_t mask,
+		 uint32_t xstate_size)
+{
+	pid_t child;
+	int status, fd[2];
+	bool child_result;
+
+	memset(compared_xbuf, 0, xstate_size);
+	/* Use pipe to transfer test result to parent process. */
+	if (pipe(fd) < 0)
+		fatal_error("create pipe failed");
+	/*
+	 * Xrstor the valid_xbuf and call syscall assembly instruction, then
+	 * save the xstate to compared_xbuf in child process for comparison.
+	 */
+	__xrstor(valid_xbuf, mask);
+	child = __fork();
+	if (child < 0) {
+		/* Fork syscall failed. */
+		fatal_error("fork failed");
+	} else if (child == 0) {
+		/* Fork syscall succeeded, now in the child. */
+		__xsave(compared_xbuf, mask);
+
+		if (memcmp(valid_xbuf, compared_xbuf, xstate_size))
+			child_result = false;
+		else
+			child_result = true;
+
+		/*
+		 * Transfer the child process test result to
+		 * the parent process for aggregation.
+		 */
+		close(fd[0]);
+		if (!write(fd[1], &child_result, sizeof(child_result)))
+			fatal_error("write fd failed");
+		_exit(0);
+	} else {
+		/* Fork syscall succeeded, now in the parent. */
+		__xsave(compared_xbuf, mask);
+		if (waitpid(child, &status, 0) != child || !WIFEXITED(status)) {
+			fatal_error("Child exit with error status");
+		} else {
+			close(fd[1]);
+			if (!read(fd[0], &child_result, sizeof(child_result)))
+				fatal_error("read fd failed");
+			return child_result;
+		}
+	}
+}
diff --git a/tools/testing/selftests/x86/xstate_helpers.h b/tools/testing/selftests/x86/xstate_helpers.h
index f50a4c1d907f..c46d26ec6750 100644
--- a/tools/testing/selftests/x86/xstate_helpers.h
+++ b/tools/testing/selftests/x86/xstate_helpers.h
@@ -5,3 +5,5 @@ extern void fill_fp_mxcsr_xstate_buf(void *buf, uint32_t xfeature_num,
 				     uint8_t ui8_fp);
 extern bool xstate_sig_handle(void *valid_xbuf, void *compared_xbuf,
 			      uint64_t mask, uint32_t xstate_size);
+extern bool xstate_fork(void *valid_xbuf, void *compared_xbuf,
+			uint64_t mask, uint32_t xstate_size);
-- 
2.31.1

