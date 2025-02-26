Return-Path: <linux-kselftest+bounces-27543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE8A451ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55893B0BB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009B1714A5;
	Wed, 26 Feb 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CztiJz6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586C154423;
	Wed, 26 Feb 2025 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532058; cv=none; b=euVZSfApTsJYJzefqMdSULZZn/xfUeD6yxuchsQWwbkFBxt3mYuR3jvm+Mao7dQn7/3X3n4AQuP/Ezd/pppb89vePG6QwRKVOH31FjODjF4WK97uJLGZYD3fPqGQQK8+pilgWTkR6LBRHHTuCoYMh8QyoO2rRShgYcSmyF9vrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532058; c=relaxed/simple;
	bh=c+B52D3/B02Xjnnbp8WNTgpN5fkvkKRB3fPrOFmGOJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsRDhM+YSaihIhXDfjovqgotpEtLUxIiJQXJ7zpJ1AGBgG4fm+2vbsr+/unlQK35eRaob83oGNx9XvE5PPQi7PAQWX91Kkb3loy8+DB7OyD4Q04rCmIWskZJMQFQYlX32qnMIrC2jVWJQcbEjnvINYhsj5aTh2KEIdvVDfhRhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CztiJz6+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532057; x=1772068057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+B52D3/B02Xjnnbp8WNTgpN5fkvkKRB3fPrOFmGOJs=;
  b=CztiJz6+VbN1nOpJn7GaELlFGE5Lk5zg/dYC0lQH9/VLmSRK9gmpY5GH
   Uc89Yf2OzKhxBWbDsFNI875Dv5oig6EAiS5bFZlqLqciG8b9KWaQ2If+X
   vBsoLMnKk+Xg2W5gymDBOIGgIqm5PU88rGv40IRFmIWtrZgLTa/2Z2rke
   JB3D2CNfwLI71z8IfztWnDtFcrq30YPDY/GaGkVeIBY+ldNbc6FB0KeN1
   RREu+chDdX19vBZIEIGYOx0H9uNzBWJevzFYV/5xqNWh3lBb9gBVwp1yL
   9JbFDZqRqBN/0ediLv0eVXmh5VeHk00CJU1ZSYqBu7rQwOJIfyfAvjS9Z
   Q==;
X-CSE-ConnectionGUID: 3DiUE2tlQ9uMzO35MeS3ng==
X-CSE-MsgGUID: GaMf3uT7Q3uvrlvS1x6KMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362184"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:35 -0800
X-CSE-ConnectionGUID: TwpKYaDWQ8a7fTfdDvAhaw==
X-CSE-MsgGUID: yct9wnqPSdG/mcG+7xKHnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467340"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:35 -0800
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
Subject: [PATCH 2/9] selftests/x86/xstate: Refactor XSAVE helpers for general use
Date: Tue, 25 Feb 2025 17:07:22 -0800
Message-ID: <20250226010731.2456-3-chang.seok.bae@intel.com>
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

The AMX test introduced several XSAVE-related helper functions, but so
far, it has been the only user of them. These helpers can be generalized
for broader test of multiple xstate features.

Move most XSAVE-related code into xsave.h, making it shareable. The
restructuring includes:

* Establishing low-level XSAVE helpers for saving and restoring register
  states, as well as handling XSAVE buffers.
* Generalizing state data manipuldations: set_rand_data()
* Introducing a generic feature query helper: get_xstate_info()

While doing so, remove unused defines in amx.c.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 tools/testing/selftests/x86/amx.c    | 142 ++-------------------------
 tools/testing/selftests/x86/xstate.h | 132 +++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/x86/xstate.h

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 0f355f331f41..366cfec221e4 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -19,46 +19,13 @@
 #include <sys/wait.h>
 #include <sys/uio.h>
 
-#include "../kselftest.h" /* For __cpuid_count() */
 #include "helpers.h"
+#include "xstate.h"
 
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
 
-#define XSAVE_HDR_OFFSET	512
-#define XSAVE_HDR_SIZE		64
-
-struct xsave_buffer {
-	union {
-		struct {
-			char legacy[XSAVE_HDR_OFFSET];
-			char header[XSAVE_HDR_SIZE];
-			char extended[0];
-		};
-		char bytes[0];
-	};
-};
-
-static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
-{
-	uint32_t rfbm_lo = rfbm;
-	uint32_t rfbm_hi = rfbm >> 32;
-
-	asm volatile("xsave (%%rdi)"
-		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
-		     : "memory");
-}
-
-static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
-{
-	uint32_t rfbm_lo = rfbm;
-	uint32_t rfbm_hi = rfbm >> 32;
-
-	asm volatile("xrstor (%%rdi)"
-		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
-}
-
 /* err() exits and will not return */
 #define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
 
@@ -68,92 +35,12 @@ static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
 
-#define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
-#define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
-
 static uint32_t xbuf_size;
 
-static struct {
-	uint32_t xbuf_offset;
-	uint32_t size;
-} xtiledata;
-
-#define CPUID_LEAF_XSTATE		0xd
-#define CPUID_SUBLEAF_XSTATE_USER	0x0
-#define TILE_CPUID			0x1d
-#define TILE_PALETTE_ID			0x1
-
-static void check_cpuid_xtiledata(void)
-{
-	uint32_t eax, ebx, ecx, edx;
-
-	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
-		      eax, ebx, ecx, edx);
-
-	/*
-	 * EBX enumerates the size (in bytes) required by the XSAVE
-	 * instruction for an XSAVE area containing all the user state
-	 * components corresponding to bits currently set in XCR0.
-	 *
-	 * Stash that off so it can be used to allocate buffers later.
-	 */
-	xbuf_size = ebx;
-
-	__cpuid_count(CPUID_LEAF_XSTATE, XFEATURE_XTILEDATA,
-		      eax, ebx, ecx, edx);
-	/*
-	 * eax: XTILEDATA state component size
-	 * ebx: XTILEDATA state component offset in user buffer
-	 */
-	if (!eax || !ebx)
-		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
-				eax, ebx);
-
-	xtiledata.size	      = eax;
-	xtiledata.xbuf_offset = ebx;
-}
+struct xstate_info xtiledata;
 
 /* The helpers for managing XSAVE buffer and tile states: */
 
-struct xsave_buffer *alloc_xbuf(void)
-{
-	struct xsave_buffer *xbuf;
-
-	/* XSAVE buffer should be 64B-aligned. */
-	xbuf = aligned_alloc(64, xbuf_size);
-	if (!xbuf)
-		fatal_error("aligned_alloc()");
-	return xbuf;
-}
-
-static inline void clear_xstate_header(struct xsave_buffer *buffer)
-{
-	memset(&buffer->header, 0, sizeof(buffer->header));
-}
-
-static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
-{
-	/* XSTATE_BV is at the beginning of the header: */
-	*(uint64_t *)(&buffer->header) = bv;
-}
-
-static void set_rand_tiledata(struct xsave_buffer *xbuf)
-{
-	int *ptr = (int *)&xbuf->bytes[xtiledata.xbuf_offset];
-	int data;
-	int i;
-
-	/*
-	 * Ensure that 'data' is never 0.  This ensures that
-	 * the registers are never in their initial configuration
-	 * and thus never tracked as being in the init state.
-	 */
-	data = rand() | 1;
-
-	for (i = 0; i < xtiledata.size / sizeof(int); i++, ptr++)
-		*ptr = data;
-}
-
 struct xsave_buffer *stashed_xsave;
 
 static void init_stashed_xsave(void)
@@ -169,21 +56,6 @@ static void free_stashed_xsave(void)
 	free(stashed_xsave);
 }
 
-/* See 'struct _fpx_sw_bytes' at sigcontext.h */
-#define SW_BYTES_OFFSET		464
-/* N.B. The struct's field name varies so read from the offset. */
-#define SW_BYTES_BV_OFFSET	(SW_BYTES_OFFSET + 8)
-
-static inline struct _fpx_sw_bytes *get_fpx_sw_bytes(void *buffer)
-{
-	return (struct _fpx_sw_bytes *)(buffer + SW_BYTES_OFFSET);
-}
-
-static inline uint64_t get_fpx_sw_bytes_features(void *buffer)
-{
-	return *(uint64_t *)(buffer + SW_BYTES_BV_OFFSET);
-}
-
 /* Work around printf() being unsafe in signals: */
 #define SIGNAL_BUF_LEN 1000
 char signal_message_buffer[SIGNAL_BUF_LEN];
@@ -281,7 +153,7 @@ static inline bool load_rand_tiledata(struct xsave_buffer *xbuf)
 {
 	clear_xstate_header(xbuf);
 	set_xstatebv(xbuf, XFEATURE_MASK_XTILEDATA);
-	set_rand_tiledata(xbuf);
+	set_rand_data(&xtiledata, xbuf);
 	return xrstor_safe(xbuf, XFEATURE_MASK_XTILEDATA);
 }
 
@@ -884,7 +756,13 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	check_cpuid_xtiledata();
+	xbuf_size = get_xbuf_size();
+
+	xtiledata = get_xstate_info(XFEATURE_XTILEDATA);
+	if (!xtiledata.size || !xtiledata.xbuf_offset) {
+		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
+			    xtiledata.size, xtiledata.xbuf_offset);
+	}
 
 	init_stashed_xsave();
 	sethandler(SIGILL, handle_noperm, 0);
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
new file mode 100644
index 000000000000..6729ffde6cc4
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate.h
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __SELFTESTS_X86_XSTATE_H
+#define __SELFTESTS_X86_XSTATE_H
+
+#include <stdint.h>
+
+#include "../kselftest.h"
+
+#define XSAVE_HDR_OFFSET	512
+#define XSAVE_HDR_SIZE		64
+
+struct xsave_buffer {
+	union {
+		struct {
+			char legacy[XSAVE_HDR_OFFSET];
+			char header[XSAVE_HDR_SIZE];
+			char extended[0];
+		};
+		char bytes[0];
+	};
+};
+
+static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_hi = rfbm >> 32;
+	uint32_t rfbm_lo = rfbm;
+
+	asm volatile("xsave (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
+		     : "memory");
+}
+
+static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_hi = rfbm >> 32;
+	uint32_t rfbm_lo = rfbm;
+
+	asm volatile("xrstor (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
+}
+
+#define CPUID_LEAF_XSTATE		0xd
+#define CPUID_SUBLEAF_XSTATE_USER	0x0
+
+static inline uint32_t get_xbuf_size(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
+		      eax, ebx, ecx, edx);
+
+	/*
+	 * EBX enumerates the size (in bytes) required by the XSAVE
+	 * instruction for an XSAVE area containing all the user state
+	 * components corresponding to bits currently set in XCR0.
+	 */
+	return ebx;
+}
+
+struct xstate_info {
+	uint32_t num;
+	uint32_t mask;
+	uint32_t xbuf_offset;
+	uint32_t size;
+};
+
+static inline struct xstate_info get_xstate_info(uint32_t xfeature_num)
+{
+	struct xstate_info xstate = { };
+	uint32_t eax, ebx, ecx, edx;
+
+	xstate.num  = xfeature_num;
+	xstate.mask = 1 << xfeature_num;
+
+	__cpuid_count(CPUID_LEAF_XSTATE, xfeature_num,
+		      eax, ebx, ecx, edx);
+	xstate.size        = eax;
+	xstate.xbuf_offset = ebx;
+	return xstate;
+}
+
+static inline struct xsave_buffer *alloc_xbuf(void)
+{
+	uint32_t xbuf_size = get_xbuf_size();
+
+	/* XSAVE buffer should be 64B-aligned. */
+	return aligned_alloc(64, xbuf_size);
+}
+
+static inline void clear_xstate_header(struct xsave_buffer *xbuf)
+{
+	memset(&xbuf->header, 0, sizeof(xbuf->header));
+}
+
+static inline void set_xstatebv(struct xsave_buffer *xbuf, uint64_t bv)
+{
+	/* XSTATE_BV is at the beginning of the header: */
+	*(uint64_t *)(&xbuf->header) = bv;
+}
+
+/* See 'struct _fpx_sw_bytes' at sigcontext.h */
+#define SW_BYTES_OFFSET		464
+/* N.B. The struct's field name varies so read from the offset. */
+#define SW_BYTES_BV_OFFSET	(SW_BYTES_OFFSET + 8)
+
+static inline struct _fpx_sw_bytes *get_fpx_sw_bytes(void *xbuf)
+{
+	return xbuf + SW_BYTES_OFFSET;
+}
+
+static inline uint64_t get_fpx_sw_bytes_features(void *buffer)
+{
+	return *(uint64_t *)(buffer + SW_BYTES_BV_OFFSET);
+}
+
+static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer *xbuf)
+{
+	int *ptr = (int *)&xbuf->bytes[xstate->xbuf_offset];
+	int data, i;
+
+	/*
+	 * Ensure that 'data' is never 0.  This ensures that
+	 * the registers are never in their initial configuration
+	 * and thus never tracked as being in the init state.
+	 */
+	data = rand() | 1;
+
+	for (i = 0; i < xstate->size / sizeof(int); i++, ptr++)
+		*ptr = data;
+}
+
+#endif /* __SELFTESTS_X86_XSTATE_H */
-- 
2.45.2


