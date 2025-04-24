Return-Path: <linux-kselftest+bounces-31493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A531A9A347
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E33188E3E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1711F91F6;
	Thu, 24 Apr 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e0l06LJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE41F76A8
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479236; cv=none; b=kDbmeP5R+VNT1ylGBXvmGvIUv6JFYEywyNrTzbe/TzswD6W5vpIyMayTNFHfJN1HcQlt2oN1rks1GLu71uYe4pt2oF6iznh5WkzVcuxnvpxK7ha7jIDAKUbNew928VQ7MAOBsTPzZzUM0jjvs9ipuzjg96CiEWg28Rd7Y2DGWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479236; c=relaxed/simple;
	bh=ynTUDLBp2gEKhFeiYfxgOCPe6wht1rOzpyg0Vu3jGXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2AnRoEDIrWqBHuMUDCwF2PX/H6u21sTzEue+mK5zyBgmuo+cNbZ2ZTu2I7yQEFu2p8y2rI6KQ/MDEpF6amME5Bajy06m9X2QDZT/2KlDzdMHxN+IR2P/fXp4NPJQNzMHbzBTHiRCnDBKBCxDf/1Od7WYgcNJGV3ZfV4DA6iakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e0l06LJG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso9624545ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479234; x=1746084034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=e0l06LJGjGYgqEs8930R24/vCj4c/+xFDgD6D9fm7Mc2uV9RevhZYL0wyKeYBUouzH
         HwVbSSx6geGhRL6RHOy9y6SWSIEtt8iEoM2LGtKQriBvCtf3+2QakHbadP6yfOhueI1h
         t1fT5WqXdcJ3591B+OOHmq8Mu+YO3t96JLkx3eDsRdmo9eUEv8xZzsuKSQMBZyUpM5VI
         VPs9IlOmYH8QIHqBVgprH3OC0bmwsK+Hl2hwON8Njbk2j+lu6YHn5kwVbyitIVIzKIOl
         A/6Sk6hPIbW5UPsLf2MyVpiyPqiywQUnpdqktr1fuBYCj7MyI5Z+wlj5sTL1nrfWp9ds
         VFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479234; x=1746084034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=Ao/Ju6dVBWI+PUinCBbf7UjL0IWliE/orJp6QehF+IkEeFC1IJpUx/eKgdMWsTS+aQ
         mbUisKguyVqj79d+Ymx8TZHBMPb/YmndreorTxJu8Wywz5a2lmfTy8YNxQZwrRsVFDuj
         ohKk20cO3ymJqFq6apH/rQbtFOf+I12pIIHG7xgVXHv0sq42ofBHBFJFb9JSHZ0pMenh
         OXhezxoGurSalP0IrFB6U/Cc8/JQDMfCO0aEpEwHYUkAx9vyY+JbhWo3fC/Am2+m59E8
         mPz9Mis3kB7QkOZtVtHtW556KCu7MS4efpF3He5qFb41ZpUD3N12MEa+QTGIkJdqcFfd
         GcQg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4Ym2cHjgMMK1OT+Ic0fLbVXDtNn/8vY2f5nRUEjvTg95Qo99jUxICatwCqJSt9rlcYg2JEQWB7tG5hFL0yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgNkkoDbCEcAZw8edRrCr2FehpoQqAgItr/lIH/xX9PM/0a5M
	ZwQ+u1GPYbBpDII6A0ko8/BGeplrY7D8yR7hhacqZwCkhmXymc9FO6+P4JGQiu4=
X-Gm-Gg: ASbGncuj02aELHEzxHG5j3gSYP9aZJNBgyVCAah4kYxkOOsSlMkPgWbOjU+lf+w2mjm
	lLVAbH9wgxnw7nbpS9DUvCCDAV5joL8IYfsimKMHebqBfQx+ctPb0EQk0RC1dNvFw4EjmwaE0sF
	3Xh+Fr8/MdkBEDiBmERV14IJvsdsk+U5tbR/mwR0qec35eW7wCZrcE71hI43LhaGpvBIzjSTHZ4
	3d7lXCaskwgpxEEGY+ZbiumLpSeWTI/5/jcg65pbObb8FUQL5MV1gQUc+nvlLKLEpVI1WGLzlDW
	LKt+ORV4EpUL8uwXS6jkjt5zQTDKK50e0yaIsVnKDGvXE27Fs/M=
X-Google-Smtp-Source: AGHT+IG7mvKQVsAWhJ67siR5HyXzPu+FGKMk0BZF9KiTPtDYxOR22o33eCLSKG+9Sr0e0wwJKYQf8g==
X-Received: by 2002:a17:903:2d0:b0:224:283f:a9ef with SMTP id d9443c01a7336-22db3ba02e2mr22559525ad.6.1745479234501;
        Thu, 24 Apr 2025 00:20:34 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:19 -0700
Subject: [PATCH v13 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-4-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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


