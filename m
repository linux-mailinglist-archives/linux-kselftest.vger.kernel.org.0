Return-Path: <linux-kselftest+bounces-17866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCFC977013
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653DD1C23565
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57851C242C;
	Thu, 12 Sep 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kex5wIKq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0A1C2316;
	Thu, 12 Sep 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164303; cv=none; b=i086ZSC+5QCXFjIVFijObktgbVybrQtOPX4G4bVb4XHrMyOyRwakOPDwgA7N7Cc0AJKGWhGYfpYZHfST3wUCaSyB+x/scPhzXT7lQGeFJnfbjcScpbl5ubTMryr3+Tp/Jh5WZXHewqTKmjdl9+WF9F40WjASxn7qxmneHnllJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164303; c=relaxed/simple;
	bh=pbqZYofb0zkkc2gFzf8QZp4Qb+rrD67VxwAkjEJJVR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFFWphXdI8Lz7NZ6FawB2iQHFCGNCQ9XyO0oETvN44eN/9B9RcRYUfD6KsgQqzMbk6KD9jBRJeWEeGBPmSChXp5d6Sr/PtExOKiqtPk2gtxWUh4X0K0MSsxgDZr0eIl/mm+2ylVdKeJjJf88ditITwR9y2wXJRxqs05lLbUIfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kex5wIKq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164302; x=1757700302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pbqZYofb0zkkc2gFzf8QZp4Qb+rrD67VxwAkjEJJVR8=;
  b=kex5wIKqH8I2I67ZQ03lgqU/NdBLLtjll7MBR6QltFPUKsd+S5k6kNqb
   +3m+N5U9Cbr+7Enjo955XUkgCzo+Peb6klrdvyT0UfYdbewdX/CeTKbQQ
   hWbLrD5VqC0G5veEjl8aGDWOKuldXllsiBF7v1kI7LpKvJABjQEYQ0ykN
   31sJhEiyDkyT8RsD4hmjRWDKbGbv+0oRwn9wdSm5wFq4+7BOW6SziC59Z
   xwN+ex64ieTqv0zGaG7S1nlErWlIvKVhHrZ3rR/FgiDjMys/EqHHVXhox
   n8f2quwvdAZ5kJGs8ao0PflGXrljHkkofTr5qWjart+Yn9tlervzLLhy5
   w==;
X-CSE-ConnectionGUID: nOi91rqLQh+PyVO1pX945g==
X-CSE-MsgGUID: kAPBNEjdSNGBTv6Mh5FywA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976626"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976626"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
X-CSE-ConnectionGUID: tsar5sZRS16LPxP14sMcbw==
X-CSE-MsgGUID: L2U9Pq1LTxOlf7ovkkDLKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724636"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
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
Subject: [PATCH V2 13/13] selftests/resctrl: Keep results from first test run
Date: Thu, 12 Sep 2024 11:14:02 -0700
Message-ID: <46200b49e874c69a05538b813852af0e1eeeea4c.1726164080.git.reinette.chatre@intel.com>
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
Changes since V1:
- Remove comment about needing results from first run removed.
- Fix existing incorrect spacing while changing line.
---
 tools/testing/selftests/resctrl/cmt_test.c |  5 ++---
 tools/testing/selftests/resctrl/mba_test.c | 10 +++-------
 tools/testing/selftests/resctrl/mbm_test.c | 10 +++-------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a7effe76b419..d4b85d144985 100644
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
index 5c6063d0a77c..89c2446b9f80 100644
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
index 7635ee6b9339..8c818e292dce 100644
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
2.46.0


