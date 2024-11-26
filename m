Return-Path: <linux-kselftest+bounces-22537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8E9D989C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 14:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D51164151
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC631D5145;
	Tue, 26 Nov 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCwEqDXU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C81B652;
	Tue, 26 Nov 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628156; cv=none; b=MZb07P5AAyXhXRvut/9aOAkEuroLI66mTdQpQcaXiQURej6oZqdx93XYAV0x3vAWKOsBazH/f4UDsK7Xoa3IckEW5WNgfb30Cg2rfaCil0or6xHl6gZHTFjppVfRyCEsqMy3Lr2imZwambWgSREV3rrZzcsUepgHaQFlFYxXz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628156; c=relaxed/simple;
	bh=n745VD2OvPkixDHWabVD2p+eyvl2SoAh53Jc/3xQELg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsG4HqFBvcW/SQgWVYu+rNjHYi6OcQZzOL9pkf7+F2TcuVFfBwgyorcm2qFmw1gxXwvem5kEVTlifIuxxmvIagGqF43RycKIyRI9mOgFbBqxtUfS6pDw38XPBZW0l8MwovX0HDC3Jrr8uKHhOM63/ejKm4iKeOjUCPkJikzSS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCwEqDXU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732628155; x=1764164155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n745VD2OvPkixDHWabVD2p+eyvl2SoAh53Jc/3xQELg=;
  b=HCwEqDXUMFPCobiqK4KVuaelwXnyefKGVQKHxNrrVx199PquFonIj33l
   IhtEdCz4xO3I4BZwoYeYpzLE6wrR1XBjfGl2UkmRPLzsLFzOVPLoaNrg2
   FJaybUJF+2JGEFTqShJPWs2yH5GhciHIB2DkBcat7atlkemiA8KuInLVy
   rkqQpO7ug7b2tZDC09j25JwQUyAjAN6j570PAgHUfSfWciii8uavuy+Sg
   CGulL26IwVbmFcqkdA/EZqRKixzaWP7T+TX0WE0uS5FwCQbfXtwpzdVcw
   +4dVk5agxVeFlVXRY2HzdaThfIDa5wyw+UwzhoU1ComM3HR6UqXkHiS1+
   g==;
X-CSE-ConnectionGUID: ZhWjXSo5Soi+E0vAyRlrDw==
X-CSE-MsgGUID: ncdbLRYrTXqK0zfQs2SXwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32727814"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32727814"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:35:11 -0800
X-CSE-ConnectionGUID: bFFjyPYnQZ2WyhMCtQKiug==
X-CSE-MsgGUID: P1EDm4I/TRyRiE1BllEf1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91782181"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.170])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:35:07 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kirill@shutemov.name,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v4 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo flag
Date: Tue, 26 Nov 2024 14:34:48 +0100
Message-ID: <4979b3de7021f34cbef22d44799e28c914f993ca.1732627541.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
References: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In current form cpu_has_la57() reports platform's support for LA57
through reading the output of cpuid. A much more useful information is
whether 5-level paging is actually enabled on the running system.

Presence of the la57 flag in /proc/cpuinfo signifies that 5-level paging
was compiled into the kernel, is supported by the platform and wasn't
disabled by kernel command line argument.

Use system() with cat and grep to figure out if la57 is enabled on the
running system.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v4:
- Add this patch to the series.

 tools/testing/selftests/x86/lam.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..0ac805125ab2 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -124,14 +124,11 @@ static inline int cpu_has_lam(void)
 	return (cpuinfo[0] & (1 << 26));
 }
 
-/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
 static inline int cpu_has_la57(void)
 {
-	unsigned int cpuinfo[4];
-
-	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
+	int ret = !!system("cat /proc/cpuinfo | grep -wq la57\n");
 
-	return (cpuinfo[2] & (1 << 16));
+	return !ret;
 }
 
 /*
-- 
2.47.1


