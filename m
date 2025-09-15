Return-Path: <linux-kselftest+bounces-41480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94CB577FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 13:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1913B1F9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE482FC898;
	Mon, 15 Sep 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uC8/kR9y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2462F360E;
	Mon, 15 Sep 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935353; cv=none; b=jdye4YHUm7hEJ6uO5erEBqzFnS21h46CJwRtfY0pCrs76evUfRDscBTdw1zXJIAc5VOxVUs6+pvlQsKGuF39OdkdhuYk4qnqTpZV5pjvrr9u8XHrNUw7ueMDgbO2hi7FFwgVXJZtCIPVebyrGeI4dvE356bRAyx5C0E3pNF+NA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935353; c=relaxed/simple;
	bh=PAjPq3B9hFsEN5lR0jqdf5nTliy719TlSkE9VoU8j1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POAAmWEf6BphrMP+k9x3Fw2/yGSrcFirzBk9cxgO56zSD4ldz3kCMGZb6qCnC3omYFIArQqZP8iIc+9nkZwPWT/HKoYF+bibfG9deU9Fh+A/QEfk1F+dCaDw1sXw0s1pXBDmvhCnhzOUrSKk/uObMoi6BUaoQB7d1U4bnUDAB7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uC8/kR9y; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757935349;
	bh=PAjPq3B9hFsEN5lR0jqdf5nTliy719TlSkE9VoU8j1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uC8/kR9yUQYP9rdbOXkUUWIRWOw/+cuscUruXfycZIBb4nIxRFFyytWPe66rF4GJQ
	 3zWg0+E8oknvA0qXFTkA8NtV9zNm8VM4PdmFnYB8iqAqk0STf82TW29Z+kTF5foEXm
	 mxrWBqGZjm3nmHZ41T39VlnwoxfMzrzYSmrma0m0=
Date: Mon, 15 Sep 2025 13:22:29 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Berg, Benjamin" <benjamin.berg@intel.com>
Cc: "w@1wt.eu" <w@1wt.eu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "tiwei.btw@antgroup.com" <tiwei.btw@antgroup.com>, 
	"acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Message-ID: <0c8abee7-8987-45da-b168-0bf7d78d9184@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-10-benjamin@sipsolutions.net>
 <5502ceaf-0b40-4961-b9ba-0c5e63498778@t-8ch.de>
 <8d6ee835fae809aa2703c51b8443878446245cfb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d6ee835fae809aa2703c51b8443878446245cfb.camel@intel.com>

On 2025-09-15 11:09:40+0000, Berg, Benjamin wrote:
> On Mon, 2025-09-15 at 11:07 +0200, Thomas Weißschuh wrote:
> > On 2025-09-15 09:11:15+0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > The registers.c file only contain the routines for floating point
> > > register access in ptrace mode and initial size detection. The file can
> > > be moved over to nolibc by replacing the ptrace libc call with a simple
> > > wrapper that does a direct syscall.
> > > 
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > ---
> > >  arch/x86/um/os-Linux/Makefile    |  5 ++++-
> > >  arch/x86/um/os-Linux/registers.c | 22 ++++++++--------------
> > >  2 files changed, 12 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
> > > index 77a308aaa5ec..d37320430822 100644
> > > --- a/arch/x86/um/os-Linux/Makefile
> > > +++ b/arch/x86/um/os-Linux/Makefile
> > > @@ -3,10 +3,13 @@
> > >  # Licensed under the GPL
> > >  #
> > >  
> > > -obj-y = registers.o mcontext.o
> > > +obj-y = mcontext.o
> > >  
> > >  obj-$(CONFIG_X86_32) += tls.o
> > >  
> > >  USER_OBJS := $(obj-y)
> > >  
> > > +obj-y += registers.o
> > > +NOLIBC_OBJS := registers.o
> > > +
> > >  include $(srctree)/arch/um/scripts/Makefile.rules
> > > diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
> > > index eb1cdadc8a61..55bce0d3f5d2 100644
> > > --- a/arch/x86/um/os-Linux/registers.c
> > > +++ b/arch/x86/um/os-Linux/registers.c
> > > @@ -6,18 +6,20 @@
> > >  
> > >  #include <errno.h>
> > 
> > Given that you are explicitly disabling errno support for nolibc, is
> > this include necessary?
> 
> I think it is technically correct as we do need ENODEV and ENOMEM to be
> defined. Not that we actually need the include if we pull in nolibc.h.

Yes, indeed.

> Considering we would never build against libc, should we maybe just do
> an explicit nolibc.h include and rely on it pulling in the rest
> automatically? That seems a bit weird to me, but as-is we will never
> notice when we forget an include.

Your choice. nolibc will always include itself fully transitively in any
case. So you won't notice a missing include that way either. The
different headers mostly exist to structure the nolibc sources
themselves and to let the application code look normal.
I would go with normal includes.

> > >  #include <stdlib.h>
> > > -#include <sys/ptrace.h>
> > > +#include <linux/ptrace.h>
> > >  #ifdef __i386__
> > >  #include <sys/user.h>
> > >  #endif
> > >  #include <longjmp.h>
> > >  #include <sysdep/ptrace_user.h>
> > > -#include <sys/uio.h>
> > > +#include <linux/uio.h>
> > 
> > It looks fairly trivial to add sys/uio.h to nolibc.
> > Only 'struct iovec' (already provided by the UAPI) and readv()/writev()
> > are necessary.
> > 
> > >  #include <asm/sigcontext.h>
> > >  #include <linux/elf.h>
> > >  #include <registers.h>
> > >  #include <sys/mman.h>
> > >  
> > > +#define my_ptrace(...) my_syscall4(__NR_ptrace, __VA_ARGS__)
> > 
> > Why not add sys/ptrace.h to nolibc and then use sys_ptrace()?
> 
> Honestly, I just got a bit lazy at that point and this was a reasonable
> proof that mixing nolibc with libc works fine.

Fair enough :-)

> You are absolutely right
> that it would be better to add this to nolibc.
> 
> > In general I'm not a fan of the my_syscall() naming scheme and would
> > like to change this in nolibc itself, so having fewer external users
> > would be nice.
> 
> How about adding a sys_syscall macro? That would match the naming
> scheme of the other functions. Then, once all users are ported, one can
> simply change the my_ prefix to __nolibc_.

sys_syscall() looks weird. Personally I would have gone with _syscall().
Let's just sidestep the issue for now by adding sys_ptrace() to nolibc.

(...)

