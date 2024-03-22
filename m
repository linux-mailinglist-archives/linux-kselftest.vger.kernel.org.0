Return-Path: <linux-kselftest+bounces-6492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EC886E3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD35B21503
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2044C84;
	Fri, 22 Mar 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="JGn3tSWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F9481CD
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Mar 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116787; cv=none; b=uq1vSG4eQWlOAdu2C6NjUFBkdSdB+OIHNIeoghvPf8FCY/aFwVTJzR+7+0wFEgo9OoTvKROBgVlCO9d20gIr0QZIUDZ8eupcUqcerP7UY3ittaw2z7ahDyP46KebU+xXlaPNacv7r3nP4pQr5Eru2XHyWKk6rWKDYG1kb2MOXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116787; c=relaxed/simple;
	bh=uabN1U09dpaxwPgK5zBOg/0q/WFlWJn6j0Uu62VmsG0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=A778rwMO6ma+yp09PdcrMFBSMldPin6+bxWBdFbwRXG61VHNhAEa3paX/5rscs570GNrfEi+WH6909oYjZaklIO5nDoSxg2hWkUKl21yLSbCzc4k8sSm7FU6FurDGj/A+B7GYs77yGcq/lLxzMjPk8wTVW38PVwfLFTsyNByHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=JGn3tSWT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221a2d0c5dcso1213324fac.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Mar 2024 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1711116784; x=1711721584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMwbsV2lr5D+n8eq4lwX8uN+1JbL7Okl9fmvTySMdOM=;
        b=JGn3tSWTiAJasNyWiBds5NvwF203NTkJV0tN+YHKu2XZKNEB1NQaiBUekwgDZ4KsQj
         WxbYvCuF5qKTWVtLULglsgwEKR8d6i95V9BIAOysCkcVNngC1iCI7PQZfZAxUc6txDKf
         tzs0qB0LrA7AeTGXliQ+mBtBb8hgnw8dgZ5Nfcm4c9kS9xxGWNdXUFHXGQj5XH2oEEh2
         lY92Yt9hukRzYCv+ivbKRuyT5qFGDEAfc1CLu5iv3rbZYgFsAtmy1jtlJj0G+jp6gbqf
         BJl5Nk0JQWNR8KmNTk/FrnggrWY2ylt4Bt2YIf0F6ckryd6JrVHJMIn/zJ/E+UckgchA
         NgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116784; x=1711721584;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMwbsV2lr5D+n8eq4lwX8uN+1JbL7Okl9fmvTySMdOM=;
        b=QEE3ZJ+1ZWcNvOWO5uSgDSuXlirtEb0CoRcu9rve/pk3uOFc95AC+hN3DC/vmhMRiK
         9uPQTGmOFMzB1e5lR1P9jWB+6hQMD3f0G5F0937h/OUCfrSG8eRDxmYNrJIvt03ncoC3
         lUd0Dl46xT+UXZrl2lksEoIfWqzKCyPJkS3tD2agFmKUFy7XQeYzgVLMD0E/jHCGCQbx
         M8zBB4BMe8TWtWy2yWJn7p8WadLJeASvGX2ceV/yb1k8Li6IPss9vJReTd0LsnzvN0dh
         8ocZCcAs05vxTvG9Z7LJFSEOEqGDLfW1vavgWZZFcJ3Ly2n6mJuveWnf3hmw/Uz19/wD
         h/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWUW0Bux62JMEywZPLowZfDOAz0yVOaGvJAl7dUoWo6N64WdYl1szxKTSwhgyPeY4ciHklHTVHL+OSo6SWHacd9KiKKIobaGZoSrPY821Gq
X-Gm-Message-State: AOJu0Ywuf4Mc+f+jXWibqZjTyDgWDE8OUYZHXPJTq3LfUb3DywdhFsxC
	CWRub+um4VurhvGcQv85Kqq24tz15o0jwSVrNDDBPfpRVRcealdOAbxuJ1M1Uqe8a+4Fg9l4+PG
	G
X-Google-Smtp-Source: AGHT+IF67p/WhASEEUOaMLQ7DminN+c4zr/4NoTc7CLi/rZc+sVKHX93JtQeh2Zc4uFIFtVUaKoXtg==
X-Received: by 2002:a05:6a21:920a:b0:1a3:7b9a:4dd6 with SMTP id tl10-20020a056a21920a00b001a37b9a4dd6mr2763771pzb.54.1711116379234;
        Fri, 22 Mar 2024 07:06:19 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id x8-20020a056a000bc800b006ea918dab9csm94982pfu.157.2024.03.22.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:06:18 -0700 (PDT)
Date: Fri, 22 Mar 2024 07:06:18 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Mar 2024 07:06:16 PDT (-0700)
Subject:     Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
In-Reply-To: <ZbxTNjQPFKBatMq+@ghost>
CC: cyy@cyyself.name, alexghiti@rivosinc.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, shuah@kernel.org, corbet@lwn.net, linux-mm@kvack.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
  linux-doc@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
> On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
>> On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
>> > On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
>> > > On riscv it is guaranteed that the address returned by mmap is less
>> > > than
>> > > the hint address. Allow mmap to return an address all the way up to
>> > > addr, if provided, rather than just up to the lower address space.
>> > > 
>> > > This provides a performance benefit as well, allowing mmap to exit
>> > > after
>> > > checking that the address is in range rather than searching for a
>> > > valid
>> > > address.
>> > > 
>> > > It is possible to provide an address that uses at most the same
>> > > number
>> > > of bits, however it is significantly more computationally expensive
>> > > to
>> > > provide that number rather than setting the max to be the hint
>> > > address.
>> > > There is the instruction clz/clzw in Zbb that returns the highest
>> > > set
>> > > bit
>> > > which could be used to performantly implement this, but it would
>> > > still
>> > > be slower than the current implementation. At worst case, half of
>> > > the
>> > > address would not be able to be allocated when a hint address is
>> > > provided.
>> > > 
>> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> > > ---
>> > >  arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
>> > > -
>> > >  1 file changed, 11 insertions(+), 16 deletions(-)
>> > > 
>> > > diff --git a/arch/riscv/include/asm/processor.h
>> > > b/arch/riscv/include/asm/processor.h
>> > > index f19f861cda54..8ece7a8f0e18 100644
>> > > --- a/arch/riscv/include/asm/processor.h
>> > > +++ b/arch/riscv/include/asm/processor.h
>> > > @@ -14,22 +14,16 @@
>> > >  
>> > >  #include <asm/ptrace.h>
>> > >  
>> > > -#ifdef CONFIG_64BIT
>> > > -#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>> > > -#define STACK_TOP_MAX		TASK_SIZE_64
>> > > -
>> > >  #define arch_get_mmap_end(addr, len, flags)			\
>> > >  ({								\
>> > >  	unsigned long
>> > > mmap_end;					\
>> > >  	typeof(addr) _addr = (addr);				\
>> > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>> > > is_compat_task())) \
>> > > +	if ((_addr) == 0 ||					\
>> > > +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
>> > > +	    ((_addr + len) > BIT(VA_BITS -
>> > > 1)))			\
>> > >  		mmap_end = STACK_TOP_MAX;			\
>> > > -	else if ((_addr) >= VA_USER_SV57)			\
>> > > -		mmap_end = STACK_TOP_MAX;			\
>> > > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>> > > VA_BITS_SV48)) \
>> > > -		mmap_end = VA_USER_SV48;			\
>> > >  	else							\
>> > > -		mmap_end = VA_USER_SV39;			\
>> > > +		mmap_end = (_addr + len);			\
>> > >  	mmap_end;						\
>> > >  })
>> > >  
>> > > @@ -39,17 +33,18 @@
>> > >  	typeof(addr) _addr = (addr);				\
>> > >  	typeof(base) _base = (base);				\
>> > >  	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
>> > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>> > > is_compat_task())) \
>> > > +	if ((_addr) == 0 ||					\
>> > > +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
>> > > +	    ((_addr + len) > BIT(VA_BITS -
>> > > 1)))			\
>> > >  		mmap_base = (_base);				\
>> > > -	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
>> > > VA_BITS_SV57)) \
>> > > -		mmap_base = VA_USER_SV57 - rnd_gap;		\
>> > > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>> > > VA_BITS_SV48)) \
>> > > -		mmap_base = VA_USER_SV48 - rnd_gap;		\
>> > >  	else							\
>> > > -		mmap_base = VA_USER_SV39 - rnd_gap;		\
>> > > +		mmap_base = (_addr + len) - rnd_gap;		\
>> > >  	mmap_base;						\
>> > >  })
>> > >  
>> > > +#ifdef CONFIG_64BIT
>> > > +#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>> > > +#define STACK_TOP_MAX		TASK_SIZE_64
>> > >  #else
>> > >  #define DEFAULT_MAP_WINDOW	TASK_SIZE
>> > >  #define STACK_TOP_MAX		TASK_SIZE
>> > > 
>> > 
>> > I have carefully tested your patch on qemu with sv57. A bug that
>> > needs
>> > to be solved is that mmap with the same hint address without
>> > MAP_FIXED
>> > set will fail the second time.
>> > 
>> > Userspace code to reproduce the bug:
>> > 
>> > #include <sys/mman.h>
>> > #include <stdio.h>
>> > #include <stdint.h>
>> > 
>> > void test(char *addr) {
>> >     char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
>> > MAP_ANONYMOUS
>> > > MAP_PRIVATE, -1, 0);
>> >     printf("hint %p got %p.\n", addr, res);
>> > }
>> > 
>> > int main (void) {
>> >     test(1<<30);
>> >     test(1<<30);
>> >     test(1<<30);
>> >     return 0;
>> > }
>> > 
>> > output:
>> > 
>> > hint 0x40000000 got 0x40000000.
>> > hint 0x40000000 got 0xffffffffffffffff.
>> > hint 0x40000000 got 0xffffffffffffffff.
>> > 
>> > output on x86:
>> > 
>> > hint 0x40000000 got 0x40000000.
>> > hint 0x40000000 got 0x7f9171363000.
>> > hint 0x40000000 got 0x7f9171362000.
>> > 
>> > It may need to implement a special arch_get_unmapped_area and
>> > arch_get_unmapped_area_topdown function.
>> > 
>> 
>> This is because hint address < rnd_gap. I have tried to let mmap_base =
>> min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
>> does not work for bottom-up while ulimit -s is unlimited. You said this
>> behavior is expected from patch v2 review. However it brings a new
>> regression even on sv39 systems.
>> 
>> I still don't know the reason why use addr+len as the upper-bound. I
>> think solution like x86/arm64/powerpc provide two address space switch
>> based on whether hint address above the default map window is enough.
>> 
>
> Yep this is expected. It is up to the maintainers to decide.

Sorry I forgot to reply to this, I had a buffer sitting around somewhere 
but I must have lost it.

I think Charlie's approach is the right way to go.  Putting my userspace 
hat on, I'd much rather have my allocations fail rather than silently 
ignore the hint when there's memory pressure.

If there's some real use case that needs these low hints to be silently 
ignored under VA pressure then we can try and figure something out that 
makes those applications work.

>
> - Charlie

