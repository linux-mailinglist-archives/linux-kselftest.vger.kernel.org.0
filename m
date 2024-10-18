Return-Path: <linux-kselftest+bounces-20101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684BC9A32CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CD81C2388C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C618A939;
	Fri, 18 Oct 2024 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnZfhGMW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC72188912;
	Fri, 18 Oct 2024 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218170; cv=none; b=TnJjlOPQFEfyOaEcMcYNeXXGINHgkiNeyiYoPL4lJrSaFfEixRGq/iCzzV3ihWC8bMWRqFwzJ96br16zQdskOvYnEqLORU1qabTlpFf1yQS5HteAEb0/3IXbhdRTvRLIF419oPnF3xTAfedKgHMr6DAL1XdJsja4w/ESVT79GFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218170; c=relaxed/simple;
	bh=rekm5nk2Fa51gQ2WkClGucC0pLS1nGxBhoPpHZmLRyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nl4pyLFxhPBZHvzSAthRvC/BV9LTMGPjMwFSsuBFYg8LFuldryLnI6gUPl4FM9Eg+DctCh/8hPHL8eTmLI//T/zk8pkrHKmX3O9nhQHNMPnmFwgk7glHTXPXZUbX0drgVralCtTeXPGnYnUb3md/A+3g2WfVk9tqAa+/KR82Nic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnZfhGMW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218168; x=1760754168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rekm5nk2Fa51gQ2WkClGucC0pLS1nGxBhoPpHZmLRyc=;
  b=EnZfhGMWVCBJNQTyiaYqqIX8Jl79R48prh6R3cPiTFS3VWxHXi5IAmg/
   OIDVTpb53U806tgmJup+37X8r3oSCz/uaV3acNvlV6DqRr58nWczdsPfR
   sdy0Y5riZByFw8UvIVY+H1nUqlpOkf2dtS3UZ0zqOkFwPzJ9RxXdgwp/8
   zPFaDBcobSsNF0PtkFo3TWzdDDniS2070os597cYRGePHPcOxqKezQ67N
   SC69V1c0F2DIsxaXqyaUZ4dK3GO2/O1YCEcPQTpmuOcOJKZCbF/szTgTi
   jQYvTTLAog0gAH6x9oHwELJ5HRBSvwHiZBLg+n1oBqnGfuZMIdk2QhUxe
   A==;
X-CSE-ConnectionGUID: a4pXeyhQSjiWxSg4Ys3emA==
X-CSE-MsgGUID: FJHZSlRjTQiGg/tZyDZvpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149723"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149723"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:38 -0700
X-CSE-ConnectionGUID: lxWic12KTw6q1wyiR/Urfw==
X-CSE-MsgGUID: zABcuXEWT8mRPMEyECy0jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697741"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
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
Subject: [PATCH V3 14/15] selftests/resctrl: Keep results from first test run
Date: Thu, 17 Oct 2024 19:33:29 -0700
Message-ID: <48201899f58835fca850913fe32a07940b394e8c.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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
2.46.2


