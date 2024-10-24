Return-Path: <linux-kselftest+bounces-20586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7C9AF466
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3431C1F21E5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975B21BAEF;
	Thu, 24 Oct 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iE2PRkoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EB21B428;
	Thu, 24 Oct 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804096; cv=none; b=A0Smm7cUox0dlzGwwwM8sDCBUovRDMDhB0JUBydWDHWaglMKnvTn+E7wadFt6HM6xr3fmHxkOtcx4LMFbyMdzKC80wlMD4VjynVRki3jnhDL1EE7MGpQSR+0jq7drcUZ2MpskX9w10hJm2N1Gn1vDq/Y7sCHzk1aZdkLzjU1ugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804096; c=relaxed/simple;
	bh=Gt5pFky4i1RJBVmV9QoqIcVcdYRvFayj0IsWsZXVFt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYgAMj/141NxzGjpi5VsTjWU0lKoB6h9KgONU0eHgP2hGG7rdhMkh9ZjnrToJvwAcqBHD+5I54OYVaZ4nwP1JeDks2TSHbje7goAwtjO1gYhZVhk8MIm8HML0ssddB6Ikqs6ksxy5QN7zpxdVJHD457J4Vvk8SHRarti4AcWRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iE2PRkoX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804094; x=1761340094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gt5pFky4i1RJBVmV9QoqIcVcdYRvFayj0IsWsZXVFt4=;
  b=iE2PRkoX+1GbpZNVcgKM7KsN/ARp7AedX+35E90duu5I3iu18r7tyTkk
   3yCu+6ZnTTEf0BiPRRDKu8hQRjg8Xzu8Nu/HafU8RnTLScz5WoldjsB1b
   MS8vTKnGPvYufq2KMFnmQVlfQNqvFFymXUQO4v3AcCwUWuq5D8f8H2mkZ
   DftxTzKb9BEBAgxt5+oj0oRDC1j6px402BY9zwf+luVotM/ajUe281sHY
   dJvBuuymAuAw7Eeij9nJ4ALv+ORUFcwUm1iGHR9PqNQ1NYtFqmJdVTOT1
   kLCdh1xMr8BNjE9r2rW2OOjrd8zpGLjHOkqssNwwxb8jNP+3WuB0vDjxQ
   w==;
X-CSE-ConnectionGUID: eJy8IhqWQOSAUkAB8l92yg==
X-CSE-MsgGUID: QL/RtGSYRkuwvYHoAXHQNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090923"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090923"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:02 -0700
X-CSE-ConnectionGUID: jsLILWxWSpysVhwELckp3A==
X-CSE-MsgGUID: KMVj3XXGRtKkstyMe0A/8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488060"
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
Subject: [PATCH V4 13/15] selftests/resctrl: Do not compare performance counters and resctrl at low bandwidth
Date: Thu, 24 Oct 2024 14:18:50 -0700
Message-ID: <4f7824c67703a1b4a4348fb1d031d2adaef77769.1729804024.git.reinette.chatre@intel.com>
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
2.47.0


