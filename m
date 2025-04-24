Return-Path: <linux-kselftest+bounces-31481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F57A99F78
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 05:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED2D7A6AC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 03:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FE1A7AF7;
	Thu, 24 Apr 2025 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kL521BJ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360F19AD48
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464625; cv=none; b=RY7RtSz+Cw3TMWbq0ywHB3yvqg6rGEU1BzId0R/1IhdgTOJfCe8sjRAPBbik/sHqZAK6dH3HhBahTwvahhw0LEwYwZH+tutoxr1ZnlD/QQW+SqXZ9xWV+L26ttJ428BqgowjNuFeJkm1pcdAU7e2+BKNKikIatjjfxFZZXgTWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464625; c=relaxed/simple;
	bh=UVCFOg19+s13dmCTwGHiyBdefPnTw16zPmpkfRlg8hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlBVQiHaNDPlZiLiASKtmk3hRp34ETtgCNOQo8NuHmYBuadV03O4TTfsjwU2JSw+8v0zXxRmW06LAwOEzn3WwZ+YrQVQdBlwD/eyM9zneKUiuI+jhDDYgXwmpYmrM9GZaHRC/GZjHh6jXeeVgh+XeBcYz9jTWIEsVsNGofesDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kL521BJ1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736a7e126c7so411965b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745464622; x=1746069422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XUAwJhWsStgPPiYel2m5dmuZ8PujmZM+CaGE2sUsiqI=;
        b=kL521BJ1GCIh/6lApmzBn9i2whQlemVa9/Exj/8nk2M90qz/RlpVMtbsyxMmxh9SdM
         6a6KF+tHiHMn/sJYVfJbI0F8h+a1kK0il/Zyv2/aBl/ffi8WFvVJlAojLzyCNrYSCITG
         zigNEJySmaSRFJ41TwLE+wYQSn+VAadnGYF3z8tp/Nk49W5XF4fzRjucmpipPvzQBeKQ
         WJcIRQAuMeLDZKSqthk3gWD2wNrA2+r4VOfvLrGI/WSDwFY4jb5gh+A5KatKo7LKlep1
         uqK/9UhmbOi10zO5fB+kLWqRq5bSO6d6G/kSSbaAwtKOdUgICn6KdthBXCkKEcT86d2i
         XR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745464622; x=1746069422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUAwJhWsStgPPiYel2m5dmuZ8PujmZM+CaGE2sUsiqI=;
        b=FgcKKCDjIY2Mgm6U0RY4lNuRGnob5zr20qWKpvuJEPTyHfjfkkiawy5Ngm0qWo2eRw
         GAH4CkqQKnZI/o65LbT1JF9iONwsZ3il2Ih/BokOr3n5llXEcHU8xgm/yTpwc+ml6kcY
         BR5UelIErw1/Bws3gm5VR3/eA3T7DpZtMuOtP9d2ZYGqkeOUZUJMiTfWbiCkPT4hWm1H
         Alxlv1EAtVGtbaeZrEXcyoFQMj5GWkiHH3cn4sY9ypGtIFGHTipTevVluS6RB2l2Arbu
         Sl8UXSSnWtjcqiYof5WADyJYrdzPZk6cboU9Hqi/+YaeUPSJt2JBZsBDBeR/9IeT1Wlu
         FGwg==
X-Forwarded-Encrypted: i=1; AJvYcCUO14Vp2W1znvaRgFNGZb8BbtJTY6NJOI+O27S091N82IHt3W6LtiQAdElin3A6HXjRHWbI0PhuJee7gfTMgX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwhetCaPqSP+cV5K9v8KON/j2/vSRRML5qvKxTcqNu7LEbZv0z
	8COK0Vwsp6NeI41CisG0HN1D3X1DegSXFt2iEpvyZm4/cUSaUROoDoffLD0FKKE=
X-Gm-Gg: ASbGncuZ0XieSFWJCK8pCywzSUNRdVgNuotZVRuIj1t6ZAZbERQwEiA8Rl0pwe67Omy
	Cp6YUnHrxAibN106AjHwMStd6T0qMUgVEyqVj9tZg2o+VJCSMihcRS7ZuHAqdsjRX3gNtZ5t3n6
	aPblceknCBVr1SrTGAyINxfbEiJxmY4xftZsWC38bvrxGiqxTSqUQFo06BrmUDaujVRfWxfhD7r
	elorShvJnmjNtd/miuKByig1zq8ar1AQywELwZar6Dty5gZbf8fRBiq6JZGyZLXjcuXmQ6nonZs
	mbNdzynjdE9X+N/14tHxzVRIUFq8sV5T1GkodIA+GjlyGzu07cA=
X-Google-Smtp-Source: AGHT+IHFdvA0DlIcVCkE1m7fhwPnPK/+qUF0hzp1UIxp5PRqy2sOJJ28/GW1knmKmyzytkf5QLtSrA==
X-Received: by 2002:a05:6a20:9f4f:b0:1f5:9208:3ad6 with SMTP id adf61e73a8af0-20444f9f316mr1339520637.41.1745464622463;
        Wed, 23 Apr 2025 20:17:02 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941fd9sm354190b3a.53.2025.04.23.20.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 20:17:02 -0700 (PDT)
Date: Wed, 23 Apr 2025 20:16:58 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v12 10/28] riscv/mm: Implement map_shadow_stack() syscall
Message-ID: <aAmtKhlwKV7oz7RF@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-10-e51202b53138@rivosinc.com>
 <D92VAWLM8AGD.3CF1VH6NYHCYV@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D92VAWLM8AGD.3CF1VH6NYHCYV@ventanamicro.com>

On Thu, Apr 10, 2025 at 11:56:44AM +0200, Radim Krčmář wrote:
>2025-03-14T14:39:29-07:00, Deepak Gupta <debug@rivosinc.com>:
>> As discussed extensively in the changelog for the addition of this
>> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>> existing mmap() and madvise() syscalls do not map entirely well onto the
>> security requirements for shadow stack memory since they lead to windows
>> where memory is allocated but not yet protected or stacks which are not
>> properly and safely initialised. Instead a new syscall map_shadow_stack()
>> has been defined which allocates and initialises a shadow stack page.
>>
>> This patch implements this syscall for riscv. riscv doesn't require token
>> to be setup by kernel because user mode can do that by itself. However to
>> provide compatibility and portability with other architectues, user mode
>> can specify token set flag.
>
>RISC-V shadow stack could use mmap() and madvise() perfectly well.

Deviating from what other arches are doing will create more thrash. I expect
there will be merging of common logic between x86, arm64 and riscv. Infact I
did post one such RFC patch set last year (didn't follow up on it). Using
`mmap/madvise` defeats that purpose of creating common logic between arches.

There are pitfalls as mentioned with respect to mmap/madivse because of
unique nature of shadow stack. And thus it was accepted to create a new syscall
to create such mappings. RISC-V will stick to that.

>Userspace can always initialize the shadow stack properly and the shadow
>stack memory is never protected from other malicious threads.

Shadow stack memory is protected from inadvertent stores (be it same thread
or a different thread in same address space). Malicious code which can do
`sspush/ssamoswap` already assumes that code integrity policies are broken.

>
>I think that the compatibility argument is reasonable.  We'd need to
>modify the other syscalls to allow a write-only mapping anyway.


>
>> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>> +static noinline unsigned long amo_user_shstk(unsigned long *addr, unsigned long val)
>> +{
>> +	/*
>> +	 * Never expect -1 on shadow stack. Expect return addresses and zero
>> +	 */
>> +	unsigned long swap = -1;
>> +	__enable_user_access();
>> +	asm goto(
>> +		".option push\n"
>> +		".option arch, +zicfiss\n"
>
>Shouldn't compiler accept ssamoswap.d opcode even without zicfiss arch?

Its illegal instruction if shadow stack aren't available. Current toolchain
emits it only if zicfiss is specified in march.

>
>> +		"1: ssamoswap.d %[swap], %[val], %[addr]\n"
>> +		_ASM_EXTABLE(1b, %l[fault])
>> +		RISCV_ACQUIRE_BARRIER
>
>Why is the barrier here?

IIRC, I was following `arch_cmpxchg_acquire`.
But I think that's not needed. 
What we are doing is `arch_xchg_relaxed` and barrier is not needed.

I did consider adding it to arch/riscv/include/asm/cmpxchg.h but there is
limited usage of this primitive and thus kept it limited to usercfi.c

Anyways I'll re-spin removing the barrier.

>
>> +		".option pop\n"
>> +		: [swap] "=r" (swap), [addr] "+A" (*addr)
>> +		: [val] "r" (val)
>> +		: "memory"
>> +		: fault
>> +		);
>> +	__disable_user_access();
>> +	return swap;
>> +fault:
>> +	__disable_user_access();
>> +	return -1;
>
>I think we should return 0 and -EFAULT.
>We can ignore the swapped value, or return it through a pointer.

Consumer of this detects -1 and then return -EFAULT.
We would eventually need this when creating shadow stack tokens for
kernel shadow stack. I believe `-1` is safe return value which can't
be construed as negative kernel address (-EFAULT will be)


>
>> +}
>> +
>> +static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
>> +					   unsigned long token_offset, bool set_tok)
>> +{
>> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>
>Is MAP_GROWSDOWN pointless?

Not sure. Didn't see that in x86 or arm64 shadow stack creation.
Let me know if its useful.

>
>> +	struct mm_struct *mm = current->mm;
>> +	unsigned long populate, tok_loc = 0;
>> +
>> +	if (addr)
>> +		flags |= MAP_FIXED_NOREPLACE;
>> +
>> +	mmap_write_lock(mm);
>> +	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
>
>PROT_READ implies VM_READ, so won't this select PAGE_COPY in the
>protection_map instead of PAGE_SHADOWSTACK?

PROT_READ is pointless here and redundant. I haven't checked if I remove it
what happens.

`VM_SHADOW_STACK` takes precedence (take a look at pte_mkwrite and pmd_mkwrite.
Only way `VM_SHADOW_STACK` is possible in vmflags is via `map_shadow_stack` or
`fork/clone` on existing task with shadow stack enabled.

In a nutshell user can't specify `VM_SHADOW_STACK` directly (indirectly via
map_shadow_stack syscall or fork/clone) . But if set in vmaflags then it'll
take precedence.

>
>Wouldn't avoiding VM_READ also allow us to get rid of the ugly hack in
>pte_mkwrite?  (VM_WRITE would naturally select the right XWR flags.)

>
>> +		       VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
>> +	mmap_write_unlock(mm);
>> +
>> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>> +{
>> [...]
>> +	if (addr && (addr & (PAGE_SIZE - 1)))
>
>if (!PAGE_ALIGNED(addr))

