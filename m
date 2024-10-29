Return-Path: <linux-kselftest+bounces-20955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E49B4A74
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9D92843EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF520650E;
	Tue, 29 Oct 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2W0luUt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078C2064FD;
	Tue, 29 Oct 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206844; cv=none; b=FOoUWhfuGymB7oEP45kZA4dRDvRPPgy6V96xxsHKxehC/Mz6MIK86ueD8rxynPenPDxCd1uxoA7LRb4yYAuJo+eymQJ9MJE37dmrvLMN6uP9UGAVMkHc08p8F+RZeIoE2SSueSpwZPM5XAoIim9OnQ1cNZhqO8Pzb8mxURcjOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206844; c=relaxed/simple;
	bh=NlGCxJtvSDZcc48LjMfcWH/FamyvO+HfkSx5n+s2kdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rer6/cLIO6kqUJfb4BfXLDp5FO38ED4eOwJOgOZV/eUV6kg6zoG4YzjTSBBRQMutXE43wtkGdcC25yYSDtxCJ+tEvTHGv9rSs0+tdCpud/tRuW81d+9gk3MtQSUuTsZ+tnDQkkGwGvQAl8RN8tQC7Eovx2Sd5zR4cbHbUDBpP+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2W0luUt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730206842; x=1761742842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlGCxJtvSDZcc48LjMfcWH/FamyvO+HfkSx5n+s2kdU=;
  b=F2W0luUty4KmqxGZDEXYlpk6U2AhwvV4po4nKMWZFlD2Am4mqzC7cJV9
   4ZzFM9WQfiRQiQxp6GLdgOwqgUToelvkcKXR/8jrK2o5t8a+MMlfh7ldY
   WKa5W2eRGk0O9lUADf5nUoga1uRbH3PIJdz1ozVUfxPw+YZiOOBQUkwOo
   aPLICJANa124xgnvdoFiaQ8epJ0L6jpKfWdqdEWWEEmJu9tnMCB02+5ZO
   zXlA1YFP585fMxwQR4jl00u+K0sl2LgwapnhiBIcDzE2+ZWYd3yiONzFn
   SSN8tQff1XYnb+pleBuhko5CU3/Vn1aoj+EGGnE9vgJ/pKVkjLKQbH8nq
   w==;
X-CSE-ConnectionGUID: sr/955+dSge1mj5SNmNEIQ==
X-CSE-MsgGUID: 9jamUg4vSp2F0pqMwuvxVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29952539"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29952539"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 06:00:42 -0700
X-CSE-ConnectionGUID: 6FcZ6JbZQwSsHJ8aGw+Ttg==
X-CSE-MsgGUID: +4YvNJWcTcedKOOGoxlxJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81584713"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.38])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 06:00:39 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v5 2/2] selftests/resctrl: Adjust SNC support messages
Date: Tue, 29 Oct 2024 14:00:29 +0100
Message-ID: <adeb1b7d2998bba69d1a57e38300f83e646ee849.1730206468.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
References: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl selftest prints a message on test failure that Sub-Numa
Clustering (SNC) could be enabled and points the user to check their BIOS
settings. No actual check is performed before printing that message so
it is not very accurate in pinpointing a problem.

Figuring out if SNC is enabled is only one part of the problem, the
others being whether the detected SNC mode is reliable and whether the
kernel supports SNC in resctrl.

When there is SNC support for kernel's resctrl subsystem and SNC is
enabled then sub node files are created for each node in the resctrlfs.
The sub node files exist in each regular node's L3 monitoring directory.
The reliable path to check for existence of sub node files is
/sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.

To check if SNC detection is reliable one can check the
/sys/devices/system/cpu/offline file. If it's empty, it means all cores
are operational and the ratio should be calculated correctly. If it has
any contents, it means the detected SNC mode can't be trusted and should
be disabled.

Add helpers for all operations mentioned above.

Detect SNC mode once and let other tests inherit that information.

Add messages to alert the user when SNC detection could return incorrect
results. Correct old messages to account for kernel support of SNC in
resctrl.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v5:
- Move all resctrlfs.c code from this patch to 1/2. (Reinette)
- Remove kernel support check and error message from CAT since it can't
  be happen.
- Remove snc checks in CAT since snc doesn't affect it here.
- Skip MBM, MBA and CMT tests if snc is unreliable.

Changelog v4:
- Change messages at the end of tests and at the start of
  run_single_test. (Reinette)
- Add messages at the end of CAT since it can also fail due to enabled
  SNC + lack of kernel support.
- Remove snc_mode global variable. (Reinette)
- Fix wrong description of snc_kernel_support(). (Reinette)
- Move call to cpus_offline_empty() into snc_nodes_per_l3_cache() so the
  whole detection flow is in one place as discussed. (Reinette)

Changelog v3:
- Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
- Add printing the discovered SNC mode. (Reinette)
- Change method of kernel support discovery from cache sizes to
  existance of sub node files.
- Check if SNC detection is unreliable.
- Move SNC detection to only the first run_single_test() instead on
  error at the end of test runs.
- Add global value to remind user at the end of relevant tests if SNC
  detection was found to be unreliable.
- Redo the patch message after the changes.

Changelog v2:
- Move snc_ways() checks from individual tests into
  snc_kernel_support().
- Write better comment for snc_kernel_support().

 tools/testing/selftests/resctrl/cmt_test.c |  8 ++++++--
 tools/testing/selftests/resctrl/mba_test.c |  8 +++++++-
 tools/testing/selftests/resctrl/mbm_test.c | 10 +++++++---
 tools/testing/selftests/resctrl/resctrl.h  |  3 +++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 0c045080d808..1470bd64d158 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -133,6 +133,10 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
 	if (ret)
 		return ret;
+
+	if ((get_vendor() == ARCH_INTEL) && snc_unreliable)
+		ksft_exit_skip("Sub-NUMA Clustering could not be detected properly. Skipping...\n");
+
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
 
 	count_of_bits = count_bits(long_mask);
@@ -175,8 +179,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		goto out;
 
 	ret = check_results(&param, span, n);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
 
 out:
 	free(span_str);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ab8496a4925b..8f4e198da047 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -170,15 +170,21 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		.setup		= mba_setup,
 		.measure	= mba_measure,
 	};
-	int ret;
+	int ret, snc_support;
 
 	remove(RESULT_FILE_NAME);
 
+	snc_support = snc_kernel_support();
+	if ((get_vendor() == ARCH_INTEL) && snc_unreliable)
+		ksft_exit_skip("Sub-NUMA Clustering could not be detected properly. Skipping...\n");
+
 	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		return ret;
 
 	ret = check_results();
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_support)
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..a68f70589b91 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -138,17 +138,21 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
 	};
-	int ret;
+	int ret, snc_support;
 
 	remove(RESULT_FILE_NAME);
 
+	snc_support = snc_kernel_support();
+	if ((get_vendor() == ARCH_INTEL) && snc_unreliable)
+		ksft_exit_skip("Sub-NUMA Clustering could not be detected properly. Skipping...\n");
+
 	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		return ret;
 
 	ret = check_results(DEFAULT_SPAN);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_support)
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 851b37c9c38a..488bdca01e4f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -121,6 +121,8 @@ struct perf_event_read {
  */
 extern volatile int *value_sink;
 
+extern int snc_unreliable;
+
 extern char llc_occup_path[1024];
 
 int snc_nodes_per_l3_cache(void);
@@ -167,6 +169,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 unsigned int count_bits(unsigned long n);
+int snc_kernel_support(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
-- 
2.46.2


