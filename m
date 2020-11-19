Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF302B9E7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Nov 2020 00:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgKSXhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 18:37:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:7299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbgKSXhH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:07 -0500
IronPort-SDR: oos1ALgB7mowvDkalLNG2aBpznIzot5iUnQbft+ZBHo58JKwUHWIHhm6Sh5ncdZ+laPf3uP+Yf
 K1+RYPiKwlGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171552666"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171552666"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:37:04 -0800
IronPort-SDR: rKqAXp2x/M9MbnVBsgDBH66SipKhyB7k8J35fj5bF8Fu+R5Hr4sYf/iznv5eL2t55aQwS/FNn9
 QdELojc+ZOSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392255"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:37:03 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 21/22] x86/fpu/xstate: Support dynamic user state in the signal handling path
Date:   Thu, 19 Nov 2020 15:32:56 -0800
Message-Id: <20201119233257.2939-22-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119233257.2939-1-chang.seok.bae@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Entering a signal handler, the kernel saves the XSAVE area. The dynamic
user state is better to be saved only when used. fpu->state_mask can help
to exclude unused states.

Returning from a signal handler, XRSTOR re-initializes the excluded state
components.

Add a test case to verify in the signal handler that the signal frame
excludes AMX data when the signaled thread has initialized AMX state.

No functional change until the kernel supports the dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
Changes from v1:
* Made it revertible (moved close to the end of the series)
* Included test case
---
 arch/x86/include/asm/fpu/internal.h |  2 +-
 tools/testing/selftests/x86/amx.c   | 89 +++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index ede3f88bdc52..d8e56e96df49 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -369,7 +369,7 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
  */
 static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 {
-	u64 mask = xfeatures_mask_user();
+	u64 mask = current->thread.fpu.state_mask;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index dce3b298f043..bf766b22cf77 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -623,6 +623,94 @@ static void test_ptrace(void)
 	test_tile_state_write(ptracee_loads_tiles);
 }
 
+/* Signal handling test */
+
+static int sigtrapped;
+struct tile_data sig_tiles, sighdl_tiles;
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void sighandler(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *uctxt = (ucontext_t *)ctx_void;
+	struct xsave_data xdata;
+	struct tile_config cfg;
+	struct tile_data tiles;
+	u64 header;
+
+	header = __get_xsave_xstate_bv((void *)uctxt->uc_mcontext.fpregs);
+
+	if (header & (1 << XFEATURE_XTILE_DATA))
+		printf("[FAIL]\ttile data was written in sigframe\n");
+	else
+		printf("[OK]\ttile data was skipped in sigframe\n");
+
+	set_tilecfg(&cfg);
+	load_tilecfg(&cfg);
+	init_xdata(&xdata);
+
+	make_tiles(&tiles);
+	copy_tiles_to_xdata(&xdata, &tiles);
+	restore_xdata(&xdata);
+
+	save_xdata(&xdata);
+	if (compare_xdata_tiles(&xdata, &tiles))
+		err(1, "tile load file");
+
+	printf("\tsignal handler: load tile data\n");
+
+	sigtrapped = sig;
+}
+
+static void test_signal_handling(void)
+{
+	struct xsave_data xdata = { 0 };
+	struct tile_data tiles = { 0 };
+
+	clearhandler(SIGTRAP);
+	sethandler(SIGTRAP, sighandler, 1);
+	sigtrapped = 0;
+
+	printf("[RUN]\tCheck tile state management in handling signal\n");
+
+	printf("\tbefore signal: initial tile data state\n");
+
+	raise(SIGTRAP);
+
+	if (sigtrapped == 0)
+		err(1, "sigtrap");
+
+	save_xdata(&xdata);
+	if (compare_xdata_tiles(&xdata, &tiles)) {
+		printf("[FAIL]\ttile data was not loaded at sigreturn\n");
+		nerrs++;
+	} else {
+		printf("[OK]\ttile data was re-initialized at sigreturn\n");
+	}
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -642,6 +730,7 @@ int main(void)
 	test_fork();
 	test_context_switch();
 	test_ptrace();
+	test_signal_handling();
 
 	return nerrs ? 1 : 0;
 }
-- 
2.17.1

