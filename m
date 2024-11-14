Return-Path: <linux-kselftest+bounces-21987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572C49C809C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985C9B258CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7FF1F7080;
	Thu, 14 Nov 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1WsfLn/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFB1F6692
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550911; cv=none; b=s3KOFhpwIHxiDvKQStc+wVfi2FeKR/88woNtnUg/sAlYl9pOQlvhh61ncPDwQd4wLtKEylVL6SddZNW1DQBimBJ5RoEyfX0Wu9ccsVxNebyFqaZR+JseAfipXcyM15OWrQj/R/xMVgZeXG0aZOQ2MWUxvs7ONIMHAMrZgSoKg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550911; c=relaxed/simple;
	bh=B++Temnqh5k2Kpb3C+xLOMD4dRSOe3xD2oWjOaskY6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX3le2RptXfH/WKv8+3QlvoszEGt0Gv/jiwv9/ALi580q0HnMlUAUkU2r38sR0k9VCZXBSxL0ZrceQ51vJlZ09CZGgIDk0aSWwyeiEb45RgRXPxlECFeXrH202OCQG+r3f6O+Hg9ORdUtZ3mc6X+fRD/YlxJU2JUTnnzKBymPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1WsfLn/f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c767a9c50so779745ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550908; x=1732155708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGolqcB7TmbdOGZaE4Q3sqzHIx0GMG3ujLvVUbhi9YM=;
        b=1WsfLn/fzbQ9U8d6gt/lZsHwqA9niKNpBB/PBT8ekglTQzgDDD0pmm7BVqN5zf1ahL
         xoj+iMrUDORdESiQCQskl9uopcPoeao+5I72fX4WZA8OoFcj1I06XMcUgQq42BwLIGG0
         pDH/+r8d6s020fJ2yk7r7UUQPDcGu0oCVqGL4s6xyvI06QG7RKrB2+7uSk0JbNMfGTJ/
         ByyRXWhQk02B3j9ALUk/92TyvxTGhVVhKwOyRgWt48CYv0q7MHewE7/6qzfHL6v9dp18
         brbgGyQnh1MDOS/1RNA8IqXNPSo7w+HIJaQ1oCs7X0pchiXkM67k7D8Spnkg4SmFUWSm
         lOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550908; x=1732155708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGolqcB7TmbdOGZaE4Q3sqzHIx0GMG3ujLvVUbhi9YM=;
        b=g2wCxRPbY0C0/v9HF0I8l2NhVpsTfYUoqN9dtwPmymv1V3eNj0qCNjYQbuvHp7gPlK
         oZOl/tDg3AdDbaeA+0TGR4pYDGejA17DsT+QFtTvF4iLMA/h1NCGHarlgDnb7pEv9uqx
         VfsuaLPpPGY+vek47dA/zTatRfeHqMkIp6Lrl982rCjGfUbBucEKu7YgLSvSnkhz2plw
         ACVJ0xRqs/TmSs4TI/9EJJDkDO4vrOrmrnqamdYFGR529j3s/0+44wng0yNDLojRxkxm
         y/FMuqoGbV1pNioJpO608WN/ydbK3AwSYlYnmO+gamgyKKwioGD0a4obpAVDf1UHxaOS
         Yhqw==
X-Forwarded-Encrypted: i=1; AJvYcCWP23SoQSNi1+KjXmIS3ivApcUG+gb15Nii243AR/5VpEmt5S97pXnK/HNO+CKraumw3nkbgfg9/iPwzMB9G2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoR15HouEfJKETV/TXW4Sb2NB9FFawCIpn+4JL9KjhXimqv3nc
	b7EBqNgjOvp5ydviBw91uu+5LIlLLP2e6CrxslvSqoL7SfNIiGvyG2oWwtk9N1Q=
X-Google-Smtp-Source: AGHT+IGHzt9GEYkmfglEeNcCLRx33++H2sl2dBfwnOIXhMhO277wEOcKDFP/ZqA4fpYMhnRI5M/4Qg==
X-Received: by 2002:a17:903:11c8:b0:20c:61a2:5ca4 with SMTP id d9443c01a7336-211c4fa22f2mr8388895ad.10.1731550908500;
        Wed, 13 Nov 2024 18:21:48 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:47 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:15 -0800
Subject: [PATCH v11 09/14] riscv: vector: Support xtheadvector save/restore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-9-236c22791ef9@rivosinc.com>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Yangyu Chen <cyy@cyyself.name>, Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19231; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=B++Temnqh5k2Kpb3C+xLOMD4dRSOe3xD2oWjOaskY6w=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3MJDP7/3zvyT9+7pRp6iIheXKuNnqX8DeKXVZT1+X
 ulq0vzRUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwERiHzP8MzvFuTt9gjbz7Cv7
 k+ZGVeoEttVcmcTrLPHO/U7U5w7faQy/mG7Mz9z3sf5XwJR2vZR7Dw2UzG9GVC3MdxeYd3bZjK1
 GXAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use alternatives to add support for xtheadvector vector save/restore
routines.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/csr.h           |   6 +
 arch/riscv/include/asm/switch_to.h     |   2 +-
 arch/riscv/include/asm/vector.h        | 222 +++++++++++++++++++++++++--------
 arch/riscv/kernel/cpufeature.c         |   6 +-
 arch/riscv/kernel/kernel_mode_vector.c |   8 +-
 arch/riscv/kernel/process.c            |   4 +-
 arch/riscv/kernel/signal.c             |   6 +-
 arch/riscv/kernel/vector.c             |  12 +-
 8 files changed, 198 insertions(+), 68 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2155f5afffd6..ee23d0366cb2 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -30,6 +30,12 @@
 #define SR_VS_CLEAN	_AC(0x00000400, UL)
 #define SR_VS_DIRTY	_AC(0x00000600, UL)
 
+#define SR_VS_THEAD		_AC(0x01800000, UL) /* xtheadvector Status */
+#define SR_VS_OFF_THEAD		_AC(0x00000000, UL)
+#define SR_VS_INITIAL_THEAD	_AC(0x00800000, UL)
+#define SR_VS_CLEAN_THEAD	_AC(0x01000000, UL)
+#define SR_VS_DIRTY_THEAD	_AC(0x01800000, UL)
+
 #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
 #define SR_XS_OFF	_AC(0x00000000, UL)
 #define SR_XS_INITIAL	_AC(0x00008000, UL)
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 94e33216b2d9..0e71eb82f920 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -117,7 +117,7 @@ do {							\
 	__set_prev_cpu(__prev->thread);			\
 	if (has_fpu())					\
 		__switch_to_fpu(__prev, __next);	\
-	if (has_vector())					\
+	if (has_vector() || has_xtheadvector())		\
 		__switch_to_vector(__prev, __next);	\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index c7c023afbacd..e8a83f55be2b 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -18,6 +18,27 @@
 #include <asm/cpufeature.h>
 #include <asm/csr.h>
 #include <asm/asm.h>
+#include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/thead.h>
+
+#define __riscv_v_vstate_or(_val, TYPE) ({				\
+	typeof(_val) _res = _val;					\
+	if (has_xtheadvector()) \
+		_res = (_res & ~SR_VS_THEAD) | SR_VS_##TYPE##_THEAD;	\
+	else								\
+		_res = (_res & ~SR_VS) | SR_VS_##TYPE;			\
+	_res;								\
+})
+
+#define __riscv_v_vstate_check(_val, TYPE) ({				\
+	bool _res;							\
+	if (has_xtheadvector()) \
+		_res = ((_val) & SR_VS_THEAD) == SR_VS_##TYPE##_THEAD;	\
+	else								\
+		_res = ((_val) & SR_VS) == SR_VS_##TYPE;		\
+	_res;								\
+})
 
 extern unsigned long riscv_v_vsize;
 int riscv_v_setup_vsize(void);
@@ -41,39 +62,62 @@ static __always_inline bool has_vector(void)
 	return riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE32X);
 }
 
+static __always_inline bool has_xtheadvector_no_alternatives(void)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
+		return riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADVECTOR);
+	else
+		return false;
+}
+
+static __always_inline bool has_xtheadvector(void)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
+		return riscv_has_vendor_extension_unlikely(THEAD_VENDOR_ID,
+							   RISCV_ISA_VENDOR_EXT_XTHEADVECTOR);
+	else
+		return false;
+}
+
 static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
 {
-	regs->status = (regs->status & ~SR_VS) | SR_VS_CLEAN;
+	regs->status = __riscv_v_vstate_or(regs->status, CLEAN);
 }
 
 static inline void __riscv_v_vstate_dirty(struct pt_regs *regs)
 {
-	regs->status = (regs->status & ~SR_VS) | SR_VS_DIRTY;
+	regs->status = __riscv_v_vstate_or(regs->status, DIRTY);
 }
 
 static inline void riscv_v_vstate_off(struct pt_regs *regs)
 {
-	regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
+	regs->status = __riscv_v_vstate_or(regs->status, OFF);
 }
 
 static inline void riscv_v_vstate_on(struct pt_regs *regs)
 {
-	regs->status = (regs->status & ~SR_VS) | SR_VS_INITIAL;
+	regs->status = __riscv_v_vstate_or(regs->status, INITIAL);
 }
 
 static inline bool riscv_v_vstate_query(struct pt_regs *regs)
 {
-	return (regs->status & SR_VS) != 0;
+	return !__riscv_v_vstate_check(regs->status, OFF);
 }
 
 static __always_inline void riscv_v_enable(void)
 {
-	csr_set(CSR_SSTATUS, SR_VS);
+	if (has_xtheadvector())
+		csr_set(CSR_SSTATUS, SR_VS_THEAD);
+	else
+		csr_set(CSR_SSTATUS, SR_VS);
 }
 
 static __always_inline void riscv_v_disable(void)
 {
-	csr_clear(CSR_SSTATUS, SR_VS);
+	if (has_xtheadvector())
+		csr_clear(CSR_SSTATUS, SR_VS_THEAD);
+	else
+		csr_clear(CSR_SSTATUS, SR_VS);
 }
 
 static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
@@ -82,10 +126,36 @@ static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
 		"csrr	%0, " __stringify(CSR_VSTART) "\n\t"
 		"csrr	%1, " __stringify(CSR_VTYPE) "\n\t"
 		"csrr	%2, " __stringify(CSR_VL) "\n\t"
-		"csrr	%3, " __stringify(CSR_VCSR) "\n\t"
-		"csrr	%4, " __stringify(CSR_VLENB) "\n\t"
 		: "=r" (dest->vstart), "=r" (dest->vtype), "=r" (dest->vl),
-		  "=r" (dest->vcsr), "=r" (dest->vlenb) : :);
+		"=r" (dest->vcsr) : :);
+
+	if (has_xtheadvector()) {
+		unsigned long status;
+
+		/*
+		 * CSR_VCSR is defined as
+		 * [2:1] - vxrm[1:0]
+		 * [0] - vxsat
+		 * The earlier vector spec implemented by T-Head uses separate
+		 * registers for the same bit-elements, so just combine those
+		 * into the existing output field.
+		 *
+		 * Additionally T-Head cores need FS to be enabled when accessing
+		 * the VXRM and VXSAT CSRs, otherwise ending in illegal instructions.
+		 * Though the cores do not implement the VXRM and VXSAT fields in the
+		 * FCSR CSR that vector-0.7.1 specifies.
+		 */
+		status = csr_read_set(CSR_STATUS, SR_FS_DIRTY);
+		dest->vcsr = csr_read(CSR_VXSAT) | csr_read(CSR_VXRM) << CSR_VXRM_SHIFT;
+
+		dest->vlenb = riscv_v_vsize / 32;
+
+		if ((status & SR_FS) != SR_FS_DIRTY)
+			csr_write(CSR_STATUS, status);
+	} else {
+		dest->vcsr = csr_read(CSR_VCSR);
+		dest->vlenb = csr_read(CSR_VLENB);
+	}
 }
 
 static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src)
@@ -96,9 +166,25 @@ static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src
 		"vsetvl	 x0, %2, %1\n\t"
 		".option pop\n\t"
 		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
-		"csrw	" __stringify(CSR_VCSR) ", %3\n\t"
-		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
-		    "r" (src->vcsr) :);
+		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl));
+
+	if (has_xtheadvector()) {
+		unsigned long status = csr_read(CSR_SSTATUS);
+
+		/*
+		 * Similar to __vstate_csr_save above, restore values for the
+		 * separate VXRM and VXSAT CSRs from the vcsr variable.
+		 */
+		status = csr_read_set(CSR_STATUS, SR_FS_DIRTY);
+
+		csr_write(CSR_VXRM, (src->vcsr >> CSR_VXRM_SHIFT) & CSR_VXRM_MASK);
+		csr_write(CSR_VXSAT, src->vcsr & CSR_VXSAT_MASK);
+
+		if ((status & SR_FS) != SR_FS_DIRTY)
+			csr_write(CSR_STATUS, status);
+	} else {
+		csr_write(CSR_VCSR, src->vcsr);
+	}
 }
 
 static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
@@ -108,19 +194,33 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
 
 	riscv_v_enable();
 	__vstate_csr_save(save_to);
-	asm volatile (
-		".option push\n\t"
-		".option arch, +zve32x\n\t"
-		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
-		"vse8.v		v0, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vse8.v		v8, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vse8.v		v16, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vse8.v		v24, (%1)\n\t"
-		".option pop\n\t"
-		: "=&r" (vl) : "r" (datap) : "memory");
+	if (has_xtheadvector()) {
+		asm volatile (
+			"mv t0, %0\n\t"
+			THEAD_VSETVLI_T4X0E8M8D1
+			THEAD_VSB_V_V0T0
+			"add		t0, t0, t4\n\t"
+			THEAD_VSB_V_V0T0
+			"add		t0, t0, t4\n\t"
+			THEAD_VSB_V_V0T0
+			"add		t0, t0, t4\n\t"
+			THEAD_VSB_V_V0T0
+			: : "r" (datap) : "memory", "t0", "t4");
+	} else {
+		asm volatile (
+			".option push\n\t"
+			".option arch, +zve32x\n\t"
+			"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
+			"vse8.v		v0, (%1)\n\t"
+			"add		%1, %1, %0\n\t"
+			"vse8.v		v8, (%1)\n\t"
+			"add		%1, %1, %0\n\t"
+			"vse8.v		v16, (%1)\n\t"
+			"add		%1, %1, %0\n\t"
+			"vse8.v		v24, (%1)\n\t"
+			".option pop\n\t"
+			: "=&r" (vl) : "r" (datap) : "memory");
+	}
 	riscv_v_disable();
 }
 
@@ -130,19 +230,33 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
 	unsigned long vl;
 
 	riscv_v_enable();
-	asm volatile (
-		".option push\n\t"
-		".option arch, +zve32x\n\t"
-		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
-		"vle8.v		v0, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vle8.v		v8, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vle8.v		v16, (%1)\n\t"
-		"add		%1, %1, %0\n\t"
-		"vle8.v		v24, (%1)\n\t"
-		".option pop\n\t"
-		: "=&r" (vl) : "r" (datap) : "memory");
+	if (has_xtheadvector()) {
+		asm volatile (
+			"mv t0, %0\n\t"
+			THEAD_VSETVLI_T4X0E8M8D1
+			THEAD_VLB_V_V0T0
+			"add		t0, t0, t4\n\t"
+			THEAD_VLB_V_V0T0
+			"add		t0, t0, t4\n\t"
+			THEAD_VLB_V_V0T0
+			"add		t0, t0, t4\n\t"
+			THEAD_VLB_V_V0T0
+			: : "r" (datap) : "memory", "t0", "t4");
+	} else {
+		asm volatile (
+			".option push\n\t"
+			".option arch, +zve32x\n\t"
+			"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
+			"vle8.v		v0, (%1)\n\t"
+			"add		%1, %1, %0\n\t"
+			"vle8.v		v8, (%1)\n\t"
+			"add		%1, %1, %0\n\t"
+			"vle8.v		v16, (%1)\n\t"
+			"add		%1, %1, %0\n\t"
+			"vle8.v		v24, (%1)\n\t"
+			".option pop\n\t"
+			: "=&r" (vl) : "r" (datap) : "memory");
+	}
 	__vstate_csr_restore(restore_from);
 	riscv_v_disable();
 }
@@ -152,33 +266,41 @@ static inline void __riscv_v_vstate_discard(void)
 	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
 
 	riscv_v_enable();
+	if (has_xtheadvector())
+		asm volatile (THEAD_VSETVLI_T4X0E8M8D1 : : : "t4");
+	else
+		asm volatile (
+			".option push\n\t"
+			".option arch, +zve32x\n\t"
+			"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
+			".option pop\n\t": "=&r" (vl));
+
 	asm volatile (
 		".option push\n\t"
 		".option arch, +zve32x\n\t"
-		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
 		"vmv.v.i	v0, -1\n\t"
 		"vmv.v.i	v8, -1\n\t"
 		"vmv.v.i	v16, -1\n\t"
 		"vmv.v.i	v24, -1\n\t"
 		"vsetvl		%0, x0, %1\n\t"
 		".option pop\n\t"
-		: "=&r" (vl) : "r" (vtype_inval) : "memory");
+		: "=&r" (vl) : "r" (vtype_inval));
+
 	riscv_v_disable();
 }
 
 static inline void riscv_v_vstate_discard(struct pt_regs *regs)
 {
-	if ((regs->status & SR_VS) == SR_VS_OFF)
-		return;
-
-	__riscv_v_vstate_discard();
-	__riscv_v_vstate_dirty(regs);
+	if (riscv_v_vstate_query(regs)) {
+		__riscv_v_vstate_discard();
+		__riscv_v_vstate_dirty(regs);
+	}
 }
 
 static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
 				       struct pt_regs *regs)
 {
-	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
+	if (__riscv_v_vstate_check(regs->status, DIRTY)) {
 		__riscv_v_vstate_save(vstate, vstate->datap);
 		__riscv_v_vstate_clean(regs);
 	}
@@ -187,7 +309,7 @@ static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
 static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
 					  struct pt_regs *regs)
 {
-	if ((regs->status & SR_VS) != SR_VS_OFF) {
+	if (riscv_v_vstate_query(regs)) {
 		__riscv_v_vstate_restore(vstate, vstate->datap);
 		__riscv_v_vstate_clean(regs);
 	}
@@ -196,7 +318,7 @@ static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
 static inline void riscv_v_vstate_set_restore(struct task_struct *task,
 					      struct pt_regs *regs)
 {
-	if ((regs->status & SR_VS) != SR_VS_OFF) {
+	if (riscv_v_vstate_query(regs)) {
 		set_tsk_thread_flag(task, TIF_RISCV_V_DEFER_RESTORE);
 		riscv_v_vstate_on(regs);
 	}
@@ -270,6 +392,8 @@ struct pt_regs;
 static inline int riscv_v_setup_vsize(void) { return -EOPNOTSUPP; }
 static __always_inline bool has_vector(void) { return false; }
 static __always_inline bool insn_is_vector(u32 insn_buf) { return false; }
+static __always_inline bool has_xtheadvector_no_alternatives(void) { return false; }
+static __always_inline bool has_xtheadvector(void) { return false; }
 static inline bool riscv_v_first_use_handler(struct pt_regs *regs) { return false; }
 static inline bool riscv_v_vstate_query(struct pt_regs *regs) { return false; }
 static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7d9e8bbfaef2..ba6976132638 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -874,8 +874,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		riscv_fill_vendor_ext_list(cpu);
 	}
 
-	if (riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADVECTOR) &&
-	    has_thead_homogeneous_vlenb() < 0) {
+	if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb() < 0) {
 		pr_warn("Unsupported heterogeneous vlenb detected, vector extension disabled.\n");
 		disable_xtheadvector();
 	}
@@ -932,7 +931,8 @@ void __init riscv_fill_hwcap(void)
 		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
 	}
 
-	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZVE32X)) {
+	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZVE32X) ||
+	    has_xtheadvector_no_alternatives()) {
 		/*
 		 * This cannot fail when called on the boot hart
 		 */
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 6afe80c7f03a..99972a48e86b 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -143,7 +143,7 @@ static int riscv_v_start_kernel_context(bool *is_nested)
 
 	/* Transfer the ownership of V from user to kernel, then save */
 	riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
-	if ((task_pt_regs(current)->status & SR_VS) == SR_VS_DIRTY) {
+	if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY)) {
 		uvstate = &current->thread.vstate;
 		__riscv_v_vstate_save(uvstate, uvstate->datap);
 	}
@@ -160,7 +160,7 @@ asmlinkage void riscv_v_context_nesting_start(struct pt_regs *regs)
 		return;
 
 	depth = riscv_v_ctx_get_depth();
-	if (depth == 0 && (regs->status & SR_VS) == SR_VS_DIRTY)
+	if (depth == 0 && __riscv_v_vstate_check(regs->status, DIRTY))
 		riscv_preempt_v_set_dirty();
 
 	riscv_v_ctx_depth_inc();
@@ -208,7 +208,7 @@ void kernel_vector_begin(void)
 {
 	bool nested = false;
 
-	if (WARN_ON(!has_vector()))
+	if (WARN_ON(!(has_vector() || has_xtheadvector())))
 		return;
 
 	BUG_ON(!may_use_simd());
@@ -236,7 +236,7 @@ EXPORT_SYMBOL_GPL(kernel_vector_begin);
  */
 void kernel_vector_end(void)
 {
-	if (WARN_ON(!has_vector()))
+	if (WARN_ON(!(has_vector() || has_xtheadvector())))
 		return;
 
 	riscv_v_disable();
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 58b6482c2bf6..6534264dfce2 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -190,7 +190,7 @@ void flush_thread(void)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	/* Free the vector context of datap. */
-	if (has_vector())
+	if (has_vector() || has_xtheadvector())
 		riscv_v_thread_free(tsk);
 }
 
@@ -240,7 +240,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		p->thread.s[0] = 0;
 	}
 	p->thread.riscv_v_flags = 0;
-	if (has_vector())
+	if (has_vector() || has_xtheadvector())
 		riscv_v_thread_alloc(p);
 	p->thread.ra = (unsigned long)ret_from_fork;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index dcd282419456..94e905eea1de 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -189,7 +189,7 @@ static long restore_sigcontext(struct pt_regs *regs,
 
 			return 0;
 		case RISCV_V_MAGIC:
-			if (!has_vector() || !riscv_v_vstate_query(regs) ||
+			if (!(has_vector() || has_xtheadvector()) || !riscv_v_vstate_query(regs) ||
 			    size != riscv_v_sc_size)
 				return -EINVAL;
 
@@ -211,7 +211,7 @@ static size_t get_rt_frame_size(bool cal_all)
 
 	frame_size = sizeof(*frame);
 
-	if (has_vector()) {
+	if (has_vector() || has_xtheadvector()) {
 		if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
 			total_context_size += riscv_v_sc_size;
 	}
@@ -284,7 +284,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	if (has_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
 	/* Save the vector state. */
-	if (has_vector() && riscv_v_vstate_query(regs))
+	if ((has_vector() || has_xtheadvector()) && riscv_v_vstate_query(regs))
 		err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
 	/* Write zero to fp-reserved space and check it on restore_sigcontext */
 	err |= __put_user(0, &sc->sc_extdesc.reserved);
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 3877a0454239..61ded78fcaec 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -63,7 +63,7 @@ int riscv_v_setup_vsize(void)
 
 void __init riscv_v_setup_ctx_cache(void)
 {
-	if (!has_vector())
+	if (!(has_vector() || has_xtheadvector()))
 		return;
 
 	riscv_v_user_cachep = kmem_cache_create_usercopy("riscv_vector_ctx",
@@ -183,7 +183,7 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
 	u32 __user *epc = (u32 __user *)regs->epc;
 	u32 insn = (u32)regs->badaddr;
 
-	if (!has_vector())
+	if (!(has_vector() || has_xtheadvector()))
 		return false;
 
 	/* Do not handle if V is not supported, or disabled */
@@ -226,7 +226,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk)
 	bool inherit;
 	int cur, next;
 
-	if (!has_vector())
+	if (!(has_vector() || has_xtheadvector()))
 		return;
 
 	next = riscv_v_ctrl_get_next(tsk);
@@ -248,7 +248,7 @@ void riscv_v_vstate_ctrl_init(struct task_struct *tsk)
 
 long riscv_v_vstate_ctrl_get_current(void)
 {
-	if (!has_vector())
+	if (!(has_vector() || has_xtheadvector()))
 		return -EINVAL;
 
 	return current->thread.vstate_ctrl & PR_RISCV_V_VSTATE_CTRL_MASK;
@@ -259,7 +259,7 @@ long riscv_v_vstate_ctrl_set_current(unsigned long arg)
 	bool inherit;
 	int cur, next;
 
-	if (!has_vector())
+	if (!(has_vector() || has_xtheadvector()))
 		return -EINVAL;
 
 	if (arg & ~PR_RISCV_V_VSTATE_CTRL_MASK)
@@ -309,7 +309,7 @@ static struct ctl_table riscv_v_default_vstate_table[] = {
 
 static int __init riscv_v_sysctl_init(void)
 {
-	if (has_vector())
+	if (has_vector() || has_xtheadvector())
 		if (!register_sysctl("abi", riscv_v_default_vstate_table))
 			return -EINVAL;
 	return 0;

-- 
2.34.1


