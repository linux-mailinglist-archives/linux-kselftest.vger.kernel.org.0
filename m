Return-Path: <linux-kselftest+bounces-5025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C78785BCF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADDF283BE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB86A039;
	Tue, 20 Feb 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+dVKl8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C26A030;
	Tue, 20 Feb 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434920; cv=none; b=FFR0ieS/foREuzcct4evMW4AC/Oqd0sYCWlOfcWjsUJ0xX5f7hi3wArkc3v+tFVQvPH1LKxPvtaHZlLDJTaAwCiKCmVEYqgfsqNT1xD4KtCql+mEE5ZwUU2hsc68XtL2ovYGmTWmx1J8NGBa4cbQ/rB8ztTKAtruMsEz09Mrisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434920; c=relaxed/simple;
	bh=is7X7bYYLaNl4Xd9u1Jgp8nNiOY1JjyfGPu5LdGB1Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDsvQNXe+ra/ItAjyXVvMpaWS2ejvo8RMa9lt9Jiy6h9S6N9jMSZUbQKTTKoWA7wcgbxiaZrJBIaFWOvJtHuPrDu6xdrV8nbc1o+IUug/14S6w0cUEamJrPqBdB8XsqHQO6neDE403R63CCXmhem50u6rhWQy+CE83o0DymllSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+dVKl8L; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708434918; x=1739970918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=is7X7bYYLaNl4Xd9u1Jgp8nNiOY1JjyfGPu5LdGB1Mo=;
  b=Q+dVKl8L7XCWwcFZOlcjdjQTaoGVbAzrqNXLejJjvHDP6ZGAi3GmJ9u2
   kGxOGxYT/k1E1po26qoAiedd9C2D85cqJd84gXgxUtRYzslX1cYSZlGsm
   2+7h9py4R/lshgFbnpw4hCmUEPhqjMDsxAwySHHcui+BplSx4cxQJqeyJ
   T8iSLEPVHdvkYluOnMW2ot1KR9Ab+DLfVPwKfNDdv/zOdhCLhC67Z68PB
   2Kl9WJIXAU8LOiiKcdA7yF0ERUzAmiJYzR9DrHOEpf4GL6KwysctpaTIP
   4ZP2WZ84qjZWc9IK/+sjjFrtfoC38UFijZKQKsvdNMZaKX0MfRLiDDdRP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2660634"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2660634"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5131033"
Received: from jmuniak-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.4.63])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:15:15 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests/resctrl: Move cleanups out of individual tests
Date: Tue, 20 Feb 2024 14:14:34 +0100
Message-ID: <63b9763211c2954f0ef517a817b3bf0c482df8cd.1708434017.git.maciej.wieczor-retman@intel.com>
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

Every test calls its cleanup function at the end of it's test function.
After the cleanup function pointer is added to the test framework this
can be simplified to executing the callback function at the end of the
generic test running function.

Make test cleanup functions static and call them from the end of
run_single_test() from the resctrl_test's cleanup function pointer.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 4 +---
 tools/testing/selftests/resctrl/cmt_test.c      | 3 +--
 tools/testing/selftests/resctrl/mba_test.c      | 4 +---
 tools/testing/selftests/resctrl/mbm_test.c      | 4 +---
 tools/testing/selftests/resctrl/resctrl.h       | 4 ----
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
 6 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 2d2f69d3e5b7..ad5ebce65c07 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -128,7 +128,7 @@ static int check_results(struct resctrl_val_param *param, const char *cache_type
 	return fail;
 }
 
-void cat_test_cleanup(void)
+static void cat_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
 }
@@ -289,8 +289,6 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 	ret = check_results(&param, test->resource,
 			    cache_total_size, full_cache_mask, start_mask);
 out:
-	cat_test_cleanup();
-
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 32ddee87e43d..c477f3c9635f 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -91,7 +91,7 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 				 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1, true);
 }
 
-void cmt_test_cleanup(void)
+static void cmt_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
 }
@@ -161,7 +161,6 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
 out:
-	cmt_test_cleanup();
 	free(span_str);
 
 	return ret;
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7cc4067ce930..e4cd484941ec 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -137,7 +137,7 @@ static int check_results(void)
 	return show_mba_info(bw_imc, bw_resc);
 }
 
-void mba_test_cleanup(void)
+static void mba_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
 }
@@ -163,8 +163,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 	ret = check_results();
 
 out:
-	mba_test_cleanup();
-
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 071e2d3808a7..405edd7df816 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -105,7 +105,7 @@ static int mbm_setup(const struct resctrl_test *test,
 	return ret;
 }
 
-void mbm_test_cleanup(void)
+static void mbm_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
 }
@@ -133,8 +133,6 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
 out:
-	mbm_test_cleanup();
-
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 79b45cbeb628..c2a74e11a65e 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -156,8 +156,6 @@ int resctrl_val(const struct resctrl_test *test,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
 void tests_cleanup(void);
-void mbm_test_cleanup(void);
-void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
@@ -166,9 +164,7 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
-void cat_test_cleanup(void);
 unsigned int count_bits(unsigned long n);
-void cmt_test_cleanup(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index b17f7401892c..e01937e798ee 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -142,6 +142,8 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 	}
 
 	ret = test->run_test(test, uparams);
+	if (test->cleanup)
+		test->cleanup();
 	ksft_test_result(!ret, "%s: test\n", test->name);
 
 cleanup:
-- 
2.43.2


