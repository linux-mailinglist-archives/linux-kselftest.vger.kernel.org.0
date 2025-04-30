Return-Path: <linux-kselftest+bounces-31977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E0AA3F02
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247BC9C2B82
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD2D225765;
	Wed, 30 Apr 2025 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aWWknuTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF91223339
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972201; cv=none; b=ev97p7TEFVaOllF2PBlqwI/rVpHoF3r6QcuLH2NKV1w/4rr9QGw9jxFl4T2pEw3AJUUJYVyUdRCPbIjGdMucuLISAdRw3guB5O9JHrmVsduLuXgZuLrfxQzR5yGoJ+UpeF1OER6Yrj0X/+VEwKAdq607cUHhxoTqb+6kPhPpd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972201; c=relaxed/simple;
	bh=ynTUDLBp2gEKhFeiYfxgOCPe6wht1rOzpyg0Vu3jGXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ey+wuCGHWjMMiCo0Un4a6Xl0nwJy1TNkRjNRD1MQER+omUJuB6nhFkVuMwcZ8kZ5jhifTa/Jxc1ZSiZ4XrKN4rr4Xiqj13xK2j2LL2VkMpOwQSykgIDINZR+ScnPmVvDTiwEuLTYNPWR8u2gtEw7AQxmJyk+brgKgpFBeZhmZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aWWknuTZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fd89d036so83499555ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972198; x=1746576998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=aWWknuTZpwr5nS3+pX78CBxY3Nv1p4LasEyZxvLZVIpT5rwtGWzxjeuc8ozsITLJj4
         uPZh4L9dUN6zfIM0rjFILkrrQxwx2KGrSgQ0TPFXRtbPLLLuLaNnegt/LR/ECb+KIlmo
         2gmbtf/mm+rAv5IPSf3hC/bXrM1R35k29ZOt3x8xGM1rs0RHSygNpVXgzuyj9fB2ZfWQ
         9FrB7wTJ2A5MRcz6BGCmJkGdMWAdzB2zT3pkwWLza7DHjSEYumOhDi/DZD1fYBAQOb/W
         THqSVcvs8g/YRs8eyU6Dfc5q/9J/FMsuV9BfRlNnan7m8OpYPOQDP4DJgXV9Raf+Isja
         ki2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972198; x=1746576998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=mJoybbRLxGWsG/0pJOREIN6gjNfYJVKYa5MbZAw5p6SQ6ZP2GgBltrqO7Wi9NRDyuW
         PdAKxPaR6feo8ICpY/NnuK1jaQhusZKDEZ1WTejNDXmiOXOONIilkO7uw5hZMWvQ7YUS
         Vj+XVf9HpiY+XzLMthvDpuClWYUNytYFsN2MuJ2iPz5mx2EERj5r7FtRTrtz3DDOrYCw
         JfW6FmkNmWqSed5eYQTOUcke33qLYMV/Xz//pba+xN/7s7X7+AUlFlPGTb46SL6/Zxqt
         XMV03G2VSyUDgsoE3JROA+JseuYAbAnv6zEZ5hEJz5y78DQcVeg/hSz9hNgOvPDsaUuS
         bz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc3nDxD1T0FkspUSH/yTAWwlSwPrF6cM1aYBX839sGbPgtDlnOac7HNDPte4YLFe7/op8eq9/G8F8HhXh51Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSIDQaw89StEhO0xrAsE5k7+Pp7DUHA2eyao0Kndm/dIxK8Ev
	F0rq6+yGULsWIBi/G4Xnlcy6QPsPnUSTLmtIz9ml74M43JWp7DnMR64/7PrFFt4=
X-Gm-Gg: ASbGncug3N+zQEj//AC7jSilSlUmq2yukfvhY08/VvgLaarLcEuHRnvO5DIfDKycDGE
	qjq+xNJTLBCT4CRygSl743YmPqoA4RSjqw9pJN/+juITqgOHcDdQtFzvWOsLdMQjLPhG1HlaHJK
	4vTrXzhff5sZqSd8p4ZRHuoy4UQwQHvZM45RshrBYqYLzdr+TgEY9LBbm3d9TWEq4FDndt8sbSn
	dEbGVdKMPry693bjAbsWVXCF9UAEyCh9PSrGjJ8xAE5IClpg6Q2l0dK0zEkZ8SfAqtIVaP98WeO
	vqhgQYMzfr/vgZBIFGL97AXliUh35gA0FB2i38h5iSTtivU/mVc=
X-Google-Smtp-Source: AGHT+IGgUZYU3gBslaD7DYbu9352xzjmmUNsFUbJHh9p4RhBMds1qn9WRtirqdbQ2JrH79nyYx15LA==
X-Received: by 2002:a17:903:1c4:b0:225:ac99:ae0d with SMTP id d9443c01a7336-22df576355emr7856465ad.10.1745972198489;
        Tue, 29 Apr 2025 17:16:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:21 -0700
Subject: [PATCH v14 04/27] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-4-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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


