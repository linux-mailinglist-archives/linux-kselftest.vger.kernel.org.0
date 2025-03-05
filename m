Return-Path: <linux-kselftest+bounces-28292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE0A4F86A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 09:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D323ACAED
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F51F866B;
	Wed,  5 Mar 2025 08:04:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101932E3360;
	Wed,  5 Mar 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161862; cv=none; b=tpmbd0SkNB5YJmnuKxTYIyLAEvCs3GmLSvJyFJxqNReggoRMEc516m8yTyI4ROMUM+IFD76qEf59+D9Wg3MstvUaokSdAPPrmnC02VPyhEum1004dZJQ21P+AK+50n/0zjVqeebBOtIyHBr/EYIHZGnwWHcTSNzSRoqFOf7xP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161862; c=relaxed/simple;
	bh=Q2nnXUKl8Z4spfoGAAq9DNPX1HlSRRUJ7kgG6D2P78g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5XD7bw3S0uOTDLXwcR8dqmq5hegMQ36G8pmualWm/l69SFfHP1LBAWYlIYcGgnVnKOZusX/FNZOiYD87krhc9ncBVkcwvwHrEuOF9nfYaQoWr7/S+HjwsVkq+L+z6w+xRc3jx++sHTduxG2h/nkaKCZJjxTEAkCqm+GWiNkAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 52583m8n015896;
	Wed, 5 Mar 2025 09:03:48 +0100
Date: Wed, 5 Mar 2025 09:03:48 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 24/32] tools/nolibc: add getopt()
Message-ID: <20250305080348.GA15844@1wt.eu>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-24-adca7cd231e2@linutronix.de>
 <20250304075429.GB9911@1wt.eu>
 <20250305081713-94bcf231-26a2-40fd-b54d-e0cc0251e521@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305081713-94bcf231-26a2-40fd-b54d-e0cc0251e521@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Mar 05, 2025 at 08:25:14AM +0100, Thomas Weiﬂschuh wrote:
> On Tue, Mar 04, 2025 at 08:54:29AM +0100, Willy Tarreau wrote:
> > On Tue, Mar 04, 2025 at 08:10:54AM +0100, Thomas Weiﬂschuh wrote:
> > > diff --git a/tools/include/nolibc/getopt.h b/tools/include/nolibc/getopt.h
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..35aee582681b79e21bce8ddbf634ae9dfdef8f1d
> > > --- /dev/null
> > > +++ b/tools/include/nolibc/getopt.h
> > > @@ -0,0 +1,105 @@
> > > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > > +/*
> > > + * getopt function definitions for NOLIBC, adapted from musl libc
> > > + * Copyright (C) 2005-2020 Rich Felker, et al.
> > > + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> > > + */
> > > +
> > > +#ifndef _NOLIBC_GETOPT_H
> > > +#define _NOLIBC_GETOPT_H
> > > +
> > > +struct FILE;
> > > +static struct FILE *const stderr;
> > > +static int fprintf(struct FILE *stream, const char *fmt, ...);
> > 
> > Is there a particular reason why you had to define these here
> > and include nolibc.h at the bottom instead of doing it the usual
> > way with the include at the top ?
> > 
> > If that's due to a limitation in nolibc, we might want to have a
> > closer look at it before it starts to affect other areas. Also if
> > in the future we have to add some str* dependencies here, it would
> > be easier if we can simply include the file as well.
> 
> Doing a regular #include "stdio.h" does fail with the following error:
> 
> In file included from sysroot/i386/include/nolibc.h:109,
>                  from sysroot/i386/include/errno.h:26,
>                  from sysroot/i386/include/stdio.h:12,
>                  from harness-selftest.c:3,
>                  from nolibc-test.c:5:
> sysroot/i386/include/getopt.h: In function 'getopt':
> sysroot/i386/include/getopt.h:72:25: error: implicit declaration of function 'fprintf' [-Werror=implicit-function-declaration]
>    72 |                         fprintf(stderr, "%s: unrecognized option: %c\n", argv[0], *optchar);
>       |                         ^~~~~~~
> [+ some followup errors]
> 
> The include chain is important here.
> The user code includes "stdio.h", which at the very beginning includes
> errno.h->nolibc.h->getopt.h. Now getopt.h tries to use the definitions from
> stdio.h. However as stdio.h was the entrypoint and is not yet fully parsed,
> these definitions are not yet available.

OK got it, the usual includes dependency mess when it comes to inline
code (here it's static but it's the same) :-(

In the early days I had thought about placing everything in to nolibc.h
and making the standard include files just stubs that would include it,
but I didn't pursue that direction since I had not reached the point of
the problems.

Maybe for the long term we'll have to reopen that reflexion. We could
even have:

  nolibc.h:
     #include "nolibc-types.h"
     #include "nolibc-stdio.h"
     #include "nolibc-stdlib.h"
     ... etc

  and stdio.h, stdlib, etc:
     #include "nolibc.h"

That could be a clean and non-invasive change that would make sure we
always include everything we need in the desired order. If we still
end up with trouble due to some cross-references (since statics are
painful for that), then it becomes possible to have extra -proto.h
files to only declare types and prototypes, not inlines, and that
will be included first.

Let's discuss that later, thanks for explaining!
Willy

