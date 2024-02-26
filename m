Return-Path: <linux-kselftest+bounces-5437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D41867603
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 14:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9801C240F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62EB80049;
	Mon, 26 Feb 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgleoIV7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F680BED;
	Mon, 26 Feb 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952826; cv=none; b=iX88P2wCtSDM4gWNnW+6/oCf0nM3yXx5z3EwhBQNc9ta08MwHigiDykstIKhQxlOZkmwZZ9bW2a96y9IYb06wFc/zQCB/kR8ZtgHewPyevq9rtb8+2fvv1dYIqLuyqkW2fFW3GVM7WuV9sr9MmlA8ClTtQYPgtK6Maouk6aKyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952826; c=relaxed/simple;
	bh=g0yR6WYCfEXEviJaKQNvbY0qMoOFIzumiw2MxAGGP1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0X/USeLTE6HvZFIvCDLzawj2rgT8CSneBmhr7GtXBvw6+0BcgmTMK1gAziGpqtMJI5S2Vq8AXcDCVmXBqzDRCJuFBhrOKeZv8bTRcRyANSsx685T8Dmy8Qc1ywVzVbgUAgeA9JZKPGDDly5GM06uEzLdyvwxz6yQtSJS5CD87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgleoIV7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708952825; x=1740488825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g0yR6WYCfEXEviJaKQNvbY0qMoOFIzumiw2MxAGGP1c=;
  b=hgleoIV7vY8cLCxHH5D0PXpdcbTx98RcwO6Gz4A7hooT1qhfLH51YvXP
   s9K0ULOm4gtpbycPjVwlfX0ngij0ouzzpJegL9TK5CIhkm6PKUch2nAjA
   2J6q9uGYWptTzekHJIl7G3ApZBSz+6F7e6LfzsSCY+oiQQVBm7IQQRt2u
   hvrIGmZlrkI/DYg/KrKPkN4uUDIIyhNzYPzJbh/5tSxfj0U1yLgZkgRzB
   7qUPJCl+deEdlPpa6FtPul9ztnRd/YCIVftxkxsTMSwMmrOigB2dYEsFg
   ZDIBFvac8asl3wduVkd/jBLQt8/YmuukxmpDCisNtD6p/7yZFKjwHQ+HL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14669182"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14669182"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6586251"
Received: from pkwiatko-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:06:34 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/3] selftests/resctrl: Simplify cleanup in ctrl-c handler
Date: Mon, 26 Feb 2024 14:05:49 +0100
Message-ID: <8ebd39230ab62eea7e1357c56e1d416e85b54c52.1708949785.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708949785.git.maciej.wieczor-retman@intel.com>
References: <cover.1708949785.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ctrl-c handler isn't aware of what test is currently running. Because of
that it executes all cleanups even if they aren't necessary. Since the
ctrl-c handler uses the sa_sigaction system no parameters can be passed
to it as function arguments.

Add a global variable to make ctrl-c handler aware of the currently run
test and only execute the correct cleanup callback.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v4:
- Reset current_test pointer and check if it's not NULL before calling.
  (Reinette)

Changelog v3:
- Make current_test static. (Ilpo)
- Add callback NULL pointer guard in ctrl-c handler. (Ilpo)

Changelog v2:
- Remove tests_cleanup() from resctrl.h.
- Make current_test a const pointer only inside resctrl_val.c. (Ilpo)

 tools/testing/selftests/resctrl/resctrl.h       |  3 +--
 tools/testing/selftests/resctrl/resctrl_tests.c | 14 +++-----------
 tools/testing/selftests/resctrl/resctrl_val.c   |  8 ++++++--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 0f49df4961ea..826783b29c9d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -153,7 +153,6 @@ int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
-void tests_cleanup(void);
 void mbm_test_cleanup(void);
 void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
@@ -162,7 +161,7 @@ int get_full_cbm(const char *cache_type, unsigned long *mask);
 int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
-int signal_handler_register(void);
+int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 void cat_test_cleanup(void);
 unsigned int count_bits(unsigned long n);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 75fc49ba3efb..161f5365b4f0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -75,19 +75,11 @@ static void cmd_help(void)
 	printf("\t-h: help\n");
 }
 
-void tests_cleanup(void)
-{
-	mbm_test_cleanup();
-	mba_test_cleanup();
-	cmt_test_cleanup();
-	cat_test_cleanup();
-}
-
-static int test_prepare(void)
+static int test_prepare(const struct resctrl_test *test)
 {
 	int res;
 
-	res = signal_handler_register();
+	res = signal_handler_register(test);
 	if (res) {
 		ksft_print_msg("Failed to register signal handler\n");
 		return res;
@@ -130,7 +122,7 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 
 	ksft_print_msg("Starting %s test ...\n", test->name);
 
-	if (test_prepare()) {
+	if (test_prepare(test)) {
 		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5a49f07a6c85..445f306d4c2f 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -62,6 +62,7 @@ struct imc_counter_config {
 static char mbm_total_path[1024];
 static int imcs;
 static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
+static const struct resctrl_test *current_test;
 
 void membw_initialize_perf_event_attr(int i, int j)
 {
@@ -472,7 +473,8 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	if (bm_pid)
 		kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
-	tests_cleanup();
+	if (current_test && current_test->cleanup)
+		current_test->cleanup();
 	ksft_print_msg("Ending\n\n");
 
 	exit(EXIT_SUCCESS);
@@ -482,13 +484,14 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
  * Register CTRL-C handler for parent, as it has to kill
  * child process before exiting.
  */
-int signal_handler_register(void)
+int signal_handler_register(const struct resctrl_test *test)
 {
 	struct sigaction sigact = {};
 	int ret = 0;
 
 	bm_pid = 0;
 
+	current_test = test;
 	sigact.sa_sigaction = ctrlc_handler;
 	sigemptyset(&sigact.sa_mask);
 	sigact.sa_flags = SA_SIGINFO;
@@ -510,6 +513,7 @@ void signal_handler_unregister(void)
 {
 	struct sigaction sigact = {};
 
+	current_test = NULL;
 	sigact.sa_handler = SIG_DFL;
 	sigemptyset(&sigact.sa_mask);
 	if (sigaction(SIGINT, &sigact, NULL) ||
-- 
2.43.2


