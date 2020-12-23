Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D672E1F1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Dec 2020 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgLWQCY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Dec 2020 11:02:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:51477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgLWQCX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Dec 2020 11:02:23 -0500
IronPort-SDR: t6n7CF+SbtZu1Il8qkPopvGUP5qkyTYu1Bxx+xUar4O0/hGpCHi2tj9cSuuJiHxTJNCacEIgRW
 iUqsS++SmHsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="176130532"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="176130532"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:42 -0800
IronPort-SDR: NgGIVCZ9caVTBX6CI/hQAb3UKswkGndWj0MAsGfGCNhlBRlIwACEqCq1zNt0Wo2SS/5B5LuPZF
 tAgnQte2g6EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458028061"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:41 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 20/21] x86/fpu/xstate: Support dynamic user state in the signal handling path
Date:   Wed, 23 Dec 2020 07:57:16 -0800
Message-Id: <20201223155717.19556-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Entering a signal handler, the kernel saves the XSAVE buffer. The dynamic
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
* Made it revertible (moved close to the end of the series).
* Included the test case.
---
 arch/x86/include/asm/fpu/internal.h |  2 +-
 tools/testing/selftests/x86/amx.c   | 66 +++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5eba9a466249..202874bb79da 100644
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
index f4ecdfd27ae9..a7386b886532 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -650,6 +650,71 @@ static void test_ptrace(void)
 	test_tile_state_write(ptracee_loads_tiles);
 }
 
+/* Signal handling test */
+
+static int sigtrapped;
+struct tile_data sig_tiles, sighdl_tiles;
+
+static void handle_sigtrap(int sig, siginfo_t *info, void *ctx_void)
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
+	sethandler(SIGTRAP, handle_sigtrap, 0);
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
+
+	clearhandler(SIGTRAP);
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -672,6 +737,7 @@ int main(void)
 	test_fork();
 	test_context_switch();
 	test_ptrace();
+	test_signal_handling();
 
 	return nerrs ? 1 : 0;
 }
-- 
2.17.1

