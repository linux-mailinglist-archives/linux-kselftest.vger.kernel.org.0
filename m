Return-Path: <linux-kselftest+bounces-38698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97CB21450
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802E63A3862
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FD2E1C64;
	Mon, 11 Aug 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8o5NsGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255872E1C53;
	Mon, 11 Aug 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936896; cv=none; b=tBdfFz4d7Zi6Brj/wh/D9jYrQuVdPN+WY26mSuSX3oSEUOJAUGiOj5+iodV5xNlgkcl5zFB0HbdOdsy5Sne3jldd3gYMEbm+R/MUwaqU8ki0PFOhfhVDl4tFegqj+/icp2N/0j/p6EBl64A9nLnx6d+zea7qcHU6nw6ACkyLjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936896; c=relaxed/simple;
	bh=R/c+sHj58hPXsXZ0wEu7sPVUYOmEp9NF5pVcd2XPhrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8wh8W67wAV2h++I1IHo9kr9WtesLiMsPjzLoFB+Wyx42GL+PfRbOT9u/hKojxe4QCsmEAJcAZbJ57JHHyEsPI9p/oJVYhNIYw7310RVmL2bYYJgj71vB8vyB/JIlC1uoiherkQAeAqw3q+sjPvGTA5pUVwOHxibxvvQ+nOu2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8o5NsGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB150C4CEED;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754936896;
	bh=R/c+sHj58hPXsXZ0wEu7sPVUYOmEp9NF5pVcd2XPhrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8o5NsGIjnD6Fikc+Kz+w8FS4JVodiTAEjEhMMlpT5RIW6ivG8H5FJh83Nc4tq/Lm
	 LxfZQn1eF3Q9MssTKldhaiUQv0nBNFWe0mloJIzvF8ha4Im7bvR6AsaHo5OAWcOeU0
	 mWmxcF745Iorr1HB9ktFabBj8J3+V0cjbarnvOEy6OF4i71tTsy18dDjE9h4PYLUwk
	 cXUBKCb7GQQc4gY6BBpqgG30ycrK36OWoH6OLx5CnTBEYJ26L7aJlUrxKuWC3yXRv3
	 mmdLGw52pB6Jq/585O+B3Rl8CDXSXh1IfmsKR4IpSP6qjRga6qTaDLR/poss1wAdSL
	 0gbdbI0FnhBSQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 3/3] lib/crc: Use underlying functions instead of crypto_simd_usable()
Date: Mon, 11 Aug 2025 11:26:31 -0700
Message-ID: <20250811182631.376302-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811182631.376302-1-ebiggers@kernel.org>
References: <20250811182631.376302-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since crc_kunit now tests the fallback code paths without using
crypto_simd_disabled_for_test, make the CRC code just use the underlying
may_use_simd() and irq_fpu_usable() functions directly instead of
crypto_simd_usable().  This eliminates an unnecessary layer.

Take the opportunity to add likely() and unlikely() annotations as well.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/arm/crc-t10dif.h          |  6 ++----
 lib/crc/arm/crc32.h               |  6 ++----
 lib/crc/arm64/crc-t10dif.h        |  6 ++----
 lib/crc/arm64/crc32.h             | 11 ++++++-----
 lib/crc/powerpc/crc-t10dif.h      |  5 +++--
 lib/crc/powerpc/crc32.h           |  5 +++--
 lib/crc/x86/crc-pclmul-template.h |  3 +--
 lib/crc/x86/crc32.h               |  2 +-
 8 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/lib/crc/arm/crc-t10dif.h b/lib/crc/arm/crc-t10dif.h
index 2edf7e9681d05..1a969f4024d47 100644
--- a/lib/crc/arm/crc-t10dif.h
+++ b/lib/crc/arm/crc-t10dif.h
@@ -3,12 +3,10 @@
  * Accelerated CRC-T10DIF using ARM NEON and Crypto Extensions instructions
  *
  * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <crypto/internal/simd.h>
-
 #include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_pmull);
@@ -21,19 +19,19 @@ asmlinkage void crc_t10dif_pmull8(u16 init_crc, const u8 *buf, size_t len,
 
 static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 {
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
 		if (static_branch_likely(&have_pmull)) {
-			if (crypto_simd_usable()) {
+			if (likely(may_use_simd())) {
 				kernel_neon_begin();
 				crc = crc_t10dif_pmull64(crc, data, length);
 				kernel_neon_end();
 				return crc;
 			}
 		} else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
 			   static_branch_likely(&have_neon) &&
-			   crypto_simd_usable()) {
+			   likely(may_use_simd())) {
 			u8 buf[16] __aligned(16);
 
 			kernel_neon_begin();
 			crc_t10dif_pmull8(crc, data, length, buf);
 			kernel_neon_end();
diff --git a/lib/crc/arm/crc32.h b/lib/crc/arm/crc32.h
index 018007e162a2b..ae71aa60b7a74 100644
--- a/lib/crc/arm/crc32.h
+++ b/lib/crc/arm/crc32.h
@@ -5,12 +5,10 @@
  * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
 #include <linux/cpufeature.h>
 
-#include <crypto/internal/simd.h>
-
 #include <asm/hwcap.h>
 #include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_crc32);
@@ -32,11 +30,11 @@ static inline u32 crc32_le_scalar(u32 crc, const u8 *p, size_t len)
 }
 
 static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (len >= PMULL_MIN_LEN + 15 &&
-	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
+	    static_branch_likely(&have_pmull) && likely(may_use_simd())) {
 		size_t n = -(uintptr_t)p & 15;
 
 		/* align p to 16-byte boundary */
 		if (n) {
 			crc = crc32_le_scalar(crc, p, n);
@@ -61,11 +59,11 @@ static inline u32 crc32c_scalar(u32 crc, const u8 *p, size_t len)
 }
 
 static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (len >= PMULL_MIN_LEN + 15 &&
-	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
+	    static_branch_likely(&have_pmull) && likely(may_use_simd())) {
 		size_t n = -(uintptr_t)p & 15;
 
 		/* align p to 16-byte boundary */
 		if (n) {
 			crc = crc32c_scalar(crc, p, n);
diff --git a/lib/crc/arm64/crc-t10dif.h b/lib/crc/arm64/crc-t10dif.h
index c4521a7f1ee9b..435a990ec43c2 100644
--- a/lib/crc/arm64/crc-t10dif.h
+++ b/lib/crc/arm64/crc-t10dif.h
@@ -5,12 +5,10 @@
  * Copyright (C) 2016 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
 #include <linux/cpufeature.h>
 
-#include <crypto/internal/simd.h>
-
 #include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_asimd);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_pmull);
@@ -23,19 +21,19 @@ asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 *buf, size_t len);
 
 static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 {
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
 		if (static_branch_likely(&have_pmull)) {
-			if (crypto_simd_usable()) {
+			if (likely(may_use_simd())) {
 				kernel_neon_begin();
 				crc = crc_t10dif_pmull_p64(crc, data, length);
 				kernel_neon_end();
 				return crc;
 			}
 		} else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
 			   static_branch_likely(&have_asimd) &&
-			   crypto_simd_usable()) {
+			   likely(may_use_simd())) {
 			u8 buf[16];
 
 			kernel_neon_begin();
 			crc_t10dif_pmull_p8(crc, data, length, buf);
 			kernel_neon_end();
diff --git a/lib/crc/arm64/crc32.h b/lib/crc/arm64/crc32.h
index 6e5dec45f05d2..31e649cd40a2f 100644
--- a/lib/crc/arm64/crc32.h
+++ b/lib/crc/arm64/crc32.h
@@ -3,12 +3,10 @@
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/neon.h>
 #include <asm/simd.h>
 
-#include <crypto/internal/simd.h>
-
 // The minimum input length to consider the 4-way interleaved code path
 static const size_t min_len = 1024;
 
 asmlinkage u32 crc32_le_arm64(u32 crc, unsigned char const *p, size_t len);
 asmlinkage u32 crc32c_le_arm64(u32 crc, unsigned char const *p, size_t len);
@@ -21,11 +19,12 @@ asmlinkage u32 crc32_be_arm64_4way(u32 crc, unsigned char const *p, size_t len);
 static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
 		return crc32_le_base(crc, p, len);
 
-	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
+	if (len >= min_len && cpu_have_named_feature(PMULL) &&
+	    likely(may_use_simd())) {
 		kernel_neon_begin();
 		crc = crc32_le_arm64_4way(crc, p, len);
 		kernel_neon_end();
 
 		p += round_down(len, 64);
@@ -41,11 +40,12 @@ static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
 		return crc32c_base(crc, p, len);
 
-	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
+	if (len >= min_len && cpu_have_named_feature(PMULL) &&
+	    likely(may_use_simd())) {
 		kernel_neon_begin();
 		crc = crc32c_le_arm64_4way(crc, p, len);
 		kernel_neon_end();
 
 		p += round_down(len, 64);
@@ -61,11 +61,12 @@ static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 static inline u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (!alternative_has_cap_likely(ARM64_HAS_CRC32))
 		return crc32_be_base(crc, p, len);
 
-	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
+	if (len >= min_len && cpu_have_named_feature(PMULL) &&
+	    likely(may_use_simd())) {
 		kernel_neon_begin();
 		crc = crc32_be_arm64_4way(crc, p, len);
 		kernel_neon_end();
 
 		p += round_down(len, 64);
diff --git a/lib/crc/powerpc/crc-t10dif.h b/lib/crc/powerpc/crc-t10dif.h
index 59e16804a6eae..e033d5f57bae2 100644
--- a/lib/crc/powerpc/crc-t10dif.h
+++ b/lib/crc/powerpc/crc-t10dif.h
@@ -4,12 +4,12 @@
  *
  * Copyright 2017, Daniel Axtens, IBM Corporation.
  * [based on crc32c-vpmsum_glue.c]
  */
 
+#include <asm/simd.h>
 #include <asm/switch_to.h>
-#include <crypto/internal/simd.h>
 #include <linux/cpufeature.h>
 #include <linux/jump_label.h>
 #include <linux/preempt.h>
 #include <linux/uaccess.h>
 
@@ -27,11 +27,12 @@ static inline u16 crc_t10dif_arch(u16 crci, const u8 *p, size_t len)
 	unsigned int prealign;
 	unsigned int tail;
 	u32 crc = crci;
 
 	if (len < (VECTOR_BREAKPOINT + VMX_ALIGN) ||
-	    !static_branch_likely(&have_vec_crypto) || !crypto_simd_usable())
+	    !static_branch_likely(&have_vec_crypto) ||
+	    unlikely(!may_use_simd()))
 		return crc_t10dif_generic(crc, p, len);
 
 	if ((unsigned long)p & VMX_ALIGN_MASK) {
 		prealign = VMX_ALIGN - ((unsigned long)p & VMX_ALIGN_MASK);
 		crc = crc_t10dif_generic(crc, p, prealign);
diff --git a/lib/crc/powerpc/crc32.h b/lib/crc/powerpc/crc32.h
index 811cc2e6ed24d..cc8fa3913d4e0 100644
--- a/lib/crc/powerpc/crc32.h
+++ b/lib/crc/powerpc/crc32.h
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <asm/simd.h>
 #include <asm/switch_to.h>
-#include <crypto/internal/simd.h>
 #include <linux/cpufeature.h>
 #include <linux/jump_label.h>
 #include <linux/preempt.h>
 #include <linux/uaccess.h>
 
@@ -22,11 +22,12 @@ static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	unsigned int prealign;
 	unsigned int tail;
 
 	if (len < (VECTOR_BREAKPOINT + VMX_ALIGN) ||
-	    !static_branch_likely(&have_vec_crypto) || !crypto_simd_usable())
+	    !static_branch_likely(&have_vec_crypto) ||
+	    unlikely(!may_use_simd()))
 		return crc32c_base(crc, p, len);
 
 	if ((unsigned long)p & VMX_ALIGN_MASK) {
 		prealign = VMX_ALIGN - ((unsigned long)p & VMX_ALIGN_MASK);
 		crc = crc32c_base(crc, p, prealign);
diff --git a/lib/crc/x86/crc-pclmul-template.h b/lib/crc/x86/crc-pclmul-template.h
index 35c950d7010c2..02744831c6fac 100644
--- a/lib/crc/x86/crc-pclmul-template.h
+++ b/lib/crc/x86/crc-pclmul-template.h
@@ -10,11 +10,10 @@
 #ifndef _CRC_PCLMUL_TEMPLATE_H
 #define _CRC_PCLMUL_TEMPLATE_H
 
 #include <asm/cpufeatures.h>
 #include <asm/simd.h>
-#include <crypto/internal/simd.h>
 #include <linux/static_call.h>
 #include "crc-pclmul-consts.h"
 
 #define DECLARE_CRC_PCLMUL_FUNCS(prefix, crc_t)				\
 crc_t prefix##_pclmul_sse(crc_t crc, const u8 *p, size_t len,		\
@@ -55,11 +54,11 @@ static inline bool have_avx512(void)
  * the dcache than the table-based code is, a 16-byte cutoff seems to work well.
  */
 #define CRC_PCLMUL(crc, p, len, prefix, consts, have_pclmulqdq)		\
 do {									\
 	if ((len) >= 16 && static_branch_likely(&(have_pclmulqdq)) &&	\
-	    crypto_simd_usable()) {					\
+	    likely(irq_fpu_usable())) {					\
 		const void *consts_ptr;					\
 									\
 		consts_ptr = (consts).fold_across_128_bits_consts;	\
 		kernel_fpu_begin();					\
 		crc = static_call(prefix##_pclmul)((crc), (p), (len),	\
diff --git a/lib/crc/x86/crc32.h b/lib/crc/x86/crc32.h
index cea2c96d08d09..2c4a5976654ad 100644
--- a/lib/crc/x86/crc32.h
+++ b/lib/crc/x86/crc32.h
@@ -42,11 +42,11 @@ static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 
 	if (!static_branch_likely(&have_crc32))
 		return crc32c_base(crc, p, len);
 
 	if (IS_ENABLED(CONFIG_X86_64) && len >= CRC32C_PCLMUL_BREAKEVEN &&
-	    static_branch_likely(&have_pclmulqdq) && crypto_simd_usable()) {
+	    static_branch_likely(&have_pclmulqdq) && likely(irq_fpu_usable())) {
 		/*
 		 * Long length, the vector registers are usable, and the CPU is
 		 * 64-bit and supports both CRC32 and PCLMULQDQ instructions.
 		 * It is worthwhile to divide the data into multiple streams,
 		 * CRC them independently, and combine them using PCLMULQDQ.
-- 
2.50.1


