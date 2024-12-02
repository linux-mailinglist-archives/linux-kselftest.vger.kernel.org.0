Return-Path: <linux-kselftest+bounces-22668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767899DFFC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 12:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38743281773
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430271FCFF3;
	Mon,  2 Dec 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtOh1Zfn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398311FCFE7;
	Mon,  2 Dec 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137740; cv=none; b=uVT/zmyGRYlRfLCAHsslSWgghkN7znGsDlYWj/ai38XdsgDu0uPwmh/xNMyw5RazDYKgdRp4/bgUxZojiOPT66SAdF2idmXsPjlyaBsn1GfENdfAh/JJm3C/5rO/0GpoGzWpKGcK7CTdRSsCkjvcBmlqBCDkJT1iyP0EDNBxe8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137740; c=relaxed/simple;
	bh=at//qM/YFMQGTbDA34HJdPgRhqXrmHXaNFIPcP6Ayls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2MCApq4u8zZfF3AYKuhly7oMOIZDtVE1ZzgjasiAad3y4QHTr9oUzK1aFYVHbooAlfIrZWhnPHr93NnKGdyw7LIaau6Ry1xUf3gD3ypybwroS5TcQjqvRwRjG6czRPhLew3caNGHKaacioenK/6qfi57JOJAd79Meekz+yeIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtOh1Zfn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733137739; x=1764673739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=at//qM/YFMQGTbDA34HJdPgRhqXrmHXaNFIPcP6Ayls=;
  b=YtOh1Zfn8xMmiTD4QnfgHDy2zZRT8W+PVsPaDReacMkyYQxSkEfIyP1o
   /kt9WZ+kHrn17CbOSsVqxS7yYdNqh8oN438Qgs4icSWYWdtSEjF0gC/oY
   2c/Yyw3MP98+tJQEleBQh46NrHfDrzIHhwJLIrcluSptuMlIP8gjORikT
   IswRa9acqRDYfhT1ARGZB2xexmt7OJCzJfrpI9IgigD0LHiKa02Zy4aT8
   +ioBQFrpkvDPtXl957zHe8CDEs5e01zD2REUTU9I5DLsKN6JjNnA4NdE7
   gyqmefTQHnm+heFPescjiT8Jn+NNQiTcADBB6s2E8I4U7wgcuO6PAgdK8
   Q==;
X-CSE-ConnectionGUID: 0x+IMBLVSWSKn5nSW6txvg==
X-CSE-MsgGUID: ACl451fQQd+e5HczW7SIMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="33452323"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33452323"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 03:08:58 -0800
X-CSE-ConnectionGUID: 1rAJNp8aSWuqgzgvc+dsHA==
X-CSE-MsgGUID: sS4Qgx5dTQuYXycpgkSYug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="130556176"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 03:08:55 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v6 2/2] selftests/resctrl: Discover SNC kernel support and adjust messages
Date: Mon,  2 Dec 2024 12:08:43 +0100
Message-ID: <6b0fee7f5d97f8140442a73ecdd50429cd697938.1733136454.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733136454.git.maciej.wieczor-retman@intel.com>
References: <cover.1733136454.git.maciej.wieczor-retman@intel.com>
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

When there is SNC support for kernel's resctrl subsystem and SNC is
enabled then sub node files are created for each node in the resctrlfs.
The sub node files exist in each regular node's L3 monitoring directory.
The reliable path to check for existence of sub node files is
/sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.

Add helper that checks for mon_sub_L3_00 existence.

Correct old messages to account for kernel support of SNC in
resctrl.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v6:
- Remove snc_unreliable checks at the end of the tests since now the
  tests are skipped if snc_unreliable was set.
- Move snc_kernel_support() back to this patch since it's not used in
  the previous patch anymore.
- Redo the patch message after code changes.

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

 tools/testing/selftests/resctrl/cmt_test.c  |  4 +--
 tools/testing/selftests/resctrl/mba_test.c  |  2 ++
 tools/testing/selftests/resctrl/mbm_test.c  |  4 +--
 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 32 +++++++++++++++++++++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 3bbf3042fb06..d09e693dc739 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -169,8 +169,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results(&param, span, n);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 536d9089d2f6..c7e9adc0368f 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -201,6 +201,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results();
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 315b2ef3b3bc..84d8bc250539 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -160,8 +160,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		return ret;
 
 	ret = check_results(param.fill_buf ? param.fill_buf->buf_size : 0);
-	if (ret && (get_vendor() == ARCH_INTEL))
-		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
+		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 38dfe5a03fcd..560171f66332 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -202,6 +202,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 unsigned int count_bits(unsigned long n);
+int snc_kernel_support(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 50561993d37c..d0a5c0f78397 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -949,3 +949,35 @@ unsigned int count_bits(unsigned long n)
 
 	return count;
 }
+
+/**
+ * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
+ * SNC resctrl support on the kernel side.
+ *
+ * Return: 0 if not supported, 1 if SNC is disabled or SNC discovery is
+ * unreliable or SNC is both enabled and supported.
+ */
+int snc_kernel_support(void)
+{
+	char node_path[PATH_MAX];
+	struct stat statbuf;
+	int ret;
+
+	ret = snc_nodes_per_l3_cache();
+	/*
+	 * If SNC is disabled then its kernel support isn't important. If SNC
+	 * got disabled because the discovery process was unreliable the
+	 * snc_unreliable variable was set. It can be used to verify the SNC
+	 * discovery reliability elsewhere in the selftest.
+	 */
+	if (ret == 1)
+		return ret;
+
+	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
+		 "mon_L3_00/mon_sub_L3_00");
+
+	if (!stat(node_path, &statbuf))
+		return 1;
+
+	return 0;
+}
-- 
2.47.1


