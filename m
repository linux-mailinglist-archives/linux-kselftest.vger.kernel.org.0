Return-Path: <linux-kselftest+bounces-5476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0D8689C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 08:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D2F1C21DD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9055789;
	Tue, 27 Feb 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyeNCJE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED954BDA;
	Tue, 27 Feb 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018534; cv=none; b=pvhZ71aa9sOFCB6DgJAnXFFVF6fnkAWD9Qfkhmtdo3sxW71lcRzwwbvUJxD+ox/5ZEx67pmwVeuYmqh2+irOfMS0J16fCMUteLPEfLkRhgpcpPx76t5ViVfJjWhv1QS5tWV9vS6F5g3OPL3R7pDc8T3TyDcVallB9Tzr0K9Cs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018534; c=relaxed/simple;
	bh=viarXyJsBylIM8v5zIxRYRLRIJ/5CzGbczuuN/R7kj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf7HKJZ3EWEiQw3WHbbpAjUzSIRADs9nFi11QkbGLJz9fHIcmfCfLbh7fPMggEC22ZDNFhrKWqm6hTKS/Yebz37soImBnqO0wcOez2UglSoqDSlQ67erAV891HP88LZqzXmIsQ2uU5XEBK3k/uuXEkr/iSO6QmUR/MX0492kw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyeNCJE3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709018533; x=1740554533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=viarXyJsBylIM8v5zIxRYRLRIJ/5CzGbczuuN/R7kj0=;
  b=YyeNCJE3DlA/xCCQSefq7GKAZ6sW0tPmaMCSGdtJUD8ZTKoHwLJmL+1h
   gke8GV+bb1JyH8L/uruQ9y9yRU9FdHr1TM5FR+Qtqqo0kTXc7/AfsdCy9
   WSyoE/z+iy7JqjELhvkKMN2c/C5ai4YOGAjp2PH9EQfiQGRtVwL9AhyhG
   0J3LiX96vfr8AaBY17mWSHGjwI/M1Dt98Arg+qrOp07CXoU+4kWutp7xJ
   i1ajHW9Pn2RQv0/ZA0STWDy6A1pcLUS19dqbrmAgQ6KeGl+zQJ9xirNKu
   88G1vi5oqzo4IQxV4bwLAEL1eEkf2PK1IdpRrv/gfspRepOVWzpBZkb3Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3508454"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3508454"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6910327"
Received: from lzaleski-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.4.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:22:09 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 3/3] selftests/resctrl: Move cleanups out of individual tests
Date: Tue, 27 Feb 2024 08:21:43 +0100
Message-ID: <e596cf36058d88f147fd8fcbf399c8eebf25bcd5.1709018050.git.maciej.wieczor-retman@intel.com>
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

Every test calls its cleanup function at the end of it's test function.
After the cleanup function pointer is added to the test framework this
can be simplified to executing the callback function at the end of the
generic test running function.

Make test cleanup functions static and call them from the end of
run_single_test() from the resctrl_test's cleanup function pointer.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v5:
- Rebased onto kselftests/next.
- Add Reinette's reviewed-by tag.

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
index 8fa4348ab461..c7686fb6641a 100644
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
index a01ccf86e6ce..a44e6fcd37b7 100644
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
index 189fbe20dc7b..5d6af9e8afed 100644
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
index 73d6a8b989f5..3059ccc51a5a 100644
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
index bc486f92aceb..00d51fa7531c 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -158,8 +158,6 @@ int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
-void mbm_test_cleanup(void);
-void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
@@ -169,9 +167,7 @@ int resource_info_unsigned_get(const char *resource, const char *filename, unsig
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
-void cat_test_cleanup(void);
 unsigned int count_bits(unsigned long n);
-void cmt_test_cleanup(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 0590daec2f44..348d17cb2a84 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -100,8 +100,10 @@ static int test_prepare(const struct resctrl_test *test)
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
@@ -143,7 +145,7 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
 	ksft_test_result(!ret, "%s: test\n", test->name);
 
 cleanup:
-	test_cleanup();
+	test_cleanup(test);
 }
 
 static void init_user_params(struct user_params *uparams)
-- 
2.43.2


