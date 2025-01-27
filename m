Return-Path: <linux-kselftest+bounces-25234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64980A1D994
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 16:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2489165EDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501314A4FF;
	Mon, 27 Jan 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4VY0Pnj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547613B5B6;
	Mon, 27 Jan 2025 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991956; cv=none; b=hX1F3z5oNx308QJLLcP9Hj5Xmr8IhiwXK1/J/gaTaLt9hoCJRuYK2NUZFXi9CarU90st69kcCCKtdX7hHJJRm/d4roczob7g9PM0h1rx5COPDjUYYAI6Rh7Cu4rPtYxe27TcggrTiWPOx7wQwGoDpLUF+8LPHAymVqNlpsv4xcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991956; c=relaxed/simple;
	bh=bOjM2226V6PMVgj0kRjSRLHjNPeXWeaMQDCKIJKmn3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwgBJnQbFwN3RABlx8wpGnouGRdH0yS6SJk2c1i8k2kLcqi2izN9I6SYonlFptg7ETFHgBmOFhAkVLcuOclrxzsOb9JrnpJpcLlGsoZCQIByhYOLaJApHbPUwoFEVE/PIkSGaxZHygsvaeifYwyb92gG6jyfUkz1IQhe4NZb76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4VY0Pnj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737991955; x=1769527955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bOjM2226V6PMVgj0kRjSRLHjNPeXWeaMQDCKIJKmn3c=;
  b=L4VY0PnjHbaF9hELKMS9yd+QYxQtK8djV06U1tw/VEmuDtC5pRwx0U6k
   PL7CFkjSDlIL26QYN7gneXES3RBd19Sz3gVWviHoeI4XJdXJz+71RfByK
   jSHb4WCDGir89FwPqk0KPU3Om45A35Ld5HbV0ZItQVIGGFXvz4YvQm9P7
   kiDn5D/8URDTb7KvVQ46vi8jKQVjtgxUpogf+k8v5GnSRmr/E/96xNYh5
   CeTLib7bL2Zw8xXoaittFRFpm70MoiLCC2RkvPkq0Ej/76Xcw8+Cy5Umz
   pDmn6AMwIRRrGCAvZJEInqlI88veHQC0i1TCjcheUrdyAyqWl/fmMP12M
   g==;
X-CSE-ConnectionGUID: 7cm5RhNTRyanQRlI8NP3zw==
X-CSE-MsgGUID: Tx5/ZiQLQJCiuKXp+0B/XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38344109"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="38344109"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:34 -0800
X-CSE-ConnectionGUID: 9N4kcibkRfqCQat2nlhgYg==
X-CSE-MsgGUID: +Rnia+ZlTtitJjBstVjJPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108991060"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:30 -0800
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
Subject: [PATCH v6 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo flag
Date: Mon, 27 Jan 2025 16:31:55 +0100
Message-ID: <8b1ca51b13e6d94b5a42b6930d81b692cbb0bcbb.1737990375.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737990375.git.maciej.wieczor-retman@intel.com>
References: <cover.1737990375.git.maciej.wieczor-retman@intel.com>
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

Check whether 5-level paging is enabled by trying to map a page in the
high linear address space.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v6:
- Go back to using mmap() to check la57 status.

Changelog v5:
- Remove "cat" from system() call and use only "grep".

Changelog v4:
- Add this patch to the series.

 tools/testing/selftests/x86/lam.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..1ce6cf322c3c 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -124,14 +124,18 @@ static inline int cpu_has_lam(void)
 	return (cpuinfo[0] & (1 << 26));
 }
 
-/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
-static inline int cpu_has_la57(void)
+static inline int la57_enabled(void)
 {
-	unsigned int cpuinfo[4];
+	int ret;
+	void *p;
+
+	p = mmap((void *)HIGH_ADDR, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
 
-	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
+	ret = p == MAP_FAILED ? 0 : 1;
 
-	return (cpuinfo[2] & (1 << 16));
+	munmap(p, PAGE_SIZE);
+	return ret;
 }
 
 /*
@@ -322,7 +326,7 @@ static int handle_mmap(struct testcases *test)
 		   flags, -1, 0);
 	if (ptr == MAP_FAILED) {
 		if (test->addr == HIGH_ADDR)
-			if (!cpu_has_la57())
+			if (!la57_enabled())
 				return 3; /* unsupport LA57 */
 		return 1;
 	}
-- 
2.47.1


