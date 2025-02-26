Return-Path: <linux-kselftest+bounces-27547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B2A451F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66C619C387C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76C18E35D;
	Wed, 26 Feb 2025 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6hettGc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213A187342;
	Wed, 26 Feb 2025 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532061; cv=none; b=hg4s7dHful26ron4h7lw/WhKiz90+MdjHJKMTPi+DNShoqntKHhxOsgl0aLzilhIZ2J2ttUaTRkOMvl+jpAn5eobeFeVygmczHB5YaagaDDMT6WO2jkdxG3Vr4EoAjSvzoLLnVUufjbhXLSJjTrjlm3YHhl05Och8ulm7LrDIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532061; c=relaxed/simple;
	bh=coXXT2jWow+DVw31djbygBL3uwg6cY+eFGQfiQPL7G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FY37VKId4jiy9qZSlL8rqOAgVhAF41K4hxB4HVc8HeVR5zMaxJQvjF8cfpqC/G/lgR/R5DuqRhsDxMcRsCMTbXuzutmiBRcEwUyeJLg28vYBYk44kUgmR/mB67tIpE5RAUueuB47SKLGox1y4oFONdQb8JVvz1NdvKuyVJ09MQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6hettGc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532060; x=1772068060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=coXXT2jWow+DVw31djbygBL3uwg6cY+eFGQfiQPL7G8=;
  b=V6hettGc0Xj/Qv4RiIcuzfQyLI1FY8HBRpwK0bOtslgApYq5R+exy+H9
   2VdMb2eRU+76/b1BlolStHNz/uN2Wdnfu1qPmDePl5b5bt0qHoB876R9B
   ia/Rm+FCHVmDQ/49teyWC6P1pLsukRoaj2be9RLD4EXZg386trUc8+OAs
   /PGUiQqQSwHpcTxOrssNm3r8QktYLvP6wpyd7YIwS4jxzIClf3rzGiNKX
   ZEXCPpMlPJg62/qM6FAc0Ggas+RIh3GwxgRjwaD0XJcxeXNXYpzEeANK2
   giWDLmLlbXjcMZJJZD5YP9tCw/oGlIuMu4/mn5jwOoOwCp5EV+RF6HTlR
   Q==;
X-CSE-ConnectionGUID: wYHq7ZDbT6qaU0vAtXvb0g==
X-CSE-MsgGUID: BMAo3DD6Qr2NZdksxjjRqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362214"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362214"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:39 -0800
X-CSE-ConnectionGUID: 0Kec9owVTN2U+DEYJ1KHNQ==
X-CSE-MsgGUID: hv8aXUN7T6WRep0eqdL+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467355"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:39 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH 6/9] selftests/x86/xstate: Introduce signal ABI test
Date: Tue, 25 Feb 2025 17:07:26 -0800
Message-ID: <20250226010731.2456-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226010731.2456-1-chang.seok.bae@intel.com>
References: <20250226010731.2456-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the refactored test cases, another xstate exposure to userspace is
through signal delivery. While amx.c includes signal-related scenarios,
its primary focus is on xstate permission management, which is largely
specific to dynamic states.

The remaining gap is testing xstate preservation and restoration across
signal delivery. The kernel defines an ABI for presenting xstate in the
signal frame, closely resembling the hardware XSAVE format, where xstate
modification is also possible.

Introduce a new test case to verify xstate preservation across signal
delivery and return, that is ensuring ABI compatibility by:

- Loading xstate before raising a signal.
- Verifying correct exposure in the signal frame
- Modifying xstate in the signal frame before returning.
- Checking the state restoration upon signal return.

Integrate this test into the AMX test suite as an initial usage site.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Expected output:
$ amx_64
...
[RUN]   AMX Tile data: load xstate and raise SIGUSR1
[OK]    'magic1' is valid
[OK]    'xfeatures' in SW reserved area is valid
[OK]    'xfeatures' in XSAVE header is valid
[OK]    xstate delivery was successful
[OK]    'magic2' is valid
[RUN]   AMX Tile data: load new xstate from sighandler and check it after sigreturn
[OK]    xstate was restored correctly
---
 tools/testing/selftests/x86/amx.c    |   2 +
 tools/testing/selftests/x86/xstate.c | 108 +++++++++++++++++++++++++++
 tools/testing/selftests/x86/xstate.h |   1 +
 3 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 4bafbb72aa1b..9cb691d67ef4 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -510,6 +510,8 @@ int main(void)
 
 	test_ptrace(XFEATURE_XTILEDATA);
 
+	test_signal(XFEATURE_XTILEDATA);
+
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index d318b35ba547..b5600f492632 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -21,6 +21,11 @@ static inline uint64_t xgetbv(uint32_t index)
 	return eax + ((uint64_t)edx << 32);
 }
 
+static inline uint64_t get_xstatebv(struct xsave_buffer *xbuf)
+{
+	return *(uint64_t *)(&xbuf->header);
+}
+
 static struct xstate_info xstate;
 
 struct futex_info {
@@ -325,3 +330,106 @@ void test_ptrace(uint32_t feature_num)
 	if (!WIFEXITED(status) || WEXITSTATUS(status))
 		ksft_exit_fail_msg("ptracee exit error\n");
 }
+
+/*
+ * Test signal delivery for the ABI compatibility.
+ * See the ABI format: arch/x86/include/uapi/asm/sigcontext.h
+ */
+
+/*
+ * Avoid using printf() in signal handlers as it is not
+ * async-signal-safe.
+ */
+#define SIGNAL_BUF_LEN 1000
+static char signal_message_buffer[SIGNAL_BUF_LEN];
+static void sig_print(char *msg)
+{
+	int left = SIGNAL_BUF_LEN - strlen(signal_message_buffer) - 1;
+
+	strncat(signal_message_buffer, msg, left);
+}
+
+static struct xsave_buffer *stashed_xbuf;
+
+static void validate_sigfpstate(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+	void *xbuf = ctx->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes;
+	uint32_t magic2;
+
+	/* Reset the signal message buffer: */
+	signal_message_buffer[0] = '\0';
+
+	sw_bytes = get_fpx_sw_bytes(xbuf);
+	if (sw_bytes->magic1 == FP_XSTATE_MAGIC1)
+		sig_print("[OK]\t'magic1' is valid\n");
+	else
+		sig_print("[FAIL]\t'magic1' is not valid\n");
+
+	if (get_fpx_sw_bytes_features(xbuf) & xstate.mask)
+		sig_print("[OK]\t'xfeatures' in SW reserved area is valid\n");
+	else
+		sig_print("[FAIL]\t'xfeatures' in SW reserved area is not valid\n");
+
+	if (get_xstatebv(xbuf) & xstate.mask)
+		sig_print("[OK]\t'xfeatures' in XSAVE header is valid\n");
+	else
+		sig_print("[FAIL]\t'xfeatures' in XSAVE hader is not valid\n");
+
+	if (validate_xstate_same(stashed_xbuf, xbuf))
+		sig_print("[OK]\txstate delivery was successful\n");
+	else
+		sig_print("[FAIL]\txstate delivery was not successful\n");
+
+	magic2 = *(uint32_t *)(xbuf + sw_bytes->xstate_size);
+	if (magic2 == FP_XSTATE_MAGIC2)
+		sig_print("[OK]\t'magic2' is valid\n");
+	else
+		sig_print("[FAIL]\t'magic2' is not valid\n");
+
+	set_rand_data(&xstate, xbuf);
+	copy_xstate(stashed_xbuf, xbuf);
+}
+
+void test_signal(uint32_t feature_num)
+{
+	bool valid_xstate;
+
+	xstate = get_xstate_info(feature_num);
+
+	/*
+	 * The signal handler will access this to verify xstate context
+	 * preservation.
+	 */
+
+	stashed_xbuf = alloc_xbuf();
+	if (!stashed_xbuf)
+		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
+
+	printf("[RUN]\t%s: load xstate and raise SIGUSR1\n", xstate.name);
+
+	sethandler(SIGUSR1, validate_sigfpstate, 0);
+
+	load_rand_xstate(&xstate, stashed_xbuf);
+
+	raise(SIGUSR1);
+
+	/*
+	 * Immediately record the test result, deferring printf() to
+	 * prevent unintended state contamination by that.
+	 */
+	valid_xstate = validate_xregs_same(stashed_xbuf);
+	printf("%s", signal_message_buffer);
+
+	printf("[RUN]\t%s: load new xstate from sighandler and check it after sigreturn\n",
+	       xstate.name);
+
+	if (valid_xstate)
+		printf("[OK]\txstate was restored correctly\n");
+	else
+		printf("[FAIL]\txstate restoration failed\n");
+
+	clearhandler(SIGUSR1);
+	free(stashed_xbuf);
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 2bf11d3a3ce9..4d0ffe9609f8 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -191,5 +191,6 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 
 void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
 void test_ptrace(uint32_t feature_num);
+void test_signal(uint32_t feature_num);
 
 #endif /* __SELFTESTS_X86_XSTATE_H */
-- 
2.45.2


