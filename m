Return-Path: <linux-kselftest+bounces-22538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E59D98A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 14:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31512B254A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995B1D516E;
	Tue, 26 Nov 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKm4tyid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5BDF78;
	Tue, 26 Nov 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628157; cv=none; b=KNI4ggPk+cOdoFQ3wO6mNkui15Xr5/iHmlYm/gQxpuvjFGqgpAA8+qlyh4hFw4hb81xY8XN5jistdOzVOjU5DBNVjx5HKRnTFw+6RgADHaN9OzuFB9OdJ7jQ4Sa8H7bGTVSkuTiBhGS9QfRUVwi47S3+q+iAwcwQEV5Fv8HJnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628157; c=relaxed/simple;
	bh=AeCvd7Yno46s8+oOSsWLJmA/0+F3XIUcR0CFLZf+laA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7o87k0ffluA8IlEYUZzvDdjTKF8QfxqcwNE7qurukqvR8vtX330fE2FhrYcKY23ULUQa5aLjfH12vgcqZx82gcqk2w85/93eW+I+LO281ROoNUrM0rLpijWJPM2fd1ZTtiEOUxDEO+Q58AgUgdpXc4Ob76MOZtQx8IpOxmxwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKm4tyid; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732628156; x=1764164156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeCvd7Yno46s8+oOSsWLJmA/0+F3XIUcR0CFLZf+laA=;
  b=HKm4tyid2QoJvBq4i0omdUAmfP7yJeuPWGpMCuikuQQzenGqyxL2xEix
   r5eaGn3Lmhte3OW6qXdQ3vf2aVlUFebMPzgZPVr1bpHTfRfXfMF/GocVY
   VAYd21hQpGJqlvPo9Zx3LdaCq/5YlAfsxhVak7JHJs0swUPZoEotQX335
   Xaq2E1aatQsNeJQ/oOR4YREyTsQbsn71zB+xPtbDoI5OF3cEy1SPV3Z6B
   jSyK4FaIUvzgC1vK9LkS1w54cDuRoB08lPa8hSzUBIhWXGoBMMwABnWp9
   AgXXzS3kl0LSMslde+KvMRc780QyaI4dVy1agX2TQh4fNp2RnwfWbBO/b
   g==;
X-CSE-ConnectionGUID: lB3XmAomRb+0UcwOwul+7w==
X-CSE-MsgGUID: i3X8J9LxRLOVHkUG0A36zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32727823"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32727823"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:35:14 -0800
X-CSE-ConnectionGUID: nmCTSLu3RAWK2QqG9V6Vyg==
X-CSE-MsgGUID: Y0LRNZCzQC+peR+dmScA2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91782188"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.170])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:35:11 -0800
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
Subject: [PATCH v4 2/3] selftests/lam: Skip test if LAM is disabled
Date: Tue, 26 Nov 2024 14:34:49 +0100
Message-ID: <09af68980f1c32f013a9e3b39fde70647f4a8879.1732627541.git.maciej.wieczor-retman@intel.com>
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

Until LASS is merged into the kernel [1], LAM is left disabled in the
config file. Running the LAM selftest with disabled LAM only results in
unhelpful output.

Use one of LAM syscalls() to determine whether the kernel was compiled
with LAM support (CONFIG_ADDRESS_MASKING) or not. Skip running the tests
in the latter case.

[1] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v4:
- Add this patch to the series.

 tools/testing/selftests/x86/lam.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ac805125ab2..5aee3e231a96 100644
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
 	int ret = !!system("cat /proc/cpuinfo | grep -wq la57\n");
@@ -1183,6 +1191,11 @@ int main(int argc, char **argv)
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


