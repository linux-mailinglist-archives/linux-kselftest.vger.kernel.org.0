Return-Path: <linux-kselftest+bounces-29265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA5EA65B90
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F18800A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8CA1B653C;
	Mon, 17 Mar 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o9nDdNqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B41AD403;
	Mon, 17 Mar 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233982; cv=none; b=JAcTvAxct8SXp8PErAA3lJRxtkXHw4ueFvn282BeIHK58QphXd879l6Dxbn+QRow5fDHYfSFCbxLkZQqy3ohKnK2BwVl7ulMgc2n+GCqUcRDkntpoA/8g+DTToiW0Dy9qwufWKMHUQI6AusNjZRD+f8csiedA7+W3vyJN76pnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233982; c=relaxed/simple;
	bh=4dJ0fmNkACSMmu1twEj7eQKRG9KtvltlsmMTAr0hcBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVmNG+RTKw1pwJOo6a26BnGgAXWadQjClNyXiSGIGxo3r5ty/1wB9UYclpp7GHG2Lg3a2z3wZ8/qZJXa3Om9hI9M2k9XDYZgGT+zPrtbfxiwJkE6jmguKIvqceBjmNJyLbwUJl8VZXcnLGDnp4gL6PYI702tOwUPmA0B1tgimEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o9nDdNqV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742233977;
	bh=4dJ0fmNkACSMmu1twEj7eQKRG9KtvltlsmMTAr0hcBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9nDdNqV6djaM1zcFVz93LKIG/jE02ihIqCduJuPMAAj1mixVNXP5ZPHXRH/BZW9d
	 DziCv6hmi+FoNOmwZozWDFQWsRFW4egp0R6suLNmYePSRZoSXVwPg2Gkndx6YAWYjI
	 Fjl42Fx2ovN93XoMZo4K5+y6kYr6aWTLgyhVkZnM=
Date: Mon, 17 Mar 2025 18:52:57 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Add support for SPARC
Message-ID: <dacaa712-08a8-4fd6-ad47-2226040f02aa@t-8ch.de>
References: <20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net>
 <20250317073746.GB5114@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317073746.GB5114@1wt.eu>

On 2025-03-17 08:37:46+0100, Willy Tarreau wrote:
> On Sun, Mar 16, 2025 at 02:55:02PM +0100, Thomas Weißschuh wrote:
> > Add support for 32bit and 64bit SPARC to nolibc.
> 
> Oh nice!
> 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > This is only tested on QEMU.
> > Any tests on real hardware would be very welcome.
> 
> I still have a working U60 here, but under solaris. Such machines are
> not trivial to boot on alternate OSes (and when you find a working
> image usually it's based on an old kernel).

An old kernel should be perfectly fine, no?

> But I've run it under
> Linux 20 years ago, so I know it was supported. I may give it a try
> when I find a moment, but let's not wait for this!

Thanks!

> A few comments below:
> 
> > diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..cb5543eca87bb4d52cfba4c0668e35cbbf6dd124
> > --- /dev/null
> > +++ b/tools/include/nolibc/arch-sparc.h
> > @@ -0,0 +1,191 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * SPARC (32bit and 64bit) specific definitions for NOLIBC
> > + * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
> > + */
> > +
> > +#ifndef _NOLIBC_ARCH_SPARC_H
> > +#define _NOLIBC_ARCH_SPARC_H
> > +
> > +#include <linux/unistd.h>
> > +
> > +#include "compiler.h"
> > +#include "crt.h"
> > +
> > +/*
> > + * Syscalls for SPARC:
> > + *   - registers are native word size
> > + *   - syscall number is passed in g1
> > + *   - arguments are in o0-o5
> > + *   - the system call is performed by calling a trap instruction
> > + *   - syscall return value is in 0a
>                                      ^^
> What is "0a" here ? I suspect a typo and you meant "o0".

Correct, will fix.

> > +/* startup code */
> > +void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
> > +{
> > +	__asm__ volatile (
> > +		/*
> > +		 * Save stack pointer to o0, as arg1 of _start_c.
> > +		 * Account for window save area and stack bias.
> > +		 */
> > +#ifdef __arch64__
> > +		"add %sp, 128 + 2047, %o0\n"
> 
> It's really unclear where this magical 2047 comes from, I think it must
> be explained in the comment above so that someone disagreeing with it
> later can figure whether it's right or wrong.

128 is the context window and 2047 is the stack bias.
I'll try to make it clearer.

> 
> > +#else
> > +		"add %sp, 64, %o0\n"
> > +#endif
> 
> Also, I could be wrong, but from my old memories of playing with the
> stack on SPARC long ago, I seem to remember that the stack is growing
> down. Thus I find these "add" suspicious or at least confusing. You
> mention "window save area and stack bias" above, I'm not sure what it
> refers to, but if we can safely erase parts of the stack because too
> much was preserved, maybe some more explanation about the initial and
> target layouts is deserved here.

There is a graphic in the psABI [0] under "Process Stack and Registers".
I'll write something based on that.

> > +		"b,a _start_c\n"     /* transfer to c runtime */
> 
> OK great, the delayed slot is covered! (that type of thing can work
> by pure luck in one test and fail in another one depending on what
> bytes follow the jump).

Yeah, it brings memories to the work on MIPS support.

> Thanks!
> 
> Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!

[0] https://uclibc.org/docs/psABI-sparc.pdf

