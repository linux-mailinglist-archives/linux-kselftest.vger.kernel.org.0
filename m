Return-Path: <linux-kselftest+bounces-47629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C265CC5DEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 04:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43293027E00
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 03:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C15262FDD;
	Wed, 17 Dec 2025 03:11:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C193B1B3;
	Wed, 17 Dec 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765941073; cv=none; b=Atre4Qduc16osYiFr0gr5EcAQvZua6tOdBsq+dAbyUUJTPo+lTOW45oB3JMKESKWflF2Du8jHn5nUMtLZyF1NmAVFPgbrdPUcrZ9HNlqF6k/sBpehxSentY6pKjySQ3PgDGx0Qo1kzvQbPR7awTKoKWpEn326a4NG1WtSbF/EFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765941073; c=relaxed/simple;
	bh=PxGqK+Upare33OSoP8+pD90vk5IxEEo1RRc2j6W6CP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khOg+GztbKf6zteA2TnvYiJ9g3J0t+0+llDWCvtmTHmGucLiVAMqzbx4XKozJ6R0fNeJ78tANEzszaRd1XbHanvHiCoA6vhU0aTyOwOZsQ/x4KVhkKyVckWE1gkYIZRL1KzKytztJPYU1GC0UWQDpC91CZimzlTqCQgxoudu1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fmLmmDA_1765940740 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 11:05:40 +0800
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
Subject: [PATCH v5 4/4] selftests/resctrl: Fix non-contiguous CBM check for Hygon
Date: Wed, 17 Dec 2025 11:04:56 +0800
Message-ID: <20251217030456.3834956-5-shenxiaochen@open-hieco.net>
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


