Return-Path: <linux-kselftest+bounces-34306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D985FACE2F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA4D3A7B6F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA69202C44;
	Wed,  4 Jun 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bGMRT4jX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD001202963
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057387; cv=none; b=RVgvDNEaWbQLcnC4Yx01uIW6jVAz/kYNsoJH3zD+mTLn832zjCF6IjRHTLhVo/1Oid9x/iNpqIqp5v7oMEm5IqKXaVIUu4787V3pB/cLLIfili2hIZHYyfly5DtOqr+HaeEHH/ssrKCwoevRRIqDRPrC9GyX9RQSzRsHCgGZhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057387; c=relaxed/simple;
	bh=ynTUDLBp2gEKhFeiYfxgOCPe6wht1rOzpyg0Vu3jGXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXEQVJ0hOK3Es6XGXhQiRdo4MWma2XdUP3kSAsiZTCKiw4kH+MGiVJNC0lGSE4Pzk8kSE1oXSwzvYvvpwvdq3lctYtxhBMMSkBcpkkSyY+dja8pb8CEP4jBDhO5d6CsXPsR8fcBAbPnBACKkZ/GPH+He6aV8+5v0S572aXTBprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bGMRT4jX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234f17910d8so661115ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057385; x=1749662185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=bGMRT4jXUFfL6pialkPmDofJUp7aaUhI5yJDVHaddRB7MYV7qPIJyBC6KWl/QdSKEo
         gxn41IhyEkEm9r0y7HmhHkawBcWnplkzf4ls17WbrvqV/UDR6GizCkso6LuBFxxcG/MG
         EsxaPasXuyu0lZJ6WWSapIQFtQu9miOva+jyD6kTOMe45PnQpvwmV28Qsz7q6CUdc4Zz
         NbUB64izqER6F72h0KQK00i2+aQ0PCGi6MtIIxBRocjGvWcDaOSVd0jsVTstg1lAWeqc
         JOyQVgrFhYmhr1SpVZWtC//nkeIiVjz7v4jh6OTn2jSdmFjGcmQuc6miCEOPBRtuUHD9
         w//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057385; x=1749662185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=nW/19+VzS1IbrLYS2ycqFUzOptg+xbJDmBOVNIULbXr2AXwwpVABmvRdUwIqzgtRpx
         purkdQXs1rntNGokktPOBqjSt4hM/p203peoi40P9SDJ7Dx93lRMJ3122V+wzrTM3/n9
         ReTfmO6unUHdUxr/A9KcUzNS9uWfq3tk6nCZaqlkkFvZ8PiFJqvhBPQD3jhdYo0lhSVH
         j7qGcJGM33q6XVMDYKKs1uTU8YVOvBlsyFtLdXxyP4H7bx++hnyW6WHw1xr1gV1179GG
         rXsuJ4vOEohqZPXy322Ztjs7XZxglInJnk9gan6ymEtHPb0wc9FOMWifVTokQODXMJDw
         Kq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTG3sBMEMgwolfrl/9el3ZseqYSmeU3tMNwsrFyUzjSH4ECxN0cneI2iRYm2oS8/RyWbQUuDbTNJeWwwECdxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+Zn/eFnT+mPLc/jLI/7I4HjvyD3p3/rQ9ljwa9C07QNc6oHs
	13MBKDlOEHeM1beQw6nYKfed+vqJCm0WEzSY2LjtwKoJhTHDmBMOPhdH5LfufKlNkECRFYn6tqJ
	+soKc
X-Gm-Gg: ASbGncsE8fTRTklHrTOxOnPDRvZvjiQU6ipl6CkpDaT/nSHcF514UA8Ondb8A+rj13N
	iIYnaIOf2vsBoAdCx2HR6G1IdZQa5R/EKfZSquGrWlJTJ3GJzTOMjr1A6pNnz8CEG4bEqd+SI/+
	TXTM8+XcLjrts6a+gZcZ77HdHC8Kh14gNqV/no1vtpy7H4w1ht2z10/9G/2bQ0wxHAVT7f8Zjbg
	HkaDSmycO+PnBNjhXQ3tG/poc1D3SSVym/tN1auAA0Ig9AKa06ro331WuacQvkiKvMAAyDVc0Ez
	uji4jZmI2leO3+vASCYD/JQAPfgeTSBngL5nVid+NfA2iwZ7+Q7zstd+rKZkgUSyEgM+yPD1
X-Google-Smtp-Source: AGHT+IHOq7jdfe1QXesVQTTYh9pdMzuQq9fifPPejLKBYzrKsJ2+M42lgYFnihYLRnJ8kIRxucrJ3w==
X-Received: by 2002:a17:903:1b45:b0:234:d292:be84 with SMTP id d9443c01a7336-235e110dc8dmr60521145ad.10.1749057385225;
        Wed, 04 Jun 2025 10:16:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:28 -0700
Subject: [PATCH v17 04/27] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-4-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS
while senvcfg controls enabling for U/VU mode.

zicfilp extension extends *status CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target
instr. `expected landing pad` bit from CPU is recorded into xstatus CSR so
that when supervisor performs xret, `expected landing pad` state of CPU can
be restored.

zicfiss adds one new CSR
- CSR_SSP: CSR_SSP contains current shadow stack pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 6fed42e37705..2f49b9663640 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,15 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zicfilp landing pad status bit */
+#define SR_SPELP	_AC(0x00800000, UL)
+#define SR_MPELP	_AC(0x020000000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -212,6 +221,8 @@
 #define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -230,6 +241,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM

-- 
2.43.0


