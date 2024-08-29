Return-Path: <linux-kselftest+bounces-16678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA9964635
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432701C2119A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499A191F89;
	Thu, 29 Aug 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GA9kBnfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F417571;
	Thu, 29 Aug 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937439; cv=none; b=dluI7+jveY1db9QshNwm6FfjLUI1chKyS/CERErkEWtRuYWRp4a4m+H+jSlA+n0maIVHlJw7WbbguU2XLQ98gU5UE8wIgVQyv49akWRAqppF5QpoYhkxfp0bYlYJSxPYNoZR6nlGKkzKpyj42ChbtEQvzElFX5A/jphla0mgdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937439; c=relaxed/simple;
	bh=OkheW9fep5gmAkh23uQK2aIyS0gnyMxZh++kQMkX4rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB8A9f5uScn9yWZfoeZaDMXbXnI46V2gEgk6xOlMmP9Pnq1Fl123Fq3mV1SNWsOUYtN2MKCRFVikBCfvs2SgW1lge5akPt5JLfdh1W0WLldTz02bub8Ti03wf05qaYLYftiTMOtFgNdRJfSAP+kkBx7yRd2ZZQhPUNaanIFTbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GA9kBnfx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724937437; x=1756473437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkheW9fep5gmAkh23uQK2aIyS0gnyMxZh++kQMkX4rY=;
  b=GA9kBnfx8XJik29/gcb1VXKvTer4Yt09ztIjcp5KOMIbm07T6PiwSccN
   xUlpkCjlxo2SGFheTbdYYKRnUUhvp+KdlnynFI3qJcuHBsqppM1YZ+SOe
   qK1e6IWME2AksRCA8ufzjskYCXB4WcNqQk7fZFTzCnHggxBwc8pAD8DSU
   bjow/4Es0udPR0QiVitbw+PbnWBhsprs8/2ZQihiLT8+Wms2KU0lsXS21
   JgCz3swyxiCofETL9QTHIGP26bmmqXMa/nKH1judfOwn6fVApveX2a75Q
   vrhaS99eT1j6z2auP/ra5MfKJi9/3uj+Ee28aLvhFKRIqO1PKK2/YkJ2/
   A==;
X-CSE-ConnectionGUID: 9zSLc8sRRiSZJT+pivhdeA==
X-CSE-MsgGUID: QuNVAxY4T+OU5sKrqn2chA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23656465"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23656465"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:17 -0700
X-CSE-ConnectionGUID: qoUlIOT0TyOKUZUzyzqipA==
X-CSE-MsgGUID: 4saiCVzbQfOyOLMF1RwrGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68461021"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/3] selftests/resctrl: Generalize non-contiguous CAT check
Date: Thu, 29 Aug 2024 16:16:55 +0300
Message-Id: <20240829131657.1917-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com>
References: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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


