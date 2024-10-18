Return-Path: <linux-kselftest+bounces-20088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E19A32B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B2FB23413
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA9F17C21B;
	Fri, 18 Oct 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2Y08xqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72014F136;
	Fri, 18 Oct 2024 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218160; cv=none; b=X4ZmOUemESxpH+H2dE84WEW6tlZ3G63cq97YfSbg+NLvisA4tVCaA71dQEDCNLKDW/z0fwnwfCxdubAmSr7v3/9t+Cg5w6vfAiFvVAGEa+ZFDnrLAX5eebHJjTVSZLcV9WU+GViXqm52Lopmddns2eOn5yupm+tLp97FUFc/Rh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218160; c=relaxed/simple;
	bh=RQwgwAvH1yN3WgCkSsFG9U5A6uInT75JDIW0Wm5kvAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTrnkrptwETctMGJuj1aL4w8edVwG8NTxNtGdlOb3T+v/rVzzE/cpQO97VPiYw2abMK2yL/Emy/JBkJLNp7V75R2cuGmfr9Hsgu5bc0irt6XRZHldQcGLgscTWnIG9bdy2rpVDoSUvK54UYwxJ1w9tyzpnwXTMWJIOMON61rr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2Y08xqy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218159; x=1760754159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RQwgwAvH1yN3WgCkSsFG9U5A6uInT75JDIW0Wm5kvAI=;
  b=C2Y08xqy8wVF+zc05OlsLN1KdhynfZFccQnzVTReoDKGohzUt6PEEfTp
   WoeXsTbuxqenQ6sTkw0adT7SSphQQb3OJBiVRTcfGxzEXchPUfDsqmtaW
   GBgrOMflRQTVZUgk/kgAGVph/2E+Ob5pvm95S5oB8B0FFCIJRFDxfJ/pL
   tCO2d9BY0/miNj3KzMnu+M8Y/id/FYZOQsujgnBfVQ+55hrTpXBb7hOWH
   MLqQWx7jNdKDUod3dxmZXK+VfJ7aVF1DErPcaXsVUnxpWjOoBHE8xBdkp
   6+84km4a7QkET9daz4OpLIh+HFVxmkABY3TGyyPwTgLnL2J4yovKWxYd0
   g==;
X-CSE-ConnectionGUID: jODhIKreRj+e9Y+Lg3t5xw==
X-CSE-MsgGUID: 9GfiYav+QsGFm5aGsCk6mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149673"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149673"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
X-CSE-ConnectionGUID: KZhemtkoQjeZ7UzJNcRgeA==
X-CSE-MsgGUID: seUgJXrCRw+kT529DcBUNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697701"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:36 -0700
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
Subject: [PATCH V3 02/15] selftests/resctrl: Print accurate buffer size as part of MBM results
Date: Thu, 17 Oct 2024 19:33:17 -0700
Message-ID: <f7c200b42bf514e587e88e5be6e866fa797eed66.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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

Changes since V2:
- Make user input checks more robust. (Ilpo)

Changes since V1:
- New patch.
---
 tools/testing/selftests/resctrl/mbm_test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..36ae29a03784 100644
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
+			if (errno || *endptr != '\0')
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
2.46.2


