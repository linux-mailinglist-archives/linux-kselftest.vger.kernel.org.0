Return-Path: <linux-kselftest+bounces-17865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB3977010
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B77F1F25503
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC41C232E;
	Thu, 12 Sep 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRQzbvXY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315411C1ADB;
	Thu, 12 Sep 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164302; cv=none; b=OatqNx7ukvtCwLlWoaSfNG6nBkfr8UY51SyyK/nq2iEm4oHB4HrtlSlMX6rWOhHtLmTyGDNsZqML86WGmOs8iRY+35WGtTo8Gy8SPNVTiE9aJFk+BsOFkcEtsPp+p2GD47Ihsc+ha9s3UyG8sipAE8XvRFUQDepn1z8GCbyhRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164302; c=relaxed/simple;
	bh=92pWei0aQ4YO4Oh0M7RHrJb9MqFXjLiYkf/YT5NhMKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1gJWpwUSR4+0iWwOZu7qvUboKI6Ml2uI8TIwlkWP6NtMHsihmQccSkcigq6Ij0DDnQYe8kxredZfL+aeq4weEEhhfyAVUGUw6AyGsimjuNcDFNHgNRUMPCWg/lHXtj23YmYcOoTbCrdFFEpRS8dS3h9npH54kqa0/auAR0jQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRQzbvXY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164302; x=1757700302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=92pWei0aQ4YO4Oh0M7RHrJb9MqFXjLiYkf/YT5NhMKs=;
  b=JRQzbvXY8eCs6gfyjaGTvoxSV/fEWQ3kUtkZYHcMWYmw+3Nn3+ar4qNb
   YK39ctB/BTDHyxeQJ4M7pQ0jP2tcA65WVDCu0uwqMDphVprspWPyHEvw+
   78wnFBrJysJjTpwUg94j9th1zLbc7pFJcdJrx3q0tshZG3twz98YmjTJ3
   VTXwt9/pdPWMssjGpzdvLJqgjMwLe/ejbiheD/oRRJGgmMMP8+9nofCIx
   ROKFwCoi/Mpr4zfWXzvGnsrHTWaeLha7tX74kQuC5V/0tdFVBaI+FaYAF
   FC/6eJ9foOBGJgxnpBptYKTSUccUV39D7Q7GvqKQuRX+LeUIIMDlRDyEb
   Q==;
X-CSE-ConnectionGUID: 74PYGfd4RE6+Nkha28MKOw==
X-CSE-MsgGUID: Uw/XXcVEQQC701K1FWQXiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976622"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976622"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
X-CSE-ConnectionGUID: ZiVBzlxSRm+jOdQGOKhWCQ==
X-CSE-MsgGUID: +T/cSBSIRB2BdH1KvBu/GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724633"
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
Subject: [PATCH V2 12/13] selftests/resctrl: Do not compare performance counters and resctrl at low bandwidth
Date: Thu, 12 Sep 2024 11:14:01 -0700
Message-ID: <955545d3377afc359d7b8b3915455bfdfc0d6605.1726164080.git.reinette.chatre@intel.com>
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

The MBA test incrementally throttles memory bandwidth, each time
followed by a comparison between the memory bandwidth observed
by the performance counters and resctrl respectively.

While a comparison between performance counters and resctrl is
generally appropriate, they do not have an identical view of
memory bandwidth. For example RAS features or memory performance
features that generate memory traffic may drive accesses that are
counted differently by performance counters and MBM respectively,
for instance generating "overhead" traffic which is not counted
against any specific RMID. As a ratio, this different view of memory
bandwidth becomes more apparent at low memory bandwidths.

It is not practical to enable/disable the various features that
may generate memory bandwidth to give performance counters and
resctrl an identical view. Instead, do not compare performance
counters and resctrl view of memory bandwidth when the memory
bandwidth is low.

Bandwidth throttling behaves differently across platforms
so it is not appropriate to drop measurement data simply based
on the throttling level. Instead, use a threshold of 750MiB
that has been observed to support adequate comparison between
performance counters and resctrl.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Fix code alignment and spacing.
- Modify flow to use "continue" instead of "break" now that
  earlier changes decreases throttling.
- Expand comment of define to elaborate causes of discrepancy
  between performance counters and MBM.
---
 tools/testing/selftests/resctrl/mba_test.c |  7 +++++++
 tools/testing/selftests/resctrl/resctrl.h  | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index d8d9637c1951..5c6063d0a77c 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -98,6 +98,13 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
+		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc < THROTTLE_THRESHOLD) {
+			ksft_print_msg("Bandwidth below threshold (%d MiB). Dropping results from MBA schemata %u.\n",
+				       THROTTLE_THRESHOLD,
+				       ALLOCATION_MIN + ALLOCATION_STEP * allocation);
+			continue;
+		}
+
 		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 		avg_diff_per = (int)(avg_diff * 100);
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index dc01dc75cba5..eb151ac74938 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -43,6 +43,16 @@
 
 #define DEFAULT_SPAN		(250 * MB)
 
+/*
+ * Memory bandwidth (in MiB) below which the bandwidth comparisons
+ * between iMC and resctrl are considered unreliable. For example RAS
+ * features or memory performance features that generate memory traffic
+ * may drive accesses that are counted differently by performance counters
+ * and MBM respectively, for instance generating "overhead" traffic which
+ * is not counted against any specific RMID.
+ */
+#define THROTTLE_THRESHOLD	750
+
 /*
  * fill_buf_param:	"fill_buf" benchmark parameters
  * @buf_size:		Size (in bytes) of buffer used in benchmark.
-- 
2.46.0


