Return-Path: <linux-kselftest+bounces-16746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B73965331
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 00:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DFDB24B25
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F41BE853;
	Thu, 29 Aug 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LM9c1eoN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E491BE242;
	Thu, 29 Aug 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971964; cv=none; b=c+vOr7tC4471Ck6j4eOTE3SSvLOqTBTWh1oY12Pf446jFwC7kUT4XthQtuap3/CgNuF7bOq7TOqP55fgfq3pBJhUIPRFefWAf2HxztpbA9HNU54mJvtwblqMsLc9EOWZYT8FLUDKqSpiVCRQ2gmjns6QEIw1oWsfUxh/QENROF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971964; c=relaxed/simple;
	bh=Pk/7UL5060saBr2FSXLTHwKgFHKGTMQhLToZZ8b+6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtPd8UsYICBz3PfEmL1Uhx1W3De8cqQUoBIANkBQeWPGFX4u0toGSPzfFJRPVBJ7de2c5SXybPABN6jaelrGXaVi6Lqq4IDjOaBTERPq5ecEbgnVQZqmjwHW2NxzIAEVztuJQsu3CrlTiAEkKtUCFHG/eWqkZKnlIv/DjF5EYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LM9c1eoN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724971963; x=1756507963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pk/7UL5060saBr2FSXLTHwKgFHKGTMQhLToZZ8b+6FQ=;
  b=LM9c1eoNcMAKroJJdKNvgS/FNqsCdEf4LfeMfK3F9dK4B6TizsvhNqYn
   Xmc57r2XFx4Dxa2YhN46SVl45ED9FHm7saQP5A80F74AuhU09kGbu2Pxf
   HRIPN7G4zR12ydw1wqjAqlkgYBqfz4oQbHNPI+RB3e9GYFYxdkJXuBA/E
   V3V1MQzMgFi9422wlKLDF/TUwapz/WWFV0XadBhS3HHuunF9MYnbzdxkp
   mBIYs/gHwd/bsRVsiz6Y+PPW8u2sohP1KjLkmyjH3BcJFFpOdwNsWtCI2
   /M6OXlhvu2jnacQIkKORAijJp53ovpdT93/KbCTzCbwPQPoqJMsM+ilGx
   Q==;
X-CSE-ConnectionGUID: 3i6e+gC4S/KVIygEFltd4g==
X-CSE-MsgGUID: HAWwvBrdROeJUHJfx4MONw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27479172"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27479172"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:41 -0700
X-CSE-ConnectionGUID: TziuriAlR9uvrAzC7mI39g==
X-CSE-MsgGUID: /KpWHAr1Q7GJI3FEZl25pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63415149"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO rchatre-mobl4.intel.com) ([10.125.111.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:40 -0700
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
Subject: [PATCH 5/6] selftests/resctrl: Do not compare performance counters and resctrl at low bandwidth
Date: Thu, 29 Aug 2024 15:52:31 -0700
Message-ID: <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com>
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
 tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
 tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index cad473b81a64..204b9ac4b108 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
+		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc < THROTTLE_THRESHOLD) {
+			ksft_print_msg("Bandwidth below threshold (%d MiB).  Dropping results from MBA schemata %u.\n",
+					THROTTLE_THRESHOLD,
+					ALLOCATION_MAX - ALLOCATION_STEP * allocation);
+			break;
+		}
+
 		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 		avg_diff_per = (int)(avg_diff * 100);
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 0e5456165a6a..e65c5fb76b17 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -43,6 +43,12 @@
 
 #define DEFAULT_SPAN		(250 * MB)
 
+/*
+ * Memory bandwidth (in MiB) below which the bandwidth comparisons
+ * between iMC and resctrl are considered unreliable.
+ */
+#define THROTTLE_THRESHOLD	750
+
 /*
  * user_params:		User supplied parameters
  * @cpu:		CPU number to which the benchmark will be bound to
-- 
2.46.0


