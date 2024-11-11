Return-Path: <linux-kselftest+bounces-21805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BD09C47A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 22:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CBEB31C1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818EB1C876F;
	Mon, 11 Nov 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ihwfTRGq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C861B5EB0
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358456; cv=none; b=YdfxwK0CYnvXw22s+oqsrZm9WCVwDr+swxo5qefNlbkQbDrHsrudLoce1HHzpvpBb3d4ptdnAFaJ/oZUX8sxwP7dAU40n2Ldv0XmP/QaEuabw86s/ZFm7rAO2n/gDQNdKfib0yUZJjPOcsh980evs8/kSnlLsij9AkWasb8e+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358456; c=relaxed/simple;
	bh=CO8+N7JlOlQWGya5jya6tiXfsgmMSXgiYb9She0/A9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJ7KlhVbOm8jW5CtCtEock+2bqkDgj0dEEXAO9SpxwJAzVVdhoORg65/P6+30mwJQ4iUyXrvgtsCVBwT45SDETBQxGNTEaCLI0ip1NBoU7OqJhP03KX01+Vt1NHXeANSaSYGsJgeeSF4eHpHEL+ERSP/KKSFfyAi4IwC9A3h4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ihwfTRGq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea8de14848so2973476a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 12:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358453; x=1731963253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPIeex8TzLPUDDSwLAkzt/bShtl/Fs0bUTE8bjGtA9Y=;
        b=ihwfTRGqzEtLG5NVBTcn/JujtUYnjC5imJigIhVP9t1OKfjhIJ7OWb5e8i+yA90kjS
         k7kGHQ7rWBsCLk5XZaIxDeVoXcA1NHdbGkJEMBHP/QlEgTEX/ObkMziDQskNRrB3YI10
         uRLeiAiVl7m32orbePzvYJxCcySHbk76eoytbbL1jJ2MJrbj7p1AbI9FJU0V4QA5jpVu
         Wkxn005QmULAfXbvOlAZItitdE/KIsL67v29SQLJLhVTB5YBixa9Cp69OEWAu/FbLgXT
         OfQOGL2aS3WCSRtGvkxcKd+clYLy9OcD2GS8WGi1G86wfWZua6pIw3NV5qDhipdH4xUH
         3VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358453; x=1731963253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPIeex8TzLPUDDSwLAkzt/bShtl/Fs0bUTE8bjGtA9Y=;
        b=OWqhHaB4UagoFJ5gaLow53HHdEW2zH1EXz7nFN6sMJqN2klkTaySmUsD7DohRVt3G2
         Dhn0aZERcS+4P4tpyL5qo0kQ7ZQbt8j2FPjAv69NjbDL3Sa60RbuaW69XLB7bZ30JwHB
         eJndGMvmslbT0OcofhXsHDfaz2lHUMmLj/Y6hn2slOq8rljMDXy0wBvJ0Q/GZUXh+vGE
         OIrgn2ciNABbbR3sF7iYwuYNyyzGFdZ3/Aq7WfGrMnu3ejHiDXSfln/VJi6BNi0zuyeR
         XF2qvpYYZBG8Iuc+tDAT3H3ipmJJqisHcFSwxVLJ2G+g5g21/WV1N+6iijz539hTW3tH
         XJPw==
X-Forwarded-Encrypted: i=1; AJvYcCWv44TD9rW22GbIDM4yh1O7eNo8rtUckj+5O/q2+Yy9nTOScNZjoZ9JWpu4BChrhVQGiD0drNHvocmxkKWw5p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyw045mJmhycSEViFiBNmU0P3owvGAZWWqxYOl39VXzdf29JcS
	uUK49Drm2yhBIjtqjNx9enALRfbRZQ7d2na2OcW8m3oIZlz5Z44m5hRUPUFnStc=
X-Google-Smtp-Source: AGHT+IHxrhthgasHXbf/UNeTJ/b0NrvHjmhrINV/NhvROg5Fgd3+BWnrPq93OPr1Rkxjz5Z0BvI9CQ==
X-Received: by 2002:a17:90b:2642:b0:2d3:ca3f:7f2a with SMTP id 98e67ed59e1d1-2e9b16c9138mr21909754a91.22.1731358453300;
        Mon, 11 Nov 2024 12:54:13 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:12 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:52 -0800
Subject: [PATCH v8 07/29] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-7-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
This is to make sure that any existing apps using PROT_WRITE still work.

Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..ef9fedf32546
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+	unsigned long pkey __always_unused)
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
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e79f15293492..4948a1f18ae8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -177,6 +177,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
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
index 0e8c20adcd98..964810aeb405 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -326,7 +326,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,

-- 
2.45.0


