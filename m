Return-Path: <linux-kselftest+bounces-47551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEEDCBA6B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 08:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29DF530CAC83
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C483274671;
	Sat, 13 Dec 2025 07:39:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4792192EE;
	Sat, 13 Dec 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765611559; cv=none; b=JYkNmSanlezo0RQPhFVUlV8I3pq5x2dRhv8GZaDUbtvWUqxOnzSQxUB/QEJC15vKinOeHOcEoCjo4555LS4D8tRF15aq+mS33qyeXbvXRvAcw2ygFtqGz/GYcyTef2LRWfolIH779Mn0ge0Yxt+bUy3bZGRO4C5IfPSdUT8hq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765611559; c=relaxed/simple;
	bh=PxGqK+Upare33OSoP8+pD90vk5IxEEo1RRc2j6W6CP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTWVPGBSCgSAhFs6zGNVr7c68HZGYWD58eN6bKwbV5EudObOlDnAvF7Si2Zr3l1pGTxz/RX7gH7jizPzRhzyaQSGyGepfXEXwdS5iI2iWQMjeB20EZShTddRmNO+dMZ3DUtJsmQCHsS05im4cu+DPtv/Vs4a/QuYZytQq/qTtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fjNqpxr_1765611545 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Dec 2025 15:39:06 +0800
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
Subject: [PATCH v4 4/4] selftests/resctrl: Fix non-contiguous CBM check for Hygon
Date: Sat, 13 Dec 2025 15:38:11 +0800
Message-ID: <20251213073811.3016864-5-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251213073811.3016864-1-shenxiaochen@open-hieco.net>
References: <20251213073811.3016864-1-shenxiaochen@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl selftest currently fails on Hygon CPUs that always supports
non-contiguous CBM, printing the error:

  "# Hardware and kernel differ on non-contiguous CBM support!"

This occurs because the arch_supports_noncont_cat() function lacks
vendor detection for Hygon CPUs, preventing proper identification of
their non-contiguous CBM capability.

Fix this by adding Hygon vendor ID detection to
arch_supports_noncont_cat().

Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 94cfdba5308d..f00b622c1460 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -290,8 +290,10 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 {
-	/* AMD always supports non-contiguous CBM. */
-	if (get_vendor() == ARCH_AMD)
+	unsigned int vendor_id = get_vendor();
+
+	/* AMD and Hygon always support non-contiguous CBM. */
+	if (vendor_id == ARCH_AMD || vendor_id == ARCH_HYGON)
 		return true;
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
-- 
2.47.3


