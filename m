Return-Path: <linux-kselftest+bounces-20588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FE99AF469
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DF31F223BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950FC21BB11;
	Thu, 24 Oct 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+cFU5qt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C421B442;
	Thu, 24 Oct 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804097; cv=none; b=TAfiRMZGK3PbdPkf2dyrrdpbVVnGjzjPON6U2FVmKGEG40qBa1iIBFuMu49a9ssrSH96YfipGYoS58lLpgwqXlWh+jpwfcdexS1nYrV729OONI7PowTk+ZBC3SLMgdVt/5qcMUf1Ut531ryv0/Cj2y8aAg/vD8EAtkhQ/XYHb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804097; c=relaxed/simple;
	bh=4ZunPOnMHW173QBc9rpbdE5QhwsHAnEOxM8gzcv7OFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1hRAfFm6CVMq9DhL2TEmsh3PGfVQCnzC77zppVBxyOlK7LvnAZTmxUAhj1tEpMlj/H6TI9V24adpCnWm6AM2+NkdtaUBcLPavQ3jFimMq6bKB2Ir11iCFs2ZOZ/av8JBNE0yeZUNqiUaVtYJ6O0RWrTqRTofDAIYiqx/T8EId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+cFU5qt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804095; x=1761340095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZunPOnMHW173QBc9rpbdE5QhwsHAnEOxM8gzcv7OFo=;
  b=O+cFU5qtXUy2iBFEq6xas2nH+nHnYvxHrOMpzaYmJZKU4jsWC9mDUnXa
   MIYkrm/ubPlUJJLwdOk6cotYADPANHx+WT3MJ8h85R4a7s9dlcfo0siK2
   Oeb/SkCr6EauuA6/1277iXH22yNU9fMXQglAAE3sfSm9gwHy4C4VmjKWY
   jdCHUQTy/yv1cIO79kyN4sZUdG7Jmac48gynMNrqFIBgt6cE/AgR63Q1m
   ++xy++CQD6Psxg2lDjqQiqBZLRwMZkX2qFiH8lwDYUJCxkPnOHLWZ1MvH
   +CaKzp6p8KmKm3ry0ZvSKnJgA4ml7KxxqpvJYHg6U94cm1fI8lSePuNP2
   w==;
X-CSE-ConnectionGUID: 0TSN5H01QVumBxrUDjOqnQ==
X-CSE-MsgGUID: Vf2ZhO4pS9SbNthR2c5xTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090924"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090924"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:02 -0700
X-CSE-ConnectionGUID: RHG2KVSIRlCNfz5RHAM4nA==
X-CSE-MsgGUID: sGz7Cd+RQhO0h9BpQ5F5RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488063"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
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
Subject: [PATCH V4 14/15] selftests/resctrl: Keep results from first test run
Date: Thu, 24 Oct 2024 14:18:51 -0700
Message-ID: <b229f0d6d1b66413ec6da0be8195a5c25b99089b.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V2:
- Separate patch addresses Ilpo's observation about magic number in
  adjacent code.
- Add Ilpo's Reviewed-by tag.

Changes since V1:
- Remove comment about needing results from first run removed.
- Fix existing incorrect spacing while changing line.
---
 tools/testing/selftests/resctrl/cmt_test.c |  5 ++---
 tools/testing/selftests/resctrl/mba_test.c | 10 +++-------
 tools/testing/selftests/resctrl/mbm_test.c | 10 +++-------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 4c3cf2c25a38..3bbf3042fb06 100644
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
index 5b4f0aa7a3a4..4e6645b172e3 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -86,18 +86,14 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		int avg_diff_per;
 		float avg_diff;
 
-		/*
-		 * The first run is discarded due to inaccurate value from
-		 * phase transition.
-		 */
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
 			ksft_print_msg("Bandwidth below threshold (%d MiB). Dropping results from MBA schemata %u.\n",
 				       THROTTLE_THRESHOLD,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 4224f8ce3538..315b2ef3b3bc 100644
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
+	for (runs = 0; runs < NUM_OF_RUNS; runs++) {
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
2.47.0


