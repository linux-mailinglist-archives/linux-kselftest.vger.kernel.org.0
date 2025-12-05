Return-Path: <linux-kselftest+bounces-47092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F4CA77AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 12:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DFBB35AACC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEBE330B18;
	Fri,  5 Dec 2025 09:26:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07B3043CF;
	Fri,  5 Dec 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764926804; cv=none; b=NMKSJ7Nh8lDkkoHmCWiePMUZiTZ/UkzDfSjJhb9YAx35PaealkSsyPJGTuSgdxwdI1XFAIIQhFX/aVo8BdH5w5Zb+wlMA5jpatO8dtLiaDFu98Id0HUHJhzRmWh0gvfPZ3nJxOn5RpiqD4a/G5c2u6SVQMrVp5yXztwmFp0gH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764926804; c=relaxed/simple;
	bh=WseTNk88/NYojYS1ySl2tLjv9eX/PweY/wlISWR/G8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjZiwh2F8DYSi9p0/Nhu/vHit6mUqAVJh2/DekRFgrd8GB2W8T95dN0SRSkMjzPQDVwSxgqN8Zq+3eAlMH6o7zbspzX/bBpv5/tbHqVLR3zfC9h320fnM3jnopNb0Mtmi7o4+mZJDhaQuIDpRiQ2ZcxCeaOTMR/q7JyW00xvFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fdWs0Y2_1764926787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 05 Dec 2025 17:26:30 +0800
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
To: tony.luck@intel.com,
	reinette.chatre@intel.com,
	bp@alien8.de,
	fenghuay@nvidia.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: babu.moger@amd.com,
	james.morse@arm.com,
	Dave.Martin@arm.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shenxiaochen@open-hieco.net
Subject: [PATCH v2 2/3] selftests/resctrl: Fix a division by zero error on Hygon
Date: Fri,  5 Dec 2025 17:25:43 +0800
Message-ID: <20251205092544.2685728-3-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit

  a1cd99e700ec ("selftests/resctrl: Adjust effective L3 cache size with SNC enabled")

introduced the snc_nodes_per_l3_cache() function to detect the Intel
Sub-NUMA Clustering (SNC) feature by comparing #CPUs in node0 with #CPUs
sharing LLC with CPU0. The function was designed to return:
  (1) >1: SNC mode is enabled.
  (2)  1: SNC mode is not enabled or not supported.

However, on certain Hygon CPUs, #CPUs sharing LLC with CPU0 is actually
less than #CPUs in node0. This results in snc_nodes_per_l3_cache()
returning 0 (calculated as cache_cpus / node_cpus).

This leads to a division by zero error in get_cache_size():
  *cache_size /= snc_nodes_per_l3_cache();

Causing the resctrl selftest to fail with:
  "Floating point exception (core dumped)"

Fix the issue by ensuring snc_nodes_per_l3_cache() returns 1 when SNC
mode is not supported on the platform.

Fixes: a1cd99e700ec ("selftests/resctrl: Adjust effective L3 cache size with SNC enabled")
Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 195f04c4d158..2b075e7334bf 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -243,6 +243,16 @@ int snc_nodes_per_l3_cache(void)
 		}
 		snc_mode = cache_cpus / node_cpus;
 
+		/*
+		 * On certain Hygon platforms:
+		 * cache_cpus < node_cpus, the calculated snc_mode is 0.
+		 *
+		 * Set snc_mode = 1 to indicate that SNC mode is not
+		 * supported on the platform.
+		 */
+		if (!snc_mode)
+			snc_mode = 1;
+
 		if (snc_mode > 1)
 			ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
 	}
-- 
2.47.3


