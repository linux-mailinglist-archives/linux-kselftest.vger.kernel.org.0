Return-Path: <linux-kselftest+bounces-15205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193B9502C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDB01F23525
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 10:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9845170A0E;
	Tue, 13 Aug 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmeA7ZZx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E876025;
	Tue, 13 Aug 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545939; cv=none; b=A+MteoZX+AyiuQCI8FHfffG2694jnuFh6bdR980Mp+8U350/rfJjcIr3J6vHu8QVoTVfYh+f7EkiKmGh24u1EdrPn+MIqeSymc2peKr7fNBQfuOEVqLAUQmS9gMYFl6wCfKewBHl8EuoTdJSkS7PJ5XcgT+hXWRuDZCj8G+6N4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545939; c=relaxed/simple;
	bh=Wc6JtmV6Oc9mUVenADICsjG8fBbJzxjtHcl4cNUR74w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOnY5sh8BARJgXCggbardiywiYLg9wiwNjFOULJLabCU/x8qSDkfBIA+LEnoI8wtW04G9PU3UmG3/Qv5svRUmeJJsZ2tPATxQoqLwSu4dtBkPvrCaA7BY2GUfFLrNNoR20+F/p7iIK/BtarzEuOjezQTwqqqUKFqtBISD+hlf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmeA7ZZx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723545938; x=1755081938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wc6JtmV6Oc9mUVenADICsjG8fBbJzxjtHcl4cNUR74w=;
  b=YmeA7ZZxS1iHsVOKOjp60X4zDZIxScHtVpbn/IgNmV8bqU3N/xymuJKg
   ZEZDIBA8QQzAEGlLmru9gZ79aINMrcI0gDDEsLmrEtoHGTTrOtiPeA4qq
   bNb/FrH88OTYcRBHzLQAQqExNmMj0+kDC1MY1h9Yg428DpzHNARp9n8MX
   FcMs4fASrKiMID/X2HVYIuoWL84HGuGrJahr9wS5CpIfPNPfQXejxG4zR
   RzZz//wDHMdE7dCN6/H0ZPwRkK6bCdUe93v3bsbF36Dpbq7pOaS75ziYy
   PmlK89dpN9GMpFGbbMZjwDKZcHF6GroYffTJGBrlEsJrjr+Md02jgsO05
   A==;
X-CSE-ConnectionGUID: Ly6o/u5ySDK604cskoLxdw==
X-CSE-MsgGUID: rQ07yxktSy2XxoYNDDLO/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39148373"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="39148373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:37 -0700
X-CSE-ConnectionGUID: Lf554aaQTcCm4QW0zSEftg==
X-CSE-MsgGUID: 5oR2ceEbTtitKUGbcCPxAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="62786950"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] selftests/resctrl: Generalize non-contiguous CAT check
Date: Tue, 13 Aug 2024 13:45:13 +0300
Message-Id: <20240813104515.19152-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch_supports_noncont_cat() checks if vendor is ARCH_AMD and if that is
not true, ARCH_INTEL is assumed which might not be true either because
get_vendor() can also return zero if neither AMD nor Intel is detected.

Generalize the vendor check using switch/case logic and return false
for unknown vendors.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 26 +++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 742782438ca3..51a1cb6aac34 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -292,19 +292,25 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 {
 	unsigned int eax, ebx, ecx, edx;
 
-	/* AMD always supports non-contiguous CBM. */
-	if (get_vendor() == ARCH_AMD)
+	switch (get_vendor()) {
+	case ARCH_AMD:
+		/* AMD always supports non-contiguous CBM. */
 		return true;
 
-	/* Intel support for non-contiguous CBM needs to be discovered. */
-	if (!strcmp(test->resource, "L3"))
-		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
-	else if (!strcmp(test->resource, "L2"))
-		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
-	else
-		return false;
+	case ARCH_INTEL:
+		/* Intel support for non-contiguous CBM needs to be discovered. */
+		if (!strcmp(test->resource, "L3"))
+			__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
+		else if (!strcmp(test->resource, "L2"))
+			__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
+		else
+			return false;
+
+		return ((ecx >> 3) & 1);
 
-	return ((ecx >> 3) & 1);
+	default:
+		return false;
+	}
 }
 
 static int noncont_cat_run_test(const struct resctrl_test *test,
-- 
2.39.2


