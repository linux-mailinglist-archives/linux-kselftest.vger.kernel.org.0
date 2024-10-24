Return-Path: <linux-kselftest+bounces-20576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6589AF44D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585C7B21BB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43042218312;
	Thu, 24 Oct 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQZFOO7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCA217320;
	Thu, 24 Oct 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804086; cv=none; b=PewbFIER81RetIwKC5EfxB/E8wUq9AKQRYT8aCxJPW9sudXN22DuxBDHDc72tdzNUvXbqwD6r5PDH5YipLovhoWYR9Y5ZPTJixnwF/1FfU4PkU3JaKpISjLorwt2n8ycq4VQiJun5qvs+/k8V+FH3XODQnINkAfZ+UwAEscb+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804086; c=relaxed/simple;
	bh=hdAK9CvNAX8I/mzX3gelODJbXuXlsAXTzOFiQp69MH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obS6evuv28/JV7mtiOdx9tu1BN6xSRvWmFcl7XnQF1dILrKmiyHchtKSnulYeL2jAwbLzHoFDjgcLEPEJsCTyqC+7q3bT5S0HR8Np8ib99LHw08qicK8UdQmFGexZv+ya+1JXZzhL+eSCW4gTzwPH3K37ON0CnoXrL7r/N+XHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQZFOO7v; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804084; x=1761340084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hdAK9CvNAX8I/mzX3gelODJbXuXlsAXTzOFiQp69MH4=;
  b=JQZFOO7vabfSrJa3tbPLf7lOKu9pHEFVs8NPh6BQj8L3kcS6VEW7L2UH
   E4qru+f/oIxL7XW6qGg70yzF/BsrcOgdtry0qnMWXK0RLMbuYmJdzLMMP
   m6V1yERlB1YBEem5atZx11XxWZHttznA1acS419xJKsCN9KqTbXFLQU9d
   bMiUwzVN9hyyFLqPUep7Q0xRjCQkY1fy0JJ+QAfau1RMGhM65Eg4025un
   4LWQuBsydTDkipdEhWOl2BLG5wBlnbhom00AA4SSlajqJUsAAvxRCNjM5
   I+vbfst9C5zFMm6fDTv/tsl96kBeatA4ndqyXI4J5IwNVbrX9w18XpYlA
   Q==;
X-CSE-ConnectionGUID: Jkq6Mz0gRp20CnKRwQK4wA==
X-CSE-MsgGUID: nJkgHBipQKyZD35UPmYZGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090876"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090876"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
X-CSE-ConnectionGUID: ltt0TNiKTpe4wM8NlDwj3Q==
X-CSE-MsgGUID: D7wtuImPSNuPDYI3Y5CWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488023"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
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
Subject: [PATCH V4 02/15] selftests/resctrl: Print accurate buffer size as part of MBM results
Date: Thu, 24 Oct 2024 14:18:39 -0700
Message-ID: <e48adb71c8213ff80833201c0cfe2cdfb041e39a.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
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

Changes since V3:
- Ensure string parsing handles case when user provides "". (Ilpo)
- Fix error returned. (Ilpo)

Changes since V2:
- Make user input checks more robust. (Ilpo)

Changes since V1:
- New patch.
---
 tools/testing/selftests/resctrl/mbm_test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..cf08ba5e314e 100644
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
+		if (uparams->benchmark_cmd[1] && *uparams->benchmark_cmd[1] != '\0') {
+			errno = 0;
+			span = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
+			if (errno || *endptr != '\0')
+				return -EINVAL;
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
2.47.0


