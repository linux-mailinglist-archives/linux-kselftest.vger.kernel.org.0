Return-Path: <linux-kselftest+bounces-22579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D89DAC91
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C48281EEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EF6201028;
	Wed, 27 Nov 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzbK3ut0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A7E2010EC;
	Wed, 27 Nov 2024 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728965; cv=none; b=NPAp+JXwV6g6iPizb5CdJCh7C/x85o3a8dRtwqSPQSZ2PJ+l9VunZVWwwyD1Ev8WVXjSSQU/ww3/5J3C2PhTknvuqt7Du7P1lk9lLZtsIGYB5tSHSmwzJV2UAgfQxlSVBijo2lhwLqpuBkeI8PQtrSMBlWO1cLDAamfIxQHnfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728965; c=relaxed/simple;
	bh=RF4rG7dZqGqAjCmjHOsGfY+CZsIm6V7+eg4OHintPpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM+28MzC2N61lB3YqbDQqwU8QrMdRfYlP2fR58/BQgxqfQapwUUuGRhOqImCtrNmmtGYNt3em/54LH6V0Y849iL4jDfr4iO/3FNoNRFXI2N8H3KID6SksGUh0ku1qn0/shHLtp0Y4/gulnf0bUdu4M600NBydyiyBMq6DGBX+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzbK3ut0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732728964; x=1764264964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RF4rG7dZqGqAjCmjHOsGfY+CZsIm6V7+eg4OHintPpk=;
  b=UzbK3ut03d+J7CArNZBuHyvQwxbvEyCF4s4ClWHVZ+bmio9gtI0c5KJd
   GTuWxVkhNWJtH7Nc7nNGOWoS8c+NiMY8Y3aruHkGCc1N5ts7LV33tgak5
   QctmCgv6isJsxMnWeAD2ekXjwViPeF68matYBwRwF/qz36mvkksuJlaDn
   PZIe7UiAJS/0EYcWeCrEomJd9ZXCjwUDkdaEYamP/g/Gxtr6OXtjrvWuE
   w/+p9MltmSWJ0sUSHZyDDYyDHCKDumRR2AxCjDL54fytR+uxOZQtUtPGB
   FQgKYwq5IF+pI8HU6xx/EyBye/x61/v3uZYstMctOxCB87OyI1IVo+EGr
   g==;
X-CSE-ConnectionGUID: 6MnxV0NpS6aDegdbOtCtzw==
X-CSE-MsgGUID: f/w3AxoKSdCp3GJ1TN4NcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43607515"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43607515"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:36:04 -0800
X-CSE-ConnectionGUID: 59gh4jNbTsinhWC6nKmM7A==
X-CSE-MsgGUID: KULZOYFgThuRaUNs5a802Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91626348"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.193])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:36:00 -0800
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
	maciej.wieczor-retman@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 2/3] selftests/lam: Skip test if LAM is disabled
Date: Wed, 27 Nov 2024 18:35:30 +0100
Message-ID: <09e6958c424a5da763f2331745cfe145962b0a83.1732728879.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until LASS is merged into the kernel [1], LAM is left disabled in the
config file. Running the LAM selftest with disabled LAM only results in
unhelpful output.

Use one of LAM syscalls() to determine whether the kernel was compiled
with LAM support (CONFIG_ADDRESS_MASKING) or not. Skip running the tests
in the latter case.

[1] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changelog v4:
- Add this patch to the series.

 tools/testing/selftests/x86/lam.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 93f2f762d6b5..4ec37a4be007 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -124,6 +124,14 @@ static inline int cpu_has_lam(void)
 	return (cpuinfo[0] & (1 << 26));
 }
 
+static inline int kernel_has_lam(void)
+{
+	unsigned long bits;
+
+	syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits);
+	return !!bits;
+}
+
 static inline int cpu_has_la57(void)
 {
 	return !system("grep -wq la57 /proc/cpuinfo");
@@ -1181,6 +1189,11 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
+	if (!kernel_has_lam()) {
+		ksft_print_msg("LAM is disabled in the kernel!\n");
+		return KSFT_SKIP;
+	}
+
 	while ((c = getopt(argc, argv, "ht:")) != -1) {
 		switch (c) {
 		case 't':
-- 
2.47.1


