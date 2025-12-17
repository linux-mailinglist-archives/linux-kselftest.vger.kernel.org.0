Return-Path: <linux-kselftest+bounces-47627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B87CC5DCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 04:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29B823002D08
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 03:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4D28C035;
	Wed, 17 Dec 2025 03:05:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227241E9915;
	Wed, 17 Dec 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940748; cv=none; b=a4u0TnNrH7J55cMv6JoHC+drnuePdqNu8IINfkXixK9Kd9vNESTlbPni85FFTeBZ1VXANsH9IDKvk5YvzNMRZ7X+lSi0F8iKs0gNwBVzswbD0eSseYGem5chjZ7C4S1/MivWhd7sGweDhRoSa/c0pE1E7Xhqz0kMZAxo1d3oMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940748; c=relaxed/simple;
	bh=PWVX4P/C70Eb5WxPZWLOS8flK6NgL+KCQmC97/5fE7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7HgMIDclr0KZ53yn4KT6kkerbEG6FCoVQggvRXfspsSgXC0k2CXvdbfkAyHTgo+HP95wwGtUv4IcSIInJCZj9pxKz9dPULlIvmtGBCrtxFwHUpWwKFSYug/8szyaXoiYxV9TIrwNY+m/R15uXg4C1wz+N2aM04NElGr5gLM8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fmLmm3Q_1765940732 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 11:05:36 +0800
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
Subject: [PATCH v5 1/4] selftests/resctrl: Fix a division by zero error on Hygon
Date: Wed, 17 Dec 2025 11:04:53 +0800
Message-ID: <20251217030456.3834956-2-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
References: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
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
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 195f04c4d158..b9c1bfb6cc02 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -243,6 +243,16 @@ int snc_nodes_per_l3_cache(void)
 		}
 		snc_mode = cache_cpus / node_cpus;
 
+		/*
+		 * On some platforms (e.g. Hygon),
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


