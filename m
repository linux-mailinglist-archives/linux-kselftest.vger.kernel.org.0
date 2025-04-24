Return-Path: <linux-kselftest+bounces-31551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FBA9ADFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640251B656FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049B27CCD3;
	Thu, 24 Apr 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AYhgthY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA927CB21
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499104; cv=none; b=PULpSTYmvvzIpFV7bPTpCX3HM8U/HABwZ6dj9wV0k34kgJiD8axOdLnVKps409ULOM1hp78Q6zIqjyhZ2qtmbsVuQ67sdOtIcPTuvEFJ0TA4jNoW8ADTKt8zwIY5o9gpg5pxj5WDW0xQksPaN/+/bYO41/zeSM3GbZheK8q5zIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499104; c=relaxed/simple;
	bh=YasCWAy3v55s89pMoa3ranL51jlpEy9fj4l4xNuEECQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VCA1z3M1ip5BCKfekV2KshcPBtYfJittvN+q32zTRilKXkyY53+p3PluaejcmnbGxIyFqNLpAUweni7Yc/wO+xkuJ8TalOqB5HJ00y03xt/r9Sxy1k/kEw8t9YsGKA+fwMXM5n7PoRV6ZjFkkSRPuUUiCTasOhW25/U7AG0SKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AYhgthY5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d72b749dcso1229955e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745499101; x=1746103901; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLukpWT5NNOxSvsbTFh0JQPpU9SQzhdcC+2BWmCpzxc=;
        b=AYhgthY5jad5RAK6lPwJjWxOTuABxtdCTU5adNG80frqMjhaPv++bPYW+Mo5dBlYty
         rHWLQ7xmIaj/k/bMYj4dq1x0FlrNLSRD7dp3X0abKHAM/ut1XHJCuQfZjXPHDa7D2/uu
         V0tBbW+2d/ScTBdSoNtId0mOGRP5x9P1dFS82PqPfOcjxLkylsWNUS+uzs452nsJpxYz
         8ZlTU0TJpF/DD1/rw5e61zruX41sRlxN+FXwWxCPdFmGgo1b0LHVfpIai7bLJK+g1NNo
         +R7xaWa9FyNJRli7ZnMHMKZzHLN4nWLY/9I7W81tGZk7uAZP09UWQiu7RcZ8z6zHlieo
         4kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499101; x=1746103901;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MLukpWT5NNOxSvsbTFh0JQPpU9SQzhdcC+2BWmCpzxc=;
        b=ozvN9PYJ+IrD0jcX5ctiWvre3l9Nxh46jwVfBsui1UrUE1ZV/wiehymHj01+qLc7Yh
         Mn60g+xmyh95rAuoTvl9gDSkt3lY/03gsr8a4rdXvZSL87Ux5cj2+9s1sxlMJ0XTmp/q
         XbI/GJjPVOqF+a2Is20VjlLq9cDKyO5XLVU1o4DioDpRldKGSOV7KX45M18PUgS9tY97
         iVt0f2M4CJtSTPVvOWjk62B+5St/sPpr4aIb4MYJd7ton8RDqML6iNNYPVhRHDLlUzQ1
         tfbOha2iY4ym5+C3EE+LVYOpVV4B7hjB035vEjr863zo4ddRKNR7Mc3FWWYCzzyduYLo
         6gYw==
X-Forwarded-Encrypted: i=1; AJvYcCUtXOtUx/VjTe7YTKq/iRdX2MJOF2Dd9gKCJv5v0onI3MxT/in3ZIjbTq03hDi5KVRzyFHgM3rq2BE0shEbc/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGzvg6auKap166IlFhm01NeT9uIh6Qjdc+iBkhoJgGQRC0x2T
	a5uTiH3I+lqa1xxvajP8DdmcAEJ2NuOvj6+rw4/OaNwkm6+eJNSenhu8Oumwi2o=
X-Gm-Gg: ASbGncubg/0InwB39LkVHfMoYWaag1jrHPqw8T7pHUclwzDL0OJtGZhOha+qg/RxxLg
	Y44eBUrvs7dJ8Uo64+mWC5CyC8lgtvdLT5OhGM/0aGQe7CAvdlHo/5EA0AhuH/FmUZOZG9wL+I6
	Pt8xZ6cMd94/xU1XY5eOf+UyMRX6evaNHqFkA0Ty815wCU22FE7WvT8jaqt6RTkgZy1fH+H2Mw1
	JL+ezKT/Zk9wTq1kQRMpBBCwxguhi5pLlMXibtpTD4K+0Whih6DU6pNe52bGI1f8IXvMmnvCIjo
	PEOk/747M0DoZW9w6YalLPyBmrcBNZOpzroB53g2F6EOr439
X-Google-Smtp-Source: AGHT+IEM7f4Ug05qJLQixhJCwrNUQhZVnfUcKsq0i+OggaoW7x6aAvFNMmOAKB/VOVrygSxaqnTFQw==
X-Received: by 2002:a05:600c:3d89:b0:439:8c80:6aee with SMTP id 5b1f17b1804b1-4409bd8d808mr9055605e9.4.1745499100564;
        Thu, 24 Apr 2025 05:51:40 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:b30c:ee4d:9e10:6a46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29b8efsm20710185e9.6.2025.04.24.05.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 14:51:39 +0200
Message-Id: <D9EVSGGM0XDE.25R31NY7EQTJX@ventanamicro.com>
Subject: Re: [PATCH v12 10/28] riscv/mm: Implement map_shadow_stack()
 syscall
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-10-e51202b53138@rivosinc.com>
 <D92VAWLM8AGD.3CF1VH6NYHCYV@ventanamicro.com>
 <aAmtKhlwKV7oz7RF@debug.ba.rivosinc.com>
In-Reply-To: <aAmtKhlwKV7oz7RF@debug.ba.rivosinc.com>

2025-04-23T20:16:58-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Apr 10, 2025 at 11:56:44AM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-03-14T14:39:29-07:00, Deepak Gupta <debug@rivosinc.com>:
>>> As discussed extensively in the changelog for the addition of this
>>> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>>> existing mmap() and madvise() syscalls do not map entirely well onto th=
e
>>> security requirements for shadow stack memory since they lead to window=
s
>>> where memory is allocated but not yet protected or stacks which are not
>>> properly and safely initialised. Instead a new syscall map_shadow_stack=
()
>>> has been defined which allocates and initialises a shadow stack page.
>>>
>>> This patch implements this syscall for riscv. riscv doesn't require tok=
en
>>> to be setup by kernel because user mode can do that by itself. However =
to
>>> provide compatibility and portability with other architectues, user mod=
e
>>> can specify token set flag.
>>
>>RISC-V shadow stack could use mmap() and madvise() perfectly well.
>
> Deviating from what other arches are doing will create more thrash. I exp=
ect
> there will be merging of common logic between x86, arm64 and riscv. Infac=
t I
> did post one such RFC patch set last year (didn't follow up on it). Using
> `mmap/madvise` defeats that purpose of creating common logic between arch=
es.
>
> There are pitfalls as mentioned with respect to mmap/madivse because of
> unique nature of shadow stack. And thus it was accepted to create a new s=
yscall
> to create such mappings. RISC-V will stick to that.

Ok.

>>> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>>> +static noinline unsigned long amo_user_shstk(unsigned long *addr, unsi=
gned long val)
>>> +{
>>> +	/*
>>> +	 * Never expect -1 on shadow stack. Expect return addresses and zero
>>> +	 */
>>> +	unsigned long swap =3D -1;
>>> +	__enable_user_access();
>>> +	asm goto(
>>> +		".option push\n"
>>> +		".option arch, +zicfiss\n"
>>
>>Shouldn't compiler accept ssamoswap.d opcode even without zicfiss arch?
>
> Its illegal instruction if shadow stack aren't available. Current toolcha=
in
> emits it only if zicfiss is specified in march.

Oof, I'll look why arch is being used like that, thanks.

(I thought arch is only for compiler generated code, so assembly
 mnemonics would always be defined if the compiler knows them.)

>>
>>> +		".option pop\n"
>>> +		: [swap] "=3Dr" (swap), [addr] "+A" (*addr)
>>> +		: [val] "r" (val)
>>> +		: "memory"
>>> +		: fault
>>> +		);
>>> +	__disable_user_access();
>>> +	return swap;
>>> +fault:
>>> +	__disable_user_access();
>>> +	return -1;
>>
>>I think we should return 0 and -EFAULT.
>>We can ignore the swapped value, or return it through a pointer.
>
> Consumer of this detects -1 and then return -EFAULT.
> We would eventually need this when creating shadow stack tokens for
> kernel shadow stack. I believe `-1` is safe return value which can't
> be construed as negative kernel address (-EFAULT will be)

I believe it as well, but I don't see a reason why we need to risk it
when we can return the stack value though a pointer and have simple
success/failure return value.

>>> +}
>>> +
>>> +static unsigned long allocate_shadow_stack(unsigned long addr, unsigne=
d long size,
>>> +					   unsigned long token_offset, bool set_tok)
>>> +{
>>> +	int flags =3D MAP_ANONYMOUS | MAP_PRIVATE;
>>
>>Is MAP_GROWSDOWN pointless?
>
> Not sure. Didn't see that in x86 or arm64 shadow stack creation.
> Let me know if its useful.

It is for automated growing of the stack.  I think that the default
stack is pointlessly large already, and if other arches don't do it, so
we can probably follow their design here as well...

>>> +	struct mm_struct *mm =3D current->mm;
>>> +	unsigned long populate, tok_loc =3D 0;
>>> +
>>> +	if (addr)
>>> +		flags |=3D MAP_FIXED_NOREPLACE;
>>> +
>>> +	mmap_write_lock(mm);
>>> +	addr =3D do_mmap(NULL, addr, size, PROT_READ, flags,
>>
>>PROT_READ implies VM_READ, so won't this select PAGE_COPY in the
>>protection_map instead of PAGE_SHADOWSTACK?
>
> PROT_READ is pointless here and redundant. I haven't checked if I remove =
it
> what happens.
>
> `VM_SHADOW_STACK` takes precedence (take a look at pte_mkwrite and pmd_mk=
write.
> Only way `VM_SHADOW_STACK` is possible in vmflags is via `map_shadow_stac=
k` or
> `fork/clone` on existing task with shadow stack enabled.
>
> In a nutshell user can't specify `VM_SHADOW_STACK` directly (indirectly v=
ia
> map_shadow_stack syscall or fork/clone) . But if set in vmaflags then it'=
ll
> take precedence.

Yeah, I don't like that ugly special case at all, so I was hoping we
could somehow avoid it. :)

