Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4294438DCA3
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 May 2021 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhEWTkB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 May 2021 15:40:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:32000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232002AbhEWTj6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 May 2021 15:39:58 -0400
IronPort-SDR: 03jaEIoJwxFsz+5d7GFC8cl4wMViHAsZG3wZCsCjjd6/U+d2ev0kxzwuhsOa4lwCaX1BV3/c2p
 9eElUdPmZ6CQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740688"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740688"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:30 -0700
IronPort-SDR: gdaFYesCiXuhSHARjLHPrjWPQ4SKnYxedOUGqBoDhH3KMOjs1IoWTekLYsIoRi7aXEGgP5dNJA
 DGygdcfyox4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467146"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 26/28] selftest/x86/amx: Test case for AMX state copy optimization in signal delivery
Date:   Sun, 23 May 2021 12:32:57 -0700
Message-Id: <20210523193259.26200-27-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test case to verify that unused states are excluded, by leaving a
known pattern on the signal stack and verifying that it is still intact
after taking a subsequent signal.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
Changes from v4:
* Separated out as a new patch.
* Improved the test routine by explicitly checking sigframe write.
---
 tools/testing/selftests/x86/amx.c | 137 ++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 7d177c03cdcf..c5a5582e2b6f 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -562,6 +562,142 @@ static void test_ptrace(void)
 	test_tile_write();
 }
 
+/* Signal handling test */
+
+static bool init_tiledata_state_before_signal;
+static bool load_tiledata_at_first;
+static bool sigalarmed, sigused;
+
+#define SIGFRAME_TILEDATA_SIGNATURE	0xFF
+
+static void handle_sigusr1(int sig, siginfo_t *info, void *ctx_void)
+{
+	void *xsave = ((ucontext_t *)ctx_void)->uc_mcontext.fpregs;
+
+	memset(xsave + xsave_xtiledata_offset, SIGFRAME_TILEDATA_SIGNATURE, xsave_xtiledata_size);
+
+	sigused = true;
+}
+
+static void handle_sigalrm(int sig, siginfo_t *info, void *ctx_void)
+{
+	void *xsave = ((ucontext_t *)ctx_void)->uc_mcontext.fpregs;
+	char d = SIGFRAME_TILEDATA_SIGNATURE;
+	bool written = false;
+	int i;
+
+	for (i = 0; i < xsave_xtiledata_size; i++) {
+		written = memcmp(xsave + xsave_xtiledata_offset + i, &d, 1);
+		if (written)
+			break;
+	}
+
+	if (__xgetbv(1) & XFEATURE_MASK_XTILEDATA)
+		err(1, "tile data state at signal delivery");
+
+	if (init_tiledata_state_before_signal && written) {
+		errs++;
+		printf("[FAIL]\tTile data was %swritten on sigframe.\n", !written ? "not " : "");
+	}
+
+	set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+	set_tiledata(xsave_buffer + xsave_xtiledata_offset);
+	xrstor(xsave_buffer, -1, -1);
+	sigalarmed = true;
+}
+
+static void test_signal_handling(void)
+{
+	pid_t child;
+
+	sigalarmed = false;
+	sigused = false;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (child > 0) {
+		do {
+			int status;
+
+			wait(&status);
+			if (WIFSTOPPED(status))
+				kill(child, SIGCONT);
+			else if (WIFEXITED(status) && !WEXITSTATUS(status))
+				break;
+			else
+				err(1, "signal test child");
+		} while (1);
+		return;
+	}
+
+	printf("\tBefore signal, load tile data -- %s, re-initialized -- %s:\n",
+	       load_tiledata_at_first ? "yes" : "no",
+	       init_tiledata_state_before_signal ? "yes" : "no");
+
+	syscall(SYS_arch_prctl, ARCH_GET_XSTATE, XFEATURE_MASK_XTILE);
+
+	raise(SIGUSR1);
+	if (!sigused)
+		err(1, "SIGUSR1");
+
+	if (load_tiledata_at_first) {
+		set_xstatebv(xsave_buffer, XFEATURE_MASK_XTILEDATA);
+		set_tiledata(xsave_buffer + xsave_xtiledata_offset);
+		xrstor(xsave_buffer, -1, -1);
+		memcpy(tiledata, xsave_buffer + xsave_xtiledata_offset, xsave_xtiledata_size);
+	}
+
+	if (init_tiledata_state_before_signal) {
+		set_xstatebv(xsave_buffer, 0);
+		xrstor(xsave_buffer, -1, -1);
+		memset(tiledata, 0, xsave_xtiledata_size);
+	}
+
+	raise(SIGALRM);
+	if (!sigalarmed)
+		err(1, "SIGALRM");
+
+	__xsave(xsave_buffer, XFEATURE_MASK_XTILEDATA, 0);
+	if (memcmp(tiledata, xsave_buffer + xsave_xtiledata_offset, xsave_xtiledata_size)) {
+		errs++;
+		printf("[FAIL]\tTile data was not restored at sigreturn\n");
+	}
+
+	if (errs)
+		nerrs++;
+	else
+		printf("[OK]\tTile data was %swritten on sigframe and restored at sigreturn\n",
+		       init_tiledata_state_before_signal ? "not " : "");
+	_exit(0);
+}
+
+static void test_signal(void)
+{
+	printf("[RUN]\tCheck tile data state in signal path:\n");
+
+	sethandler(SIGALRM, handle_sigalrm, 0);
+	sethandler(SIGUSR1, handle_sigusr1, 0);
+
+	load_tiledata_at_first = false;
+	init_tiledata_state_before_signal = true;
+	errs = 0;
+	test_signal_handling();
+
+	load_tiledata_at_first = true;
+	init_tiledata_state_before_signal = false;
+	errs = 0;
+	test_signal_handling();
+
+	load_tiledata_at_first = true;
+	init_tiledata_state_before_signal = true;
+	errs = 0;
+	test_signal_handling();
+
+	clearhandler(SIGALRM);
+	clearhandler(SIGUSR1);
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -592,6 +728,7 @@ int main(void)
 	test_fork();
 	test_context_switch();
 	test_ptrace();
+	test_signal();
 
 	clearhandler(SIGSEGV);
 
-- 
2.17.1

