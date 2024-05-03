Return-Path: <linux-kselftest+bounces-9336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9008BA644
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059C7280CEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845B13B7A4;
	Fri,  3 May 2024 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yLunRZQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212B13B5AA
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711623; cv=none; b=e80eu0T4ZrQxVfrhRo+NjZpsL3chczJShwaOhVeIv2vJgcRa1uwich6Ljros+2yYQCeV+l0fNzjLiP3Y7Ix2PD2KFfEuzWaZFv5e8XV7fULu94iBbROCJdCgYQ5BeQteNGrV9KHh+vaMCgTwfariCW9FIzI1q+c6bHW7Si4OKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711623; c=relaxed/simple;
	bh=2AJiZIKU/txIzz8lcRnB5tCco7QN7//SJU1vx5ohkb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwLk+LBIIvlt24S6yG1EPTiK6SJ93+FvB2jDAznYst2qSAuK4ugqTTPZyzPSr8agLhU2o5ThffPn/ln9PnPNnuNi9Qt4bDoKqpa+jhkbKOWu2u0zijy91iFkU0H60XCECFrE+PNocsouW/wm4XrjnDXnpVEl7WPKOv9D5j4LqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yLunRZQ6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44ebe99cdso6551b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 21:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711621; x=1715316421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBAtK6yz0tN7qnDVCrHDFDflditCb34tqrZg7A4OIKI=;
        b=yLunRZQ6XlK/OOIgRETVBGg6/vnJ0Gb6ca2Zli7+BExEDR5uN4XkEbCSdxUS9x1IQP
         uEKf7L1xBLpklsmoF994TcYzp91UhtnYFTpc2NlNBxWlff6+2VJVNWvJTi1zLujZfCtF
         VLHRCcCo1GLspEnqyZgIs9J4PFdS2Prp0vTAx3+aXnEBj/LeiVZgoe/Qxjz/VHRhqspX
         ly0uzp0qmgMIV/eLgYCCjo5YGwJOBNWvHJcuXZqDD7Wn5+VLaCuBZdCKV1fhFHqvoBxv
         ZOWDHTbQ0UIEZNtdMy9g2p/Q2xHfwXFhgOEJbpWirDvePGmbmHv5zjSTTzAhvW7MO8Zw
         H4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711621; x=1715316421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBAtK6yz0tN7qnDVCrHDFDflditCb34tqrZg7A4OIKI=;
        b=KXfC2d7StYYNzB7UlzagugOyMEhIGKJOb0SJsP8co4uOJNbhk2STnkQBdczrNCQc2Q
         QfT5h05makqLdiPy+ww0EH8vLQg02X9srnAabiBK4MrIqV3a2IURV7Ii8P6QBBwI6dEB
         IVnkV1rsJUY9AvxO72LbuxKFztjEdZ4J0lT4Cq6RL16fobAt7DukNm8N4Sx3EAvY5FBD
         BNzkFLH5SRueWD6r7l3PNVdoOFdEmtbnefSVQvs+YsfJGQcmP1kYykCdzqEopWpOBxWi
         Nyffl17FN8YaNOnu9ji5mSPbjb8UNMlGgIW4TqZMP05gkNv+gYu+k5rBTjmhkxAjbokR
         VPug==
X-Forwarded-Encrypted: i=1; AJvYcCVzSTIPTTso15rZF9etnqMcWoZqQBdIG4Msn8Kja0TDWWqlXNh9mljeqgvkeTwi4PCndBF7zwLzWa2nxnrkq3JRFb7vkH8lu5YY2XKI+HUm
X-Gm-Message-State: AOJu0YxNXk59WTT7Q7NTYHAmcJjvALxz9tT07iFjGDd5K/7Ha1JlX+EZ
	ZgZIu4f1G9DTYvUKbo3WYAF1sGVI/c8NpS8JFoKSut07/it5f+GeOEXTAAR9mQ0=
X-Google-Smtp-Source: AGHT+IF06THjz5G9qZKmeRTr1gAvHdFeHK50QwVhMpmQmsh4TwbRlEVHFDctwj8AEiO9jRfEFBYmZw==
X-Received: by 2002:a05:6a20:a122:b0:1af:6a37:3cfd with SMTP id q34-20020a056a20a12200b001af6a373cfdmr2118253pzk.24.1714711620917;
        Thu, 02 May 2024 21:47:00 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:47:00 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:43 -0700
Subject: [PATCH v5 08/17] riscv: cpufeature: Extract common elements from
 extension checking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-8-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=7158;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=2AJiZIKU/txIzz8lcRnB5tCco7QN7//SJU1vx5ohkb8=;
 b=YOIghtsf7HC7GWmj4P7wyDakVJLWJTC5OsydPCk6VdnIqyCKpImm9cXdMtYbcFm9oDMyUx2It
 1Je3ehTENzUA3Yjtec9EJKC48M+XxXGidUnbtL8A2DpwHXJ5Z/qdhYK
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The __riscv_has_extension_likely() and __riscv_has_extension_unlikely()
functions from the vendor_extensions.h can be used to simplify the
standard extension checking code as well. Migrate those functions to
cpufeature.h and reorganize the code in the file to use the functions.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/cpufeature.h        | 78 +++++++++++++++++-------------
 arch/riscv/include/asm/vendor_extensions.h | 28 -----------
 arch/riscv/kernel/vendor_extensions.c      | 16 +++---
 3 files changed, 51 insertions(+), 71 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index fedd479ccfd1..88723ac2d26e 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -98,59 +98,66 @@ extern bool riscv_isa_fallback;
 
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
+#define STANDARD_EXT		0
+
 bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit);
 #define riscv_isa_extension_available(isa_bitmap, ext)	\
 	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
 
-static __always_inline bool
-riscv_has_extension_likely(const unsigned long ext)
+static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
+							 const unsigned long ext)
 {
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm goto(
-		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_no);
-	} else {
-		if (!__riscv_isa_extension_available(NULL, ext))
-			goto l_no;
-	}
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_no);
 
 	return true;
 l_no:
 	return false;
 }
 
-static __always_inline bool
-riscv_has_extension_unlikely(const unsigned long ext)
+static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
+							   const unsigned long ext)
 {
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm goto(
-		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_yes);
-	} else {
-		if (__riscv_isa_extension_available(NULL, ext))
-			goto l_yes;
-	}
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
+static __always_inline bool riscv_has_extension_unlikely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely(STANDARD_EXT, ext);
+
+	return __riscv_isa_extension_available(NULL, ext);
+}
+
+static __always_inline bool riscv_has_extension_likely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely(STANDARD_EXT, ext);
+
+	return __riscv_isa_extension_available(NULL, ext);
+}
+
 static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
 {
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_likely(STANDARD_EXT, ext))
 		return true;
 
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
@@ -158,7 +165,10 @@ static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsign
 
 static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
 {
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_unlikely(STANDARD_EXT, ext))
 		return true;
 
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
index a6959836f895..d21e411d7338 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -47,34 +47,6 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 	__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, \
 					       RISCV_ISA_VENDOR_EXT_##ext)
 
-static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
-							 const unsigned long ext)
-{
-	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
-	:
-	: [vendor] "i" (vendor), [ext] "i" (ext)
-	:
-	: l_no);
-
-	return true;
-l_no:
-	return false;
-}
-
-static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
-							   const unsigned long ext)
-{
-	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
-	:
-	: [vendor] "i" (vendor), [ext] "i" (ext)
-	:
-	: l_yes);
-
-	return false;
-l_yes:
-	return true;
-}
-
 static __always_inline bool riscv_has_vendor_extension_likely(const unsigned long vendor,
 							      const unsigned long ext)
 {
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index e4ef574b7d08..7910890c17de 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -31,16 +31,14 @@ const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_li
  */
 bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit)
 {
-	unsigned long *bmap;
-	struct riscv_isainfo *cpu_bmap;
-	size_t bmap_size;
+	struct riscv_isavendorinfo *bmap;
+	struct riscv_isavendorinfo *cpu_bmap;
 
 	switch (vendor) {
 #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
 	case THEAD_VENDOR_ID:
-		bmap = riscv_isa_vendor_ext_list_thead.vendor_bitmap;
-		cpu_bmap = riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
-		bmap_size = riscv_isa_vendor_ext_list_thead.bitmap_size;
+		bmap = &riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap;
+		cpu_bmap = &riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu];
 		break;
 #endif
 	default:
@@ -48,11 +46,11 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 	}
 
 	if (cpu != -1)
-		bmap = cpu_bmap[cpu].isa;
+		bmap = &cpu_bmap[cpu];
 
-	if (bit >= bmap_size)
+	if (bit >= RISCV_ISA_VENDOR_EXT_MAX)
 		return false;
 
-	return test_bit(bit, bmap) ? true : false;
+	return test_bit(bit, bmap->isa) ? true : false;
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);

-- 
2.44.0


