Return-Path: <linux-kselftest+bounces-5274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C1785F543
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F9A28294A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01943D549;
	Thu, 22 Feb 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkraqQS+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA938DD9;
	Thu, 22 Feb 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596330; cv=none; b=ugEeAlSqU9nTUJcXBQ1eYwF+UpV35CmYw9LokH7OKG4knagU68IcW1q6P7Mbj6SfbqNrx7VF+qgE/2XecIIqjR6TifDOH2U8xcEZ+vSQMQB5kN6Kr/MrzTeQNXkvtdfyKEmjYEe2hm5kIz69tY/fFUUrUtld3ji70sbePpdnc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596330; c=relaxed/simple;
	bh=2UTZs7x3PMzSPqopk6ukhMebJaPmC5bK7YeG/3265o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faF+WbILy40mvIGo7MYxZTSxABR+XLbkbFZ0HwvUgghlOZX+3FSmupro62/5/pTmHZiNh6DLEkVFOP14+UEUP1C4bduoFB6l4xfvs/bWUN1PwShWU3Hr+Z81FFm7f6Owvj59vrdtYvAV4y9utl/LIP1gtgvmOyNTsMIZSeETeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkraqQS+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708596321; x=1740132321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2UTZs7x3PMzSPqopk6ukhMebJaPmC5bK7YeG/3265o0=;
  b=IkraqQS+MrJ+KNiwACKQv7GKkXgWPeOKA7ADuavaD1XSbf9qEN0T26sd
   UsZkMGUQPYRYKJ9hFhJU45ro9JkIXALwPNqnvGhcH3sfLKWk8z0JJ4JU2
   6rpx4AC8etMNaT4vHLmU5MyzvwRBOwxaj/qFww5xOezuOFpeRJglhyA8B
   m401pDPXkkRQdzqHtMhqjQyCatSCTUTiSMmFxJP2jzCfqxRe/A7hJnPZM
   BdjwAIp4oqdQnVNZFURolHqaz3e91Mi/RuRdB3e6C8qq2mrF2K7ssF6Zr
   oEYdw/QmlBf9clD6H3jNWxTHaPgg89eojyPRsdIpdLMKGMZzeOtMPsUHU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2920717"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2920717"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5753936"
Received: from ksulimow-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.120])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:05:12 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/3] selftests/resctrl: Simplify cleanup in ctrl-c handler
Date: Thu, 22 Feb 2024 11:04:29 +0100
Message-ID: <3a6639cd338a706bd2ed341aa6c717e1e79cc1f0.1708596015.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708596015.git.maciej.wieczor-retman@intel.com>
References: <cover.1708596015.git.maciej.wieczor-retman@intel.com>
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
Changelog v2:
- Remove tests_cleanup() from resctrl.h.
- Make current_test a const pointer only inside resctrl_val.c. (Ilpo)

 tools/testing/selftests/resctrl/resctrl.h       |  3 +--
 tools/testing/selftests/resctrl/resctrl_tests.c | 14 +++-----------
 tools/testing/selftests/resctrl/resctrl_val.c   |  6 ++++--
 3 files changed, 8 insertions(+), 15 deletions(-)

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
index 5a49f07a6c85..d572815436f3 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -62,6 +62,7 @@ struct imc_counter_config {
 static char mbm_total_path[1024];
 static int imcs;
 static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
+const struct resctrl_test *current_test;
 
 void membw_initialize_perf_event_attr(int i, int j)
 {
@@ -472,7 +473,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	if (bm_pid)
 		kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
-	tests_cleanup();
+	current_test->cleanup();
 	ksft_print_msg("Ending\n\n");
 
 	exit(EXIT_SUCCESS);
@@ -482,13 +483,14 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
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
-- 
2.43.2


