Return-Path: <linux-kselftest+bounces-28291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8500A4F7D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 08:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E6167905
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740431EA7C3;
	Wed,  5 Mar 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iieZ0Pq6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WvM/2IBZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65E84D08;
	Wed,  5 Mar 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159519; cv=none; b=CPvKzT84iUwtAId3viayz2RZGW/beyiAV3giTF5FcsPla6XacWKoh9fL3F2DLq+pl6cfjxvvV0ksIt6i51voWKUSkdqAifZWrqn+I4ffbeZ4/tV0yJ78B5pBeO0P1w14nWxigCAZcspbIIOikjJlP4alub9WR6pHG0qHr5W6Xb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159519; c=relaxed/simple;
	bh=Ce12eCJqtp7G0z3ZLIVdAta+74a1lkNWXI/HxhS566M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7rgD6hpRBjMRmzVReE2amkCKcLC/56WfuNm4nIB3XWFNq3oS/cMudRWoDIeG4W5wdN0qCUVlEkfETfeNv2KI8wc1cC/If/kdFZ8QcjuNuI1H0qbfRwB/6kxng5SUR3o547PuVaB8QV6g+VNpgBxijKJXFt+1F1QqF7iO5H0f4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iieZ0Pq6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WvM/2IBZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 08:25:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741159515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSg7BUAyTPsa5G5rGu81F0w65tdR3Cr9oXCjQAgwjJU=;
	b=iieZ0Pq6uEdEhJhR9FALsZz01e/b9JXWW7SvRjRekGV3F1GaExuyg9FTF2lufvWB/h/kFU
	QHG1h0R7U7CzNoPVllOp9+fIibuDksFXNVJlKMP8+E/2GiH8NRJu7bnbIIsUcAoXo8OdWG
	FDAzn6AVM12WQlZFOeopwY2mdMNV9fUETlq4jxmTPNSRWDCyQIJ9UB/zNghpr2KM3hyGnH
	+AKyf1YvbDloFbM2S/Wxrxx0rJv6fhEmsov/axsMfSOmAd6zdR2Gt29cYDUTmall1rrW17
	4m/gKRtxz9DW0a82SLZMpIlaBqd04XhOMkyVW9cBB5FO8Xew9TTraz+ELUSSHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741159515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSg7BUAyTPsa5G5rGu81F0w65tdR3Cr9oXCjQAgwjJU=;
	b=WvM/2IBZUaySpaXEjNQ2jgf5LXP183VoC/0B3niTU0otd772I/kYYhg03FeT1NmkeoTh19
	BtonpBUAm9XdvyBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 24/32] tools/nolibc: add getopt()
Message-ID: <20250305081713-94bcf231-26a2-40fd-b54d-e0cc0251e521@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-24-adca7cd231e2@linutronix.de>
 <20250304075429.GB9911@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304075429.GB9911@1wt.eu>

On Tue, Mar 04, 2025 at 08:54:29AM +0100, Willy Tarreau wrote:
> On Tue, Mar 04, 2025 at 08:10:54AM +0100, Thomas Weiﬂschuh wrote:
> > diff --git a/tools/include/nolibc/getopt.h b/tools/include/nolibc/getopt.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..35aee582681b79e21bce8ddbf634ae9dfdef8f1d
> > --- /dev/null
> > +++ b/tools/include/nolibc/getopt.h
> > @@ -0,0 +1,105 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * getopt function definitions for NOLIBC, adapted from musl libc
> > + * Copyright (C) 2005-2020 Rich Felker, et al.
> > + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> > + */
> > +
> > +#ifndef _NOLIBC_GETOPT_H
> > +#define _NOLIBC_GETOPT_H
> > +
> > +struct FILE;
> > +static struct FILE *const stderr;
> > +static int fprintf(struct FILE *stream, const char *fmt, ...);
> 
> Is there a particular reason why you had to define these here
> and include nolibc.h at the bottom instead of doing it the usual
> way with the include at the top ?
> 
> If that's due to a limitation in nolibc, we might want to have a
> closer look at it before it starts to affect other areas. Also if
> in the future we have to add some str* dependencies here, it would
> be easier if we can simply include the file as well.

Doing a regular #include "stdio.h" does fail with the following error:

In file included from sysroot/i386/include/nolibc.h:109,
                 from sysroot/i386/include/errno.h:26,
                 from sysroot/i386/include/stdio.h:12,
                 from harness-selftest.c:3,
                 from nolibc-test.c:5:
sysroot/i386/include/getopt.h: In function 'getopt':
sysroot/i386/include/getopt.h:72:25: error: implicit declaration of function 'fprintf' [-Werror=implicit-function-declaration]
   72 |                         fprintf(stderr, "%s: unrecognized option: %c\n", argv[0], *optchar);
      |                         ^~~~~~~
[+ some followup errors]

The include chain is important here.
The user code includes "stdio.h", which at the very beginning includes
errno.h->nolibc.h->getopt.h. Now getopt.h tries to use the definitions from
stdio.h. However as stdio.h was the entrypoint and is not yet fully parsed,
these definitions are not yet available.

> > +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> > +char *optarg;
> > +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> > +int optind = 1;
> > +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> > +int opterr = 1;
> > +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> > +int optopt;
> > +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> > +int __optpos;
> 
> I think that for better readability, you'd need to either place
> them on the same line, or leave a blank line between each
> declaration.

Ack.

> > +static __inline__
> > +int getopt(int argc, char * const argv[], const char *optstring)
> 
> It would be better marked with the usual unused attribute. That's a
> bit large for inlining, and I'm not convinced that the compiler will
> see any opportunity for simplifying it given that it acts on a list
> of actions taken from a string.

Ack.

