Return-Path: <linux-kselftest+bounces-41728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD970B807C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FB47A3765
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83110333AB3;
	Wed, 17 Sep 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nhivmng";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ob8EioHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484A30BF72;
	Wed, 17 Sep 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122487; cv=none; b=coJqUAdV8hbCSSo1ZxfxCn2Hh4YlsztlUkAbjALgvk7+bWq0C+2K4/VYw25D3mBGs4DEz4t95lCKvuZXPCoyIOXhKfhTjBaX2buNtpYFIuEbWG/y41TXbH2WZVSj9Xv41diKIRz/tDhxavcbK4yYAZGKCC6YPvLw1U+XCJs3Qys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122487; c=relaxed/simple;
	bh=JnjyxHE2SHo2lMYG24a/vuZ5+YxATNSRGf4WRidX/4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3yxGXzDTyQa/5oyU4IE+tHJ+DjgoQDiPMzK8X1MZtQDpfog8jnHyYpyCR37MBkIfWWdowkpOKVc/d4DnpZnyJ/6BNOHEOpC/zW9Ogs/niao+AR36BZ8hjgIwIf0S1Cu6oQxzWGEAuGxnlfHEfLlALvVDrQKXwwCGnYUvCfb4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nhivmng; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ob8EioHS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 17:21:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758122483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/sWpX1d0FqUQZmJaMW2nRnPQMp56EHFIU2k1H50MYU=;
	b=3nhivmngd6+PmA3+eV33THTVRq9jhpe+HBt/O4eCUY3Xh5mSatPaAakAkLSiN/PgvcAopM
	y0Vf/JBYg9oMJuBPbUW8p3kfUkXUykpOTcPsUyVMjVq1GXYPIMNETdFVpFy8Dq/WubWuCF
	s78V7VLCyrlgSlUS4fRKO9Jc+yrd1jlMFKyXuxYp5AiWpIVOuskTy+86RTMbqukB7HkVfE
	7tOkUXZcX2xRhQyZwhU66M/r+VdJA/P0eIRfDbHpsj4zJHjLjz1urRGJEwwhNOxhg3HUFu
	gLLrhHi+vVShPn758ZvkO2UBIFtcaaRzj0ag6ZXNqRNipr1zS9Npoc4oLzCXjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758122483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/sWpX1d0FqUQZmJaMW2nRnPQMp56EHFIU2k1H50MYU=;
	b=ob8EioHSqHCIf/3CBZz5Tz2bb9bzFkW7kWflQdESNktBSVsvxeZSnY6E6RONhA6DbGeGkn
	5sDsyosGlBsU7rDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King <linux@armlinux.org.uk>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 07/36] powerpc/vdso: Explicitly include asm/cputable.h
 and asm/feature-fixups.h
Message-ID: <20250917171207-1fad0416-7543-481c-a998-5881fab1714e@linutronix.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
 <20250917-vdso-sparc64-generic-2-v3-7-3679b1bc8ee8@linutronix.de>
 <41d100c5-4706-400e-a61a-46b068f1bc74@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41d100c5-4706-400e-a61a-46b068f1bc74@csgroup.eu>

On Wed, Sep 17, 2025 at 04:41:49PM +0200, Christophe Leroy wrote:
> 
> 
> Le 17/09/2025 ‡ 16:00, Thomas Weiﬂschuh a Ècrit†:
> > The usage of ASM_FTR_IFCLR(CPU_TR_ARCH_31) requires asm/cputable.h and
> > asm/feature-fixups.h. Currently these headers are included transitively,
> > but that transitive inclusion is about to go away.
> 
> Hum ...
> 
> That was unexpectedly added by commit 9c7bfc2dc21e ("powerpc/64s: Make
> POWER10 and later use pause_short in cpu_relax loops")
> 
> In theory, vdso/ headers shouldn't include any headers outside of vdso/

I am aware. But this is the dependency as it exists today and I don't really
want to make this series larger than it already is. This is by far not the
only such layering violation in the vDSO headers. I have some patches prepared...

> > Explicitly include the headers.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >   arch/powerpc/include/asm/vdso/processor.h | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
> > index 80d13207c5688d73954822aede2bbe2d0e05c054..42b64903bdf47cc5bd571fc3b5caed45e6358cb9 100644
> > --- a/arch/powerpc/include/asm/vdso/processor.h
> > +++ b/arch/powerpc/include/asm/vdso/processor.h
> > @@ -4,6 +4,9 @@
> >   #ifndef __ASSEMBLY__
> 
> __ASSEMBLY__ is replaced by __ASSEMBLER__ in powerpc-next in commit
> 74db6cc331b0 ("powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi
> headers")

Ack. I'll have to rebase this series after -rc1 in any case. Right now I am
hoping to collect some Acks.

> > +#include <asm/cputable.h>
> > +#include <asm/feature-fixups.h>
> > +
> >   /* Macros for adjusting thread priority (hardware multi-threading) */
> >   #ifdef CONFIG_PPC64
> >   #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
> > 
> 

