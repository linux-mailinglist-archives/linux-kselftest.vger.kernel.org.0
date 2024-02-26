Return-Path: <linux-kselftest+bounces-5438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169E86763B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 14:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2AC2B26F7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409684A3A;
	Mon, 26 Feb 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTT5wpb5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FCA81756;
	Mon, 26 Feb 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952830; cv=none; b=h0cNBJ1Br/ZJrkCCfMwdug82ViruDyf/0sAvOyE+ieccuFJ++HmevOrero8QsayDPpglSLJK+OSuPmtp+R/YSf1N6EFV6OcJ3wT78I4rj1bjt9bIIpwNY9AZhRBjLt50VW1DpQ3vO46YtcA6hlg85LjpVn+ieKwEsWM6tCSHHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952830; c=relaxed/simple;
	bh=bx31a6Hgu3PNfIf12RI+wbdyS9Wxxa8ztr0P7NRK8fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsEOhSQ/d58FOeyCE8d00uOhhsoByxTliI1KmFEoNNT58CixCnGqskbB3JXpeyiAGO3SgdkWOxfI3Wf86IkJS2Yrjlq3jNlEDWdGh9ldABhBeVDu2sblXlGlwnYhZoHHg32sm8vHcKWj6h7YbsRdF1xTpBZH15DkMyqNRTI7IhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTT5wpb5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708952829; x=1740488829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bx31a6Hgu3PNfIf12RI+wbdyS9Wxxa8ztr0P7NRK8fU=;
  b=KTT5wpb5/eOsLGz0ekkZb7eQZ553nhge/5ozR2Wg/2a9Ppuh0NeP4bAr
   2Jf+R0wdyCxoiu8zNrbfRFUcXq8l29gt8sUwoSH+WOxjLqoxvfw1d6nZy
   zqtgr0tiKXm6eRlItFPu4tAc/tjTIECNAlO4M5+j8PrqZreAVYTCzIGYy
   FfO9QdTzAndvSu64ZZX63rP3aeC0zo7FL9+2q+wiDfRPAAMpWxLkQhiSP
   muxoTOsEKxdQFTpJJyzoZE7vNQZmeDx3glBeqx8XV02cERRfkVPpaygwD
   ovpJI8WBYHAUH77ZkMXx7+h8e6/Ur1HmSWCiLdY14ztpjoDKI22WD2qOq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14669214"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14669214"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6586267"
Received: from pkwiatko-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:06:40 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 3/3] selftests/resctrl: Move cleanups out of individual tests
Date: Mon, 26 Feb 2024 14:05:50 +0100
Message-ID: <ef48cf79fb4ef464e78294240e781d2987811385.1708949785.git.maciej.wieczor-retman@intel.com>
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

Every test calls its cleanup function at the end of it's test function.
After the cleanup function pointer is added to the test framework this
can be simplified to executing the callback function at the end of the
generic test running function.

Make test cleanup functions static and call them from the end of
run_single_test() from the resctrl_test's cleanup function pointer.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v4:
- Move cleanup call to test_cleanup(). (Reinette)

Changelog v2:
- Change most goto out paths into return ret. (Ilpo)

 tools/testing/selftests/resctrl/cat_test.c      | 7 ++-----
 tools/testing/selftests/resctrl/cmt_test.c      | 3 +--
 tools/testing/selftests/resctrl/mba_test.c      | 7 ++-----
 tools/testing/selftests/resctrl/mbm_test.c      | 7 ++-----
 tools/testing/selftests/resctrl/resctrl.h       | 4 ----
 tools/testing/selftests/resctrl/resctrl_tests.c | 6 ++++--
 6 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 2d2f69d3e5b7..1d1efed6164e 100644
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
@@ -284,13 +284,10 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 	ret = cat_test(test, uparams, &param, span, start_mask);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = check_results(&param, test->resource,
 			    cache_total_size, full_cache_mask, start_mask);
-out:
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
index 7cc4067ce930..a2f81d900900 100644
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
@@ -158,13 +158,10 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 
 	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = check_results();
 
-out:
-	mba_test_cleanup();
-
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 071e2d3808a7..6589154c102e 100644
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
@@ -126,15 +126,12 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 
 	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = check_results(DEFAULT_SPAN);
 	if (ret && (get_vendor() == ARCH_INTEL))
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-out:
-	mbm_test_cleanup();
-
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 826783b29c9d..428ce9174384 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -153,8 +153,6 @@ int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
-void mbm_test_cleanup(void);
-void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
@@ -163,9 +161,7 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
-void cat_test_cleanup(void);
 unsigned int count_bits(unsigned long n);
-void cmt_test_cleanup(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 161f5365b4f0..4c902cf80c49 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -94,8 +94,10 @@ static int test_prepare(const struct resctrl_test *test)
 	return 0;
 }
 
-static void test_cleanup(void)
+static void test_cleanup(const struct resctrl_test *test)
 {
+	if (test->cleanup)
+		test->cleanup();
 	umount_resctrlfs();
 	signal_handler_unregister();
 }
@@ -137,7 +139,7 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 	ksft_test_result(!ret, "%s: test\n", test->name);
 
 cleanup:
-	test_cleanup();
+	test_cleanup(test);
 }
 
 static void init_user_params(struct user_params *uparams)
-- 
2.43.2


