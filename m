Return-Path: <linux-kselftest+bounces-5024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F885BCF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D76B2152E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F76A331;
	Tue, 20 Feb 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ke3pfWy1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DD6A330;
	Tue, 20 Feb 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434905; cv=none; b=J8QcGXICD19XRz5Dd6OXUnvvOzOyUIN/gQmkX4r4zbEj93HMHvcBdSyNXpqLzRPf40vNFpoRGXuTB1l6qzLf+9hd7oIWcWXMwxX19V135LA05gt1f9HusFYJ/U3Fk18OZWrA4TPhgskbPpt/1o5b1DuPA+VEoVyJjWFInZN2dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434905; c=relaxed/simple;
	bh=v3wRrQUnwDGEEcD6kai4bnghYWPZ35GmgQAO7Rp1/68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmz0mmOIS+TOXI6SFk5E5oGSSg+ltlc8FBFDHosoQ9+WayyJoabxdBpiNO1w8P4MpyVFul78lfn5ABDZp12/g7q9SXRus+0C9y9Wqb1Orm6DRASLG5rQkPd3R/1OfZYkuTWpJZ1VPxxUtwcwHrVZc2r+UAtQA4euS+dHqvDv/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ke3pfWy1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708434904; x=1739970904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3wRrQUnwDGEEcD6kai4bnghYWPZ35GmgQAO7Rp1/68=;
  b=ke3pfWy1TLuoDDwQ1lR2mvxzr6ppA4Yqwl9tkMuH5d1Yk3+tvViJOED7
   Aw7EPEuT5vw/6HaWvl0RX4evRkNnEAsVgUWhAZsfPogUSMN9ED75CWOrw
   zvYIcHCR7qhssYMNH7McYVcSMpVjpyg4uKMTUD5fkcSFf39yD7kvpNPs1
   11aJovEHFlZNS1obJwLJH+Pt6EVkuNddunplvoxHEIaLlw4ByJ8aAlsrD
   CW7E9cigv1a3665WhWTpR3sVGHN63B95BHeWVKYrgcWOza5ZT89NHIFZx
   fhwUxltsLHe6rG+ufLkXHrV+t5uJDXMquMXSqlauWubBT/9zf/12u7bOf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2660621"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2660621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5130974"
Received: from jmuniak-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.4.63])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:15:01 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftests/resctrl: Simplify cleanup in ctrl-c handler
Date: Tue, 20 Feb 2024 14:14:33 +0100
Message-ID: <8c4fcfb6b4e38a0f0e400be88ecf1af0d20e12e7.1708434017.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708434017.git.maciej.wieczor-retman@intel.com>
References: <cover.1708434017.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ctrl-c handler isn't aware of what test is currently running. Because of
that it executes all cleanups even if they aren't necessary. Since the
ctrl-c handler uses the sigaction system no parameters can be passed
to it as function arguments.

Add a global variable to make ctrl-c handler aware of the currently run
test and only execute the correct cleanup callback.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 ++
 .../testing/selftests/resctrl/resctrl_tests.c | 20 +++++++++----------
 tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 0f49df4961ea..79b45cbeb628 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -128,6 +128,8 @@ extern pid_t bm_pid, ppid;
 
 extern char llc_occup_path[1024];
 
+extern struct resctrl_test current_test;
+
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 75fc49ba3efb..b17f7401892c 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -14,6 +14,12 @@
 static volatile int sink_target;
 volatile int *value_sink = &sink_target;
 
+/*
+ * Set during test preparation for the cleanup function pointer used in
+ * ctrl-c sa_sigaction
+ */
+struct resctrl_test current_test;
+
 static struct resctrl_test *resctrl_tests[] = {
 	&mbm_test,
 	&mba_test,
@@ -75,18 +81,12 @@ static void cmd_help(void)
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
 
+	current_test = *test;
+
 	res = signal_handler_register();
 	if (res) {
 		ksft_print_msg("Failed to register signal handler\n");
@@ -130,7 +130,7 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 
 	ksft_print_msg("Starting %s test ...\n", test->name);
 
-	if (test_prepare()) {
+	if (test_prepare(test)) {
 		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5a49f07a6c85..db6aac33ced1 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -472,7 +472,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	if (bm_pid)
 		kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
-	tests_cleanup();
+	current_test.cleanup();
 	ksft_print_msg("Ending\n\n");
 
 	exit(EXIT_SUCCESS);
-- 
2.43.2


