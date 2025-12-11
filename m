Return-Path: <linux-kselftest+bounces-47392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D4CB4EBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 07:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144C930281AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077F2C0F65;
	Thu, 11 Dec 2025 06:47:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841312882CD;
	Thu, 11 Dec 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435638; cv=none; b=CFesyMcRn7gaOBdmh7i4pjATbzZkkBFAbT64wMJFsx6lf2m3ulLZwZuT0MkXw0DLOpiCT5BFFO+gT4PMrAHGwIUj0ElZ9aMSZsXTP3oPiNLBeloeuRz9lS0mcJx6CdXnQTywPc+1g6bEDl1iy6w2Ek4m1PLxjxOwHpUaWnWguWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435638; c=relaxed/simple;
	bh=DqP/hJfyPqzgzGn53rBaJvj9v6j0Lfk8qad3fEOXkbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhD8krTlhU9uPGHZCefVND5GbYqCOUduu/G5vbjvsk6frDkb8GKNjeN90Yed/N/iotG3Ig8R/5sB1tjnNrm63EqAyLgioCid4pRO/Fmy1Z66cWMTSa9uBacCu32NNTPJXCHMgtjGUpTGceSczIiV7Uly1pkuhc7mvH4w46nP0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fhodoYA_1765435626 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 14:47:07 +0800
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
Subject: [PATCH v3 4/4] selftests/resctrl: Fix non-contiguous CBM check for Hygon
Date: Thu, 11 Dec 2025 14:46:32 +0800
Message-ID: <20251211064632.2344393-5-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
References: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
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
Maintainer note:
Even though this is a fix it is not a candidate for backport since it is
based on another patch series (x86/resctrl: Fix Platform QoS issues for
Hygon) which is in process of being added to resctrl.

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


