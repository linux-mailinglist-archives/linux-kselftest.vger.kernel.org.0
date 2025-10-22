Return-Path: <linux-kselftest+bounces-43809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30041BFE89E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9F1E4E277B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBB30BF64;
	Wed, 22 Oct 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="UAyJ7kz4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A3309EFC
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175789; cv=none; b=rWW9nB7s45wS88HXx5y1SlTj3nmh4THSdIGcSOCe4cLyYblDAyUEP/p/NIZ1KOFcpbJWk7tl+UO26V+Djk8If2Bs2xCkJvtOuOkfnTeAjMu3Efy5O8iMWvMiXW9Nvic41eWRJxzRaonDxx28gqKYSwT9+jUzHQazheTRBdd640c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175789; c=relaxed/simple;
	bh=kcKAh3qiYa6u+vavoC8VVP4XbgP0FdaLB3/LKiPnoo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnxGxPAKS0rHdDAcgsNWqpO4YaP2PgpkPHm7jMMPZCwl9T6o8+LwgCUeJ/MStiq0Z5xL+EdbF/LIis2sQgNln3K2ojza4Wnofi528dt58LMzU2dHfqS2E52dIlgdKdoc3dx6Jv0fVz3NOt/+Skgkz5xS9ob7jlncOcwuxlqd4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=UAyJ7kz4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782e93932ffso174535b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175786; x=1761780586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=UAyJ7kz4SyjeMfJyBJsyH0sZhGYdIueo5darApiWOdi+dnrpwzUslLUo89dGqBOyJK
         29Wx79Ez5mWTZSUWOHuPBMBpYyNaTlv+OPRx0+in5XAQYSpMVd7Z83rsGoYNV6Ggphap
         bi1lbpfV+kGqgLkc+7isdouDJHpn/ZomopCGAKmocrGiIsi9oLjGCtkW3RM8AU8oUCIf
         UmdsUNdakN6B8DV+B7GXmuHgXZ+zk0aEQo8tgcVp6t5fqAu8qlcYqUDS7+jYwzOIV2zA
         z7Qw9NGQL4CaralcdVHO7j2SVwtuuLx4XgpKaJ1bVd9a7+2+NLDdllVbnSHkVihaYbIm
         /hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175786; x=1761780586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=cKwinNsABm/wgCpXS13GkYLc6aRZr78fpHEU+GulJJi6G/99vJPeZPCh93K6zuowuc
         MibvjOZk0fBlUiW8IWws1f10xIU7n5OLIX4Nv8fDzjJWKnM0PDAj7wdmMy0AipeheXK7
         PoFpUflFwIOTwpjkeaxDd0pOVhP/sAH7qcPv4Wy1S1soR6D0IEQidgc0m3fQGsQCn7xz
         xLCq6sNcFVQ87+0itbyjy5jlIVsnzKlFTtnl6zEk7FoMGKRp/8GmFB8mQRmLqjseLWNj
         Gy9irNrDR2Ox75gaK1X27v6y/yiU/6j0PUnktKzMmKWktrhhwXK7yRGupncXgPIYpIEp
         0+JA==
X-Forwarded-Encrypted: i=1; AJvYcCVwLnpcOUaUeuTiwuHhDHwOBeHIHQBxdPG6y0ABxuiQudHLvZgIOTjKpfPKW4x6rN+ReEQPu9JGSwdtbSApboU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwttdpO97Cnm75sX+BssMqiqMRyhCvFF45Rqarh+PLvVEdP9rIo
	SReLXmWGbgRhaBNOTYpc/4txFRr5EICN34syia4tPSQ2TZ/xFbG/bEqzZTTqBcLVUMc=
X-Gm-Gg: ASbGnctle/XAH3PBY6cXWasttfTQ/M2dRdvJ+gwaJ96+tYkuFw4YGkpwJs1yetz0LKG
	tdDMjwqcs3rByo+YWX+/l6qEHc/msNQ8LQACwoQUu+vQrOjQY34RIAEe+0gPAOgpFwqGPv+I0bA
	xXaaLVXT6jDbWI1Mw1CCwe5iDUf6PD5zXWaOJ4KwQOnwq3Ld8acyc+aVy+fB2Q8D9nLNHEsibBE
	Zq2DHCOt0cOhYlGNL4Sd64L9e4fobqIJTt1JxT2ELCx3TvGEpFqRdt2/xbRoXovXCliWo6S7SXG
	mysMuzYKsmNYL0JdqM5js5KGbJiN3lIbLICLOWVaeMvsCf4HIVf0+qDYxewHN1+HCuFXRQ85F62
	4xzFhgAAZ4vpWdQe1Myb9HumUHzNslQ0VDLnK/9tqCET3wE9q+TklcW7NA2YHAMjBMx7HDEywF4
	5+ushfv3d6Bw==
X-Google-Smtp-Source: AGHT+IGpg9In2jt8/9pAPq15ryiECZkAZCWmg0292eiGIgEJkxmDrXUmRgAvAg3+aUxc5xibypmpsQ==
X-Received: by 2002:a05:6a00:3e24:b0:7a2:6e61:c2ad with SMTP id d2e1a72fcca58-7a26e61c595mr2577650b3a.19.1761175785988;
        Wed, 22 Oct 2025 16:29:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:30 -0700
Subject: [PATCH v22 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-v5_user_cfi_series-v22-4-fdaa7e4022aa@rivosinc.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
In-Reply-To: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
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
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
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
index 4a37a98398ad..78f573ab4c53 100644
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


