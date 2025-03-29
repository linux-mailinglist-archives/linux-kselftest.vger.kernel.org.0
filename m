Return-Path: <linux-kselftest+bounces-29914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FEEA75643
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 13:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91BE16E531
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F71BD50C;
	Sat, 29 Mar 2025 12:49:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFBD1FC8;
	Sat, 29 Mar 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743252546; cv=none; b=usrM1PfGKEIeYck7yjm+/ksGnDM31Z6nn8oh1RRuEsEu3iHphWPWI6Zpv67ERCD8sIQ1/rZfvDgt6dcSI/BI2B5AGxG4ng4qW4zpCNRx8dIYx8jjTtxkoeHUJsq5U7KREznRf9oB2PmoThlLbFKGCLQGdbHciNj2dQvgaBm59is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743252546; c=relaxed/simple;
	bh=FOs7PQk4EBqCuu/+MQmpjVpHLf5BYkUfO8dcCugbFGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx7JJ7Iy93U5vjr+Z0hbHCZAiYN7aa0OraUuT+r+wD1naG18ddUDxYNdPSS+gmuYD/yEFdKsxBNcckstiSzLPj422NiFyRKKbMMF57F8iGOKICqPgx+uKs34Ftkmy8zET+4TzLlYVLXi6Xg6XZZ2f5+hYbnU+nG5kUla0NrvUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 6373172C8CC;
	Sat, 29 Mar 2025 15:48:56 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 51B347CCB3A; Sat, 29 Mar 2025 15:48:56 +0300 (IDT)
Date: Sat, 29 Mar 2025 15:48:56 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	strace-devel@lists.strace.io, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ptrace/get_syscall_info: fix for MIPS n32
Message-ID: <20250329124856.GA1356@strace.io>
References: <20250115233747.GA28541@strace.io>
 <0262acf1-4d3f-471b-bd56-4ddf8a2bc1a3@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0262acf1-4d3f-471b-bd56-4ddf8a2bc1a3@linuxfoundation.org>

On Fri, Mar 28, 2025 at 05:04:54PM -0600, Shuah Khan wrote:
> On 1/15/25 16:37, Dmitry V. Levin wrote:
> > MIPS n32 is one of two ILP32 architectures supported by the kernel
> > that have 64-bit syscall arguments (another one is x32).
> > 
> > When this test passed 32-bit arguments to syscall(), they were
> > sign-extended in libc, PTRACE_GET_SYSCALL_INFO reported these
> > sign-extended 64-bit values, and the test complained about the mismatch.
> > 
> > Fix this by passing arguments of the appropriate type to syscall(),
> > which is "unsigned long long" on MIPS n32, and __kernel_ulong_t on other
> > architectures.
> > 
> > As a side effect, this also extends the test on all 64-bit architectures
> > by choosing constants that don't fit into 32-bit integers.
> > 
> > Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> > ---
> > 
> > v2: Fixed MIPS #ifdef.
> > 
> >   .../selftests/ptrace/get_syscall_info.c       | 53 +++++++++++--------
> >   1 file changed, 32 insertions(+), 21 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ptrace/get_syscall_info.c b/tools/testing/selftests/ptrace/get_syscall_info.c
> > index 5bcd1c7b5be6..2970f72d66d3 100644
> > --- a/tools/testing/selftests/ptrace/get_syscall_info.c
> > +++ b/tools/testing/selftests/ptrace/get_syscall_info.c
> > @@ -11,8 +11,19 @@
> >   #include <err.h>
> >   #include <signal.h>
> >   #include <asm/unistd.h>
> > +#include <linux/types.h>
> >   #include "linux/ptrace.h"
> >   
> > +#if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
> > +/*
> > + * MIPS N32 is the only architecture where __kernel_ulong_t
> > + * does not match the bitness of syscall arguments.
> > + */
> > +typedef unsigned long long kernel_ulong_t;
> > +#else
> > +typedef __kernel_ulong_t kernel_ulong_t;
> > +#endif
> > +
> 
> What's the reason for adding these typedefs? checkpatch should
> have warned you about adding new typedefs.
> 
> Also this introduces kernel_ulong_t in user-space test code.
> Something to avoid.

There has to be a new type for this test, and the natural way to do this
is to use typedef.  The alternative would be to #define kernel_ulong_t
which is ugly.  By the way, there are quite a few typedefs in selftests,
and there seems to be given no rationale why adding new types in selftests
is a bad idea.

That is, the new type in this test is being added on purpose,
and I'd rather keep it this way.

> >   static int
> >   kill_tracee(pid_t pid)
> >   {
> > @@ -42,37 +53,37 @@ sys_ptrace(int request, pid_t pid, unsigned long addr, unsigned long data)
> >   
> >   TEST(get_syscall_info)
> >   {
> > -	static const unsigned long args[][7] = {
> > +	const kernel_ulong_t args[][7] = {
> >   		/* a sequence of architecture-agnostic syscalls */
> >   		{
> >   			__NR_chdir,
> > -			(unsigned long) "",
> > -			0xbad1fed1,
> > -			0xbad2fed2,
> > -			0xbad3fed3,
> > -			0xbad4fed4,
> > -			0xbad5fed5
> > +			(uintptr_t) "",
> 
> You could use ifdef here.

Not just here but in other cases as well.
I think this would make the code less readable.
I'd prefer a single ifdef with a single explanatory comment.


-- 
ldv

