Return-Path: <linux-kselftest+bounces-43870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6EC01662
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768DF188F064
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A75A32C953;
	Thu, 23 Oct 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="G4oQRC14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0232B9AA
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225952; cv=none; b=EISUWi5NICP6ecUAU+aRnzWHxphK+C3jczsBdNHWCNtwqF+MXtc3DuYbcJL/YnkZoI1nNLO6RlmujdEbamWJ0Z6l8Vyw3gidlx5znplj3MBenXf1SZM0LIjnodV5yOE8kvfcDuDD1dWakx1azG5fhDvSXSwVO2YYvN+WauaSJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225952; c=relaxed/simple;
	bh=lpSh/4YF4b6DV2vqO7uhXaAxm8ZQQfhDo9tNU1Zgc2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWfMiI+rg2pcxrYXOUFybqzSNkmYO3uIWta9SJiflDaFkKveSMmbYRGgwECkqQtJ5kQk18+2qAwEM4biUjCnpfov6mlF5zDKNIsqo7OrXw7nbKk5z9qSLgr8rNUNSQmxHJGeCxi7qKHQRVhkdKYZf0pEjJAR+nM5w5qRfjJwHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=G4oQRC14; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2697899a202so15978715ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225950; x=1761830750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZlhaeGyn05OIbis6SfSAIFcz6IbZPi7uJh5910jbDw=;
        b=G4oQRC14VFELFcxDtCM/xw9+miPsbh5+eqoX75/zKqWk0oDTz0WhwbaoWEQ+6Cifj7
         9+Z6THuuBScTxdr0rSD/vdFwPLvTodJXxSpYTD0vPEFwek+8HoYWyLGg5qVPnkBKGBU0
         AOzVpmr/nWj/IU3bXprK/vVvkL+gAGO4YEQh3C93Xu1CJkIjAceAa/NtO8c2u2OtEprK
         HIW6pqnPqoi53BNnO7CzxlKz9HAPHTyQXf4hyGre5ROFYK38FNmRWj6Efs3ZeSLp3Tv5
         B/1iv5L9SKGqeQKUsR/X30/U0j6wy7X+UWq27TNzGheuf7cKDmYNyqvq4SyLEpm0voXz
         V7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225950; x=1761830750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZlhaeGyn05OIbis6SfSAIFcz6IbZPi7uJh5910jbDw=;
        b=VpYJm6OSo89aaeUBpqLxaLDyn0I3rtB9asU0DhhAZB/bpC/i/4wh2pM0uHL2Wjs51+
         d3QH3mLATX8vCTKqYDC3qpnc4DkmoPA0IjEqNRhnqxoOS5YjnKejx1PmceTrcirlN6Yp
         Ebn0Njb8IXenJFDIm4YIbEUIMRVUxrbkadalAJPtdLqYSpytIgg7kiUy8JKV8qUqVgq5
         KoMHnfMgDE8X/2UUjmzlfXAuihQ6po/KdleQxAZ9FxeEjuJct05vX6ezLGV6JeQ7mzXY
         FvY0Api1GXgoFTq6FCRVGnZYy85XVxTs8Kuluuur8EsoqwqQsHafYRWusEOVDtkXSaZw
         N1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCU3bYwXnMyyh950ag7DJD8HIKYbr5Xa5/tttRhzgXMfR1ib8GGh4l63Iiqdyi0zhVpl2rNH+UH5Mf2hV53JGgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClVLkrG+8oqekNvxqXDCMEv38l+p7Y+cjrldImQp4Ue++B9/2
	FlI7Y8KxL4AtejIHhYqqEKOfWrZ41VSL54AxozxAYkqZXf1bFuwLIxHr5tSB42Dozk8=
X-Gm-Gg: ASbGncuBeRcCobL84obW167nFfD8HAPa2LEl3vJO6+gxzQDnG7I2qY3Pe/NFGFbZSyS
	qE6+8YuFxMpZDseae5uCasGwf6ewCRwnXANpGS8cztEScQyqav3yutE2MekHeJ/YUbD3CV2cSq8
	81tdV7DKhMGk2EbaMccmHfzlxtzXiKjFNjCLX5TkyUOv928frx78Fltu7e1Bvi6Fhz3MWv488RJ
	q7xKaOYm9JerLaJHg7IcY+AHNabPa5Du6Yj7IKvn9XUlaaepHkpfBmRSMhvm9xC1ehIE6En/Nik
	Q0TJvSvXsiXWPDMM2Z3hkRTNffUv/BPgv3c6WcsxFbjBVzy1A9QEMcpnlesyjYWVktuwjEz6qvE
	b4uvek9FMdALrQcHw8sXtLjWd2Qt7uGK0MKtilKUgushY2pnaUanmLRbs+GNRBgbch5gFrrIAy1
	Le9tCRiJmX9/qjPMKmgmlh
X-Google-Smtp-Source: AGHT+IEHY7zI2nM4g3gPAMySUNFQlHWGbNzHIjBZCB5gajpWZtOBTzgHVWp5MlgKB+cFABF2H9LLUw==
X-Received: by 2002:a17:902:d483:b0:267:9601:dca0 with SMTP id d9443c01a7336-292ffc8a00cmr86856515ad.27.1761225950264;
        Thu, 23 Oct 2025 06:25:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:35 -0700
Subject: [PATCH v22 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-6-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
This is to make sure that any existing apps using PROT_WRITE still work.

Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 26 ++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..0ad1d19832eb
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+						   unsigned long pkey __always_unused)
+{
+	unsigned long ret = 0;
+
+	/*
+	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
+	 * Only VM_WRITE means shadow stack.
+	 */
+	if (prot & PROT_WRITE)
+		ret = (VM_READ | VM_WRITE);
+	return ret;
+}
+
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 29e994a9afb6..4c4057a2550e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -182,6 +182,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 795b2e815ac9..22fc9b3268be 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -7,6 +7,7 @@
 
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
+#include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If PROT_WRITE is specified then extend that to PROT_READ
+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
+	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		prot |= PROT_READ;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d85efe74a4b6..62ab2c7de7c8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -376,7 +376,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,

-- 
2.43.0


