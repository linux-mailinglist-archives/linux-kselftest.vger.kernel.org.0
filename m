Return-Path: <linux-kselftest+bounces-35675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697EAE5FAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3C93B08A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6960226AA88;
	Tue, 24 Jun 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozbY9Al3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE026A1C7
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754504; cv=none; b=soMJ8LLDMPlg0KFNkXWzj8xCLGLIuhPM2OZ0h5svr4wjabAuh8PD7s/feR/I6FD8/4mqU7KJ/L/UANvxPgH2sv/7xVZPWyH9JenItMGMmVfGDhfwmCkJqHpZARUVo3jct1PZvXFizfjYsnIKRaYj26U33axCOkztpddHHKlZ8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754504; c=relaxed/simple;
	bh=EQ6k/3us5mFyIyxxisVZ0vu9nUJSxMmC5Dr/rmAZ8o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2t7H57oO8SiPryDZZGBoUF+0sYfPY1d3NCGieprSEl6EKbBAyuuZGjMdj+xX2YXP4Y/lc05e0Z1B6HzpHsaNsL4kYalj55haeDGiuzm2RYffEEjFXXsYVnPpxmHtuilrA7DbsyB0mPkGtRn5WorZLurAqukF54URXvukA5+F/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozbY9Al3; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Jun 2025 10:41:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750754500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZJk1co4OhHhKxG5ybsrLzoSEb0nCOo3fmKlGka1MHg=;
	b=ozbY9Al3iiJNs8m0qlPPplG13XOr4UHQAfIKaSCfF1xOj8JPwCLLaO8AOD8naHiyLY9uKX
	Nbf6eienajX9v67L1aP6XLVTmrJS8LaLQ0jG+nuvFNgLE8DdeNy0lJo2py48bG97y6k8OO
	xCks1cKu0aXWQQ75KyehYEvqtW2byNU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH] riscv: lib: sbi_shutdown add exit code.
Message-ID: <20250624-9f7044f67c5054d0a948b94a@orel>
References: <20250620155051.68377-1-jesse@rivosinc.com>
 <20250623-c4c3115e6402176024bac6ea@orel>
 <CALSpo=YQun4owTSkCULpgSu386nHK4q8kuU--oif4Wtw2S_V1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALSpo=YQun4owTSkCULpgSu386nHK4q8kuU--oif4Wtw2S_V1w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 23, 2025 at 03:46:31PM -0700, Jesse Taube wrote:
> On Mon, Jun 23, 2025 at 10:01 AM Andrew Jones <andrew.jones@linux.dev> wrote:
> >
> > On Fri, Jun 20, 2025 at 08:50:51AM -0700, Jesse Taube wrote:
> > > When exiting it may be useful for the sbi implementation to know the
> > > exit code.
> > > Add exit code to sbi_shutdown, and use it in exit().
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
> > > index fb40adb7..02231268 100644
> > > --- a/lib/riscv/io.c
> > > +++ b/lib/riscv/io.c
> > > @@ -150,7 +150,7 @@ void halt(int code);
> > >  void exit(int code)
> > >  {
> > >       printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
> > > -     sbi_shutdown();
> > > +     sbi_shutdown(code & 1);
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
> >
> > We can't do this because a kvm-unit-tests exit code is not an
> > SRST::reset_reason[1]. This could result in the SBI implementation
> > returning an error, or doing something else, rather than shutting
> > down.
> 
> Yes that's why there is:
> +sbi_shutdown(code & 1);

Ah, I overlooked that.

> Admittedly it should probably be:
> +sbi_shutdown(!!code);

Indeed, it would only work now because bit 0 is set in the abort
exit code.

> 
> >
> > If this is a custom kvm-unit-tests-specific SBI implementation, then
> > we could pass in a reset_reason in the 0xE0000000 - 0xEFFFFFFF range.
> 
> That still doesn't guarantee it to succeed.
> In the exit function we can add a fallback like `sbi_shutdown(0);`,
> but reason code 1 (System failure) should always work.
> If anyone wants to use it for SBI specific codes, that's fine,
> but I only added it for the No reason and System failure exit codes.

Yup, I see now that the intention is just to say success/failure, not
pass down the actual exit code. The commit message says exit code,
though, which is why I didn't read the patch closely.

Please send a v2 with the !! change and a change to the commit message.

Thanks,
drew

