Return-Path: <linux-kselftest+bounces-17046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2296A0FD
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA078289C3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40113D625;
	Tue,  3 Sep 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzYawxx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A714A4E0;
	Tue,  3 Sep 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374750; cv=none; b=LnR/yfVxPuq1COX4u7r+c037NghxnMPjV7IsNqd/8uu3VyBDh9kezsNIPiT3FrZ2Ri5WIxqI95J9aWay1vViHoFGeWtulTeyXkvljhbEpgdmbobSsLCtHSuifsOmXOCx7Vv9l0KthAhXRkUYN8L44eSxg67ALy+/WVsdBH04Q3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374750; c=relaxed/simple;
	bh=OkheW9fep5gmAkh23uQK2aIyS0gnyMxZh++kQMkX4rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KX1ysbx8POSnbex8R3n94XQBdrCxaOJ24jQ/u1FaQXO4RH1eYChJpXjsw7oxZyBb8KYQWAuRthDTdr09WWrYGZ4wSV/3ddHsvcmSMcOYQe2GMiyivQkUbtKYl6jf4sJnDUu+gY/XuKW40IzPJPPJJ7Ntc39PlFP40BsZt0AP3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzYawxx5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374749; x=1756910749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkheW9fep5gmAkh23uQK2aIyS0gnyMxZh++kQMkX4rY=;
  b=CzYawxx5pDYAx6Qgk3VTk8WKYXG64Z4j8PL9pn6JoZbko9WKDsm13NPr
   CTkvhwukUlWuwpOxQGDIEytFR2J+pae7B+8lXESdk1UVGnOfBuRUG1O9/
   sxh+a+xP7Jxvpd2Zqjgb/EFVW6tpUv5v/tUuLre9THHxR7pO1rZDqPFKp
   voUeDugwmwfIHnSYmLTPRayM3C/dWOKCNcSOsQl847RL/Gbidk7pTQZL8
   7rTTaFeGSXN7Y5Yz9j+p3LOF6wsg6kq87cJx3X9eh+knaeyKUB/xsFN1P
   d+9ym/sMJArxvZtHstycGDjjKEbIB5OTV411yxRC+PG136GhMF3PasBij
   g==;
X-CSE-ConnectionGUID: pEsEjGyTTUycNWdoT3rGRg==
X-CSE-MsgGUID: yFcjgDhBTgaMGOrlnGryZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24145195"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24145195"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:48 -0700
X-CSE-ConnectionGUID: ojV7Tc9nSq6TCIQHLxfHmg==
X-CSE-MsgGUID: cHXnl2mfRRKkC+xuD58aRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64577442"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/4] selftests/resctrl: Generalize non-contiguous CAT check
Date: Tue,  3 Sep 2024 17:45:25 +0300
Message-Id: <20240903144528.46811-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
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


