Return-Path: <linux-kselftest+bounces-31979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0E7AA3EF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF2B4E061C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4A23C502;
	Wed, 30 Apr 2025 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wgHNBhrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C523C4E6
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972207; cv=none; b=drurfe/a2YFLnjAr2lNeZwgkURhgKVJQLWRI9X7DNcFyoD60Cwvk7vYygIfQM1Y87E9ouJI61vjacVTi26m0vajiM1aJV8I07Vj9Q40KROBtGNpjuvvpzGX7cfjopGpErba3G04+6md1rWUYd7vFxhDMSuQmmtvTZAxPeOOLHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972207; c=relaxed/simple;
	bh=dgiqoDVtRvidZ666HdQoxDdMstst5+zplhPdm8ygATI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxbCYCymEHiSrh2sFrThcNHmze/R3Ply6S5yJ7iHjaEkhpzmaocqDch7nuwp7c1GkMAg1Xorb+rjGzspl0ior7vlCbUgRDQQBYCzDcyOmxAejxKIIGej63agNAuYY3lmiSvBmK6Oah1HfI0BUuCPRc1L66OsBu+empZMzOSzsbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wgHNBhrA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33e4fdb8so71131265ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972205; x=1746577005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bllvdjgPqMLGFPevmb9vKr9B2wGZQF3J7YB/p9RdhJg=;
        b=wgHNBhrANvNbTJhmH2go2D+kl+XeYC6xAgbmVaSP/y+S5Fqpx+aKvWeCR6pRrK1At/
         samuYWkxsh0HaATqkOFWGR38Qzwpaoprwl3vjPO0loLSa0Ns7SkfZFWaHWDLcNCIORrz
         xg6b7CE358aeFaZ828nHS+FH5qOmesXvQgPbJ0tAMhdrTRRyN0FX/9nUnrzdUJEYwMD9
         Df4z7Vtga1MdMQiBN4Lh3tg1ncbjpuWtqm+x941EvsLepX+xjc4noIGu+3RtsPkyRUDk
         hPFgrlxG6xyoSusqJj9yUKALJWFkBrZFa4brumS5I3fmVKqlTYyCh5XmZu6bZ67ARsTL
         eQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972205; x=1746577005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bllvdjgPqMLGFPevmb9vKr9B2wGZQF3J7YB/p9RdhJg=;
        b=QQt02In2SFPphOPud1SN2bu7cWCc2ypRfYxNgkMt2+nKeTxV6Hbr2X1vfTcGwoqmO2
         kx1Ps4jyYO/PJiv3gYbZ2PP6IB012UceG15lKN7tlmS5GuF71XX6Spn/lL/6tl1m4PIk
         WVt7r/uK5Q1PGkx837yipZygKB531TzYbns/gFxwIptHvge0OKwvWFF5ObHuz2K90NXq
         ancU6f4PrEh+HALqsi+RxJnCVO/BOpbcCST3Rl5wZEsjLSEI7rmyOb9cbays0lxq5HEg
         HcJbjcoack11Mzz4Dv2NQmaDFMAAH3XVDo4d1rey9gsA72/4yAWLNvhH4xm5J8nb1ch1
         EisQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4rQJ5qzw8wNgQYZE0KBDIY62+p6glnBMHbvrmuBbvV0oXr18duRdPSaZBoqMd2RRCYVbzoIXMld1RQJYUz1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9a6GhSkxP2DO4vsoJUXYeOUQpwHm0GL04dLJ40GNlCkCpsKAi
	DYx/FSJzeDBIOz6TT3S8i+J99tNjNZHWJCdPUllRtxkVwbGfJDVHEHJW5k3/YNY=
X-Gm-Gg: ASbGncvv+acZZyvxH2FaMO/7IRqj7xRkDmnO3BV6H04yqjP9ixcN/12IhpFdKLONmGy
	r+D7r3rLVz3IWLLYM/qpuNcYOKZOBcjLTgIyAffGVDjt3zs5ROf8lQqj8ayZ5zWWiSRvHNcEPWv
	UHFIOkurIrnCxWyNTu8GAdBGrUtNlZIbts+7l0FyJdgUaPesoWbUXmLAXWBfYtJtR3GUDk/rQwx
	8SL6Y0lJph6nESE5m+GHu9qMirK+wer0bGd2tdIgWNWldmDMXZd6BtGuYV3w1Bsg6Quo/0AKcvo
	cf+ui7SMHW1HXIxBDMIpZnYGsbK5Zzoncg1yyxbQedd9EesOK0c=
X-Google-Smtp-Source: AGHT+IGX6X1OgZofU2ZlJvPnk66vj+cVgPxJf6DI4qEF6hu7Dh1aTRpCC1f+gbT1r+ijJlpWLtiuCg==
X-Received: by 2002:a17:902:e886:b0:226:30f6:1639 with SMTP id d9443c01a7336-22df3587194mr16990645ad.51.1745972204843;
        Tue, 29 Apr 2025 17:16:44 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:44 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:23 -0700
Subject: [PATCH v14 06/27] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-6-5239410d012a@rivosinc.com>
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
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 25 +++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..392c9c2d2e78
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
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
index 428e48e5f57d..dba257cc4e2d 100644
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
index d77afe05578f..43a448bf254b 100644
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
index ab475ec6ca42..78b27164bf83 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -375,7 +375,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
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


