Return-Path: <linux-kselftest+bounces-32241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B03AA7CC9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E534F7B8676
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B29242D78;
	Fri,  2 May 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TyXxakHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DF235BFB
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228655; cv=none; b=n3Mj9rKLnmycI72GkYHolIRffafR2sQrUhtHXaVpUd6JijAYN5HQTYBa106ys6lAuhrPfljRYDOwTJjweNtNr0EBX9xQvTB8rRRAAb8yKamb6BAjlI9qeNiUb/5iRRe/phnw58xAlR71qN0mVhEjUr4ylw+b80a2DBP4UMkZLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228655; c=relaxed/simple;
	bh=ynTUDLBp2gEKhFeiYfxgOCPe6wht1rOzpyg0Vu3jGXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bODIFlXJwKnI1fzJuk8I+tQgkADA8fgj5RMtRd6EON6L0ge07gXrPWEg8PeIa5SSNp/ciDA4rbyvJ44e11JnyCtxM1V+pM2IY1MJCg7YoHAB7E2dM4Nl+bpiEeyvBLEhge3e8Rz+XwMnwtWovqT+azkRq1W7FBPdXZle74ICuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TyXxakHa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af52a624283so2423028a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228653; x=1746833453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=TyXxakHaeAZHlTUvoWa2TjRET+Ee6BA9WYGfuTQqhwzC4usjFDv9FZN97xRFTg0mUg
         URzOUT3OleO77+SmHNVy5WDxPqQ3G6bR3lnlwZtq5LYLNFOhhmGXF2uZBjX22t5DbRWH
         DVdmNcX4rUT0/xI5Xr2B0lOGGA1ymozm4ccX2w/IZIxbq21UqfSIVRx2ToZSZsJ/+f9y
         CNnCMw1HaF5uXCyEUh8LLtNH2gOgxW4VarhgWgG01tfv9RjpRM8tV3nrPJc6WphnGvxe
         5KcNrNZwQdxkpt3AYIESkMbvgW/m80ArozCy6w2Z7tH/CeJx5omHZEl+Z6RDi0sobfUc
         Mh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228653; x=1746833453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=mir157ukrNvCVuzkGfZcAIZMIbeea/c+KMhryTqq1MmU86b8x7sYvUSij6gikI7MHo
         +xELMlFwmjJnhtsHCQYBZPcBK1LRO/33guo3atkGed0qocAzaCcm0dRFqWM2UuN/adWf
         Gk7KSs/hLO4ZS9lYN0vgKt4qSUNvGDgEYueiWfpMn5atmqTmf/VLNwn5ols9EBR97MTe
         2QZ7aqQp7BXY8DmN7haKyGmOWEL1L1bMLilD2MsNNFZYFWfqZSRsCSgPiDUNz72Adh/e
         dEFcyPF9JgGGehDMh1CFq3uUw3ccq1mb9kSRbUwdqboz5Dry7XEvxodTwV0naIe+kqwH
         twUw==
X-Forwarded-Encrypted: i=1; AJvYcCWkCezcpTyU8PHIwG+inwMnNh2riPNAKTAeDwulQPExpaE/tFwHUjfC0tCYuCQr0ycWl51RoBI5BybkxBqi4PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/iACMM3LUVZN4Rs/XGHgTNbg33VbKIOGSfRGMn2V35nnLjpm
	ocIjXs+Kqg1W+p3Xt9i5h8EXs6TfH7URqB3lEVxUmGSDo51yvZjsBfzQAo22GCCYACp+LzJCIvH
	B
X-Gm-Gg: ASbGnctzDLLCHU0Lfm3l4lr5fR8PoJ2wk7fr61lOHs/VxyYzwaFB7Tq0rFFMiTMr3Iq
	NC6hlm6TAz/owfuHH8OLWcGVNEjAYha+8nvAqKKegK0bUW/JanFKRn/Ad9Aq3JxaNjTOAuIij2f
	w8uCgGSgAK3cdzT+cxAT9XIdW9Qr86+H9npIO+SuNT4ip5I9cESPysSWNJVN7cb3nz8RDD/bicM
	9FnsUy3lvByVNe0UP3ixgTJ3wupdeUnj6odgPRufzUB2UeyA4FNJ4KlzADZ8q5rhKJ9NzafkxSc
	CMDQSYsGSDKJ113x4QPLr2psfiEV0b6aF69JMjqqtqGjmvDZJb8=
X-Google-Smtp-Source: AGHT+IGs0pVpUevLo2D3rqK2og/pTuqkSwWUPXTs5QiAGT/XEwvhGyWKmfpP4hXzuCuawzC/3i61QQ==
X-Received: by 2002:a17:90b:5242:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-30a42e73ab8mr12121491a91.8.1746228652914;
        Fri, 02 May 2025 16:30:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:30:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:35 -0700
Subject: [PATCH v15 04/27] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-4-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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


