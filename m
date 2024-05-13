Return-Path: <linux-kselftest+bounces-10146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272D8C45F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 19:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294AB2824D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F922EF4;
	Mon, 13 May 2024 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WM6XAWX9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733420DCB
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621167; cv=none; b=BeRvwbCPTxFCGzn4OgkPCJ/1yG37G6Jp1WzTqjKOh4miXvUo3W2dpDr3KUDpV/aXqk7wOP8XrqYPpk2nBnbLXRXpGQMMmDANeCfoFDrhDsaer7ZkphONsKWFrBg/ycq/P2HaSjIH/80V2QUQwYWSSSs9aBe0tFRXtO8JKz13L5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621167; c=relaxed/simple;
	bh=cW1LAz4fXICGwS+AudhaArylUOOaq0clgFk/bVAy87g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPZvzdl6olv5z3PFYTR0oXonny6yssX8S+fw17XDg9/MhWXYyFhzwTP8LR5Vc9RY9lrrfXnutRrBGZ+dRoaKSwjXujLtXIz1/ISfT+GHfJUROqAfMpdW007dCJvBQEB5UCl2VGGBA9pPcLcxkdyHYsRTM+3B+XDqERs8A2RT7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WM6XAWX9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso3892519b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715621164; x=1716225964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CphAxnYmU7rHUQNVs8T3cwnTqgP0hWjWzVy/6SXnII=;
        b=WM6XAWX9Heh3keW9gXOWjZsUUV1gOPrDY4Lhx57R5ffGqM/8r9sMup3/X0S3j/4iTG
         FP2OB1KeDxpG0EEH//gtDHeF39fkiEwsKo+xTI3ly76WagO1JGbYQjZsdxc3jUpV0y54
         UfU23TAL2IZsxC7XTux4VDznWWRzV628ZQsYk+2sgqbuPuhj9oB2ppnktRwWQAevWVSm
         NRDW5Htptd8Xln5Xmqpn6qx+T+QZg+n0N+y3RKYuNPpn95CBNOTT7UZYlz9/54BXGS10
         qBFCpZWmzXsfVNOYvRenaGunLRlW4ruhs0q6MZLmM4JXcDs8fbDbqPwmhVAaf4n8AQm2
         01GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621164; x=1716225964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CphAxnYmU7rHUQNVs8T3cwnTqgP0hWjWzVy/6SXnII=;
        b=VxtP3LncsRbraJnAI8Mp25X5IAldJ0VF5KYFPy2sJgaZZa/RVxjf4AxT/40xPRvfdA
         N6dUWFCjMfcpXgykT77y+7iwFgoLG5ujG62pbt1XT73W8gwc/gzgWoKidNlYqk/2XYme
         LhTNKpF59Ff/O7RrIpDMo65SN5uG1MV/YVoDGKUbfVzgvooFN8iTLPrRamwtwVcUYwt2
         wrkmSg/AIRha1pNPz86OD0wiBVnNa5dSryJ4jo0NtIBNan3OBCS64NoYt8uBNFfV8y3+
         e8JMtZzu6DPbE5WNX1LDYvAvpTX5WP5AdNBAyQBvZzrvqB5Ng9eicTH13ozivGvA8eSt
         1+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWm4y8jKo2GdsDV1plpi4N55fhcS7XAcOATWBdii0I4YgSKycaI9FhTl3rdFSlySDM7vrhO0MurLeAPiEw7koyjDEMpY7FxVGkiAQYCcx9m
X-Gm-Message-State: AOJu0YyO8GZqopbu7oCCDJootFfFrrjIrNZyQT1plKtuX/5U5gPHHrO5
	Zwh/6nD2bxVEGpApSRZljDxLf4gbv7OHaXI9TRGAjs1oY8g9tDaZjFPXeERheLw=
X-Google-Smtp-Source: AGHT+IHWYfZIMujic/Efx734TOOxaipvPsENyzxTx20y3wHlQ1JvIbN+S3KCHp0gNXx2ROBa3RZW9g==
X-Received: by 2002:a05:6a20:7343:b0:1af:dbe7:c976 with SMTP id adf61e73a8af0-1afde115bc1mr11659334637.36.1715621163769;
        Mon, 13 May 2024 10:26:03 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411530b0esm8050191a12.88.2024.05.13.10.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:26:03 -0700 (PDT)
Date: Mon, 13 May 2024 10:25:59 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, bjorn@rivosinc.com, alexghiti@rivosinc.com,
	samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 14/29] riscv/mm: Implement map_shadow_stack() syscall
Message-ID: <ZkJNJwEjoeHK6GDY@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-15-debug@rivosinc.com>
 <d0e2d1a5-110a-40be-8662-7c78afe22446@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d0e2d1a5-110a-40be-8662-7c78afe22446@ghiti.fr>

On Sun, May 12, 2024 at 06:50:18PM +0200, Alexandre Ghiti wrote:
>
>On 04/04/2024 01:35, Deepak Gupta wrote:
>>As discussed extensively in the changelog for the addition of this
>>syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>>existing mmap() and madvise() syscalls do not map entirely well onto the
>>security requirements for shadow stack memory since they lead to windows
>>where memory is allocated but not yet protected or stacks which are not
>>properly and safely initialised. Instead a new syscall map_shadow_stack()
>>has been defined which allocates and initialises a shadow stack page.
>>
>>This patch implements this syscall for riscv. riscv doesn't require token
>>to be setup by kernel because user mode can do that by itself. However to
>>provide compatibility and portability with other architectues, user mode
>>can specify token set flag.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/kernel/Makefile      |   2 +
>>  arch/riscv/kernel/usercfi.c     | 149 ++++++++++++++++++++++++++++++++
>>  include/uapi/asm-generic/mman.h |   1 +
>>  3 files changed, 152 insertions(+)
>>  create mode 100644 arch/riscv/kernel/usercfi.c
>>
>>diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>index 604d6bf7e476..3bec82f4e94c 100644
>>--- a/arch/riscv/kernel/Makefile
>>+++ b/arch/riscv/kernel/Makefile
>>@@ -107,3 +107,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
>>  obj-$(CONFIG_64BIT)		+= pi/
>>  obj-$(CONFIG_ACPI)		+= acpi.o
>>+
>>+obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
>>diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>>new file mode 100644
>>index 000000000000..c4ed0d4e33d6
>>--- /dev/null
>>+++ b/arch/riscv/kernel/usercfi.c
>>@@ -0,0 +1,149 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+/*
>>+ * Copyright (C) 2024 Rivos, Inc.
>>+ * Deepak Gupta <debug@rivosinc.com>
>>+ */
>>+
>>+#include <linux/sched.h>
>>+#include <linux/bitops.h>
>>+#include <linux/types.h>
>>+#include <linux/mm.h>
>>+#include <linux/mman.h>
>>+#include <linux/uaccess.h>
>>+#include <linux/sizes.h>
>>+#include <linux/user.h>
>>+#include <linux/syscalls.h>
>>+#include <linux/prctl.h>
>>+#include <asm/csr.h>
>>+#include <asm/usercfi.h>
>>+
>>+#define SHSTK_ENTRY_SIZE sizeof(void *)
>>+
>>+/*
>>+ * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
>>+ * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
>>+ * shadow stack. To keep it simple, we plan to use `ssamoswap` to perform writes on shadow
>>+ * stack.
>>+ */
>>+static noinline unsigned long amo_user_shstk(unsigned long *addr, unsigned long val)
>>+{
>>+	/*
>>+	 * Since shadow stack is supported only in 64bit configuration,
>>+	 * ssamoswap.d is used below.
>
>>*        * CONFIG_RISCV_USER_CFI is dependent
>>+	 * on 64BIT and compile of this file is dependent on CONFIG_RISCV_USER_CFI
>>+	 * In case ssamoswap faults, return -1.
>
>
>To me, this part of the comment is not needed.

Ok, will remove it.

>
>
>>+	 * Never expect -1 on shadow stack. Expect return addresses and zero
>
>
>In that case, should we BUG() instead?

Caller (create_rstor_token) of `amo_user_shstk` is returning -EFAULT. It'll translate to 
signal (SIGSEGV) delivery to user app or terminate.

>
>
>>+	 */
>>+	unsigned long swap = -1;
>>+
>>+	__enable_user_access();
>>+	asm goto(
>>+				".option push\n"
>>+				".option arch, +zicfiss\n"
>>+				"1: ssamoswap.d %[swap], %[val], %[addr]\n"
>>+				_ASM_EXTABLE(1b, %l[fault])
>>+				RISCV_ACQUIRE_BARRIER
>>+				".option pop\n"
>>+				: [swap] "=r" (swap), [addr] "+A" (*addr)
>>+				: [val] "r" (val)
>>+				: "memory"
>>+				: fault
>>+			);
>>+	__disable_user_access();
>>+	return swap;
>>+fault:
>>+	__disable_user_access();
>>+	return -1;
>>+}
>>+
>>+/*
>>+ * Create a restore token on the shadow stack.  A token is always XLEN wide
>>+ * and aligned to XLEN.
>>+ */
>>+static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>>+{
>>+	unsigned long addr;
>>+
>>+	/* Token must be aligned */
>>+	if (!IS_ALIGNED(ssp, SHSTK_ENTRY_SIZE))
>>+		return -EINVAL;
>>+
>>+	/* On RISC-V we're constructing token to be function of address itself */
>>+	addr = ssp - SHSTK_ENTRY_SIZE;
>>+
>>+	if (amo_user_shstk((unsigned long __user *)addr, (unsigned long) ssp) == -1)
>>+		return -EFAULT;
>>+
>>+	if (token_addr)
>>+		*token_addr = addr;
>>+
>>+	return 0;
>>+}
>>+
>>+static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
>>+				unsigned long token_offset,
>>+				bool set_tok)
>>+{
>>+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>>+	struct mm_struct *mm = current->mm;
>>+	unsigned long populate, tok_loc = 0;
>>+
>>+	if (addr)
>>+		flags |= MAP_FIXED_NOREPLACE;
>>+
>>+	mmap_write_lock(mm);
>>+	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
>
>
>Hmmm why do you map the shadow stack as PROT_READ here?

I believe its redundant here. I followed what x86 did for their shadow stack creation.
GCS (arm shadow stack) patches also do same thing. Collectively, we think at some time in
future many of these flows will become generic (arch agnostic).

>
>
>>+				VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
>>+	mmap_write_unlock(mm);
>>+
>>+	if (!set_tok || IS_ERR_VALUE(addr))
>>+		goto out;
>>+
>>+	if (create_rstor_token(addr + token_offset, &tok_loc)) {
>>+		vm_munmap(addr, size);
>>+		return -EINVAL;
>>+	}
>>+
>>+	addr = tok_loc;
>>+
>>+out:
>>+	return addr;
>>+}
>>+
>>+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>>+{
>>+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
>>+	unsigned long aligned_size = 0;
>>+
>>+	if (!cpu_supports_shadow_stack())
>>+		return -EOPNOTSUPP;
>>+
>>+	/* Anything other than set token should result in invalid param */
>>+	if (flags & ~SHADOW_STACK_SET_TOKEN)
>>+		return -EINVAL;
>>+
>>+	/*
>>+	 * Unlike other architectures, on RISC-V, SSP pointer is held in CSR_SSP and is available
>>+	 * CSR in all modes. CSR accesses are performed using 12bit index programmed in instruction
>>+	 * itself. This provides static property on register programming and writes to CSR can't
>>+	 * be unintentional from programmer's perspective. As long as programmer has guarded areas
>>+	 * which perform writes to CSR_SSP properly, shadow stack pivoting is not possible. Since
>>+	 * CSR_SSP is writeable by user mode, it itself can setup a shadow stack token subsequent
>>+	 * to allocation. Although in order to provide portablity with other architecture (because
>>+	 * `map_shadow_stack` is arch agnostic syscall), RISC-V will follow expectation of a token
>>+	 * flag in flags and if provided in flags, setup a token at the base.
>>+	 */
>>+
>>+	/* If there isn't space for a token */
>>+	if (set_tok && size < SHSTK_ENTRY_SIZE)
>>+		return -ENOSPC;
>>+
>>+	if (addr && (addr % PAGE_SIZE))
>
>
>I would use:
>
>if (addr && (addr & (PAGE_SIZE - 1))

noted.

>
>
>>+		return -EINVAL;
>>+
>>+	aligned_size = PAGE_ALIGN(size);
>>+	if (aligned_size < size)
>>+		return -EOVERFLOW;
>>+
>>+	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
>>+}
>>diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
>>index 57e8195d0b53..0c0ac6214de6 100644
>>--- a/include/uapi/asm-generic/mman.h
>>+++ b/include/uapi/asm-generic/mman.h
>>@@ -19,4 +19,5 @@
>>  #define MCL_FUTURE	2		/* lock all future mappings */
>>  #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>>+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
>>  #endif /* __ASM_GENERIC_MMAN_H */
>
>
>Don't we need to advertise this new syscall to the man pages?

`map_shadow_stack` is already mainline as part of x86. I am assuming there is man page for this.
I'll check to be sure and confirm here.

>

