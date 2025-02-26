Return-Path: <linux-kselftest+bounces-27544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8015A451EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6830919C3821
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE05E186E2D;
	Wed, 26 Feb 2025 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4RinY7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D638155A52;
	Wed, 26 Feb 2025 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532059; cv=none; b=k/EnEpiDibo1DguGx4v0D+mGGdHrqulpv+sGj4FKpB2jWcXUqcdq02A80AWlsUxOUlUKP+11F+NVJPGybct0aSBIgF7icRbmWpIPYw6lfBjEMjT7SQmwi4T+G2iDTcYPR9u8lmQoWGSiCQHoSg95SS1erJwnQSqhO55rEgi2Pv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532059; c=relaxed/simple;
	bh=S+6m2ahVPH+LSNhzYKSi30AW7vgAqg0xXfDPaKKHiaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evpMjFvIR8YDu6MAo0uDn/HxHYY9e87DNueWm3mG6amIJ20V/RDcAyIeQV0rOw4o9UmJaB64y+TWP9uvusKKdRfjZsj5dVQGMOWswsx99ZAypKFHzchc3OCW5s35540RGWtyfjdrlqaYaUarq73ix2PUU1nCVQRQqF/2+Bb+Ktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4RinY7j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532058; x=1772068058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S+6m2ahVPH+LSNhzYKSi30AW7vgAqg0xXfDPaKKHiaA=;
  b=h4RinY7j021aoVBiVWNop3wVOC2POaPDx2jhP1IkhItsbSSI5Y0C12bh
   TqnRv5uBUDG+uJv5oxKXmHsajqarFQfbEZ3eu3JxfEeoAMxZn6/qoxX9Q
   mqEeAe1svjRiao/4Hv4iHP0uoZT87bddFjV+G/xqdM9IjLEj0rh8OftOe
   2b0A7tsmSdY38wK4GPoNlhmaBaesLXo8E6UlMObxYQAbfsyqM2VcPQ/WR
   38o8Cu6yZnq8J830Z7/uKDICpHwPtXe3i84IOfQKnaeJ3Iu7/5BQI+BQp
   o4Xps5T6IFhlIbrKVAUIuHrN/Yiz3ddnTzX9FAaVIdtZ9r+h7dMeeP3zf
   A==;
X-CSE-ConnectionGUID: +r7naifvTLqcbLsEqJd03g==
X-CSE-MsgGUID: c4qUxtfIT56ZVtqhCbBeOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362191"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362191"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:36 -0800
X-CSE-ConnectionGUID: 5xFzlMoER5Gzhv9UiAsAxA==
X-CSE-MsgGUID: XwSt+c1ETn2Da42kjVCcEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467345"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:36 -0800
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
Subject: [PATCH 3/9] selftests/x86/xstate: Enumerate and name xstate components
Date: Tue, 25 Feb 2025 17:07:23 -0800
Message-ID: <20250226010731.2456-4-chang.seok.bae@intel.com>
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

After moving essential helpers from amx.c, the code remains neutral
regarding which xstate components it handles. However, explicitly listing
known components helps users identify which features are ready for
testing.

Enumerate xstate components to facilitate identification. Extend struct
xstate_info to include a name field, providing a human-readable
identifier.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 tools/testing/selftests/x86/amx.c    |  2 -
 tools/testing/selftests/x86/xstate.h | 60 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 366cfec221e4..cde22f303905 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -29,8 +29,6 @@
 /* err() exits and will not return */
 #define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
 
-#define XFEATURE_XTILECFG	17
-#define XFEATURE_XTILEDATA	18
 #define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 6729ffde6cc4..d3461c438461 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -9,6 +9,59 @@
 #define XSAVE_HDR_OFFSET	512
 #define XSAVE_HDR_SIZE		64
 
+/*
+ * List of XSAVE features Linux knows about. Copied from
+ * arch/x86/include/asm/fpu/types.h
+ */
+enum xfeature {
+	XFEATURE_FP,
+	XFEATURE_SSE,
+	XFEATURE_YMM,
+	XFEATURE_BNDREGS,
+	XFEATURE_BNDCSR,
+	XFEATURE_OPMASK,
+	XFEATURE_ZMM_Hi256,
+	XFEATURE_Hi16_ZMM,
+	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
+	XFEATURE_PKRU,
+	XFEATURE_PASID,
+	XFEATURE_CET_USER,
+	XFEATURE_CET_KERNEL_UNUSED,
+	XFEATURE_RSRVD_COMP_13,
+	XFEATURE_RSRVD_COMP_14,
+	XFEATURE_LBR,
+	XFEATURE_RSRVD_COMP_16,
+	XFEATURE_XTILECFG,
+	XFEATURE_XTILEDATA,
+
+	XFEATURE_MAX,
+};
+
+/* Copied from arch/x86/kernel/fpu/xstate.c */
+static const char *xfeature_names[] =
+{
+	"x87 floating point registers",
+	"SSE registers",
+	"AVX registers",
+	"MPX bounds registers",
+	"MPX CSR",
+	"AVX-512 opmask",
+	"AVX-512 Hi256",
+	"AVX-512 ZMM_Hi256",
+	"Processor Trace (unused)",
+	"Protection Keys User registers",
+	"PASID state",
+	"Control-flow User registers",
+	"Control-flow Kernel registers (unused)",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"AMX Tile config",
+	"AMX Tile data",
+	"unknown xstate feature",
+};
+
 struct xsave_buffer {
 	union {
 		struct {
@@ -58,6 +111,7 @@ static inline uint32_t get_xbuf_size(void)
 }
 
 struct xstate_info {
+	const char *name;
 	uint32_t num;
 	uint32_t mask;
 	uint32_t xbuf_offset;
@@ -69,6 +123,12 @@ static inline struct xstate_info get_xstate_info(uint32_t xfeature_num)
 	struct xstate_info xstate = { };
 	uint32_t eax, ebx, ecx, edx;
 
+	if (xfeature_num >= XFEATURE_MAX) {
+		ksft_print_msg("unknown state\n");
+		return xstate;
+	}
+
+	xstate.name = xfeature_names[xfeature_num];
 	xstate.num  = xfeature_num;
 	xstate.mask = 1 << xfeature_num;
 
-- 
2.45.2


