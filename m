Return-Path: <linux-kselftest+bounces-17855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E32976FFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776DE1C23B39
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7124F1BFDFC;
	Thu, 12 Sep 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO4qSKY2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFABE1BE84E;
	Thu, 12 Sep 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164296; cv=none; b=TB5NZ5ajYq/oP0e1PK8dxGja+Gy85MfdErZcvkpXOMjGs0QCCozqT/wwKddZfs5WkIsVlNmOX6Fz6BpNaYI/drPYU3lFNQowJ4+dkjRKz1zNGA5edsnPuZBlNY01NoG4Bf8fJVJXx3FCEK628TtZrBmz+foB1eaY0Q17ZgCJDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164296; c=relaxed/simple;
	bh=GekzePbD6SC0PRV60y9gwrgEA4v1IP+CNeWjInB00S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjhvFQHct5JymLac+I91dRqZcvmamMtJunZvwfH5rwqFXZrVMuZNh64+cqSTSxpNYO7aOfpApiyWwl97w3nECDz/Kx34isj+FtSrdKgNT2XWObcIBiqrj0NQ0SW8E5dAN67kYF2NtpGDskIOytieT4vPNLYbac192POP1xboDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO4qSKY2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164295; x=1757700295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GekzePbD6SC0PRV60y9gwrgEA4v1IP+CNeWjInB00S4=;
  b=TO4qSKY22p6KUU9at0hrIfU6YfySGf1W8kUe/RAIoW29mRGf1oXRS3sP
   Q6DhNWGkT7yegrcTcfJKMoLk2QOYbO96h/U1bfg39ag2oir4kSJEHaFuh
   xsSdwQo0HNZ9Vx1lDa6CYo75dQIDiyWYm6XGwH8MmAhHxOlu8XYj+P0o7
   pavOrqpe8Peo4ebTlObhG4qM6Rp/eQpYsyGBsLnQ/FKu2Inl+a+s0LHLN
   By+kUMz1Jj0y3d4Vm0dTqtjcdhuCJEI24/3SWiTIhS0Tci8zlPKqRT9Sc
   mrpgEM/fzCV2zfHN4db0eHpKCfTAZMorkW6Bzu/Q1RzxkTHVJKbrA1iqn
   Q==;
X-CSE-ConnectionGUID: 5N2zQF7hSsyGOsh4u2hiNA==
X-CSE-MsgGUID: z0+Nd7rPTxiuIjPOWTdaBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976577"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976577"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
X-CSE-ConnectionGUID: Dg6C74eeQomnptQoLqOtSA==
X-CSE-MsgGUID: FSpxpPrYTousJH6a1cjeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724603"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/13] selftests/resctrl: Print accurate buffer size as part of MBM results
Date: Thu, 12 Sep 2024 11:13:51 -0700
Message-ID: <61a16518b9c2e43276bd0a7356bc064b94c1af87.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default the MBM test uses the "fill_buf" benchmark to keep reading
from a buffer with size DEFAULT_SPAN while measuring memory bandwidth.
User space can provide an alternate benchmark or amend the size of
the buffer "fill_buf" should use.

Analysis of the MBM measurements do not require that a buffer be used
and thus do not require knowing the size of the buffer if it was used
during testing. Even so, the buffer size is printed as informational
as part of the MBM test results. What is printed as buffer size is
hardcoded as DEFAULT_SPAN, even if the test relied on another benchmark
(that may or may not use a buffer) or if user space amended the buffer
size.

Ensure that accurate buffer size is printed when using "fill_buf"
benchmark and omit the buffer size information if another benchmark
is used.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Backporting is not recommended. Backporting this fix will be
a challenge with all the refactoring done since then. This issue
does not impact default tests and there is no sign that
folks run these tests with anything but the defaults. This issue is
also minor since it does not impact actual test runs or results,
just the information printed during a test run.

Changes since V1:
- New patch.
---
 tools/testing/selftests/resctrl/mbm_test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..80c7a1bc13b8 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -40,7 +40,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 	ksft_print_msg("%s Check MBM diff within %d%%\n",
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
-	ksft_print_msg("Span (MB): %zu\n", span / MB);
+	if (span)
+		ksft_print_msg("Span (MB): %zu\n", span / MB);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 
@@ -138,15 +139,26 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
 	};
+	char *endptr = NULL;
+	size_t span = 0;
 	int ret;
 
 	remove(RESULT_FILE_NAME);
 
+	if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "fill_buf") == 0) {
+		if (uparams->benchmark_cmd[1]) {
+			errno = 0;
+			span = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
+			if (errno || uparams->benchmark_cmd[1] == endptr)
+				return -errno;
+		}
+	}
+
 	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		return ret;
 
-	ret = check_results(DEFAULT_SPAN);
+	ret = check_results(span);
 	if (ret && (get_vendor() == ARCH_INTEL))
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-- 
2.46.0


