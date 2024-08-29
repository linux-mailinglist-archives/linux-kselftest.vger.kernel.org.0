Return-Path: <linux-kselftest+bounces-16748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC4965335
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 00:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F701C21DC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81B1BF310;
	Thu, 29 Aug 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvedgY2D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A611BE854;
	Thu, 29 Aug 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971966; cv=none; b=q+Ec9tWP/YzgLAKshcaYZf/Ydxb7cD+veBl0A7rXtdJ/8m8Dq4d25dR1cMEIjNF4fYqLMw4IK9te3UCjWSb2EfPUaDAnsf9jZ9aTxIRIaZw6YmH6wV8l37Ja+Jxd2vSY7L3lER1lI6BSvgIlvBvBObnvDLNbaY61Sut2xP8AZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971966; c=relaxed/simple;
	bh=I0V/mXYSyqAaEqRosYfRH9ZnCyLxtliSkutcjvFE7bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQyxzsGRWfXz6SRkczCi+ut9HZvGgKZkqk26cWSW+NMB6UX6n/A0gFiH0Czy92ez83TJ1yh++1ex5HY9iRQP0/IlNCbq+3DGHfY4hyAGoZ6Wubrs/HBVF/+hu9D+Qq2OQMCVDU/HGKh64uhONezrzholeyEAzhCE5wlb22enOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvedgY2D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724971965; x=1756507965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0V/mXYSyqAaEqRosYfRH9ZnCyLxtliSkutcjvFE7bE=;
  b=LvedgY2DMUOso6YKj/gO0zaSx0wTFMekO5Oqm4/nvU5/DSQ6kdBwBsCW
   WtV9nBTaXPCMEzLinFq15ba8crhOhzOd9QWgvoVBiLncVwSiWm7oRVEyk
   nk7dWfTMk1h4DULUbxMi28Pu1DR1AzcksMnh/mI8m8+KIpv81ZKNC6RCb
   iSCgGqNvgJMG8/Cq4E9/11uB19bNwFzXe/Fx+rMwHinxVJGKWR217dtVJ
   ddLUYd9+WDVd+AMJrcWLbMgk07mVazGAzHfhkxKlWakrpBxH501WoLmzJ
   dfUD0CPJD53N21LDVoh0BDN4CyLyIRp15CEgM+QU3OKTzYqTIvZ410aoW
   A==;
X-CSE-ConnectionGUID: LoawZaj6RkCzdZ+LmRkm9A==
X-CSE-MsgGUID: Ie6v+o++RvWhy7tl2PHsQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27479176"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27479176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:41 -0700
X-CSE-ConnectionGUID: BcpweYAKS1Kin8ptnRCQRA==
X-CSE-MsgGUID: vHblY/NITC28FsoqGqp+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63415152"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO rchatre-mobl4.intel.com) ([10.125.111.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:41 -0700
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
Subject: [PATCH 6/6] selftests/resctrl: Keep results from first test run
Date: Thu, 29 Aug 2024 15:52:32 -0700
Message-ID: <772813207becd105d309de43d1ab03e52bbd3091.1724970211.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724970211.git.reinette.chatre@intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl selftests drop the results from every first test run
to avoid (per comment) "inaccurate due to monitoring setup transition
phase" data. Previously inaccurate data resulted from workloads needing
some time to "settle" and also the measurements themselves to
account for earlier measurements to measure across needed timeframe.

commit da50de0a92f3 ("selftests/resctrl: Calculate resctrl FS derived mem
bw over sleep(1) only")

ensured that measurements accurately measure just the time frame of
interest. The default "fill_buf" benchmark since separated the buffer
prepare phase from the benchmark run phase reducing the need for the
tests themselves to accommodate the benchmark's "settle" time.

With these enhancements there are no remaining portions needing
to "settle" and the first test run can contribute to measurements.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cmt_test.c |  5 ++---
 tools/testing/selftests/resctrl/mba_test.c |  6 +++---
 tools/testing/selftests/resctrl/mbm_test.c | 10 +++-------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index f09d5dfab38c..85cb93d525b8 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -99,14 +99,13 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 		}
 
 		/* Field 3 is llc occ resc value */
-		if (runs > 0)
-			sum_llc_occu_resc += strtoul(token_array[3], NULL, 0);
+		sum_llc_occu_resc += strtoul(token_array[3], NULL, 0);
 		runs++;
 	}
 	fclose(fp);
 
 	return show_results_info(sum_llc_occu_resc, no_of_bits, span,
-				 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1, true);
+				 MAX_DIFF, MAX_DIFF_PERCENT, runs, true);
 }
 
 static void cmt_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 204b9ac4b108..dddf9bc04cfa 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -88,14 +88,14 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		 * The first run is discarded due to inaccurate value from
 		 * phase transition.
 		 */
-		for (runs = NUM_OF_RUNS * allocation + 1;
+		for (runs = NUM_OF_RUNS * allocation;
 		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
 			sum_bw_imc += bw_imc[runs];
 			sum_bw_resc += bw_resc[runs];
 		}
 
-		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
-		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
+		avg_bw_imc = sum_bw_imc / NUM_OF_RUNS;
+		avg_bw_resc = sum_bw_resc / NUM_OF_RUNS;
 		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc < THROTTLE_THRESHOLD) {
 			ksft_print_msg("Bandwidth below threshold (%d MiB).  Dropping results from MBA schemata %u.\n",
 					THROTTLE_THRESHOLD,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 734bfa4f42b3..bbacba4ec195 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -22,17 +22,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 	int runs, ret, avg_diff_per;
 	float avg_diff = 0;
 
-	/*
-	 * Discard the first value which is inaccurate due to monitoring setup
-	 * transition phase.
-	 */
-	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
+	for (runs = 0; runs < NUM_OF_RUNS ; runs++) {
 		sum_bw_imc += bw_imc[runs];
 		sum_bw_resc += bw_resc[runs];
 	}
 
-	avg_bw_imc = sum_bw_imc / 4;
-	avg_bw_resc = sum_bw_resc / 4;
+	avg_bw_imc = sum_bw_imc / NUM_OF_RUNS;
+	avg_bw_resc = sum_bw_resc / NUM_OF_RUNS;
 	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 	avg_diff_per = (int)(avg_diff * 100);
 
-- 
2.46.0


