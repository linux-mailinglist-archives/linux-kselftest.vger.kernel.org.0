Return-Path: <linux-kselftest+bounces-26809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A731A38DF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5153A1370
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C623906A;
	Mon, 17 Feb 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rQ7v/zQe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF322B8A1;
	Mon, 17 Feb 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827601; cv=none; b=hYpZMCCWcS5Z/24fe8GKVO2XhUeB714+wlzuVN7qEfXJuYwfyGV5Ix0L7UmrWrdlh1gR+w0qgGbQviOXvlTY6DTsYHUmZaoBijmTs7C4382DHbZtlECYRVmqTDHFZPeMRfS/lJfLR/k0nLthbBrcVL+w1m6AJfUUrPfNAw3Ldeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827601; c=relaxed/simple;
	bh=NgF5paxrgLRrg9NYUhM6TowTgot513H1RwgVrlHOVbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWFg4v3wB6vkajpVBX0FMHjjN8SNwGCUhie0+Aw9D0dbXjBCArjw8TiylFLKZOsyXIsPwzPEprg2NS0X4lR4dzgeYxKUjzH35JRzoAlTz3mHzWJj60ygkt4sc+Kf53DWtzRi2jfSZJ1ocmBWsBcLUB1g5uSDp914kQlpg20vGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rQ7v/zQe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739827594;
	bh=NgF5paxrgLRrg9NYUhM6TowTgot513H1RwgVrlHOVbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQ7v/zQeYJxeocL7W2DbevTBCOSNTFJFXnNEAlBjI97ii+by4uG1mtx7Jvlf1SRLJ
	 5xZNNgDTi7kmVHT2wpV191QhLOHvkXK0nWDruXUT5IxiJQ0Byjp2Qq/ELAqMRtVbUv
	 Tso21ZNPT6gNsRTmZIbUclHA1EWXUkMO1ApmmAuA=
Date: Mon, 17 Feb 2025 22:26:33 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tools/nolibc: add support for N64 and N32 ABIs
Message-ID: <9a3f5971-38ff-4d2f-991d-1d0740380d37@t-8ch.de>
References: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net>
 <20250216094938.GB2192@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250216094938.GB2192@1wt.eu>

On 2025-02-16 10:49:38+0100, Willy Tarreau wrote:
> On Wed, Feb 12, 2025 at 07:49:53PM +0100, Thomas Weißschuh wrote:
> > +#if defined(_ABIO32)
> > +
> >  #define _NOLIBC_SYSCALL_CLOBBERLIST \
> >  	"memory", "cc", "at", "v1", "hi", "lo", \
> >  	"t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
> > +#define _NOLIBC_SYSCALL_STACK_RESERVE "addiu $sp, $sp, -32\n"
> > +#define _NOLIBC_SYSCALL_STACK_UNRESERVE "addiu $sp, $sp, 32\n"
> > +
> > +#elif defined(_ABIN32) || defined(_ABI64)
> > +
> > +/* binutils, GCC and clang disagree about register aliases, use numbers instead. */
> 
> Is this often encountered despite this ? I guess it can cause portability
> issues :-/

No idea. It's the first time I saw something like this.

> > +#if defined(_ABIO32)
> > +
> >  #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
> >  ({                                                                            \
> >  	register long _num __asm__ ("v0") = (num);                            \
> (...)
> > @@ -178,6 +201,50 @@
> >  	_arg4 ? -_num : _num;                                                 \
> >  })
> >  
> > +#else
> > +
> 
> Here you should indicate which ABI is covered by this #else, because one
> has to go up to previous definitions to figure it's _ABIN32 and _ABI64.

Ack.

> > +#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
> > +({                                                                            \
> > +	register long _num __asm__ ("v0") = (num);                            \
> > +	register long _arg1 __asm__ ("$4") = (long)(arg1);                    \
> > +	register long _arg2 __asm__ ("$5") = (long)(arg2);                    \
> > +	register long _arg3 __asm__ ("$6") = (long)(arg3);                    \
> > +	register long _arg4 __asm__ ("$7") = (long)(arg4);                    \
> > +	register long _arg5 __asm__ ("$8") = (long)(arg5);                    \
> (...)
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
> 
> So same here. I think you should do it for all #else since you're generally
> grouping 2 ABIs vs one between a #if and a #else and it's not trivial to
> figure what a #else covers, like below.

Ack.

> > +		"daddiu $sp, $sp, -8\n"  /* space for .cprestore to store $gp              */
> > +		".cpsetup $ra, 0, 1b\n"
> > +		"li    $t0, -16\n"
> > +		"and   $sp, $sp, $t0\n"  /* $sp must be 16-byte aligned                    */
> > +#endif
> > +
> > +		/* ABI requires current function address in $t9 */
> > +#if defined(_ABIO32) || defined(_ABIN32)
> > +		"lui $t9, %hi(_start_c)\n"
> >  		"ori $t9, %lo(_start_c)\n"
> > +#else
> 
> This one indeed covers only _ABI64

(That is intentional)

> > +		"lui  $t9, %highest(_start_c)\n"
> > +		"ori  $t9, %higher(_start_c)\n"
> > +		"dsll $t9, 0x10\n"
> > +		"ori  $t9, %hi(_start_c)\n"
> > +		"dsll $t9, 0x10\n"
> > +		"ori  $t9, %lo(_start_c)\n"
> > +#endif
> 
> With the tiny details above, this looks fine. It's great that syscall
> numbers didn't change so that you can cover an extra arch with only a
> few ifdefs. I have not tested but I guess you did :-) So that's OK for
> me:

The syscall numbers are different, but the UAPI headers also detect the
ABI in use and select the correct numbers.

> Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!

