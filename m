Return-Path: <linux-kselftest+bounces-27549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B1A451F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAFF17EF4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F152192D98;
	Wed, 26 Feb 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHbjbEcw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9818DB3E;
	Wed, 26 Feb 2025 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532063; cv=none; b=SkZ6tndtvZKaEoqq6koDmQg2MQTiANsl0Ny96lV3u6lpu+013pmOEnkBT5I9x4SteiDal3EC/uv2/RQrkGSm19HtE6oiFKPPFsajoaiTu3OjfPWg4ny+YwKih9SO/U/IDDM5HCcUmKFP4clVFdmSsQC+/PSyrtEhPTTDbDxjKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532063; c=relaxed/simple;
	bh=4sTOw2av5PulmOSKLaCJyfyuR6ivrfW3vA9KaO3Cjfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCJwfX2qrjukSoCUjjln7Mj/o/ce7LQeSsx0kLHxD1Ng2X4jlRAP37FZFvczt9OPYh3i/9Hyrck+4eC2EudO/B9r51pOLYAjaUA/Pl4WeQoXrQZ16BH2ZCPH1KPmC0CxFu1SVLdO1E8dSKK+uaRqQylHghgMHJwy8VAgwW8MCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHbjbEcw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532061; x=1772068061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4sTOw2av5PulmOSKLaCJyfyuR6ivrfW3vA9KaO3Cjfc=;
  b=cHbjbEcw33YKPGUVSIT7ukl1HngEwpG791Ls8sZyyE7P61VSxz7pQQmp
   LaFayXKxxN+Q/09T3oetWgiDPW/YEYdXDU2YVgu7oNtdvOcPHRAF3Lz3P
   pnfYnrPB3SyDkOWKbdyWjZlj0dwxLkJoRUVfQL2bEqCIQ73nPvRK0NnQC
   BVN1pLNqFqO+S2Obzji/JDIQevJtUTmUN9qLAUA26SrUbAl47VwN8EibW
   u4XbfvJgtEqlCUDEUjWaU36VUkoGEIItf1Wxq2DNq5rnXn4Z/Ffbf0zGM
   qnb/7cADB9j7FdufvzWbUXm+Rxc571w+cJEExsGOuHzUkW96gl239s8TU
   Q==;
X-CSE-ConnectionGUID: 4o9VWn48TpGBmEhP6/o/Vg==
X-CSE-MsgGUID: it2iQC/+R/2ZMP5borl5Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362228"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362228"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:41 -0800
X-CSE-ConnectionGUID: D4RKixikTgmzrFGdginQ4g==
X-CSE-MsgGUID: Y07lTYroRtK1SdRbGK0oTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467363"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:41 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH 8/9] selftests/x86/xstate: Clarify supported xstates
Date: Tue, 25 Feb 2025 17:07:28 -0800
Message-ID: <20250226010731.2456-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226010731.2456-1-chang.seok.bae@intel.com>
References: <20250226010731.2456-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The established xstate test code is designed to be generic, but certain
xstates require special handling and cannot be tested without additional
adjustments.

Clarify which xstates are currently supported, and enforce testing only
for them.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 tools/testing/selftests/x86/xstate.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index fd8451e55f3f..875777911d82 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -15,6 +15,24 @@
 #include "helpers.h"
 #include "xstate.h"
 
+/*
+ * The userspace xstate test suite is designed to be generic and operates
+ * with randomized xstate data. However, some states require special handling:
+ *
+ * - PKRU and XTILECFG need specific adjustments, such as modifying
+ *   randomization behavior or using fixed values.
+ * - But, PKRU already has a dedicated test suite in /tools/selftests/mm.
+ * - Legacy states (FP and SSE) are excluded, as they are not considered
+ *   part of extended states (xstates) and their usage is already deeply
+ *   integrated into user-space libraries.
+ */
+#define XFEATURE_MASK_TEST_SUPPORTED	\
+	((1 << XFEATURE_YMM) |		\
+	 (1 << XFEATURE_OPMASK)	|	\
+	 (1 << XFEATURE_ZMM_Hi256) |	\
+	 (1 << XFEATURE_Hi16_ZMM) |	\
+	 (1 << XFEATURE_XTILEDATA))
+
 static inline uint64_t xgetbv(uint32_t index)
 {
 	uint32_t eax, edx;
@@ -435,6 +453,12 @@ void test_xstate(uint32_t feature_num)
 	unsigned long features;
 	long rc;
 
+	if (!(XFEATURE_MASK_TEST_SUPPORTED & (1 << feature_num))) {
+		ksft_print_msg("The xstate test does not fully support the component %u, yet.\n",
+			       feature_num);
+		return;
+	}
+
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
 	if (rc || !(features & (1 << feature_num))) {
 		ksft_print_msg("The kernel does not support feature number: %u\n", feature_num);
-- 
2.45.2


