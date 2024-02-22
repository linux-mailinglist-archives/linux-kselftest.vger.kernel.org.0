Return-Path: <linux-kselftest+bounces-5284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D9D85F7BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 13:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122E8B22575
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0C5FB8D;
	Thu, 22 Feb 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZ0ty5BW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2660B93;
	Thu, 22 Feb 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603678; cv=none; b=Z5xjVQzXVp2v3BjqEnx7RhZPhm15+R8BbPfBm/J6o0Su7XcC9ulAGWZpWYObq+JJWw6cPeAj2oj4oq1mgHKk6fjC6PncuD9STdTbLnoiQjW2Tqo0ZxeHX42wC7x/ZJmrNNPzzUFN/C6ovTTXs6ndiiueT+61LBnPKXh+PSmwzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603678; c=relaxed/simple;
	bh=HYaPaOLExnses+9nv4Y9Jo34xyvgZeuLtCkP2ug5iXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW2sE4XmQFcxT02Jb9/R+jCxKoZd5Mhjy8r0TDIh5F5JtCp6SvIU6MSNyjpUBqh/05RL9NLwI27HeoFy9yj5+BxA+y53c1hPgicjfZ8Kym3n3ajxQA5R78r2GpLPalI4oql0lQrRVg1m0oJIGYwB+vFWD2smW3JBu1xtKF06D8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZ0ty5BW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708603676; x=1740139676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYaPaOLExnses+9nv4Y9Jo34xyvgZeuLtCkP2ug5iXc=;
  b=YZ0ty5BWI23BSSLLj8O4SMNoVKCx5rvRTTB7zamNOCoqeHot1fxrjg0h
   AGWs44FPVDt72ddTA66o134BGx1t1hBntmw1e3l7gG6GKlrlmKRaqULgO
   uhBAEMSjcy+Qcy/3r4BGXm2y0GRQqz7Xq6qBOwCnAiq0CZGuc/uBzcjXu
   Mqe2XABv9MhyJfEcwbEVsCjHhouuuQD7XMYV2bEHVUJzu/yldaOUNahei
   +HItjsp0PWiCWROt80AhMFukmPsjfsA0rNLbwitj6p3p+tSgw/ZGi2yHA
   nj31qxM0Dls1SD/7kO79vn7o6oQj6e77vN2VUVmrCyLCwRZ56e8DgibdR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2974040"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2974040"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5843301"
Received: from ksulimow-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.120])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:07:53 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/3] selftests/resctrl: Simplify cleanup in ctrl-c handler
Date: Thu, 22 Feb 2024 13:07:30 +0100
Message-ID: <e84995d79debfa8775a1535a82c6ca637f6891da.1708599491.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
References: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
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
Changelog v3:
- Make current_test static. (Ilpo)
- Add callback NULL pointer guard in ctrl-c handler. (Ilpo)

Changelog v2:
- Remove tests_cleanup() from resctrl.h.
- Make current_test a const pointer only inside resctrl_val.c. (Ilpo)

 tools/testing/selftests/resctrl/resctrl.h       |  3 +--
 tools/testing/selftests/resctrl/resctrl_tests.c | 14 +++-----------
 tools/testing/selftests/resctrl/resctrl_val.c   |  7 +++++--
 3 files changed, 9 insertions(+), 15 deletions(-)

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
index 5a49f07a6c85..0134aa2f896a 100644
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
+	if (current_test->cleanup)
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
-- 
2.43.2


