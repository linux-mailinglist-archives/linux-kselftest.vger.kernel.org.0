Return-Path: <linux-kselftest+bounces-5994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C187347C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 11:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F24286944
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A160893;
	Wed,  6 Mar 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOZqnaV3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62A605B6;
	Wed,  6 Mar 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721621; cv=none; b=IFWrcomKh4lDfvqzcx6CD0uc0Hkdd2nHrdZwsjj6PVpBBcSXy9oUMdAvyQZ7vxS9ib7HL/e92NOmZvR6PRlO+tAsPFdxD/AzxoUoE2Ymrm4xdnfnIZq74A2FXUKV/lX/EaUHPshPRyqtOAixupg2jVfk1JpKUO8KmJagRJFmEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721621; c=relaxed/simple;
	bh=s+ut/76woukc2cIw6pdftfYqrtPuS0qGolRJE53TM8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbR9aLzlPm6rP97JXZzVQz/V9+T3a2rGVwJI+JUCJuoC+0iOXgjaQPQtRf8mXWzQtzOEMTyLILw6X7UnanBJI89y6BPM7r1JpDgYpYbizlIkF8EyEN+S3VqXvxpBCkFCKullXH41w4T9GKRY441CMuToO8mR/tpF9uP+fGXK4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOZqnaV3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709721618; x=1741257618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+ut/76woukc2cIw6pdftfYqrtPuS0qGolRJE53TM8Q=;
  b=bOZqnaV3LuX5zHVNzACjo2KYVFSFeKOD8NPyqgfE3QSzPt53TKfCbIjJ
   DsqL+QyH92dnmmAW6YcxXTrheFzdTqnkBsAbngVjsq8nItNXVE0reHNO+
   mtb/bza8sQYywIOhlZDBFj6AWuAXrjFP4U2QjCq7xdCtM0sQgVkbK7a22
   XQS7ncdHFJVBJOex76XBUF31E/427oVfsZfcOQbYNf6/KFvK5vXPAjkG+
   6wO3tnqbKKj3j7B7vPCQRN4D7mzctEp1Q8dzvw02oHyp3wxRTaU9Wye8S
   i7pZcx1wgojRBJzyeNT0kTDRCXG611KMXhUjXhB3hI0LVWdpV33/cvDI4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4497591"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4497591"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9803753"
Received: from ksznyce-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.25.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:39:59 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/4] selftests/resctrl: SNC support for MBM
Date: Wed,  6 Mar 2024 11:39:20 +0100
Message-ID: <def02de22a4747ed56ddc28f334e55872ba95f13.1709721159.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory Bandwidth Monitoring (MBM) measures how much data flows between
cache levels. Only the flow for a process specified with a Resource
Monitoring ID (RMID) is measured.

Sub-Numa Clustering (SNC) causes MBM selftest to fail because the
increased amount of NUMA nodes per socket is not taken into account.
That in turn makes the test use incorrect values for the start and end
of the measurement by tracking the wrong node.

For the MBM selftest to be NUMA-aware it needs to track the start and end
values of a measurement not for a single node but for all nodes on the
same socket. Then summing all measured values comes out as the real
bandwidth used by the process.

Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Closes: https://lore.kernel.org/lkml/TYAPR01MB6330A4EB3633B791939EA45E8B39A@TYAPR01MB6330.jpnprd01.prod.outlook.com/
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c    |  1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 37 ++++++++++++-------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..fc31a61dab0c 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -147,7 +147,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
-		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
 		.setup		= mba_setup
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e75e3923ebe2..2fe9f8bb4a45 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -595,9 +595,10 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 
 static int measure_vals(const struct user_params *uparams,
 			struct resctrl_val_param *param,
-			unsigned long *bw_resc_start)
+			unsigned long *bw_resc_start,
+			int res_id)
 {
-	unsigned long bw_resc, bw_resc_end;
+	unsigned long bw_resc = 0, bw_resc_sum = 0, bw_resc_end;
 	float bw_imc;
 	int ret;
 
@@ -612,17 +613,19 @@ static int measure_vals(const struct user_params *uparams,
 	if (ret < 0)
 		return ret;
 
-	ret = get_mem_bw_resctrl(&bw_resc_end);
-	if (ret < 0)
-		return ret;
+	for (int i = 0 ; i < snc_ways() ; i++) {
+		set_mbm_path(param->ctrlgrp, strlen(param->mongrp) > 0 ? param->mongrp : NULL,
+			     res_id + i);
+		ret = get_mem_bw_resctrl(&bw_resc_end);
+		bw_resc = (bw_resc_end - bw_resc_start[i]) / MB;
+		bw_resc_sum += bw_resc;
+		bw_resc_start[i] = bw_resc_end;
+	}
 
-	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
-	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc_sum);
 	if (ret)
 		return ret;
 
-	*bw_resc_start = bw_resc_end;
-
 	return 0;
 }
 
@@ -697,12 +700,16 @@ int resctrl_val(const struct resctrl_test *test,
 		struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
-	unsigned long bw_resc_start = 0;
 	int res_id, ret = 0, pipefd[2];
+	unsigned long *bw_resc_start;
 	struct sigaction sigact;
 	char pipe_message = 0;
 	union sigval value;
 
+	bw_resc_start = calloc(snc_ways(), sizeof(unsigned long));
+	if (!bw_resc_start)
+		return -1;
+
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
 
@@ -710,7 +717,7 @@ int resctrl_val(const struct resctrl_test *test,
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
 		ret = validate_bw_report_request(param->bw_report);
 		if (ret)
-			return ret;
+			goto out_free;
 	}
 
 	/*
@@ -721,7 +728,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 	if (pipe(pipefd)) {
 		ksft_perror("Unable to create pipe");
-
+		free(bw_resc_start);
 		return -1;
 	}
 
@@ -733,7 +740,7 @@ int resctrl_val(const struct resctrl_test *test,
 	bm_pid = fork();
 	if (bm_pid == -1) {
 		ksft_perror("Unable to fork");
-
+		free(bw_resc_start);
 		return -1;
 	}
 
@@ -841,7 +848,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(uparams, param, &bw_resc_start);
+			ret = measure_vals(uparams, param, bw_resc_start, res_id);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
@@ -855,6 +862,8 @@ int resctrl_val(const struct resctrl_test *test,
 
 out:
 	kill(bm_pid, SIGKILL);
+out_free:
+	free(bw_resc_start);
 
 	return ret;
 }
-- 
2.44.0


