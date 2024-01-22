Return-Path: <linux-kselftest+bounces-3362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C283735A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 20:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1417B21BCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076373FE50;
	Mon, 22 Jan 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Mf2QUJ7A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E543FB33
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953397; cv=none; b=XC/NY0IO6mqDLZtG6FiZ29mFC2pbXX2bqdvTtOouqvd9Fk3Va9cuwPbTEDnSx1xrmnFT8eJnyYqqMTASXXF79UZ5Do56O76fpikO3ClCBcOpdhtqLJRt9wyKKE0103fl2wBFCqBqF86eDJwdSHwhzTVdR5H5fVoXe2UqFK6so48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953397; c=relaxed/simple;
	bh=LxSgvig4j5z8INM0/P+yyg1wqb61ux+RUaUaiS5yrbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Di1YSxXQ0TOoNf2jxwLOTEps6JcweQYFBIgySGebVzjU7oIkfdvmh2WNQPlCDYqn5Tf4YYulhpRmp43s9qz1InagpaRQKXVAWA6NiGac/X8YfVYki4ajpiaRciNl6X1ClyuutSoPB18Obh3Tyyvz2gAn3QiXwO+TmEk+58uP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Mf2QUJ7A; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2477671a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705953395; x=1706558195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UH3ZxhToA5oQfyXBCJ4srePY/ACWm4Ai6nHOFGyU640=;
        b=Mf2QUJ7A7My6pmxBHVVz+j+cLo1wBziUWxZPdg2r1JxYnf+5yP/2UdVhy7zRvX0gDg
         yRRbJiWrUrFEd34yNbueGPLiTfjbYta3oukAO8xLMR3GVJJ1lyrQZmZf3e3OesWaJXCD
         BxFOOYMUZbEkKX+kYg7wC0ORBVJeglpoKLtCOjHS5PEi/kPdEWt5igQOtcirqDkOppOt
         z265G6u2f1ZRlLTAq6TMrnANUVO8MqA+NpmNi5d84Yof7UvqNKOFOCoIzToriL/FrU4r
         N+vj4bAyFbI74g4QClzJLy/yXrnKGtEDtMtNWR1GOrVSedvQ3tddTgXrdRDfnOZkxVWm
         aREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705953395; x=1706558195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UH3ZxhToA5oQfyXBCJ4srePY/ACWm4Ai6nHOFGyU640=;
        b=C/B9j2cmHaSpObQK4HmaVpBqB3K11c/6xdW985Uvownr4FxVSnrKBJLFrRULRMdEOX
         cT/94AGhECyQZp/yR/fYkUpJZIan31nR3VTwImRiJSyu8YxUzIupffBWjhixKoSXcL97
         WskxRIMpMWbOaMw4iW5dIR99h7LlzKEekJ7a4OmxEhUHl3algfRzV4FHW93nQGjHW3N4
         pwHE+oSKMrLKxWCG4Z3pPxkbNYmDJxrvOR157LehEXjAGqtyvqCfmkjXZ8XCWB+1uyAQ
         m8KI4tgi995WAdxrW/9ufcIVRX8IxZBiCx1/mF3yM18C0thAt0K3lCxUg262Ve0x7UaO
         qa4Q==
X-Gm-Message-State: AOJu0YxTX9L2NYWrOoyRlSgFi682MEj4j18ASRfbKy+5fH2gJW33mL2N
	A7307C8ONLwuaajOlUv0xOfYMiz/oa03lsOiNm38e6tr3r6WqXbwGjcRL1/aT2GSOW6/e6AKG2o
	o3Lk=
X-Google-Smtp-Source: AGHT+IELosIoqFP0xlW9ykmXuQHjrS4lU/5p79wfCOzfjuOQzfpaOXw8gaBbyXJ6ZQFkAIC9bM85zQ==
X-Received: by 2002:a17:90a:fe0a:b0:290:6e71:7cec with SMTP id ck10-20020a17090afe0a00b002906e717cecmr1580074pjb.75.1705953395560;
        Mon, 22 Jan 2024 11:56:35 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id qa1-20020a17090b4fc100b00290c9b195e9sm214833pjb.28.2024.01.22.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:56:35 -0800 (PST)
Date: Mon, 22 Jan 2024 11:56:32 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: alexghiti@rivosinc.com, anup@brainfault.org, aou@eecs.berkeley.edu,
	conor@kernel.org, jrtc27@jrtc27.com, konstantin@linuxfoundation.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, mick@ics.forth.gr,
	palmer@rivosinc.com, paul.walmsley@sifive.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v10 0/4] RISC-V: mm: Make SV48 the default address space
Message-ID: <Za7IcJg6hv3OBBch@ghost>
References: <20230809232218.849726-1-charlie@rivosinc.com>
 <tencent_F9568C6D8872E30EDFAF20ADF686A31D6E06@qq.com>
 <ZasjJ3HPUVuxr2oG@ghost>
 <tencent_FE461EBE274178ED6047005CCF98D710B807@qq.com>
 <Zats/W/oiaphdWTv@ghost>
 <tencent_A80D5721462124BDB19CAF4E10473BD55105@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A80D5721462124BDB19CAF4E10473BD55105@qq.com>

On Sat, Jan 20, 2024 at 03:09:51PM +0800, Yangyu Chen wrote:
> 
> 
> On 1/20/24 14:49, Charlie Jenkins wrote:
> > On Sat, Jan 20, 2024 at 02:13:14PM +0800, Yangyu Chen wrote:
> > > Thanks for your reply.
> > > 
> > > On 1/20/24 09:34, Charlie Jenkins wrote:
> > > > On Sun, Jan 14, 2024 at 01:26:57AM +0800, Yangyu Chen wrote:
> > > > > Hi, Charlie
> > > > > 
> > > > > Although this patchset has been merged I still have some questions about
> > > > > this patchset. Because it breaks regular mmap if address >= 38 bits on
> > > > > sv48 / sv57 capable systems like qemu. For example, If a userspace program
> > > > > wants to mmap an anonymous page to addr=(1<<45) on an sv48 capable system,
> > > > > it will fail and kernel will mmaped to another sv39 address since it does
> > > > 
> > > > Thank you for raising this concern. To make sure I am understanding
> > > > correctly, you are passing a hint address of (1<<45) and expecting mmap
> > > > to return 1<<45 and if it returns a different address you are describing
> > > > mmap as failing? If you want an address that is in the sv48 space you
> > > > can pass in an address that is greater than 1<<47.
> > > > 
> > > > > not meet the requirement to use sv48 as you wrote:
> > > > > 
> > > > > > 	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > > > > > 		mmap_end = VA_USER_SV48;			\
> > > > > > 	else							\
> > > > > > 		mmap_end = VA_USER_SV39;			\
> > > > > 
> > > > > Then, How can a userspace program create a mmap with a hint if the address
> > > > > > = (1<<38) after your patch without MAP_FIXED? The only way to do this is
> > > > > to pass a hint >= (1<<47) on mmap syscall then kernel will return a random
> > > > > address in sv48 address space but the hint address gets lost. I think this
> > > > 
> > > > In order to force mmap to return the address provided you must use
> > > > MAP_FIXED. Otherwise, the address is a "hint" and has no guarantees. The
> > > > hint address on riscv is used to mean "don't give me an address that
> > > > uses more bits than this". This behavior is not unique to riscv, arm64
> > > > and powerpc use a similar scheme. In arch/arm64/include/asm/processor.h
> > > > there is the following code:
> > > > 
> > > > #define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
> > > > 					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
> > > > 					base)
> > > > 
> > > > arm64/powerpc are only concerned with a single boundary so the code is simpler.
> > > > 
> > > 
> > > As you say, this code in arm64/powerpc will not meet the issue I address.
> > > For example, If the addr here is (1<<50) on arm64, the arch_get_mmap_base
> > > will return base+TASK_SIZE-DEFAULT_MAP_WINDOW which is (1<<vabits_actual).
> > > And this behavior on arm64/powerpc/x86 does not break anything since we will
> > > use a larger address space if the hint address is specified on the address >
> > > DEFAULT_MAP_WINDOW. The corresponding behavior on RISC-V should be if the
> > > hint address > BIT(47) then use Sv57 address space and use Sv48 when the
> > > hint address > BIT(38) if we want Sv39 by default.
> > > 
> > > However, your patch needs the address >= BIT(47) rather than BIT(38) to use
> > > Sv48 and address >= BIT(56) to use Sv57, thus breaking existing userspace
> > > software to create mapping on the hint address without MAP_FIXED set.
> > 
> > Code that needs mmap to provide a specific address must use MAP_FIXED.
> > On riscv, it was decided that the address returned from mmap cannot be
> > greater than the hint address. This is currently implemented by using
> > the largest address space that can fit into the hint address. It may be
> > possible that this range can be extended to use all of the addresses
> > that are less than or equal to the hint address.
> > 
> 
> So this decision might be wrong. It requires some userspace software to
> modify their mmap flags to fit with this. For example, a binary translate
> JIT compiler already probes this platform is capable with Sv48, then want to
> create mapping on some address specified on the mmap hint to align with
> foreign binary native address but also provide a fallback path with
> performance overhead. Your patch here will always let userspace software use

I do not follow. This mechanism allows a program to always know how many
bits will be available in the virtual address provided by mmap,
regardless of the size of the underlying virtual address space.

The phrasing "align with foreign binary native address" seems like the
program requires a specific address, which is never guaranteed by mmap
without MAP_FIXED. If the program is relying on mmap to provide the
address without MAP_FIXED, the program is relying on behavior that
cannot be expected to remain constant across Linux releases.

> a fallback path with performance overhead until the userspace software
> changes its syscall to use MAP_FIXED. But it is not required in x86, arm64,
> powerpc.
> 
> >  From reading the code even on arm64 if you pass an address that is
> > greater than DEFAULT_MAP_WINDOW it is not guaranteed that mmap will
> > return an address that is greater than DEFAULT_MAP_WINDOW. It may still
> > be provide an address that is less than DEFAULT_MAP_WINDOW if it fails
> > to find an address above. This seems like this would also break your use
> > case.
> > 
> 
> Yeah. As I said before, this patch will always let userspace software use a
> fallback path and this only happens in RISC-V. Make default sv48 is right,
> but RISC-V implementation for this and changing the hint address behavior
> might be wrong. And x86, arm64, powerpc already use
> 48-bit address space by default but do not change the meaning of hint
> address on mmap.
> 
> > > 
> > > > > violate the principle of mmap syscall as kernel should take the hint and
> > > > > attempt to create the mapping there.
> > > > 
> > > > Although the man page for mmap does say "on Linux, the kernel will pick
> > > > a nearby page boundary" it is still a hint address so there is no strict
> > > > requirement (and the precedent has already been set by arm64/powerpc).
> > > > 
> > > 
> > > Yeah. There is no strict requirement. But currently x86/arm64/powerpc works
> > > in this situation well. The hint address on these ISAs is not used as the
> > > upper bound to allocating the address. However, on RISC-V, you treat this as
> > > the upper bound.
> > > 
> > > > > 
> > > > > I don't think patching in this way is right. However, if we only revert
> > > > > this patch, some programs relying on mmap to return address with effective
> > > > > bits <= 48 will still be an issue and it might expand to other ISAs if
> > > > > they implement larger virtual address space like RISC-V sv57. A better way
> > > > > to solve this might be adding a MAP_48BIT flag to mmap like MAP_32BIT has
> > > > > been introduced for decades.
> > > > > 
> > > > > Thanks,
> > > > > Yangyu Chen
> > > > > 
> > > > 
> > > > - Charlie
> > > > 
> > > 
> 

