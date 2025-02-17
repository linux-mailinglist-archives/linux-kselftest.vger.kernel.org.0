Return-Path: <linux-kselftest+bounces-26816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C9A38F93
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 00:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3892C3B24FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 23:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493071AA1F4;
	Mon, 17 Feb 2025 23:23:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3214D444;
	Mon, 17 Feb 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834602; cv=none; b=DEGlufwUnnOJ/BHlEKgsFHVQ20N3y6IFAGOATjDMYvvdnDgfEluK+/0zBrqP9V9Y8gFJ1kFcswIMk0+dA2QsPGWyOPfnMCKrn48oBKu88/daOyxpI7XAzmUOWbAvv++sNQzI0R7tZazmtqdpeasakkKxj3eoRl2suK1lNmIknGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834602; c=relaxed/simple;
	bh=ohyx9wFz5bUQOgsQJ/OchrFfpmMIXOcu8vqb+spn4xo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cpKCt2kIYCbpHhW1WCiwuoPH08k/FYVZg0DEyblehR+oq/V1MKTyPFTqhQ+9K7LAWpwaHiyBAWFNUEWgTJXTtMOGrgoJ/xEQKQlnKpVmEIWfUQUyqDAVBholACR/e/vPDc+QGny5MQMI7V/w151ml4+v+3pJaSCLDIN1lOhk3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 737F692009C; Tue, 18 Feb 2025 00:23:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6D6CC92009B;
	Mon, 17 Feb 2025 23:23:11 +0000 (GMT)
Date: Mon, 17 Feb 2025 23:23:11 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-mips@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tools/nolibc: add support for N64 and N32 ABIs
In-Reply-To: <3080562c-7cfd-4f66-9f62-9a99552d283f@t-8ch.de>
Message-ID: <alpine.DEB.2.21.2502172208570.65342@angie.orcam.me.uk>
References: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net> <alpine.DEB.2.21.2502161523290.65342@angie.orcam.me.uk> <3080562c-7cfd-4f66-9f62-9a99552d283f@t-8ch.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Thomas,

> thanks for your feedback!

 You're welcome.  Sadly little MIPS-fu seems still available nowadays and 
for me it's often too easy to miss MIPS-related topics in the mailing list 
flood.

> >  Why is this code breaking stack alignment just to have to fix it up two 
> > instructions down the line?  Or is it that the incoming $sp is not aligned 
> > in the first place (in which case we're having a deeper problem).
> 
> nolibc itself does not assume that $sp is aligned.
> Maybe Willy can explain the historical background.

 I'm all ears.

> The System V ABI MIPS supplement [0] says the following:
> 
> The registers listed below have the specified contents at process entry:
> 	...
> 
> 	$sp The stack pointer holds the address of the bottom of the stack, which
> 	must be doubleword (8 byte) aligned.
> 	...
> 
> However "process entry" is main(), while this code is running before main.

 Umm, no, process entry definitely is not main(); if you refer to the 
somewhat obsolete and inaccurate MIPS psABI, then please note that the 
paragraph right above your quote says:

$2	A non-zero value specifies a function pointer the application 
	should register with atexit(BA_OS).  If $2 contains zero, no 
	action is required.

and one immediately below it says:

$31	The return address register is set to zero so that programs that 
	search backward through stack frames (stack backtracing) recognize 
	the last stack frame, that is, a stack frame with a zero in the 
        saved $31 slot.

and there is more on the initial process stack earlier on, including the 
location of the auxiliary vector.  All it making it clear it's not main() 
this specification refers to, but the entry point from the OS kernel (then 
of course you're aware already it's o32 it talks about; n64/n32 requires 
16 bytes, but then again we only have secondary references[1][2], in this 
case for SGI IRIX).

> The kernel always aligns the stack to a multiple of 16 bytes.
> See the usage of STACK_ROUND() in fs/binfmt_elf.c.
> 
> So I guess we could remove the manual alignment.
> (At least for alignments of 16 bytes and less)

 I think they all need to go then, but then stack pointer adjustments have 
to be made in multiples of the alignment required by the psABI of course.

> > > +
> > > +		/* ABI requires current function address in $t9 */
> > > +#if defined(_ABIO32) || defined(_ABIN32)
> > > +		"lui $t9, %hi(_start_c)\n"
> > >  		"ori $t9, %lo(_start_c)\n"
> > > +#else
> > > +		"lui  $t9, %highest(_start_c)\n"
> > > +		"ori  $t9, %higher(_start_c)\n"
> > > +		"dsll $t9, 0x10\n"
> > > +		"ori  $t9, %hi(_start_c)\n"
> > > +		"dsll $t9, 0x10\n"
> > > +		"ori  $t9, %lo(_start_c)\n"
> > 
> >  This could be optimised using a temporary (e.g. $at, but I guess any will 
> > do as I gather we don't have any ABI abnormalities here).
> 
> clang rejects manual usage of $at without ".set noat".
> So $t0 is simpler.

 It's always `.set at' that's required to use $at by hand; it's been so 
long before clang was even thought of.  Or you could use LA and DLA macros 
for o32/n32 and n64 respectively for the assembler to do all this stuff 
for you in the default `.set reorder' mode (assuming that clang is not 
completely broken here).

> > > +#endif
> > > +
> > >  		"jalr $t9\n"             /* transfer to c runtime
> > > */
> > >  		" nop\n"                 /* delayed slot
> > 
> >  On an unrelated matter JALR above ought to be JAL (or otherwise there's 
> > no point in using the .cprestore pseudo-op).  And I fail to see why this 
> > code has to be "noreorder" (except for the .cpload piece, of course), it's 
> > just asking for troubles.
> 
> Thanks for the hints.
> 
> Without "noreorder", is the manually addition of the delayed slot "nop"
> still necessary?

 It's not.  It's for the `.set noreorder' mode only, to fill the branch 
delay slot by hand.  Otherwise it'll become just a useless instruction 
following the call sequence and executed after return.

> These points also apply to the existing O32 implementation, right?

 Correct.  Sadly it's the first time I see this code.

 Overall I find it a bit of a chimera: it uses `.set noreorder' and 
explicit relocations on one hand, and then high-level assembly `.cpload' 
and `.cprestore' pseudo-ops on the other, effectively mixing the two 
styles of assembly.

 The pseudo-ops come from times when using assembly macros was the norm 
and are there to support that coding model where macros rely on these 
pseudo-ops, and before the use of explicit relocations became the norm at 
least for GCC.  In the absence of assembly macros you can write code 
expansions for these pseudo-ops by hand, just as what GCC does nowadays 
(in the `-mexplicit-relocs' mode, which is usually the default).

 But due to architecture variations it's very hard to write handcoded 
assembly in the `.set noreorder' mode: you need to take care of all the 
data dependencies that appear due to the lack of interlocking between 
pipeline stages, which results in code that either works correctly 
everywhere, but is suboptimal for newer architecture revisions, or code 
that works better with newer architecture revisions, but is actually 
broken with earlier ones.

 About the only typical case where you do want to use `.set noreorder' is 
to schedule a branch delay slot by hand due to a data anti-dependency 
between the two instructions.  Patchable/self-modifying code is a less 
frequent case.  And I had literally one case in my entire career where I 
wanted to actually jump to a branch delay slot instruction (it's still 
there in arch/mips/include/asm/div64.h, in do_div64_32(); see label #2).

 Also it appears no code in this function actually relies on $gp having 
been set up, so perhaps this stuff can just be discarded in the first 
place?

References:

[1] "MIPSpro 64-Bit Porting and Transition Guide", 
    <https://irix7.com/techpubs/007-2391-006.pdf>

[2] "MIPSpro N32 ABI Handbook", 
    <https://irix7.com/techpubs/007-2816-004.pdf>

  Maciej

