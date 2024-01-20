Return-Path: <linux-kselftest+bounces-3268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ADA8332FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 07:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158991C21C38
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B01FD6;
	Sat, 20 Jan 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sc3g52yh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC871FBC
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Jan 2024 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705733379; cv=none; b=KU7BxVh6E5WE0Z6e2rZIMVFzvyWl4Gl3PkR+acFtRT336onLROXoq3CekUm6jM0NxHki6PQjp+s1nFbv+JuOSVbDYuWj8jKu8nAmahvq5Bhadu1Ni0FZhF5SZ39QLcRI3LJc0hLQO/6lonk6V9Ud+atnXB52qyoyUqvqoCG7DGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705733379; c=relaxed/simple;
	bh=VwK6OtlxT/WLY3BZmo4K9C/ZH8hQX7yEjr/FamD7lrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrWToPt1Opc35E4MOjHzBMKz3v2D64MNYrnWgu6/8ANIF8Rt2ygM7rxO1QVCbwzSOwReMUMrcCdpT9BVzuIXRZo5ObVBXNaT9xFkg8oS08lf7OqeFweZ8PsaogFZs/ukUhYwXXbnqu5irtmI368WCEov6FIalmudF9/2za4GdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sc3g52yh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d70696b6faso12919845ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 22:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705733377; x=1706338177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMNq17q3D6EGfQkVBOfkiQr/f5qkK8wzXeUaA36zW64=;
        b=sc3g52yh0WW0+74h7S4baN49pQmeI2cFIV6SjVHrs8jt4NTZ2dhJFXFICBT+m3Pyzf
         KQEXV3KVzuqzTcDWpmKjTjg+pU8eciHfp2eq8NccptCD36I/VMaORH9U4yGNg/NeRYTQ
         N1JdpgjgFtdah0o4e5FkkgQVbqNXFYRli2LaQX8qqsJN0+wiCCpnfy461oJlAeVxFQWN
         VdCiitcrHSSjRygvP1ELhYpqTuPlOYQRTgN5+KN0xY8A0gUclVGLR4d8udslXEYZot51
         WEXyrPJOQnNvtIlE57pN1JQFI401F4RSGqUlHjLG/y+pFJRSxE71UA2ZHF8QkgsEHCUx
         D6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705733377; x=1706338177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMNq17q3D6EGfQkVBOfkiQr/f5qkK8wzXeUaA36zW64=;
        b=QPau23TeL/p7dcHH/TLDB5wO1aYWqFuKr7JgJ6NF8lzmL7KcFnCpwBUmeS+zblvKWM
         xIMf+Wh15v9MSVOatrI7RUthTW270Mm924Li6obfc/9jjQ/6fQ5RLdfk/4Mvhdjl5xsj
         ic4n+2ohQVGkH84NtZ9xU4sYMLUPYiCGGadzkwl6onkl3yEl3480n7d0Ral+ttpD5a5X
         8MNHKvq0F/aEY4EGtdUrG3lH1uPvOvtMxmx4y/v1SrkLw4dYAimaYTISVsCxx6hEMr0C
         8rsGyjO86fgnBUpnibHQcMPoH3WXftVj6oAx+cfiCxNv5rONo2LaSebD3CpVJ4KCYm1d
         +oyQ==
X-Gm-Message-State: AOJu0Yyk5u8llNl2dsLtsV+S33iEBbh/PZSVV/vyKIqUmqmQ3NZRJbkh
	/0Kt9mnoJLngXGvOJc9nZjkyyX5l6CuUYdMVzgtaP1r/c4AVyz9fQ9w7x7Qt1Q4=
X-Google-Smtp-Source: AGHT+IHuiDuKFM2UR73CaJ02HXo9ean1HBHrvYu61hM8hW45PnG18N9ghGARYqYc2iZy9dYx7vea7Q==
X-Received: by 2002:a17:903:2304:b0:1d5:231b:6ea3 with SMTP id d4-20020a170903230400b001d5231b6ea3mr1323587plh.16.1705733377493;
        Fri, 19 Jan 2024 22:49:37 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:9c37:413:ae5:27a4])
        by smtp.gmail.com with ESMTPSA id y11-20020a170903010b00b001d706bb2711sm3790425plc.22.2024.01.19.22.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 22:49:36 -0800 (PST)
Date: Fri, 19 Jan 2024 22:49:33 -0800
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
Message-ID: <Zats/W/oiaphdWTv@ghost>
References: <20230809232218.849726-1-charlie@rivosinc.com>
 <tencent_F9568C6D8872E30EDFAF20ADF686A31D6E06@qq.com>
 <ZasjJ3HPUVuxr2oG@ghost>
 <tencent_FE461EBE274178ED6047005CCF98D710B807@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FE461EBE274178ED6047005CCF98D710B807@qq.com>

On Sat, Jan 20, 2024 at 02:13:14PM +0800, Yangyu Chen wrote:
> Thanks for your reply.
> 
> On 1/20/24 09:34, Charlie Jenkins wrote:
> > On Sun, Jan 14, 2024 at 01:26:57AM +0800, Yangyu Chen wrote:
> > > Hi, Charlie
> > > 
> > > Although this patchset has been merged I still have some questions about
> > > this patchset. Because it breaks regular mmap if address >= 38 bits on
> > > sv48 / sv57 capable systems like qemu. For example, If a userspace program
> > > wants to mmap an anonymous page to addr=(1<<45) on an sv48 capable system,
> > > it will fail and kernel will mmaped to another sv39 address since it does
> > 
> > Thank you for raising this concern. To make sure I am understanding
> > correctly, you are passing a hint address of (1<<45) and expecting mmap
> > to return 1<<45 and if it returns a different address you are describing
> > mmap as failing? If you want an address that is in the sv48 space you
> > can pass in an address that is greater than 1<<47.
> > 
> > > not meet the requirement to use sv48 as you wrote:
> > > 
> > > > 	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > > > 		mmap_end = VA_USER_SV48;			\
> > > > 	else							\
> > > > 		mmap_end = VA_USER_SV39;			\
> > > 
> > > Then, How can a userspace program create a mmap with a hint if the address
> > > > = (1<<38) after your patch without MAP_FIXED? The only way to do this is
> > > to pass a hint >= (1<<47) on mmap syscall then kernel will return a random
> > > address in sv48 address space but the hint address gets lost. I think this
> > 
> > In order to force mmap to return the address provided you must use
> > MAP_FIXED. Otherwise, the address is a "hint" and has no guarantees. The
> > hint address on riscv is used to mean "don't give me an address that
> > uses more bits than this". This behavior is not unique to riscv, arm64
> > and powerpc use a similar scheme. In arch/arm64/include/asm/processor.h
> > there is the following code:
> > 
> > #define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
> > 					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
> > 					base)
> > 
> > arm64/powerpc are only concerned with a single boundary so the code is simpler.
> > 
> 
> As you say, this code in arm64/powerpc will not meet the issue I address.
> For example, If the addr here is (1<<50) on arm64, the arch_get_mmap_base
> will return base+TASK_SIZE-DEFAULT_MAP_WINDOW which is (1<<vabits_actual).
> And this behavior on arm64/powerpc/x86 does not break anything since we will
> use a larger address space if the hint address is specified on the address >
> DEFAULT_MAP_WINDOW. The corresponding behavior on RISC-V should be if the
> hint address > BIT(47) then use Sv57 address space and use Sv48 when the
> hint address > BIT(38) if we want Sv39 by default.
> 
> However, your patch needs the address >= BIT(47) rather than BIT(38) to use
> Sv48 and address >= BIT(56) to use Sv57, thus breaking existing userspace
> software to create mapping on the hint address without MAP_FIXED set.

Code that needs mmap to provide a specific address must use MAP_FIXED.
On riscv, it was decided that the address returned from mmap cannot be
greater than the hint address. This is currently implemented by using
the largest address space that can fit into the hint address. It may be
possible that this range can be extended to use all of the addresses
that are less than or equal to the hint address.

From reading the code even on arm64 if you pass an address that is
greater than DEFAULT_MAP_WINDOW it is not guaranteed that mmap will
return an address that is greater than DEFAULT_MAP_WINDOW. It may still
be provide an address that is less than DEFAULT_MAP_WINDOW if it fails
to find an address above. This seems like this would also break your use
case.

> 
> > > violate the principle of mmap syscall as kernel should take the hint and
> > > attempt to create the mapping there.
> > 
> > Although the man page for mmap does say "on Linux, the kernel will pick
> > a nearby page boundary" it is still a hint address so there is no strict
> > requirement (and the precedent has already been set by arm64/powerpc).
> > 
> 
> Yeah. There is no strict requirement. But currently x86/arm64/powerpc works
> in this situation well. The hint address on these ISAs is not used as the
> upper bound to allocating the address. However, on RISC-V, you treat this as
> the upper bound.
> 
> > > 
> > > I don't think patching in this way is right. However, if we only revert
> > > this patch, some programs relying on mmap to return address with effective
> > > bits <= 48 will still be an issue and it might expand to other ISAs if
> > > they implement larger virtual address space like RISC-V sv57. A better way
> > > to solve this might be adding a MAP_48BIT flag to mmap like MAP_32BIT has
> > > been introduced for decades.
> > > 
> > > Thanks,
> > > Yangyu Chen
> > > 
> > 
> > - Charlie
> > 
> 

