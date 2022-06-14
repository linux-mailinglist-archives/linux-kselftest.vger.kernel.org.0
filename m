Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1761054B444
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356250AbiFNPL5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356221AbiFNPLz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 11:11:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377623F88B;
        Tue, 14 Jun 2022 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655219514; x=1686755514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2aHl53WvnO/FvyT5FOpuxZQlcnfaJheQizeiOWcK4bw=;
  b=Y2QtsKMAd+lpqykaFHkHgDagVpreJthl3MoBa0HVQfxSAOIPxq5mzIsg
   rEPESjdlaTFacD+olnlaWA/iHaUbTWC65FUlh/DdZ1G4JkU2TgA+mAfGV
   iNkzwp6qjk3a4wO89VQLUVrrJbKl8lRApcwh+jna5FLw8k6VFryfxeZ6F
   LdGlRagfSG21D0o//xjmlq1aeit/qDyH+g/TA5hQYFI0LrankLzy185gr
   srbnsmdaiebDQxzbBRuMGRs0htuVbbVQuGMZpcG+O68NG4l2yAr4VeKn5
   z2NvduUfltuqHvowTY75vGtXHmtkt5iVrT5w+1PDgzx8PxjA7QsjFNVWJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261673605"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261673605"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="673941779"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 08:11:51 -0700
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
Subject: [PATCH v9 2/2] selftests/x86/xstate: Add xstate fork test for XSAVE feature
Date:   Tue, 14 Jun 2022 23:11:06 +0800
Message-Id: <d31e4ba98e5a5deecd06be9ae62be9aa48eb5273.1655218544.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1655218544.git.pengfei.xu@intel.com>
References: <cover.1655218544.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

  [ Dave Hansen; Chang S. Bae: bunches of cleanups ]

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/x86/xstate.c         | 22 ++++++++-
 tools/testing/selftests/x86/xstate.h         |  1 +
 tools/testing/selftests/x86/xstate_helpers.c | 51 ++++++++++++++++++++
 tools/testing/selftests/x86/xstate_helpers.h |  2 +
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index 05dabb4733a0..96e6b5db907b 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -45,7 +45,7 @@
 #include "xstate_helpers.h"
 #include "../kselftest.h"
 
-#define NUM_TESTS 1
+#define NUM_TESTS 3
 #define xstate_test_array_init(idx, init_opt, fill_opt)	\
 	do {						\
 		xstate_tests[idx].init = init_opt;	\
@@ -135,6 +135,25 @@ static void test_xstate_sig_handle(void)
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
@@ -153,6 +172,7 @@ static void prepare_xstate_test(void)
 			       fill_pkru_xstate_buf);
 
 	xstate_tests[XSTATE_CASE_SIG].xstate_case = test_xstate_sig_handle;
+	xstate_tests[XSTATE_CASE_FORK].xstate_case = test_xstate_fork;
 }
 
 static void test_xstate(void)
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index a60429591c49..17e0f7b17a6e 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -87,6 +87,7 @@ enum supportability {
 
 enum xstate_case {
 	XSTATE_CASE_SIG,
+	XSTATE_CASE_FORK,
 	XSTATE_CASE_MAX,
 };
 
diff --git a/tools/testing/selftests/x86/xstate_helpers.c b/tools/testing/selftests/x86/xstate_helpers.c
index 0f88f56f839e..406d7330e2ae 100644
--- a/tools/testing/selftests/x86/xstate_helpers.c
+++ b/tools/testing/selftests/x86/xstate_helpers.c
@@ -158,3 +158,54 @@ bool xstate_sig_handle(void *valid_xbuf, void *compared_xbuf, uint64_t mask,
 
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
+		/* Fork syscall failed */
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
index 1806c0bf484b..307781708ffa 100644
--- a/tools/testing/selftests/x86/xstate_helpers.h
+++ b/tools/testing/selftests/x86/xstate_helpers.h
@@ -6,3 +6,5 @@ extern void fill_fp_mxcsr_xstate_buf(void *buf, int xfeature_num,
 				     uint8_t ui8_fp);
 extern bool xstate_sig_handle(void *valid_xbuf, void *compared_xbuf,
 			      uint64_t mask, uint32_t xstate_size);
+extern bool xstate_fork(void *valid_xbuf, void *compared_xbuf,
+			uint64_t mask, uint32_t xstate_size);
-- 
2.31.1

