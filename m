Return-Path: <linux-kselftest+bounces-16022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D995AFF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2231F228DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AF01741D1;
	Thu, 22 Aug 2024 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U60xBCVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBC17084F;
	Thu, 22 Aug 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314316; cv=none; b=IEwaT3mr7rRcuS8PRHMgZP5HjGzR++FltVVKGOyvOd4/Yrs047N+p9JxH/Baapl2sFEWl2m1whVyydLOztJlbFyieNd0O7wPxvCvSWl+B+vqw8iI7kAKTzqfxwM5R/Kf9BzsDAisWY+E7SHqItHaQGnLr+SUB73hJx7dan+y3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314316; c=relaxed/simple;
	bh=OkheW9fep5gmAkh23uQK2aIyS0gnyMxZh++kQMkX4rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQNg/2z0mlCS2xFu5VMUcjUvq7w85p9jRWwiOZAEK+0ClYCoEDXYuVWjUBNe/zsI1zIBjCfGDMs4gjYndgV/LC1WfgdneEGbzLbVi5UyiRoPaS0VvAFuT97/3DnS/qw1kJRUEcSZRmaTbDoeLKZb4Yf5JtpliIT33Tg1HxsCRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U60xBCVG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724314315; x=1755850315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkheW9fep5gmAkh23uQK2aIyS0gnyMxZh++kQMkX4rY=;
  b=U60xBCVG1xaRw//1DAQhPGXFm27MsBUpQddac6tBgKtX0il/r52PXJ4+
   z+wkIJNOSzjoR48zZs2oQFda36hl2WwZp7baXHyWvUhenvlduZ3oT5tR5
   OFvNuqiiIHGnkLD/RuiCsg5JV2FyDD7vkfbnec+2p6gyAZfZul2kxxh/l
   sz8h++Vp4csrTQqAq7vEk5DNnGd0luDNGWI/AMHATB38PMh2OfzpMHN1I
   TalLc+wdA6T+YZLM/T9YcWvdoIzsf4als7DR0NG99AOJNz/WC1atYGupP
   KUaQcp0vaZZ1GfTC4EyU9Sz/zTzn99wXDObm1PxsM/p/Dgj0/4V1SIaa2
   A==;
X-CSE-ConnectionGUID: QtrDgxT3RmyUGlqnB6Ur9A==
X-CSE-MsgGUID: DuFz4s9wRfO7WjcCAwqxfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33331685"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33331685"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:11:53 -0700
X-CSE-ConnectionGUID: kCtUWrgkQgmUv0oo3Qjg5g==
X-CSE-MsgGUID: ejyAgPK/RGmkqAuhBA1Lyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66182026"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:11:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/3] selftests/resctrl: Generalize non-contiguous CAT check
Date: Thu, 22 Aug 2024 11:11:12 +0300
Message-Id: <20240822081114.4695-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
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


