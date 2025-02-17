Return-Path: <linux-kselftest+bounces-26813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA62A38E38
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 22:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4780A188B3AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89E1A3BD8;
	Mon, 17 Feb 2025 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ahuLmOne"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A461A23AC;
	Mon, 17 Feb 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828469; cv=none; b=l6DJxyEV5neQiOU1JDCnGzkMA5FY/Fh1Od2Hs68RRXZoo5tJK9Laz/OPEk7ON/F/1mON60LVoWCjN4ZNo8jvOR7QCn1tfyhNWFV44gHcLMvsFSlJO/YdSJb3oHZAJeSNzkpDhdEWBccp8cX5NR/hISoyyCie2YxFqxTOBAP35L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828469; c=relaxed/simple;
	bh=/s65XmxztWKhi1Q5tO0x+OCQIOkt/hyL01vMU1SMIhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Ze0k1mrMpYfRUHpJU98o21WQsw+iswvjASF/fUsHiFKkTWWTW54DLqzdPf3fzDq6uQYcOsyAz12Vzz5dh6wMLqj+SaHNyifiVnnEtEoT8oA0zS868Iatts++Z6iLyRxVkQJ7kZCGkPXzHv1knFz39Z/B/xGP1aXBa1lyatZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ahuLmOne; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739828465;
	bh=/s65XmxztWKhi1Q5tO0x+OCQIOkt/hyL01vMU1SMIhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahuLmOneHpritpLZA/wVdO1PuL3Za8f4E9XtVvyQ6qOv25L53KVRNI5sUDSlRbUDY
	 AF7JhtLzODzCIG3l7w90mJ0AcnUupVD/O+/BhxKgf2rPbZh0CGdynlZL5R4rznJWMr
	 NvSNLJ7c7RKJXnouebV1bEIM8izZmWywBNLk9Eso=
Date: Mon, 17 Feb 2025 22:41:04 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tools/nolibc: add support for N64 and N32 ABIs
Message-ID: <3080562c-7cfd-4f66-9f62-9a99552d283f@t-8ch.de>
References: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net>
 <alpine.DEB.2.21.2502161523290.65342@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2502161523290.65342@angie.orcam.me.uk>

Hi Maciej,

thanks for your feedback!

On 2025-02-16 15:41:55+0000, Maciej W. Rozycki wrote:
> On Wed, 12 Feb 2025, Thomas Weißschuh wrote:
> > diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
> > index 753a8ed2cf695f0b5eac4b5e4d317fdb383ebf93..638520a3427a985fdbd5f5a49b55853bbadeee75 100644
> > --- a/tools/include/nolibc/arch-mips.h
> > +++ b/tools/include/nolibc/arch-mips.h
> > @@ -190,13 +257,33 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
> >  		"1:\n"
> >  		".cpload $ra\n"
> >  		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
> > +
> > +#if defined(_ABIO32)
> >  		"addiu $sp, $sp, -4\n"   /* space for .cprestore to store $gp              */
> >  		".cprestore 0\n"
> >  		"li    $t0, -8\n"
> >  		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
> >  		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
> > -		"lui $t9, %hi(_start_c)\n" /* ABI requires current function address in $t9 */
> > +#else
> > +		"daddiu $sp, $sp, -8\n"  /* space for .cprestore to store $gp              */
> > +		".cpsetup $ra, 0, 1b\n"
> > +		"li    $t0, -16\n"
> > +		"and   $sp, $sp, $t0\n"  /* $sp must be 16-byte aligned                    */
> > +#endif
> 
>  Why is this code breaking stack alignment just to have to fix it up two 
> instructions down the line?  Or is it that the incoming $sp is not aligned 
> in the first place (in which case we're having a deeper problem).

nolibc itself does not assume that $sp is aligned.
Maybe Willy can explain the historical background.

The System V ABI MIPS supplement [0] says the following:

The registers listed below have the specified contents at process entry:
	...

	$sp The stack pointer holds the address of the bottom of the stack, which
	must be doubleword (8 byte) aligned.
	...

However "process entry" is main(), while this code is running before main.

The kernel always aligns the stack to a multiple of 16 bytes.
See the usage of STACK_ROUND() in fs/binfmt_elf.c.

So I guess we could remove the manual alignment.
(At least for alignments of 16 bytes and less)

> > +
> > +		/* ABI requires current function address in $t9 */
> > +#if defined(_ABIO32) || defined(_ABIN32)
> > +		"lui $t9, %hi(_start_c)\n"
> >  		"ori $t9, %lo(_start_c)\n"
> > +#else
> > +		"lui  $t9, %highest(_start_c)\n"
> > +		"ori  $t9, %higher(_start_c)\n"
> > +		"dsll $t9, 0x10\n"
> > +		"ori  $t9, %hi(_start_c)\n"
> > +		"dsll $t9, 0x10\n"
> > +		"ori  $t9, %lo(_start_c)\n"
> 
>  This could be optimised using a temporary (e.g. $at, but I guess any will 
> do as I gather we don't have any ABI abnormalities here).

clang rejects manual usage of $at without ".set noat".
So $t0 is simpler.

> > +#endif
> > +
> >  		"jalr $t9\n"             /* transfer to c runtime
> > */
> >  		" nop\n"                 /* delayed slot
> 
>  On an unrelated matter JALR above ought to be JAL (or otherwise there's 
> no point in using the .cprestore pseudo-op).  And I fail to see why this 
> code has to be "noreorder" (except for the .cpload piece, of course), it's 
> just asking for troubles.

Thanks for the hints.

Without "noreorder", is the manually addition of the delayed slot "nop"
still necessary?
These points also apply to the existing O32 implementation, right?
If so I'll make a proper series out of it.

[0] https://refspecs.linuxfoundation.org/elf/mipsabi.pdf


Thomas

