Return-Path: <linux-kselftest+bounces-29180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0404AA643E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 08:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4313ABF6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699121ABC3;
	Mon, 17 Mar 2025 07:38:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7C21B1A3;
	Mon, 17 Mar 2025 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197084; cv=none; b=bUNGtnsyIApM4q7nkTehkksEtsZuorcnlc91vPzy16TdXDm/r4E5TDgvSPNgpMh/RvKeO3Fd69jkm/s7jmVlXx9dgCc34JyHwZ0olYIjKplt7nX2zSZvk2ZjQL/C3JeCDYiM3jpXSC3nxhz2f89l+/qEYBVmTINMg46T/pg+Dxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197084; c=relaxed/simple;
	bh=t2aL2htvGvAMDKnCszETOnstB9mx4YkHpmnbiw6gEEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgdnshn1Y7LhXwoZj6+v4vXbDWPiaSMsZ/BmcF5f4LIi0+7WNaGrexx+aNIjio2t6oC/QV72LR5FdcB1aI1T6kZaoDe21V3Ir6MmK0jIys4J7jdpxnPvRFhK2aN15cTK8QY/U6VPAU+E8MKb5rrDFq0M/HTPx9kiUfZOFd9wiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 52H7bkNM005227;
	Mon, 17 Mar 2025 08:37:46 +0100
Date: Mon, 17 Mar 2025 08:37:46 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Add support for SPARC
Message-ID: <20250317073746.GB5114@1wt.eu>
References: <20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Mar 16, 2025 at 02:55:02PM +0100, Thomas Weiﬂschuh wrote:
> Add support for 32bit and 64bit SPARC to nolibc.

Oh nice!

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> This is only tested on QEMU.
> Any tests on real hardware would be very welcome.

I still have a working U60 here, but under solaris. Such machines are
not trivial to boot on alternate OSes (and when you find a working
image usually it's based on an old kernel). But I've run it under
Linux 20 years ago, so I know it was supported. I may give it a try
when I find a moment, but let's not wait for this!

A few comments below:

> diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..cb5543eca87bb4d52cfba4c0668e35cbbf6dd124
> --- /dev/null
> +++ b/tools/include/nolibc/arch-sparc.h
> @@ -0,0 +1,191 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * SPARC (32bit and 64bit) specific definitions for NOLIBC
> + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> + */
> +
> +#ifndef _NOLIBC_ARCH_SPARC_H
> +#define _NOLIBC_ARCH_SPARC_H
> +
> +#include <linux/unistd.h>
> +
> +#include "compiler.h"
> +#include "crt.h"
> +
> +/*
> + * Syscalls for SPARC:
> + *   - registers are native word size
> + *   - syscall number is passed in g1
> + *   - arguments are in o0-o5
> + *   - the system call is performed by calling a trap instruction
> + *   - syscall return value is in 0a
                                     ^^
What is "0a" here ? I suspect a typo and you meant "o0".

> +/* startup code */
> +void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
> +{
> +	__asm__ volatile (
> +		/*
> +		 * Save stack pointer to o0, as arg1 of _start_c.
> +		 * Account for window save area and stack bias.
> +		 */
> +#ifdef __arch64__
> +		"add %sp, 128 + 2047, %o0\n"

It's really unclear where this magical 2047 comes from, I think it must
be explained in the comment above so that someone disagreeing with it
later can figure whether it's right or wrong.

> +#else
> +		"add %sp, 64, %o0\n"
> +#endif

Also, I could be wrong, but from my old memories of playing with the
stack on SPARC long ago, I seem to remember that the stack is growing
down. Thus I find these "add" suspicious or at least confusing. You
mention "window save area and stack bias" above, I'm not sure what it
refers to, but if we can safely erase parts of the stack because too
much was preserved, maybe some more explanation about the initial and
target layouts is deserved here.

> +		"b,a _start_c\n"     /* transfer to c runtime */

OK great, the delayed slot is covered! (that type of thing can work
by pure luck in one test and fail in another one depending on what
bytes follow the jump).

Thanks!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

