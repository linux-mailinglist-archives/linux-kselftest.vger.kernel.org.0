Return-Path: <linux-kselftest+bounces-5475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461EC8689C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 08:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B3E1C21E2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF2855775;
	Tue, 27 Feb 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y27B1R4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17E54BC1;
	Tue, 27 Feb 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018526; cv=none; b=V+nb39lJoKAFEb0iOgt+Bkvxm7Zr0/F2Y0yK52G7BEi+XZaCxUO6NrXOFcFNG+TR2oB4HLfv54P4ahSzQYUZK33yEpGf1uXVd6abGcT/xO/nqNhf+bAz1Suh/yY+v1VqY+phwjTS4uljhi1/QwGS3Kj93k7kmv8LitVKV31Agzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018526; c=relaxed/simple;
	bh=uDgP2vcohTC7g1Pcj5ZE98Wu6OuxK5wx6e35I3V2EtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSjlhl4c1Of157TwLpQKfggQ72m2iAU+FLuONm1N1Uvsbmvn4MYcexHecvFnxHHDiCn1ZS/PfgZftz4EmkCHqiQVpNVTkJA1N7pkCLhUm+MXmkr1wBtWwjh4YmKblo3RZE/5PqdtMLQ+8DEvLQ0RvN0yTO6qHJ4llKqxoeE/trQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y27B1R4o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709018525; x=1740554525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uDgP2vcohTC7g1Pcj5ZE98Wu6OuxK5wx6e35I3V2EtM=;
  b=Y27B1R4oIi1v+9SjB0QKuXuKgVks173RkxBOMtq4g/iQuFoxj36RRn/T
   hL8ip6JHSC1kZex6hUGxwcc2gku0qO4CsucKkUlBZsFcaqZ9SdCt0jloi
   N+XC5CiPhnM1IChs6oYETWHwtCJGhHRUv08yxrJk7+20fk+kkMtKhzp6j
   yK90lzrHZknjDRlLi9vegB9XRiEtYD7xd26VWuvWDYYHKNQ8G2X7ysrwn
   z5jXzQih93oJeZ+ys4qPlThdwjjWyBiCrflS0wey522jwDMF6KxFGve0b
   gXi+UNGtajCIZTsVklA4Nlw9cb53BsQXjGO8p8NufTrtYUksFn/X6yYvl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3508448"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3508448"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6910298"
Received: from lzaleski-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.4.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:22:01 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 2/3] selftests/resctrl: Simplify cleanup in ctrl-c handler
Date: Tue, 27 Feb 2024 08:21:42 +0100
Message-ID: <d32d722cca9a2c689e749e614e818486cafb6250.1709018050.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
References: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v5:
- Rebased onto kselftests/next.
- Add Reinette's reviewed-by tag.

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
index 221c94532733..bc486f92aceb 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -158,7 +158,6 @@ int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
-void tests_cleanup(void);
 void mbm_test_cleanup(void);
 void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
@@ -168,7 +167,7 @@ int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
-int signal_handler_register(void);
+int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 void cat_test_cleanup(void);
 unsigned int count_bits(unsigned long n);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f3dc1b9696e7..0590daec2f44 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -81,19 +81,11 @@ static void cmd_help(void)
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
@@ -136,7 +128,7 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 
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


