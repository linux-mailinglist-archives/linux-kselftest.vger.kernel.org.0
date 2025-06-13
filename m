Return-Path: <linux-kselftest+bounces-34905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AABAD8D1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3ADF7A8830
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1F1624C5;
	Fri, 13 Jun 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DhcdyrLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFB15A87C
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821379; cv=none; b=fGF05LSvZo4qrF42qdfaEBXdyKiQBrlfSoXwA3/wAN8ieWjA5fJn4pi9FB1gwj/9LvtlCmixpUXD07i908aRMeSPUKle5F/FRe5zPXzJuZi6TQUJ6xPjZ7K9ir6Bvix8VLhVW5ZfqctIddQVFpsjQhXHgIPr3m8J4nSth41Oxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821379; c=relaxed/simple;
	bh=6lAJlnes6QqXwNak5p4WWw0SOJxyB3LYvEyInzKSXQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDln240nGn3KPkiN/WdU9CT76gVY2aN1PH35qn8DkXtJVqw8y7fZUhzRhvTTbKOBW/rx7+BqYo0IynFtqSVohyI5InAW7VoKceFOduW0sC/oxKw+l348dI2Vy7xwBMDa79sS3du4WijaYPHjwdr+rPCuFgKR0jPo/4aQf8PYhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DhcdyrLh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Jun 2025 15:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749821365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDFsYEgxo1GXhtFdQGrCC+9YCOStEBIAsgElrlaVhWs=;
	b=DhcdyrLhQdNsb4gZpeaIn1xkIfmF5quDJPQodcIzL76+o+IAvTDTXPpAkkddf/Jux25r7K
	mS6yCvB7i66zgNM6f4cH/+RM5qwf4C+zf0k82NBlcT9HK5BHm0bybQi+n23mJFsWP2pmOl
	1zhMS9WQi2HAnHdbG2argozEOfKFqOo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atish.patra@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [kvm-unit-tests PATCH 1/2] riscv: Allow SBI_CONSOLE with no uart
 in device tree
Message-ID: <20250613-031a531dce64411cb0ba7774@orel>
References: <20250612200747.683635-1-jesse@rivosinc.com>
 <20250613-68a39013932d854741a41c4c@orel>
 <CALSpo=Y1uq6zAJYgJOTnVxzaNMmms7-eVSF4U_Z2rJ1zNVU9+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALSpo=Y1uq6zAJYgJOTnVxzaNMmms7-eVSF4U_Z2rJ1zNVU9+w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 13, 2025 at 05:11:19AM -0700, Jesse Taube wrote:
> On Fri, Jun 13, 2025 at 12:53 AM Andrew Jones <andrew.jones@linux.dev> wrote:
> >
> > On Thu, Jun 12, 2025 at 01:07:47PM -0700, Jesse Taube wrote:
> > > When CONFIG_SBI_CONSOLE is enabled and there is no uart defined in the
> > > device tree kvm-unit-tests fails to start.
> > >
> > > Only check if uart exists in device tree if SBI_CONSOLE is false.
> > >
> > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > ---
> > >  lib/riscv/io.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> > > index fb40adb7..96a3c048 100644
> > > --- a/lib/riscv/io.c
> > > +++ b/lib/riscv/io.c
> > > @@ -104,6 +104,7 @@ static void uart0_init_acpi(void)
> > >
> > >  void io_init(void)
> > >  {
> > > +#ifndef CONFIG_SBI_CONSOLE
> > >       if (dt_available())
> > >               uart0_init_fdt();
> > >       else
> > > @@ -114,6 +115,7 @@ void io_init(void)
> > >                      "Found uart at %p, but early base is %p.\n",
> > >                      uart0_base, UART_EARLY_BASE);
> > >       }
> > > +#endif
> >
> > Doesn't this generate uart0_init_fdt/acpi defined but not used types of
> > warnings?
> 
> No, but it should have, I'll fix it.
> 
> > We need to put everything unused under the #ifndef
> > CONFIG_SBI_CONSOLE, just as uart0_read/write already are. Alternatively,
> > we can keep everything out of the #ifndef and export.
> 
> The problem is uart0_init_fdt panics if no compatible uart was found.

Let's do

#ifndef CONFIG_SBI_CONSOLE
   if (ret) {
       printf("%s: Compatible uart not found in the device tree, aborting...\n",__func__);
       abort();
   }
#else
   uart0_base = NULL;
   return;
#endif

And then in uart0_puts() do a 

  assert(uart0_base);

This rules out mapping a uart at physical address zero, but hopefully
that's not a thing. If it ever does appear to be a thing, then we can
just add a boolean to track whether the base address is valid or not.
But we'll burn that bridge when we cross it later, if ever.

Thanks,
drew

> 
> Thanks,
> Jesse Taube
> > void sbi_puts(const char *s);
> > void uart0_puts(const char *s);
> >
> > then just have a single use of the #ifdef,
> >
> > void puts(const char *s)
> > {
> > #ifdef CONFIG_SBI_CONSOLE
> >     sbi_puts(s);
> > #else
> >     uart0_puts(s);
> > #endif
> > }
> >
> > I think I like that better since it will ensure all code gets compile
> > tested all the time and allow an SBI console using unit test to also
> > access its uart if it has one, just because...
> >
> > Thanks,
> > drew
> >
> >
> > >  }
> > >
> > >  #ifdef CONFIG_SBI_CONSOLE
> > > --
> > > 2.43.0
> > >
> > >
> > > --
> > > kvm-riscv mailing list
> > > kvm-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kvm-riscv
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

