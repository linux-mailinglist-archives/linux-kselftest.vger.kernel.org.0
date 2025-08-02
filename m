Return-Path: <linux-kselftest+bounces-38219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EF2B18E35
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1777617EED0
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E28202C3E;
	Sat,  2 Aug 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cvuJfUik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8A1F4174
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754133982; cv=none; b=RJOVkfSgVIPfHZbWxf+qRGPYtv5BMsv/OokJiaHZZ8Z+QnXk1oyXK4r+otnGWYLEu0I1cIOlrqRWSCzxo5vPc1CDRMxisH0P8Fd/JNbn2lkrkd0EUkEGizQQLu8Oqg7TXAUYSXV8LHFTNOLu0SU97RSUzr0jcgVngq74HeK2TSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754133982; c=relaxed/simple;
	bh=pTpUwIMtvy3KygmFUBopuAMTObXl6d7h7Dj1lNhQdBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzQzUpRvoQ6cQ4t1+2GnIIbvk8Kk4U/yvHWELQGN/98ydyroVN5lUZnF5suJvDwnA6iWvC5T2n5LxwW/icDkMsVmhiRpb07OPXOEX9xrv5CEbAQhC5eCbd7ViwF1NlZPXKDjZPlNmsPPcwpvnqZBZ/4xMq64qSwpnVes1kYic4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cvuJfUik; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754133972;
	bh=pTpUwIMtvy3KygmFUBopuAMTObXl6d7h7Dj1lNhQdBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvuJfUikBQj1ato9zJSXZYxJEy0oCpd1IfdsH/dwIRy0P7xLElcGnQhdd9185i0Nb
	 oqvDx9hul3vcmz9/XbHVKv3WF+2YrURQMWISeuetlH3SiheSQ+hsPPxhEUBZYqr6TO
	 jTvw2cr5HfWgIhE9IInoCQ3sZOXXszRzpfIspuo0=
Date: Sat, 2 Aug 2025 13:26:11 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Berg, Benjamin" <benjamin.berg@intel.com>
Cc: "w@1wt.eu" <w@1wt.eu>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] tools/nolibc: add signal support
Message-ID: <ef70e7c7-15e0-4de6-9100-f6b70bb4010e@t-8ch.de>
References: <20250731201225.323254-1-benjamin@sipsolutions.net>
 <20250731201225.323254-5-benjamin@sipsolutions.net>
 <fbd9add3-dd99-4deb-979d-79ecfdae2f6c@t-8ch.de>
 <bae0c68a9cb24aa5d16f0df74959207ea4385c66.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bae0c68a9cb24aa5d16f0df74959207ea4385c66.camel@intel.com>

Note: Please also Cc the patches to LKML in the future.

On 2025-08-02 10:26:34+0000, Berg, Benjamin wrote:
> On Fri, 2025-08-01 at 17:09 +0200, Thomas Weißschuh wrote:
> > On 2025-07-31 22:12:25+0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > Add support for sigaction() using the rt_sigaction syscall and implement
> > > the normal sa_mask helpers.
> > > 
> > > For the uapi definitions, everything is copied into nolibc. This avoids
> > > issues with kernel architecture headers that are not usable with the
> > > rt_sigaction syscall.
> > > 
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > ---
> > > 
> > > v3:
> > > - put everything into signal.h and the new asm-signal.h
> > 
> > Hm, did we decide on that? We don't want the per-architecture include
> > dance, but static overrides should still be fine I think.
> > Keeping the architecture ifdeffery inside the respective arch header.
> > And all the generic stuff in a shared header.
> 
> I probably just didn't really understand what you meant :-)
> 
> You are right, we can have the common definitions in signal.h and just
> skip them if the architecture header did already define them.

Sounds good to me.

> I think I'll also drop asm-signal.h again, see below.
> 
> > > - split out sigset_t tests
> > > - actually mark signal_check static
> > > - remove unused string.h include
> > > - fix SIGUSR2 reset
> > > - Use integer for signal_check as the signals are emitted from the
> > >   syscall context.
> > 
> > I don't understand this point, isn't it a signal handler?
> 
> My reasoning is, that the signal emission by the kernel happens from
> the kill syscall or function return. Both cases implicitly act as a
> memory barrier. So in this specific case we do not actually need an
> atomic variable.

Ok. Given that the code is doing a read-modify-write, the guarantees of
sig_atomic_t are probably not enough anyways.
What about volatile?

> > > v2:
> > > - Use newly added macros to check signal emission order
> > > - Add tests for sigset handling
> > > - Restore the default handler after signal test
> > > - make signal_check variable static
> > > 
> > > v1:
> > > - Update architecture support (adding sh)
> > > - Move sparc sys_rt_sigaction logic into its header
> > > - Add sig_atomic_t
> > > - Use new BITSET_* macros
> > > - Move test into syscall suite
> > > - Various other small changes
> > > ---
> > >  tools/include/nolibc/Makefile                |   1 +
> > >  tools/include/nolibc/arch-s390.h             |   4 +-
> > >  tools/include/nolibc/asm-signal.h            | 237 +++++++++++++++++++
> > >  tools/include/nolibc/signal.h                | 179 ++++++++++++++
> > >  tools/include/nolibc/sys.h                   |   2 +-
> > >  tools/include/nolibc/sys/wait.h              |   1 +
> > >  tools/include/nolibc/time.h                  |   2 +-
> > >  tools/include/nolibc/types.h                 |   9 +
> > >  tools/testing/selftests/nolibc/nolibc-test.c | 134 +++++++++++
> > >  9 files changed, 566 insertions(+), 3 deletions(-)
> > >  create mode 100644 tools/include/nolibc/asm-signal.h
> > 
> > (...)
> > 
> > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > index 295e71d34aba..a790e816565b 100644
> > > --- a/tools/include/nolibc/sys.h
> > > +++ b/tools/include/nolibc/sys.h
> > > @@ -14,7 +14,6 @@
> > >  
> > >  /* system includes */
> > >  #include <linux/unistd.h>
> > > -#include <linux/signal.h>  /* for SIGCHLD */
> > >  #include <linux/termios.h>
> > >  #include <linux/mman.h>
> > >  #include <linux/fs.h>
> > > @@ -28,6 +27,7 @@
> > >  #include "errno.h"
> > >  #include "stdarg.h"
> > >  #include "types.h"
> > > +#include "asm-signal.h" /* for SIGCHLD */
> > 
> > #include "signal.h"
> 
> Right, this and asm-signal.h happened because signal.h uses sys_kill()
> for raise(), resulting in a circular dependency.
> 
> The simplest solution is probably to avoid the circular include by
> implementing raise() as:
> 
> int raise(int signal);
> __attribute__((weak,unused,section(".text.nolibc_raise")))
> int raise(int signal)
> {
> 	return my_syscall2(__NR_kill, my_syscall0(__NR_getpid), signal);
> }

Also sounds good. Or add local declarations sys_kill() and sys_getpid().

(...)

