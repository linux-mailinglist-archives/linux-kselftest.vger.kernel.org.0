Return-Path: <linux-kselftest+bounces-23027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEE9E91D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C5618879C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CF3219E85;
	Mon,  9 Dec 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/rPix66"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69620218AA4;
	Mon,  9 Dec 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742600; cv=none; b=BfYxfbb0uIcMmtSzgtM/Nx+oVR3qaekJk3CKUoGCz3EUuptJZSk2+CgQujkrPRLGdqhksVb+f8ex1LK2btQe3JTqxEBXI4Z/v78RtH4M4RCk6PqSUaJBgiaFP9XxyZhvUpnXie7U/Y10mR/ZOk9gCudy/CnvdLvlN1+j62a3/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742600; c=relaxed/simple;
	bh=r3ch+ojo3RH1TXCizG+3QiyAv0pvjJVVUhJu4g5bKBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9XUNqRk4e/NaJ/jzg/XcnTPQZrWmCjDrJhY0u1Ikkg0wdRbuR4G34G0ahglNO5v5AGCx41khXVEHw7OK4CY8+5IfxqQQwuRm1c3X8oxkEyqxEPTP2W+hNupQL1Ckt/T+ViA6U9wz3klXGJEu21gh9+0ftcjWrbm142lb22Il1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/rPix66; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733742599; x=1765278599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3ch+ojo3RH1TXCizG+3QiyAv0pvjJVVUhJu4g5bKBk=;
  b=E/rPix66lpZORwVImarBVQs7eXYMA8A53mp0Lp3rb74ZIxgOuXB1eZL2
   L85PJ62WUsQOTpX607YsQqmUtuR0FbctHUPj04m+BnvJ54R6+DGfiRQ2Y
   upnbVseC6KnKQ9Dal8fne8uutUCykoWkC5MAhjtZdTgAf3NC7LAkERvRP
   +JbCtdudx6XP1XTLxTGfXsADw3wbG7OiksAIf1HlSs+rflv5M6/DZ0a+C
   ++ZoT17gBHp9+qawa5F93xKDjLYdvymnQSY7m2QRdGknHF1nm0LrBtyQH
   UpRPk+ricP36AN6nWw4hAg9LOSmtfCgf4Y5KfPL/8pj84lrRwAqM96Bhy
   g==;
X-CSE-ConnectionGUID: x3rDgzV9T4K1e6wCGvmXvw==
X-CSE-MsgGUID: 1J5UqDmCSFiRQS3XuFBGBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37958213"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="37958213"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:09:58 -0800
X-CSE-ConnectionGUID: QRts8xaNR+i0TRl/v85AmQ==
X-CSE-MsgGUID: 71nQZJAGTyqWvX2ytom+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95384661"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.38])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:09:56 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v7 2/2] selftests/resctrl: Discover SNC kernel support and adjust messages
Date: Mon,  9 Dec 2024 12:09:32 +0100
Message-ID: <ffd4f0609a9edca8e6876c4086331d3d82e3ec3d.1733741950.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
References: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
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
Changelog v7:
- Merge strings with file paths that are saved into node_path variable.

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
index 35fa3afee9c3..cd3adfc14969 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -203,6 +203,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(const struct resctrl_test *test);
 void signal_handler_unregister(void);
 unsigned int count_bits(unsigned long n);
+int snc_kernel_support(void);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index dc7ce3cbdb27..195f04c4d158 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -957,3 +957,35 @@ unsigned int count_bits(unsigned long n)
 
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
+	snprintf(node_path, sizeof(node_path), "%s/%s", RESCTRL_PATH,
+		 "mon_data/mon_L3_00/mon_sub_L3_00");
+
+	if (!stat(node_path, &statbuf))
+		return 1;
+
+	return 0;
+}
-- 
2.47.1


