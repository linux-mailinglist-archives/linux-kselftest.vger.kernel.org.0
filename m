Return-Path: <linux-kselftest+bounces-28181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF7A4D56D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF23A94E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F7D1F8BBC;
	Tue,  4 Mar 2025 07:54:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B103E1F8ACA;
	Tue,  4 Mar 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074879; cv=none; b=K4PUpfnWN5y+T5vs5xvdy/JPwRgWEPFaQo4hIffivkvhGs6uhXw0cXG5lgdwPvZkzm0r9d11c0lgu7b3GUC6tE2nvDw772awMvCSa1t0oo3ZSCZThUtxInrPgDXFqfVTgxIT8/T66R+MOwJwWIHsQBC3BXQYib6EEZs2JYVZTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074879; c=relaxed/simple;
	bh=Roo7xrvcGrNLyH1JXHOSdKv66yxlKiNWaN+vDxEMdt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcJCWtxYiv9zEyP3Lr03c5brlU1BNJfi3szV6MBcd6DkufpOAt55wrV7AQHn9ZYM+wAfbGL1q9vh/GzxsmpNTJA0h96UQac7F/D6HQfxyX0uYSvu1ojYl8Ktxy5yPYCEu37pIUynrJD3vxZVcjpl3wFgvJvt+s7tuX8/90l9yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5247sTGp010186;
	Tue, 4 Mar 2025 08:54:29 +0100
Date: Tue, 4 Mar 2025 08:54:29 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 24/32] tools/nolibc: add getopt()
Message-ID: <20250304075429.GB9911@1wt.eu>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-24-adca7cd231e2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-24-adca7cd231e2@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 04, 2025 at 08:10:54AM +0100, Thomas Weiﬂschuh wrote:
> diff --git a/tools/include/nolibc/getopt.h b/tools/include/nolibc/getopt.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..35aee582681b79e21bce8ddbf634ae9dfdef8f1d
> --- /dev/null
> +++ b/tools/include/nolibc/getopt.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * getopt function definitions for NOLIBC, adapted from musl libc
> + * Copyright (C) 2005-2020 Rich Felker, et al.
> + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> + */
> +
> +#ifndef _NOLIBC_GETOPT_H
> +#define _NOLIBC_GETOPT_H
> +
> +struct FILE;
> +static struct FILE *const stderr;
> +static int fprintf(struct FILE *stream, const char *fmt, ...);

Is there a particular reason why you had to define these here
and include nolibc.h at the bottom instead of doing it the usual
way with the include at the top ?

If that's due to a limitation in nolibc, we might want to have a
closer look at it before it starts to affect other areas. Also if
in the future we have to add some str* dependencies here, it would
be easier if we can simply include the file as well.

> +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> +char *optarg;
> +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> +int optind = 1;
> +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> +int opterr = 1;
> +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> +int optopt;
> +__attribute__((weak,unused,section(".data.nolibc_getopt")))
> +int __optpos;

I think that for better readability, you'd need to either place
them on the same line, or leave a blank line between each
declaration.

> +static __inline__
> +int getopt(int argc, char * const argv[], const char *optstring)

It would be better marked with the usual unused attribute. That's a
bit large for inlining, and I'm not convinced that the compiler will
see any opportunity for simplifying it given that it acts on a list
of actions taken from a string.

Willy

