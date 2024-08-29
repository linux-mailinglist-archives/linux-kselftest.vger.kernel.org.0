Return-Path: <linux-kselftest+bounces-16745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4D96532F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038FE2822BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62E1BE84E;
	Thu, 29 Aug 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1kndo4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965C1BE22B;
	Thu, 29 Aug 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971964; cv=none; b=UYp8U3VlWpG1N746q/P301H5F+y8nw+IuJeyifiY0/X3ZberroOE4P2UN2JgUYxQwRjH9fH1WL9WJbdIpcWAFfIQ+Y0nwC0PK085Xyyv/XuG+0fi0o2LLhIt/EG7vDFL+UJYoeVmTl1QD7P8Mw/t5aartGhW1wSVF+FWbVAT/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971964; c=relaxed/simple;
	bh=idF4CTKFsmnnUxvbJlS1PZZ3Ktwhc6P2TlPzn2oeFTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0gMIm+lpPAgbSfM+cRXx3aIloBqpdqTnOhh99NmeCSAVJwXYf5eGZQk6k2nwidi93i+m2KoCi1j1aBjUR8biqlcYhPBEbuJlbZhlJySVNxKm3XgboXNJHOxPQA8ptCRCVl4tz5Da43goA/usdCGpd93FA7bKgQcEALUrfW+fek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1kndo4B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724971962; x=1756507962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idF4CTKFsmnnUxvbJlS1PZZ3Ktwhc6P2TlPzn2oeFTA=;
  b=g1kndo4BDTdCekQ6Dg1nhdtJ+1322BrhwAWCueCnY2MOSFsSp/+ncZkh
   3rtCil33+yP0hKjaNw+vNy1GjE4xWJndHzCYoYk99iF6g7LtEXdYz47jQ
   HhnmoNXxGDxsGJy6b1tPdkmH5jTO4S1VB0DDwXAQHSsP2geqP7jVGfOQ1
   umKC7sKVZXIgWYmC1qoW5yH7FbYD+qkpoobdA9AWG56ttDEThfmrL5vDH
   sYHM7duSj/oN+wkUaIIxfwF5oZ1/4OaohAHUGDh0tiIE8M2Wwb5Zs3KW/
   AArL/S8aHjlOYsyNgNFgDruR97I1gjjZqBYdFZtHx3U4qRQ1Aj4gwOYNd
   Q==;
X-CSE-ConnectionGUID: dr2ht3/OSKKsLof7QhJVCw==
X-CSE-MsgGUID: VGhaikf9T8uE5Ehxecjgbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27479168"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27479168"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:40 -0700
X-CSE-ConnectionGUID: cnOQrdNmTaW584l+E2YsLw==
X-CSE-MsgGUID: WvIqZecIRTSjorz+rLtmaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63415144"
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
Subject: [PATCH 4/6] selftests/resctrl: Use cache size to determine "fill_buf" buffer size
Date: Thu, 29 Aug 2024 15:52:30 -0700
Message-ID: <d357189fe0695b2140fc03efde75edc6fa0c88c6.1724970211.git.reinette.chatre@intel.com>
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

By default the MBM and MBA tests use the "fill_buf" benchmark to
read from a buffer with the goal to measure the memory bandwidth
generated by this buffer access.

Care should be taken when sizing the buffer used by the "fill_buf"
benchmark. If the buffer is small enough to fit in the cache then
it cannot be expected that the benchmark will generate much memory
bandwidth. For example, on a system with 320MB L3 cache the existing
hardcoded default of 250MB is insufficient.

Use the measured cache size to determine a buffer size that can be
expected to trigger memory access while keeping the existing default
as minimum that has been appropriate for testing so far.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 8 +++++++-
 tools/testing/selftests/resctrl/mbm_test.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 8ad433495f61..cad473b81a64 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -170,11 +170,17 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		.setup		= mba_setup,
 		.measure	= mba_measure,
 	};
+	unsigned long cache_total_size = 0;
 	int ret;
 
 	remove(RESULT_FILE_NAME);
 
-	param.fill_buf.buf_size = DEFAULT_SPAN;
+	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
+	if (ret)
+		return ret;
+
+	param.fill_buf.buf_size = cache_total_size > DEFAULT_SPAN ?
+				  cache_total_size * 2 : DEFAULT_SPAN;
 	param.fill_buf.memflush = 1;
 	param.fill_buf.operation = 0;
 	param.fill_buf.once = false;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index b6883f274c74..734bfa4f42b3 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -138,11 +138,17 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
 	};
+	unsigned long cache_total_size = 0;
 	int ret;
 
 	remove(RESULT_FILE_NAME);
 
-	param.fill_buf.buf_size = DEFAULT_SPAN;
+	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
+	if (ret)
+		return ret;
+
+	param.fill_buf.buf_size = cache_total_size > DEFAULT_SPAN ?
+				  cache_total_size * 2 : DEFAULT_SPAN;
 	param.fill_buf.memflush = 1;
 	param.fill_buf.operation = 0;
 	param.fill_buf.once = false;
-- 
2.46.0


