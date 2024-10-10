Return-Path: <linux-kselftest+bounces-19411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C18997972
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 02:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F81B20BF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 00:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0BA33E1;
	Thu, 10 Oct 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vuvB9ybR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADE2CA7
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518535; cv=none; b=ZTpatuIddd7Ho80ltARNq7n+O//NHCEl+VFhKHCpcmlyb7EXSCnnWCngq6Gx5Oa5m9KrnZFKfMxP14sQat3XV4tFYcpqtWzeRlMdgpW7YRHPZFLEyD10SEGLRxa5NsXn+Nf8tEEKQYDW+Deol5pQQuLkfJzkoRBdmZD3V5GMRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518535; c=relaxed/simple;
	bh=ewGqRf1g6Sl7BxQGp08YR8W3r9FXfAEWp++dX7lyTMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q35TnVnX6hq5ywD+IryjeUq+TZheE/Dgr0Ro1YjuVv4bS2rIhd+tlS4CaoNMbmKvcWm/+Ce7zUm4E1SaK6oywwEPsaTBlyLu1fVHrCt73Ao1qNQGt7p+99IahaLUixY4+hN6UcpaRvlcd1VRZGkaEQ4hHzQE9DyYtqWbrLbpTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vuvB9ybR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e29555a1b2so275621a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2024 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728518533; x=1729123333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z81onnv7XmpsFKJJEJouk5fW7lC/eJB47z6sozvRnOU=;
        b=vuvB9ybRThfOultl9MKUk74XHtLMYLSGysi4/XdZtFHACescnpiUWJodqvF1gCEshr
         epG7YLP5ADOJukQ4lj/g5GvaKJw6A4GO3UhutTbN48Fg/Gng499b2OPL94jrgKPt45pE
         fNomdr4+iSptDyfc93Erp34tfQ6lCa9LwhMm0W1Cmk8pyFYnfL7c8XFR4FH2izHoOJba
         Lr2J3djRLveFmfBpzjAafxekAsQxClmYeMnFOl2a7flCsXq3aoRzdkxJfz0guWRPZ3uL
         IqxcSKFrgY8WV6JDQ6dTFiXAJBHWxMZg8FugPOX3z0XN7ae1eurvLR68U4dkgfGlTWWV
         4nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518533; x=1729123333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z81onnv7XmpsFKJJEJouk5fW7lC/eJB47z6sozvRnOU=;
        b=bJa7552kgohrXj9Nt+5NO+XO0Mc61kS5dqncOzJ20/LPvIRVgRXezM3dxr4OVOfNiV
         +dn1m/8EiYuSd++ei1TYDxGGcWL9LDm/suz0dVlPh9pJPzfeR2/dyi05IDztfFw+tQG3
         uF8lPN/g8p8w3u/gI1Fo4Z1F6euSIG6VmaYDY/8i/hJiNPlmn/rOAOLagQTnIpPRueei
         3tCB1ut6s3Lp7jl27bQW+GKsNd+rpj3g+ZfsHRY6IzMUKgtcPKnRYCFN1Q00aqFMXpxB
         znOls13d7FOFygYkdPU4D4JuWCHBSfvOoVLkUriYAoyL8M6ryuSNoySaqRwDh2MG6g3D
         8Ghw==
X-Forwarded-Encrypted: i=1; AJvYcCXjC4CWr1moinF0ITcAglQWrNowyczTsZO+YRLRJwr0lcRK50vWy+LnXFeDVAQdjVy5IKJ+iLvIXOrOTxSU0d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVA2TYqzl99kSRyyX6enI9uLysSX9IoxxlLEUCyGD+E3CBlI4
	wh14pnrZrR3S06rdfqAH0Am77lurRMa1rgVQPa+ZLuy+SmLhdB4RUD73ttKVb+o=
X-Google-Smtp-Source: AGHT+IFZmP54aZT+PGhT0sMeks15kfczHLhKUFL1tfOl/r4KWZKd9Mj0XsQpQ7yVRv3lx6isgmniRg==
X-Received: by 2002:a17:90b:4a42:b0:2e2:bad2:69ba with SMTP id 98e67ed59e1d1-2e2bad26afcmr3003723a91.14.1728518533102;
        Wed, 09 Oct 2024 17:02:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f0b03bsm22252a91.34.2024.10.09.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 17:02:12 -0700 (PDT)
Date: Wed, 9 Oct 2024 17:02:08 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v6 11/33] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Message-ID: <ZwcZgKuOK5MpldDX@debug.ba.rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-11-60d9fe073f37@rivosinc.com>
 <22972e7b-0844-4ebc-8d82-a0838b83c3a0@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <22972e7b-0844-4ebc-8d82-a0838b83c3a0@lucifer.local>

On Wed, Oct 09, 2024 at 02:36:12PM +0100, Lorenzo Stoakes wrote:
>On Tue, Oct 08, 2024 at 03:36:53PM -0700, Deepak Gupta wrote:
>> `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
>> VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
>> updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
>> This is to make sure that any existing apps using PROT_WRITE still work.
>>
>> Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
>> Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
>> encodings for shadow stack. Above changes ensure that existing apps
>> continue to work because underneath kernel will be picking
>> `protection_map[VM_WRITE|VM_READ]` PTE encodings.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
>>  arch/riscv/include/asm/pgtable.h |  1 +
>>  arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
>>  arch/riscv/mm/init.c             |  2 +-
>>  mm/mmap.c                        |  1 +
>>  5 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
>> new file mode 100644
>> index 000000000000..ef9fedf32546
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/mman.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_MMAN_H__
>> +#define __ASM_MMAN_H__
>> +
>> +#include <linux/compiler.h>
>> +#include <linux/types.h>
>> +#include <uapi/asm/mman.h>
>> +
>> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>> +	unsigned long pkey __always_unused)
>> +{
>> +	unsigned long ret = 0;
>> +
>> +	/*
>> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
>> +	 * Only VM_WRITE means shadow stack.
>> +	 */
>> +	if (prot & PROT_WRITE)
>> +		ret = (VM_READ | VM_WRITE);
>> +	return ret;
>> +}
>> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>> +
>> +#endif /* ! __ASM_MMAN_H__ */
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index e79f15293492..4948a1f18ae8 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -177,6 +177,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
>>  #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>>  #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
>>  					 _PAGE_EXEC | _PAGE_WRITE)
>> +#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
>>
>>  #define PAGE_COPY		PAGE_READ
>>  #define PAGE_COPY_EXEC		PAGE_READ_EXEC
>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>> index d77afe05578f..43a448bf254b 100644
>> --- a/arch/riscv/kernel/sys_riscv.c
>> +++ b/arch/riscv/kernel/sys_riscv.c
>> @@ -7,6 +7,7 @@
>>
>>  #include <linux/syscalls.h>
>>  #include <asm/cacheflush.h>
>> +#include <asm-generic/mman-common.h>
>>
>>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>>  			   unsigned long prot, unsigned long flags,
>> @@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>>  		return -EINVAL;
>>
>> +	/*
>> +	 * If PROT_WRITE is specified then extend that to PROT_READ
>> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
>> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
>> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
>> +	 */
>> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
>> +		prot |= PROT_READ;
>> +
>>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>>  }
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 0e8c20adcd98..964810aeb405 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -326,7 +326,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>>  static const pgprot_t protection_map[16] = {
>>  	[VM_NONE]					= PAGE_NONE,
>>  	[VM_READ]					= PAGE_READ,
>> -	[VM_WRITE]					= PAGE_COPY,
>> +	[VM_WRITE]					= PAGE_SHADOWSTACK,
>>  	[VM_WRITE | VM_READ]				= PAGE_COPY,
>>  	[VM_EXEC]					= PAGE_EXEC,
>>  	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index dd4b35a25aeb..b56f1e8cbfc6 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -47,6 +47,7 @@
>>  #include <linux/oom.h>
>>  #include <linux/sched/mm.h>
>>  #include <linux/ksm.h>
>> +#include <linux/processor.h>
>
>This seems benign enough, just wonder why you need it?

I think leftover from previous versions. Will remove it.
Don't think its needed here anymore.

>
>>
>>  #include <linux/uaccess.h>
>>  #include <asm/cacheflush.h>
>>
>> --
>> 2.45.0
>>

