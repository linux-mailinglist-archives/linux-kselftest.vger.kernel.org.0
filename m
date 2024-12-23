Return-Path: <linux-kselftest+bounces-23732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBBA9FAB78
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 09:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616CB165CE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11F191F66;
	Mon, 23 Dec 2024 08:13:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E4190049;
	Mon, 23 Dec 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734941632; cv=none; b=Fbgn02oK6WGReDj8F81b8AQUY5AR80FZJY03O195iYIcc6GHHX4iUvE8hy2MTzlZySr648FzB4XNpOSuE31cG7kBxK9EEcm9yPwooORq8Mw4xe2IazAHc4Z2k3nKdIS89KHZ01k/kJvp3SOJuV4hHBDlVHHbU/d+Dookl1ETs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734941632; c=relaxed/simple;
	bh=IsttWfVW1c0p+Dr1yvKdNwWVEmah8ceYV0ISgea8gGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD2zmgZCmPMyXyczjZzzesF7aUteJVbs9ubNbQVKzUntXxiaQeCobuS57XwQ9zu/fqiLBWOo8+317Gxdh1DB6i8sScs5TedDr3ARPkX/S5j9bbzq4OMxf5PcvhscvuxXmAzTZnckz5w8pMzc0aAJxf8vnquqiQi9mImTHZUHdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4BN8DJbb003891;
	Mon, 23 Dec 2024 09:13:19 +0100
Date: Mon, 23 Dec 2024 09:13:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 1/6] tools/nolibc: add support for waitid()
Message-ID: <20241223081319.GA3840@1wt.eu>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
 <20241221-nolibc-rv32-v1-1-d9ef6dab7c63@weissschuh.net>
 <20241221163540.GA11984@1wt.eu>
 <732f202e-c0de-493e-adec-59fe069b17c9@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <732f202e-c0de-493e-adec-59fe069b17c9@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas!

On Sun, Dec 22, 2024 at 12:39:01PM +0100, Thomas Weißschuh wrote:
> > Maybe it will be time for us to run an overall audit of arch-dependent
> > syscalls we currently have, to make sure that the common ones continue
> > to work fine there (and waitpid() definitely is as common a syscall as
> > open() since it's the good old and portable one).
> 
> Isn't this what nolibc-test is already doing?

My concern is that it might be progressively going away from this if
we replace some standard syscalls with new ones that are cross-arch.

> Or do you also want to compare it to non-current kernel versions?

I mean that we progressively replace old posix calls with new cross arch
ones in the system (e.g. open->openat, waitpid->waitid etc) and normally
it's a libc's role to preserve application-level compatibility by
maintaining the mapping between standard ones and specific ones so that
applications relying on standard ones continue to work, and that was one
of the original goals of nolibc.

I have nothing against missing some calls in newly added architectures,
of course, but when I'm seeing for example that we switch some of the
lower layer tests to use a pipe because some call was not present, I
tend to think that maybe we should first define what is the minimal set
of working syscalls that the nolibc-test program requires to be usable
on any arch.

In the current case, we seem to have to arbiter between pipe() and
lseek() support for basic nolibc-test support. But maybe a new arch will
be added for which it will be the opposite choice between the two. We
may very well require both of them to work if needed, or either, at the
risk of delaying support of a specific arch in the future, but that's
fine.

Second we should have a new look at all our supported calls and check if
some of them are present while the legacy calls they're supposed to
replace is missing (which would be perfectly possible). For example if
we had implemented waitpid() much later, it would have been perfectly
possible that we'd only implement waitid() and miss waitpid() that
applications expect.

Honestly it's not a particularly interesting job to do. That's why I'm
mostly saying that we should just keep that in mind to be careful with
new additions.

> In general the special rv32 syscalls are not really
> architecture-dependent, they just dropped the "legacy" ones, especially
> all using 32bit timestamps.

I understand, and when adding a new arch we need to start with something.
I just think that we should consider that for a new arch to switch from
"in progress" to "working", it would require the legacy ones working on
other archs to work on that one as well. My concern is that early boot
tools would only build on certain archs but not all when all of them are
supposed to be in a working state. When it fails everywhere that's fine,
it just means we're missing some calls and the user is welcome to submit
a patch. But when the user only tests on, say, x86 and arm, and someone
relies on that to package kernels and discovers late that it fails on
riscv for example, that's a problem. Note that I'm just making up examples,
and not designating any particular issue.

Maybe it would be convenient to maintain a support matrix for the syscalls
we currently support. It could look something like:

   waitpid()   x86: native
               arm: native
               riscv32: via waitid()
               foobar: not yet

   open()      ...

etc. I could try to work on such a thing if you're interested as well, but
not now as I don't have the time at the moment.

Cheers,
Willy

