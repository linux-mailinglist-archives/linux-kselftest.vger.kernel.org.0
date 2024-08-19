Return-Path: <linux-kselftest+bounces-15665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E2595715D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7781128321A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0C17C992;
	Mon, 19 Aug 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hR/ilOzC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB517920A
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086868; cv=none; b=poCsLMuwmG7qZxNBLq0oFomo/e5S+9vgyliGuATiS0owSv7jo1n4S6GcMnyZOz3Dk1t8ncXRLaU9C40IXMQOBpyxgy6QmfcQg4rTVnmegh3NtVbsEPalUxY8O9nt4Qrt1Pe1b1u0brRDyTkXhiZFpvJe4W8cI45MLIQotEL1yFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086868; c=relaxed/simple;
	bh=ZtX2zam0FT/hFX74bfMDbN5fKKbjL8LUsshVOfW6MUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ7e/PLigOBVKrfalJk2PpAOyg9SrquhAIpgmNZNCEPpLUqe+Z/1mJwU66WBXu40jr8d3FT0g3LHDufRVOWqf6G57yKjvlYV/I1CQMwAshy0YoBIFtl4qVl4Gf9tZctl6Kw8KOFhK8Flpcxxh1VUHibYHFNs4gcBhxGC81mj1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hR/ilOzC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202146e93f6so29451545ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724086865; x=1724691665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kCQe9G/ESsT5mGMR2/0Q1jS/fZ3F9lMSZDT/xQTaFw=;
        b=hR/ilOzCBUfBR13kj4mjTSRfnb6k8SHsA/Sh18pGmU117LUbDakCyWgFKV6VVVizYP
         oq5cpNct7fYMNgAIzpoJ0T3GaYpeqc8NnPr6TvSXI/sYdZ1UL1TxA+hXAshgtRe4HC6A
         HwYTLJmD9s5xrttCLxKX/J8MAXMFjTX0zi/ouTxoOAsB9XTQyExUa27JlTQNUMlRsNCt
         ezO8c0iSEYJbVsAiKPtF9kzHC/qXhchxUkVSSojAK5KeaOi4T2sMCYxUy9FFi1Nq9Y2U
         xaN10UKBUBYbEZlVtz6TAElINektYMtDF6caB39BowQG9WPaWq9a700ESnjnR9wShO0Z
         Cylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086865; x=1724691665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kCQe9G/ESsT5mGMR2/0Q1jS/fZ3F9lMSZDT/xQTaFw=;
        b=Y86hU3nM4iFNrwde9caFoAy3ATC6uLdXFpeU04RLBDOUO7YgNDw7scHskxMTtemrrj
         5tn+hdDzV+zJssQhmczL9ZATrGZe60w1648/NnfBnr2zgO1fH6WJh6GoBIpf3x4xy+9T
         WwDkG18AzGm0kNMNcl05CkOk70Ce6ZIErJdvyfe7UxTHwHGu5oksPNEiDsGniUbu1FUE
         L8epHPXfE3Zvc1hgy5Qbx+ySUp7CVPUsgk8F1E3/PMzyUlVLknEBvTdQDvKzSBKsJaWN
         Xug/RXWP6maTddwUon9rrhUqYlviFokzlUPJJIiHixj3+vCrx4YmNAhfaMM2eqfk8zoM
         9a2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhAFrqEWIVp+uECYNQIEA8JWqQ2tkQgsR/s6BOzw0b4VOAEOv9e0F6AWtGZUmMzR7OF37m83jXj/mfm+xdCaJDt9xxJJ+ph+fsD8lD78FZ
X-Gm-Message-State: AOJu0YwOlT630MNza5mMqw0Kd2I9hLqwm4Zh0lbm1FiEeyozAs3YVMfg
	DDQe4dF7+QgFZPX9f4gdlyEpAVYomyLsO5oz1X2rkRal5qEZtEytj1QXDEZIaWQ=
X-Google-Smtp-Source: AGHT+IHut0PifcKMMGeqhfJ8yiuVWQ7wXVh2IejTYX1LXvOUkkJjf0fMHibwkq8TDuAnUw+VWMtRMQ==
X-Received: by 2002:a17:902:e74d:b0:202:244e:a0b3 with SMTP id d9443c01a7336-202244ea2admr94263185ad.46.1724086864336;
        Mon, 19 Aug 2024 10:01:04 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa4d5sm65079055ad.41.2024.08.19.10.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:01:03 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:00:55 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Levi Zim <rsworktech@outlook.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, cyy@cyyself.name,
	alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, shuah@kernel.org, corbet@lwn.net,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
Message-ID: <ZsN6R8IliKzAKKMb@ghost>
References: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
 <MEYP282MB2312106710775098261AB348C68C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB2312106710775098261AB348C68C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>

On Mon, Aug 19, 2024 at 01:55:57PM +0800, Levi Zim wrote:
> On 2024-03-22 22:06, Palmer Dabbelt wrote:
> > On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
> > > On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
> > > > On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
> > > > > On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
> > > > > > On riscv it is guaranteed that the address returned by mmap is less
> > > > > > than
> > > > > > the hint address. Allow mmap to return an address all the way up to
> > > > > > addr, if provided, rather than just up to the lower address space.
> > > > > > > > This provides a performance benefit as well, allowing
> > > > mmap to exit
> > > > > > after
> > > > > > checking that the address is in range rather than searching for a
> > > > > > valid
> > > > > > address.
> > > > > > > > It is possible to provide an address that uses at most the same
> > > > > > number
> > > > > > of bits, however it is significantly more computationally expensive
> > > > > > to
> > > > > > provide that number rather than setting the max to be the hint
> > > > > > address.
> > > > > > There is the instruction clz/clzw in Zbb that returns the highest
> > > > > > set
> > > > > > bit
> > > > > > which could be used to performantly implement this, but it would
> > > > > > still
> > > > > > be slower than the current implementation. At worst case, half of
> > > > > > the
> > > > > > address would not be able to be allocated when a hint address is
> > > > > > provided.
> > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
> > > > > > -
> > > > > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > > > > > > > diff --git a/arch/riscv/include/asm/processor.h
> > > > > > b/arch/riscv/include/asm/processor.h
> > > > > > index f19f861cda54..8ece7a8f0e18 100644
> > > > > > --- a/arch/riscv/include/asm/processor.h
> > > > > > +++ b/arch/riscv/include/asm/processor.h
> > > > > > @@ -14,22 +14,16 @@
> > > > > >
> > > > > >  #include <asm/ptrace.h>
> > > > > >
> > > > > > -#ifdef CONFIG_64BIT
> > > > > > -#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
> > > > > > -#define STACK_TOP_MAX        TASK_SIZE_64
> > > > > > -
> > > > > >  #define arch_get_mmap_end(addr, len, flags)            \
> > > > > >  ({                                \
> > > > > >      unsigned long
> > > > > > mmap_end;                    \
> > > > > >      typeof(addr) _addr = (addr);                \
> > > > > > -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > > > > is_compat_task())) \
> > > > > > +    if ((_addr) == 0 ||                    \
> > > > > > +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
> > > > > > +        ((_addr + len) > BIT(VA_BITS -
> > > > > > 1)))            \
> > > > > >          mmap_end = STACK_TOP_MAX;            \
> > > > > > -    else if ((_addr) >= VA_USER_SV57) \
> > > > > > -        mmap_end = STACK_TOP_MAX;            \
> > > > > > -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
> > > > > > VA_BITS_SV48)) \
> > > > > > -        mmap_end = VA_USER_SV48;            \
> > > > > >      else                            \
> > > > > > -        mmap_end = VA_USER_SV39;            \
> > > > > > +        mmap_end = (_addr + len);            \
> > > > > >      mmap_end;                        \
> > > > > >  })
> > > > > >
> > > > > > @@ -39,17 +33,18 @@
> > > > > >      typeof(addr) _addr = (addr);                \
> > > > > >      typeof(base) _base = (base);                \
> > > > > >      unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);    \
> > > > > > -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > > > > is_compat_task())) \
> > > > > > +    if ((_addr) == 0 ||                    \
> > > > > > +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
> > > > > > +        ((_addr + len) > BIT(VA_BITS -
> > > > > > 1)))            \
> > > > > >          mmap_base = (_base);                \
> > > > > > -    else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
> > > > > > VA_BITS_SV57)) \
> > > > > > -        mmap_base = VA_USER_SV57 - rnd_gap; \
> > > > > > -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
> > > > > > VA_BITS_SV48)) \
> > > > > > -        mmap_base = VA_USER_SV48 - rnd_gap; \
> > > > > >      else                            \
> > > > > > -        mmap_base = VA_USER_SV39 - rnd_gap; \
> > > > > > +        mmap_base = (_addr + len) - rnd_gap; \
> > > > > >      mmap_base;                        \
> > > > > >  })
> > > > > >
> > > > > > +#ifdef CONFIG_64BIT
> > > > > > +#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
> > > > > > +#define STACK_TOP_MAX        TASK_SIZE_64
> > > > > >  #else
> > > > > >  #define DEFAULT_MAP_WINDOW    TASK_SIZE
> > > > > >  #define STACK_TOP_MAX        TASK_SIZE
> > > > > > > > I have carefully tested your patch on qemu with sv57. A
> > > > bug that
> > > > > needs
> > > > > to be solved is that mmap with the same hint address without
> > > > > MAP_FIXED
> > > > > set will fail the second time.
> > > > > > Userspace code to reproduce the bug:
> > > > > > #include <sys/mman.h>
> > > > > #include <stdio.h>
> > > > > #include <stdint.h>
> > > > > > void test(char *addr) {
> > > > >     char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
> > > > > MAP_ANONYMOUS
> > > > > > MAP_PRIVATE, -1, 0);
> > > > >     printf("hint %p got %p.\n", addr, res);
> > > > > }
> > > > > > int main (void) {
> > > > >     test(1<<30);
> > > > >     test(1<<30);
> > > > >     test(1<<30);
> > > > >     return 0;
> > > > > }
> > > > > > output:
> > > > > > hint 0x40000000 got 0x40000000.
> > > > > hint 0x40000000 got 0xffffffffffffffff.
> > > > > hint 0x40000000 got 0xffffffffffffffff.
> > > > > > output on x86:
> > > > > > hint 0x40000000 got 0x40000000.
> > > > > hint 0x40000000 got 0x7f9171363000.
> > > > > hint 0x40000000 got 0x7f9171362000.
> > > > > > It may need to implement a special arch_get_unmapped_area and
> > > > > arch_get_unmapped_area_topdown function.
> > > > >
> > > > This is because hint address < rnd_gap. I have tried to let mmap_base =
> > > > min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
> > > > does not work for bottom-up while ulimit -s is unlimited. You said this
> > > > behavior is expected from patch v2 review. However it brings a new
> > > > regression even on sv39 systems.
> > > > 
> > > > I still don't know the reason why use addr+len as the upper-bound. I
> > > > think solution like x86/arm64/powerpc provide two address space switch
> > > > based on whether hint address above the default map window is enough.
> > > > 
> > > 
> > > Yep this is expected. It is up to the maintainers to decide.
> > 
> > Sorry I forgot to reply to this, I had a buffer sitting around somewhere
> > but I must have lost it.
> > 
> > I think Charlie's approach is the right way to go.  Putting my userspace
> > hat on, I'd much rather have my allocations fail rather than silently
> > ignore the hint when there's memory pressure.
> > 
> > If there's some real use case that needs these low hints to be silently
> > ignored under VA pressure then we can try and figure something out that
> > makes those applications work.
> 
> I could confirm that this patch has broken chromium's partition allocator on
> riscv64. The minimal reproduction I use is chromium-mmap.c:
> 
> #include <stdio.h>
> #include <sys/mman.h>
> 
> int main() {
>     void* expected = (void*)0x400000000;
>     void* addr = mmap(expected, 17179869184, PROT_NONE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>     if (addr != expected) {

It is not valid to assume that the address returned by mmap will be the
hint address. If the hint address is not available, mmap will return a
different address.

>         printf("Not expected address: %p != %p\n", addr, expected);
>     }
>     expected = (void*)0x3fffff000;
>     addr = mmap(expected, 17179873280, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS,
> -1, 0);
>     if (addr != expected) {
>         printf("Not expected address: %p != %p\n", addr, expected);
>     }
>     return 0;
> }
> 
> The second mmap fails with ENOMEM. Manually reverting this commit fixes the
> issue for me. So I think it's clearly a regression and breaks userspace.
> 

The issue here is that overlapping memory is being requested. This
second mmap will never be able to provide an address at 0x3fffff000 with
a size of 0x400001000 since mmap just provided an address at 0x400000000
with a size of 0x400000000.

Before this patch, this request causes mmap to return a completely
arbitrary value. There is no reason to use a hint address in this manner
because the hint can never be respected. Since an arbitrary address is
desired, a hint of zero should be used.

This patch causes the behavior to be more deterministic. Instead of
providing an arbitrary address, it causes the address to be less than or
equal to the hint address. This allows for applications to make
assumptions about the returned address.

This code is unfortunately relying on the previously mostly undefined
behavior of the hint address in mmap. The goal of this patch is to help
developers have more consistent mmap behavior, but maybe it is necessary
to hide this behavior behind an mmap flag.

- Charlie

> See also https://github.com/riscv-forks/electron/issues/4
> 
> > > 
> > > - Charlie
> 
> Sincerely,
> Levi
> 

