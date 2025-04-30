Return-Path: <linux-kselftest+bounces-31997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB59AA3F79
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8CF1888249
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081D2882DF;
	Wed, 30 Apr 2025 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OIh9BZPH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B42882B6
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972265; cv=none; b=UJ3tM2gxAy6g+mx44gAmKV8vaHPDiEwTkB2EKOy/03QsvXy6NL7byxhNDVigeF7Jc4xT/avbxdwMbtF5eBOi4wI/HFKV35oEPrdIXv4UR+Vuy+qTdFO6Q7wilAKXfJ/kJcEx8tBY9ddKYncBNUnOKjY/Ul3vYphB9KfXX2gbsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972265; c=relaxed/simple;
	bh=GE8Gm6miTPIzkm/uWfW2yRIZ2hw1s9BGH/sbAx2eJGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9BT8pKcwq/ddFFKmX1u3/sgyHrFQ9avzhqu8t0uEJ931hXj2edHvDaFGyluWKsLAYY4vpfW05u57+cTx7fygnQvaYx2BT7GjA3QjVuPnlYFba12IDVxSj92cim5jvPx09EKbmCJaUdte3t8wE/QfZFS0U0F5EMvnElE323esHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OIh9BZPH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c33e5013aso79523085ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972262; x=1746577062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNzeP/w/trhTL6cWe9Pecwh1mzcoQfn9vSNH+Q0tuaw=;
        b=OIh9BZPHwJ6jYY0goxjKk+XEnTQzcCvm0OuYYaiLa9J6Y9Dd6Ktfpvec8jXD8xHAx0
         1jfF0QZUfIB/sVKqGE648PcEoZ5ZVFJtgcQhQlbFldTm70ilB6NfbJsul/VMMA5nc/sh
         X7oa4o2E1BzFudbIIdwhnCs0/8tnCtJH6QqMXbq1LkX8WF/vtwzz1FZPoLqQGPxBYboG
         QyXY1/lcvxftV7guWaQ+2gY/eBQ6DR9IXJecxlQspEimEoPtkCIvlBzvVW/SYqJ8Wm78
         3sHQGg6vc+hO8jRZN4SAnm62vbYbOOBdEy6KUGrx4moBZ15/JDlosz3vilV2u41dp/oD
         OZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972262; x=1746577062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNzeP/w/trhTL6cWe9Pecwh1mzcoQfn9vSNH+Q0tuaw=;
        b=FPBYtKJfrK2GlpNxBWqau4aAxeq33L1fc780OSJrOAVdSp27s1Ew9IeMAoVr4lFlDn
         Z9A1lr0g58ByyiiOvJ2UghlJokWz/P6p12Z3HfceGkgr813gE8UhjKBDsIhH2GUNlMH1
         TFyBLr+5JnIFGAd7+dU8huWi/vS5RGlJFGRrS19e2Dc3lSqyaNwNX0a7xgWLkIZJiCgd
         WlfUz8qDUYfMk4saHzfbnvmpLVTecozD+8qiAjAEULLyk+PXpxFY6n9d+2lSxVJ/SsKp
         lgm1lfUl7uaeNLpOdQO38m0k9qkfD1VhNVf34d5CIVQHn3mDca9oQ8fv42y5zv31C/sW
         IVMg==
X-Forwarded-Encrypted: i=1; AJvYcCVCEGHDwu7KWODfxGs4wVw2ji7m/5am3LRq5FZE8mqCzzk0dw6gcPgLLoUJHCccWECwJh/PtuzmTbJSf471eZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfHxHnsRiJjD2N4c+jWhHKWmK/6ZCmRt4Uy/YU8lnIbjZIsbi
	yWjhfysS3I9r48c+VgHEimWF7tMUIyl6XR1kgO+kg4J3sp4rxnLAS2zEGRrAnT0=
X-Gm-Gg: ASbGnctckKy+HlmPvile8/PVwz8SRycWyW4b77wOcUf4qqsKbWqp9W5ZEmT/tGs1uvM
	jpq1/d1iuUNxwyKFPqeKlPXfQJYPHm2GhLsMMfrPH5siwXU1DnfMH1kYkHeiqQBtzISzwHk1l0N
	DyPzgS87iFCfrC7OwKbNKfcoL2JEkHHp5kC9nrc0q8Vxqnchpu7M1MRIXyq1+hEbhlkmAaqR6q7
	hq/iOS7Iv+0f8TAACTpTLrXlOCCiA+UQHJNgCukCXF5Go/G9qn0YdB8e/aigRgN+OCnM3x9rDcH
	CfW0UBf+inVWCeKmvbadtzNAwZSbSTy5mpRVFA6ccQpd8WMOcx12icKZt8Egyw==
X-Google-Smtp-Source: AGHT+IE8bdn8tLEphSjIyMJDkn6ceb8Wnl4C2tXu5He9G7slYh6azYWKOO5c5aQwZY8zwfz/0/Deyg==
X-Received: by 2002:a17:903:2ec6:b0:215:b1a3:4701 with SMTP id d9443c01a7336-22df57a3f9cmr6603965ad.13.1745972262508;
        Tue, 29 Apr 2025 17:17:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:41 -0700
Subject: [PATCH v14 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-24-5239410d012a@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bbec87b79309..31ba88f42b1c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -256,6 +256,26 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select DYNAMIC_SIGFRAME
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8

-- 
2.43.0


