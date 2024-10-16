Return-Path: <linux-kselftest+bounces-19873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF89A13D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C5A284053
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7636217316;
	Wed, 16 Oct 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fE6R9JoT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92C21644E
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110504; cv=none; b=FIbiTwlOurQvmndmwFNxoXCWaK7B0MtKVZjPcGlfKtPKkLUT790V1l6vVwtkTrqxwcY3qnJQbJZbrGsga3ixVF4SzA++nms5+1f9fYad9reCGkTrVTO2FOLllaTYbQQibCOOWwOrKjAc7PtqYbigJto39uwy+jK5e5j3sgeP4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110504; c=relaxed/simple;
	bh=G3tcHs0vugRLIs9AZLkTyVmXxoSZrPQ98Ip0I2VATc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijFmwOOAr5RQ4m0UTLYP+Vmwdmo2kD73tRSZuhRqgWuQ7nyGAEQwMpifLxdQoaBy6mQX+0/n6A+p8l+Y3nXBrYVOSP5crQN/bNLaXQUklnd8Wt9MB1u+PwWOxnOVO88gEM5HqctVA1IhIdQJ/0ljgHw6DrzXH0AjJE9bTWu/acY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fE6R9JoT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so172337a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110502; x=1729715302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8L9RcsXGBuOOIJkGyl0uzoPHSEP08/B/TxdDRrdDog=;
        b=fE6R9JoToN9iNBYxzX4tzIDJXRub40c4vCs9CZsWMcxBpadpIlwl/zgmxj+N5Lg6ew
         kc267vpfGbIfj1mTF0EdmWn1HC+Go/jhxDDTCk7PAt0TewqN51Jt16jmxX8y/tcd05Ru
         2tWyAGWR7OjbZiDPQVg70IDXJFBj/RhJPcqohqFu4Iksahol8lAPDo8s3TqcCjXAY2x6
         uKawWcg2TjwhxWdH5SWKfwXOLj9NtuPvI8RNf67Ow3c3S8ubr3MtR6HP6rODnBV7/aHM
         ZZK9msk3HrnFy0I51Qms6TAcHazIzg5ytNrnALrjBq3VyT+bp7m2Qr3GFtFxQEAj8DbY
         BJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110502; x=1729715302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8L9RcsXGBuOOIJkGyl0uzoPHSEP08/B/TxdDRrdDog=;
        b=ZeZa/THcvtzpvIf+z/Amk7QGsEnTlUUbNTLL7tWoKajN0BtVKQTBVIpFmx33rVzQUB
         W7tiSCaIIejruUBCaDpMjiaak447T16gudW/1rjgcBcciyIXHAFukEIe9stdL/P+yFV3
         RkxBoyFzdGd8u/s0F01jsCQ02HAJzSkQA2rhHC5FoRm1CT4+C7sQLlJ96ikZtthIMMu6
         O4kDI+se6H09b2exNTto3jlLuXnWXgnY0j464smDr7FvFFfsfzrRV9AB67ol7WZWpiA4
         IPm2iTWvdSDlCvf/ydX9c4ljUJdOIunCvYlAbGqehM3IYxOrMUemqh4kF+7Bk898pfCN
         VvyA==
X-Forwarded-Encrypted: i=1; AJvYcCXwpScLhrL8YR60I6iEd5eJSgNLSTjj/0SuLZCeIKPLCbEUiI0HmNrXLsvalVTKssgPpArrIY6ONwVKgGn9lwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzAPSTOKWyUKn788+20uSXf65q30Y72yOTu3x1Y/y2FmgNFQQq
	6Km5HdpIH4dy7lNIEuYhwnJAFDCpggyqLxezbDh2odqA2Wzz198O6UPjr9F6aVE=
X-Google-Smtp-Source: AGHT+IEcrRzQueyWfGvwY23TG0nBCtrzNyg/XChtvSqTPLeH3iuBVoZX2ptDYNex9tUfXpxWrJVkCg==
X-Received: by 2002:a17:90b:2313:b0:2e2:cf5c:8ee3 with SMTP id 98e67ed59e1d1-2e3ab7fe655mr6587578a91.10.1729110502579;
        Wed, 16 Oct 2024 13:28:22 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:22 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 03/10] riscv: Add CSR definitions for pointer masking
Date: Wed, 16 Oct 2024 13:27:44 -0700
Message-ID: <20241016202814.4061541-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer masking is controlled via a two-bit PMM field, which appears in
various CSRs depending on which extensions are implemented. Smmpm adds
the field to mseccfg; Smnpm adds the field to menvcfg; Ssnpm adds the
field to senvcfg. If the H extension is implemented, Ssnpm also defines
henvcfg.PMM and hstatus.HUPMM.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Use shifts instead of large numbers in ENVCFG_PMM* macro definitions

Changes in v2:
 - Use the correct name for the hstatus.HUPMM field

 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..fe5d4eb9adea 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -119,6 +119,10 @@
 
 /* HSTATUS flags */
 #ifdef CONFIG_64BIT
+#define HSTATUS_HUPMM		_AC(0x3000000000000, UL)
+#define HSTATUS_HUPMM_PMLEN_0	_AC(0x0000000000000, UL)
+#define HSTATUS_HUPMM_PMLEN_7	_AC(0x2000000000000, UL)
+#define HSTATUS_HUPMM_PMLEN_16	_AC(0x3000000000000, UL)
 #define HSTATUS_VSXL		_AC(0x300000000, UL)
 #define HSTATUS_VSXL_SHIFT	32
 #endif
@@ -195,6 +199,10 @@
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
+#define ENVCFG_PMM			(_AC(0x3, ULL) << 32)
+#define ENVCFG_PMM_PMLEN_0		(_AC(0x0, ULL) << 32)
+#define ENVCFG_PMM_PMLEN_7		(_AC(0x2, ULL) << 32)
+#define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
@@ -216,6 +224,12 @@
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
 
+/* mseccfg bits */
+#define MSECCFG_PMM			ENVCFG_PMM
+#define MSECCFG_PMM_PMLEN_0		ENVCFG_PMM_PMLEN_0
+#define MSECCFG_PMM_PMLEN_7		ENVCFG_PMM_PMLEN_7
+#define MSECCFG_PMM_PMLEN_16		ENVCFG_PMM_PMLEN_16
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
@@ -382,6 +396,8 @@
 #define CSR_MIP			0x344
 #define CSR_PMPCFG0		0x3a0
 #define CSR_PMPADDR0		0x3b0
+#define CSR_MSECCFG		0x747
+#define CSR_MSECCFGH		0x757
 #define CSR_MVENDORID		0xf11
 #define CSR_MARCHID		0xf12
 #define CSR_MIMPID		0xf13
-- 
2.45.1


