Return-Path: <linux-kselftest+bounces-15740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1D957B8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 04:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEDE1F22D1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 02:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE03AC36;
	Tue, 20 Aug 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SVsBefwg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE61DDA6
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121789; cv=none; b=k5VIOZACOxhuSBdvUeWhIVg8PbU9rTT965tTDGBYE+eBOWoSqEg7+/IHhLhAnC0H84JZU7QXTEPL8SkRaPnEuJMN0YkkVHL32rjGOie8RXqE9ZVYPqe3RuuQamm3GDpb7FERHlvOSKckTmckHjytRU2A7uxZejl/IHFHKbKYMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121789; c=relaxed/simple;
	bh=MiM+Baco+drbu6/oLZP+MltqU1AZ1t/ILbuUxIiehqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOPoxKLowfBophMoIU/wKmV66MwH2UjuTOfjj3oddPr0c01G0fEm0jl8LwIxgEEj+fXLj5XUFlmcwbLO6eeJ2UHYh6SmaaEK250KMlkre5Hi/mIRVtB+4AfIrmUB5cKTDWsui8zyRm0QgUGkGq8cPaBq1y7pqWLNOGdKHvuyg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SVsBefwg; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27020fca39aso2793438fac.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724121785; x=1724726585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IFOzHWvbak6LE8xz7ZLjSo/pB2FEXgmHkGdVOLCa8Qg=;
        b=SVsBefwgA/CSd0Ji5kQ2L9s3wC0qmFJCJ6wwf1ap+TLIUsawjaiwN5k9OIRJ+Z+y+J
         Su6Df1Sa1ssjirYjDq3GUsPZjS7tjYZncKKwysDGiGY+w6GV8jBwbWj7QIvcVh72FwVc
         H2abm3uvNvs4zG+p5j3osmGIB3pV5ETgwX3YLA0Gk7OIfouEXhwNWraUaqkoHXd0xhq2
         lumGWOLQF3BK03bT3Zr6uh5M5xQ7U7utVrAxKIAHgm76OltUUTDTyNHEYOKLyopR8yLW
         jL+1yYazJ6zvD5Ar0tHwen0fUW7V1UNOXA6dqQAiqJCjs8vNgoLf5mJlvibglxA9iQaW
         Fu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724121785; x=1724726585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFOzHWvbak6LE8xz7ZLjSo/pB2FEXgmHkGdVOLCa8Qg=;
        b=gf+ucyU0COjC8tSN3GuvA04HX9WnYKKE2jhhNquenbnxKo8RfGO4hmK8JlqiAkjvi6
         TdisUSo+8ntteg0v/DAuRK6h/sLPd/w+CX1vVCrxqNXO9OJbbVGy7cKyB7arhbPh7BRX
         wZEKDKsXKkG06xeoHzxuajIuecXD/XZKxh6OQmtDIbXm2doGeivL9qUafrPj6IjeZGls
         h5R/N+xAbQox6e7T+9sqnC+I/775a//Du3NFixAmPea+rMTVZmzEQUVOqCKeFutq7P9a
         DES9VllYO/kLiyckapoFy82V5Fbsa+2WfNBhWC84asmSt5qsvI9g6VjNo6N8SXjrRzF3
         LMUg==
X-Forwarded-Encrypted: i=1; AJvYcCXJV/TxFSpwlJL6xCaoJLl69rllYUchiaBoz6FkTcup6wNim6NLJlIt5fGCfmoeAnO19J8oXW/CNvKaFn3A7fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpgb0U/pH6bN6EOAHAcXVGewTm5+ynJha/2A/7XBZdEqJFT1Y
	CQmLjyQENXRzFis+EHjqRghvN8mfkaygP/OFNarW9cvgEn6brVYvu1QXIvu9B0c=
X-Google-Smtp-Source: AGHT+IFyL2JXMETglLC3qz3X/+8Y7jUI/5f0Wd58GItgifYO6esi1EP2LeOLUWy1KtEsosdOCx3dgA==
X-Received: by 2002:a05:6870:e387:b0:24e:8987:6f34 with SMTP id 586e51a60fabf-2701c354855mr15623458fac.3.1724121785232;
        Mon, 19 Aug 2024 19:43:05 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:7ef:3ad1:b795:8617])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1e415sm7473468b3a.175.2024.08.19.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 19:43:04 -0700 (PDT)
Date: Mon, 19 Aug 2024 19:43:01 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Levi Zim <rsworktech@outlook.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, cyy@cyyself.name,
	alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, shuah@kernel.org, corbet@lwn.net,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
Message-ID: <ZsQCtUP9ul2Y9WB9@ghost>
References: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
 <MEYP282MB2312106710775098261AB348C68C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <ZsN6R8IliKzAKKMb@ghost>
 <MEYP282MB2312FDB8F4AA7A76884081ADC68D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB2312FDB8F4AA7A76884081ADC68D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>

On Tue, Aug 20, 2024 at 09:48:50AM +0800, Levi Zim wrote:
> On 2024-08-20 01:00, Charlie Jenkins wrote:
> > On Mon, Aug 19, 2024 at 01:55:57PM +0800, Levi Zim wrote:
> > > On 2024-03-22 22:06, Palmer Dabbelt wrote:
> > > > On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
> > > > > On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
> > > > > > On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
> > > > > > > On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
> > > > > > > > On riscv it is guaranteed that the address returned by mmap is less
> > > > > > > > than
> > > > > > > > the hint address. Allow mmap to return an address all the way up to
> > > > > > > > addr, if provided, rather than just up to the lower address space.
> > > > > > > > > > This provides a performance benefit as well, allowing
> > > > > > mmap to exit
> > > > > > > > after
> > > > > > > > checking that the address is in range rather than searching for a
> > > > > > > > valid
> > > > > > > > address.
> > > > > > > > > > It is possible to provide an address that uses at most the same
> > > > > > > > number
> > > > > > > > of bits, however it is significantly more computationally expensive
> > > > > > > > to
> > > > > > > > provide that number rather than setting the max to be the hint
> > > > > > > > address.
> > > > > > > > There is the instruction clz/clzw in Zbb that returns the highest
> > > > > > > > set
> > > > > > > > bit
> > > > > > > > which could be used to performantly implement this, but it would
> > > > > > > > still
> > > > > > > > be slower than the current implementation. At worst case, half of
> > > > > > > > the
> > > > > > > > address would not be able to be allocated when a hint address is
> > > > > > > > provided.
> > > > > > > > > > Signed-off-by: Charlie Jenkins<charlie@rivosinc.com>
> > > > > > > > ---
> > > > > > > >   arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
> > > > > > > > -
> > > > > > > >   1 file changed, 11 insertions(+), 16 deletions(-)
> > > > > > > > > > diff --git a/arch/riscv/include/asm/processor.h
> > > > > > > > b/arch/riscv/include/asm/processor.h
> > > > > > > > index f19f861cda54..8ece7a8f0e18 100644
> > > > > > > > --- a/arch/riscv/include/asm/processor.h
> > > > > > > > +++ b/arch/riscv/include/asm/processor.h
> > > > > > > > @@ -14,22 +14,16 @@
> > > > > > > > 
> > > > > > > >   #include <asm/ptrace.h>
> > > > > > > > 
> > > > > > > > -#ifdef CONFIG_64BIT
> > > > > > > > -#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
> > > > > > > > -#define STACK_TOP_MAX        TASK_SIZE_64
> > > > > > > > -
> > > > > > > >   #define arch_get_mmap_end(addr, len, flags)            \
> > > > > > > >   ({                                \
> > > > > > > >       unsigned long
> > > > > > > > mmap_end;                    \
> > > > > > > >       typeof(addr) _addr = (addr);                \
> > > > > > > > -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > > > > > > is_compat_task())) \
> > > > > > > > +    if ((_addr) == 0 ||                    \
> > > > > > > > +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
> > > > > > > > +        ((_addr + len) > BIT(VA_BITS -
> > > > > > > > 1)))            \
> > > > > > > >           mmap_end = STACK_TOP_MAX;            \
> > > > > > > > -    else if ((_addr) >= VA_USER_SV57) \
> > > > > > > > -        mmap_end = STACK_TOP_MAX;            \
> > > > > > > > -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
> > > > > > > > VA_BITS_SV48)) \
> > > > > > > > -        mmap_end = VA_USER_SV48;            \
> > > > > > > >       else                            \
> > > > > > > > -        mmap_end = VA_USER_SV39;            \
> > > > > > > > +        mmap_end = (_addr + len);            \
> > > > > > > >       mmap_end;                        \
> > > > > > > >   })
> > > > > > > > 
> > > > > > > > @@ -39,17 +33,18 @@
> > > > > > > >       typeof(addr) _addr = (addr);                \
> > > > > > > >       typeof(base) _base = (base);                \
> > > > > > > >       unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);    \
> > > > > > > > -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > > > > > > is_compat_task())) \
> > > > > > > > +    if ((_addr) == 0 ||                    \
> > > > > > > > +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
> > > > > > > > +        ((_addr + len) > BIT(VA_BITS -
> > > > > > > > 1)))            \
> > > > > > > >           mmap_base = (_base);                \
> > > > > > > > -    else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
> > > > > > > > VA_BITS_SV57)) \
> > > > > > > > -        mmap_base = VA_USER_SV57 - rnd_gap; \
> > > > > > > > -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
> > > > > > > > VA_BITS_SV48)) \
> > > > > > > > -        mmap_base = VA_USER_SV48 - rnd_gap; \
> > > > > > > >       else                            \
> > > > > > > > -        mmap_base = VA_USER_SV39 - rnd_gap; \
> > > > > > > > +        mmap_base = (_addr + len) - rnd_gap; \
> > > > > > > >       mmap_base;                        \
> > > > > > > >   })
> > > > > > > > 
> > > > > > > > +#ifdef CONFIG_64BIT
> > > > > > > > +#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
> > > > > > > > +#define STACK_TOP_MAX        TASK_SIZE_64
> > > > > > > >   #else
> > > > > > > >   #define DEFAULT_MAP_WINDOW    TASK_SIZE
> > > > > > > >   #define STACK_TOP_MAX        TASK_SIZE
> > > > > > > > > > I have carefully tested your patch on qemu with sv57. A
> > > > > > bug that
> > > > > > > needs
> > > > > > > to be solved is that mmap with the same hint address without
> > > > > > > MAP_FIXED
> > > > > > > set will fail the second time.
> > > > > > > > Userspace code to reproduce the bug:
> > > > > > > > #include <sys/mman.h>
> > > > > > > #include <stdio.h>
> > > > > > > #include <stdint.h>
> > > > > > > > void test(char *addr) {
> > > > > > >      char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
> > > > > > > MAP_ANONYMOUS
> > > > > > > > MAP_PRIVATE, -1, 0);
> > > > > > >      printf("hint %p got %p.\n", addr, res);
> > > > > > > }
> > > > > > > > int main (void) {
> > > > > > >      test(1<<30);
> > > > > > >      test(1<<30);
> > > > > > >      test(1<<30);
> > > > > > >      return 0;
> > > > > > > }
> > > > > > > > output:
> > > > > > > > hint 0x40000000 got 0x40000000.
> > > > > > > hint 0x40000000 got 0xffffffffffffffff.
> > > > > > > hint 0x40000000 got 0xffffffffffffffff.
> > > > > > > > output on x86:
> > > > > > > > hint 0x40000000 got 0x40000000.
> > > > > > > hint 0x40000000 got 0x7f9171363000.
> > > > > > > hint 0x40000000 got 0x7f9171362000.
> > > > > > > > It may need to implement a special arch_get_unmapped_area and
> > > > > > > arch_get_unmapped_area_topdown function.
> > > > > > > 
> > > > > > This is because hint address < rnd_gap. I have tried to let mmap_base =
> > > > > > min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
> > > > > > does not work for bottom-up while ulimit -s is unlimited. You said this
> > > > > > behavior is expected from patch v2 review. However it brings a new
> > > > > > regression even on sv39 systems.
> > > > > > 
> > > > > > I still don't know the reason why use addr+len as the upper-bound. I
> > > > > > think solution like x86/arm64/powerpc provide two address space switch
> > > > > > based on whether hint address above the default map window is enough.
> > > > > > 
> > > > > Yep this is expected. It is up to the maintainers to decide.
> > > > Sorry I forgot to reply to this, I had a buffer sitting around somewhere
> > > > but I must have lost it.
> > > > 
> > > > I think Charlie's approach is the right way to go.  Putting my userspace
> > > > hat on, I'd much rather have my allocations fail rather than silently
> > > > ignore the hint when there's memory pressure.
> > > > 
> > > > If there's some real use case that needs these low hints to be silently
> > > > ignored under VA pressure then we can try and figure something out that
> > > > makes those applications work.
> > > I could confirm that this patch has broken chromium's partition allocator on
> > > riscv64. The minimal reproduction I use is chromium-mmap.c:
> > > 
> > > #include <stdio.h>
> > > #include <sys/mman.h>
> > > 
> > > int main() {
> > >      void* expected = (void*)0x400000000;
> > >      void* addr = mmap(expected, 17179869184, PROT_NONE,
> > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> > >      if (addr != expected) {
> > It is not valid to assume that the address returned by mmap will be the
> > hint address. If the hint address is not available, mmap will return a
> > different address.
> 
> Oh, sorry I didn't make it clear what is the expected behavior.
> The printf here is solely for debugging purpose and I don't mean that
> chromium expect it will get the hint address. The expected behavior is that
> both the two mmap calls will succeed.
> 
> > >          printf("Not expected address: %p != %p\n", addr, expected);
> > >      }
> > >      expected = (void*)0x3fffff000;
> > >      addr = mmap(expected, 17179873280, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS,
> > > -1, 0);
> > >      if (addr != expected) {
> > >          printf("Not expected address: %p != %p\n", addr, expected);
> > >      }
> > >      return 0;
> > > }
> > > 
> > > The second mmap fails with ENOMEM. Manually reverting this commit fixes the
> > > issue for me. So I think it's clearly a regression and breaks userspace.
> > > 
> > The issue here is that overlapping memory is being requested. This
> > second mmap will never be able to provide an address at 0x3fffff000 with
> > a size of 0x400001000 since mmap just provided an address at 0x400000000
> > with a size of 0x400000000.
> > 
> > Before this patch, this request causes mmap to return a completely
> > arbitrary value. There is no reason to use a hint address in this manner
> > because the hint can never be respected. Since an arbitrary address is
> > desired, a hint of zero should be used.
> > 
> > This patch causes the behavior to be more deterministic. Instead of
> > providing an arbitrary address, it causes the address to be less than or
> > equal to the hint address. This allows for applications to make
> > assumptions about the returned address.
> 
> About the overlap, of course the partition allocator's request for
> overlapped vma seems unreasonable.
> 
> But I still don't quite understand why mmap cannot use an address higher
> than the hint address.
> The hint address, after all, is a hint, not a requirement.

Yes that is fair. A "hint" that does not guarantee anything is
useless so architectures have abused the term quite a bit.

> 
> Quoting the man page:
> 
> >    If another mapping already exists there, the kernel picks
> >         a new address that may or may not depend on the hint.  The
> >         address of the new mapping is returned as the result of the call.
> So for casual programmers that only reads man page but not architecture
> specific kernel
> documentation, the current behavior of mmap on riscv64 failing on overlapped
> address ranges
> are quite surprising IMO.

The man pages for riscv are in desperate need of attention. I have
submitted a couple of updates to them recently, but there is a lot more
work to be done to help developers.

> 
> And quoting the man page again about the errno:
> 
> >       ENOMEM No memory is available.
> > 
> >       ENOMEM The process's maximum number of mappings would have been
> >              exceeded.  This error can also occur for munmap(), when
> >              unmapping a region in the middle of an existing mapping,
> >              since this results in two smaller mappings on either side
> >              of the region being unmapped.
> > 
> >       ENOMEM (since Linux 4.7) The process's RLIMIT_DATA limit,
> >              described in getrlimit(2), would have been exceeded.
> > 
> >       ENOMEM We don't like addr, because it exceeds the virtual address
> >              space of the CPU.
> > 
> 
> There's no matching description for the ENOMEM returned here.
> I would suggest removing "because it exceeds the virtual address
> space of the CPU." from the last item if the ENOMEM behavior here
> is expected.

This ENOMEM means something like "no memory available in the requested
region".

> 
> > This code is unfortunately relying on the previously mostly undefined
> > behavior of the hint address in mmap.
> Although I haven't read the code of chromium's partition allocator to judge
> whether it should
> be improved or fixed for riscv64, I do know that the kernel "don't break
> userspace" and
> "never EVER blame the user programs".

The hint address design of mmap is a tricky one because it is largely
implementation defined and what the man pages say is not how it is
implemented in most architectures!

> > The goal of this patch is to help
> > developers have more consistent mmap behavior, but maybe it is necessary
> > to hide this behavior behind an mmap flag.
> Thank you for helping to shape a more consistent mmap behavior.
> I think this should be fixed ASAP either by allowing the hint address to be
> ignored
> (as suggested by the Linux man page), or hide this behavior behind an mmap
> flag as you said.

Having a flag could also lead to a generic way of defining this
behavior. Other architectures do not provide a way for applications to
guarantee that some number of bits are left unused in a virtual address,
and that was one of the motivating design goals here.

- Charlie

> 
> > - Charlie
> > 
> > > See alsohttps://github.com/riscv-forks/electron/issues/4
> > > 
> > > > > - Charlie
> > > Sincerely,
> > > Levi
> > > 

