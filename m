Return-Path: <linux-kselftest+bounces-35783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EBAE8894
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DD5681039
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B0526C3B2;
	Wed, 25 Jun 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCWvxbic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D202C1A2
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866463; cv=none; b=rL0Z3OACc063FSgLynWbrDdqGou6bqrVf8L/cGUhNXHGc4pj7jl+1nz/lvIUSvMQ/kwTN6DVQvoUcykw9Um2hH2XU4mDHITjr6pE/JpSYJJTQcNrtK8/CavHUc7nrGTcxTuvKk1MdTjRzSX7F1CmzyD+hdUSqoQdqE7r/Fkwj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866463; c=relaxed/simple;
	bh=jXjH/8Tl1bNiN/PonxA0L7KYXD+DLe36+I4z2jMEyNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHKXRpVPYmaTodYC2+7X2iYPRM5uV2E11p1vBTy67r2p2KdjPyAuORVI8tyW5A6Wnu92cYjbXfWEZXwjISrco5R8yThEQe8d2x+FkoOBAnKY5TQJI/JQfBvIl5FioQwHKakZDtZ8lSQfj4V2oZwb7WxDWcvWulpbg/oVbI0khX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCWvxbic; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Jun 2025 17:47:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750866457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVs0TQ6LDv86rPHaG+xh8Q0xxxW4Qg4t45LzYEhUjQQ=;
	b=FCWvxbicUcT2NwvTSs2RCWF+oIGoyAmdVAqTku4ck1SSFx2tLFoDWuxhCfXcoHN6VfCfM0
	OMaA/keFB/bQQ+Z9wLeTiHaaITt5/0ryYsuZ6CoRDR44IUxAF2gtR0PiEx/3oJ+xNnqiW9
	FBIlv5zO+Tkv5q3f11Jhsp2JTQ2vlWw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2] riscv: lib: sbi_shutdown add pass/fail
 exit code.
Message-ID: <20250625-9b8a7fd71ce4924eca101cb1@orel>
References: <20250624192317.278437-1-jesse@rivosinc.com>
 <20250625-fc81fec2cf6d7ee195c0eb6c@orel>
 <CALSpo=ZsEEQeoYz2dby9B4zgbFcxCzmjN9SH8Jch4Avvm14Cog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALSpo=ZsEEQeoYz2dby9B4zgbFcxCzmjN9SH8Jch4Avvm14Cog@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 25, 2025 at 07:31:27AM -0700, Jesse Taube wrote:
> On Wed, Jun 25, 2025 at 1:33 AM Andrew Jones <andrew.jones@linux.dev> wrote:
> >
> > On Tue, Jun 24, 2025 at 12:23:17PM -0700, Jesse Taube wrote:
> > > When exiting it may be useful for the sbi implementation to know if
> > > kvm-unit-tests passed or failed.
> > > Add exit code to sbi_shutdown, and use it in exit() to pass
> > > success/failure (0/1) to sbi.
> > >
> > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > ---
> > >  lib/riscv/asm/sbi.h | 2 +-
> > >  lib/riscv/io.c      | 2 +-
> > >  lib/riscv/sbi.c     | 4 ++--
> > >  3 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
> > > index a5738a5c..de11c109 100644
> > > --- a/lib/riscv/asm/sbi.h
> > > +++ b/lib/riscv/asm/sbi.h
> > > @@ -250,7 +250,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> > >                       unsigned long arg3, unsigned long arg4,
> > >                       unsigned long arg5);
> > >
> > > -void sbi_shutdown(void);
> > > +void sbi_shutdown(unsigned int code);
> > >  struct sbiret sbi_hart_start(unsigned long hartid, unsigned long entry, unsigned long sp);
> > >  struct sbiret sbi_hart_stop(void);
> > >  struct sbiret sbi_hart_get_status(unsigned long hartid);
> > > diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> > > index fb40adb7..0bde25d4 100644
> > > --- a/lib/riscv/io.c
> > > +++ b/lib/riscv/io.c
> > > @@ -150,7 +150,7 @@ void halt(int code);
> > >  void exit(int code)
> > >  {
> > >       printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
> > > -     sbi_shutdown();
> > > +     sbi_shutdown(!!code);
> > >       halt(code);
> > >       __builtin_unreachable();
> > >  }
> > > diff --git a/lib/riscv/sbi.c b/lib/riscv/sbi.c
> > > index 2959378f..9dd11e9d 100644
> > > --- a/lib/riscv/sbi.c
> > > +++ b/lib/riscv/sbi.c
> > > @@ -107,9 +107,9 @@ struct sbiret sbi_sse_inject(unsigned long event_id, unsigned long hart_id)
> > >       return sbi_ecall(SBI_EXT_SSE, SBI_EXT_SSE_INJECT, event_id, hart_id, 0, 0, 0, 0);
> > >  }
> > >
> > > -void sbi_shutdown(void)
> > > +void sbi_shutdown(unsigned int code)
> > >  {
> > > -     sbi_ecall(SBI_EXT_SRST, 0, 0, 0, 0, 0, 0, 0);
> > > +     sbi_ecall(SBI_EXT_SRST, 0, 0, code, 0, 0, 0, 0);
> > >       puts("SBI shutdown failed!\n");
> > >  }
> > >
> > > --
> > > 2.43.0
> > >
> >
> > I enhanced the commit message, changed the parameter to a boolean, and
> > applied to riscv/sbi
> >
> > https://gitlab.com/jones-drew/kvm-unit-tests/-/commits/riscv/sbi
> >
> > but I'm having some second thoughts on it. It looks like opensbi and the
> > two KVM VMMs I looked at (QEMU and kvmtool) all currently ignore this
> > parameter and we don't know what they might choose to do if they stop
> > ignoring it.
> 
> For the default syscon QEMU doesn't ignore it and exits with the exit
> code given.
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/misc/sifive_test.c?ref_type=heads#L44
> 
> Both RustSBI and BBL implement the sifive_test device correctly and
> provide an exit code,
> OpenSBI ignores it, though it is trivial to add it.
> https://github.com/rustsbi/rustsbi/blob/main/prototyper/prototyper/src/platform/reset.rs#L21
> https://github.com/riscv-software-src/riscv-pk/blob/master/machine/finisher.c#L15
> 
> > For example, they could choose to hang, rather than complete
> > the shutdown when they see a "system failure" reason. It may make sense
> > to indicate system failure if the test aborts, since, in those cases,
> > something unexpected with the testing occurred. However, successfully
> > running tests which find and report failures isn't unexpected, so it
> > shouldn't raise an alarm to the SBI implementation in those cases.
> >
> > Do you already have a usecase for this in mind?
> 
> Yes making CI easier, as the exit code is passed to QEMU rather than
> having to parse the text.

OK

> 
> > If so, we could make
> > the behavior optional to enable that use case and use cases like it
> > but we'd keep that behavior off by default to avoid problems with SBI
> > implementations that do things with the "system failure" information we'd
> > rather they not do.
> 
> Sure, do you want it to be a configure flag like  --console?

Yeah. I'd prefer to have configurable behavior controlled by environment
variables, in order to allow the same binaries to run on multiple targets,
but something like this will need to know what to do before variables are
initialized. Hmm, maybe we can do both. A configure flag to set the
default and an environment variable allowing it to be overridden. It
should be possible to do that for the console as well.

Thanks,
drew

