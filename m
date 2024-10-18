Return-Path: <linux-kselftest+bounces-20099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD109A32C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10A91C2393B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D031891AB;
	Fri, 18 Oct 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/CshZ4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B7188713;
	Fri, 18 Oct 2024 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218168; cv=none; b=ikgFeelbP3NEsTLQZywAnxYa0cxfRHXcXuq5PLsMuhVC6J6MWQXqu9DJDDwISZjhB3lgcDyH8iLqRfj7uTCP9p41w7GSczrBv1nU2DETJQgRYPeRAxXW7NVylf6j0XQafV4bzD/zs5lJwzOk2Sa+4UrwEYns7vJY88DcOm9Cw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218168; c=relaxed/simple;
	bh=vSW/xY/u5gQfdaq8Fb5zDhVy9K06adJcO87Sfqnguxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs7PBlF8hW6aFPgqA1QeSsaSAgo3i/8vLbtt7x8zMrv2AWZUjIvEEcFz4vLw8xQkLdTZ5pmZkpln+laIQdvBybUbt6dW+5WVysvfi1Q/K+Yq6F7qPZ6nLQdM7iknQ2fr/ive7zD02ZookfFweNeEWZKbRVBW8q7HN7tJ4EjDAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/CshZ4c; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218167; x=1760754167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vSW/xY/u5gQfdaq8Fb5zDhVy9K06adJcO87Sfqnguxo=;
  b=g/CshZ4cwTEiw8Yg6zaoWUhizohWTbcUIAtTMzH3KJdQ2koaE4DLgsez
   m1k6zOjET1vzqk/qtnhAGx/aXTHL9iHru698I1TV9Cu60J75I9Kk5iaeH
   xPxPVQTk0a04nHIGF5P9X5/tMKy2+Fv+OZc4eTKhBQK+Wr0p40YxXShjo
   LZ9NNXqrMAqxUcXrfflwVdSiTx+acn97vH6xZ8Q3nCjcVjeZWVOe2JXk7
   sxAML0oUw8aM9vDKArWWcJXoffkIadrRweoEI+QNLJlj3w7c3SWU3O8T6
   ufMINBXwC8qG3jPn6a2/26Ymc5N+YY0MuhlT37FBUPt/EoajW5+bCigFY
   w==;
X-CSE-ConnectionGUID: 7SUFslUgQ+WDRNjgtydD6A==
X-CSE-MsgGUID: 0wOlB5wiRoKzEV7vs00uWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149721"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149721"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:38 -0700
X-CSE-ConnectionGUID: MvDR+WAaTJKdlQAxE7Q/xw==
X-CSE-MsgGUID: snqS7aexSLuXEefTbLjNCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697738"
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
Subject: [PATCH V3 13/15] selftests/resctrl: Do not compare performance counters and resctrl at low bandwidth
Date: Thu, 17 Oct 2024 19:33:28 -0700
Message-ID: <c755b3ed590ea89c095f8890d17113fe25a4c2c2.1729218182.git.reinette.chatre@intel.com>
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V2:
- Add Ilpo's Reviewed-by tag.

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
index bf37f3555660..5b4f0aa7a3a4 100644
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
index a553fe975938..dab1953fc7a0 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -43,6 +43,16 @@
 
 #define MINIMUM_SPAN		(250 * MB)
 
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
2.46.2


