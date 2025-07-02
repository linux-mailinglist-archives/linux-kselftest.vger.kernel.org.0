Return-Path: <linux-kselftest+bounces-36342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01751AF5D55
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B23A8AED
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF217303DCB;
	Wed,  2 Jul 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kahmAKwf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF22D0C63
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470411; cv=none; b=o47kgHKGI5ewOjolHpL+p0am21C5sfS1qinbwgc6qOC4JmXk3wPyxuOTVyviowhGqfqLcbvQoKEpU3r9B77pe4r7lx3XIfNL8kZag/i1++PN5uqUEDFszsgqXt2e0eTB2Edl8ZfwKWUznASAFIF+XGbS46NA8TYgopbMmk6Wyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470411; c=relaxed/simple;
	bh=mpuDy+YCvbfNSqpGlnEVdBf5feIF71mJsg1+kpwOn9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjN7zysPcaj1F8MNX6xpS62N6yprgKNLRREAwkITHW2nvI0jhtCri7j1DEyKSBVeU6hBOcyhLxgJuQPP1d8Cp0MWNsmuSA2V/Bt+5Ar4wJOflsmzvde/yuVBy7yaqkMhfIUc43m9euqVvL0UZaJwUYbkNkPKvqmzTjIGLgoJXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kahmAKwf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xvJ6tH3P6h6IA1WbzPOdT2pBy9mtLov5nbK05/96uVs=;
	t=1751470409; x=1752680009; b=kahmAKwftJL08dMKiAT+kmLuuoJiJmrKmdmIaZ5hkZnMeQb
	SkV2n8qEgvjm2G3KxW/HiMHIzTItqLES+pgRlMXPWpcu/k2n3L3o7SNhyw5G4AGGVV9h/jewkEX0s
	lkcr2zFEozVXWQM7ugSHq7lOubYRpDfqGl80Ex4oL7GjJ55/JFfMHSCWkPLN3vsuVCPcOw5E1kLKl
	iF83355TyWztCUIwxYteQtADRnLoczAcQ82fChihK3zrrM2uDPrful8NHPrO/ag0bqR5HL6gJneon
	/pzZ2dfkr+Hh1bsjeAVHySKeNb/uPzzuc3KCZPZ9adkKXQNii+uyiUxvb3XFRtJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uWzSg-00000004Dp2-0RI5;
	Wed, 02 Jul 2025 17:33:26 +0200
Message-ID: <c870d823e686c4b4ef6928d9ca0162d72e484339.camel@sipsolutions.net>
Subject: Re: [RFC v2] tools/nolibc: add sigaction()
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Date: Wed, 02 Jul 2025 17:33:24 +0200
In-Reply-To: <21cf1fee-21ce-43b2-95cc-18aa58adcd87@t-8ch.de> (sfid-20250702_000453_996016_4A5318A8)
References: <20250701122910.45823-1-benjamin@sipsolutions.net>
	 <21cf1fee-21ce-43b2-95cc-18aa58adcd87@t-8ch.de>
	 (sfid-20250702_000453_996016_4A5318A8)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Wed, 2025-07-02 at 00:04 +0200, Thomas Wei=C3=9Fschuh wrote:
> [SNIP]
> > --- a/tools/include/nolibc/arch-i386.h
> > +++ b/tools/include/nolibc/arch-i386.h
> > @@ -10,6 +10,19 @@
> > =C2=A0#include "compiler.h"
> > =C2=A0#include "crt.h"
> > =C2=A0
> > +/* Needed to get the correct struct sigaction definition */
> > +#define SA_RESTORER	0x04000000
> > +
> > +/* Restorer must be set on i386 */
> > +#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
> > +
> > +/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
> > +#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
> > +
> > +/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
> > +#include <asm-generic/signal.h>
> > +#include <asm-generic/siginfo.h>
>=20
> This doesn't work if the user already has <linux/signal.h> included for
> some other reason. The symbol names will conflict.

I was thinking this is fine. Such a conflict already exists between the
normal glibc <signal.h> and <linux/signal.h>. So there would only be a
problem if the user is explicitly not including <signal.h> to then use
<linux/signal.h>. I doubt that makes sense.

Benjamin

>=20
> Can we do something like this:
>=20
> #include <linux/signal.h>
>=20
> /* lifted from asm-generic/signal.h */
> struct __nolibc_sigaction {
> 	__sighandler_t sa_handler;
> 	unsigned long sa_flags;
> #ifdef SA_RESTORER
> 	__sigrestore_t sa_restorer;
> #endif
> 	__nolibc_sigset_t sa_mask;
> };
>=20
> int sys_rt_sigaction(int signum, const struct sigaction *act, struct siga=
ction *oldact)
> {
> 	struct __nolibc_sigaction nolibc_act, nolibc_oldact;
> 	int ret;
>=20
> 	/* Convert whatever gunk we got from linux/signal.h to what the
> 	 * kernel actually expects. If it is the same structure,
> 	 * hopefully the compiler manages to optimize it away.
> 	 * See __nolibc_user_timespec_to_kernel() et al.
> 	 * (Comment not meant to be copied verbatim)
> 	 */
> 	__nolibc_sigaction_user_to_kernel(act, &nolibc_act);
>=20
> #if defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER)
> ...
> #endif
>=20
> 	ret =3D my_syscall4(__NR_rt_sigaction, signum, &nolibc_act, &nolibc_olda=
ct, sizeof(nolibc_act->sa_mask));
>=20
> 	__nolibc_sigaction_kernel_to_user(&nolibc_oldact, oldact);
>=20
> 	return ret;
> }
>=20
> Or am I missing something?
>=20
> > +
> > =C2=A0/* Syscalls for i386 :
> > =C2=A0 *=C2=A0=C2=A0 - mostly similar to x86_64
> > =C2=A0 *=C2=A0=C2=A0 - registers are 32-bit
>=20
> <snip>
>=20
> > --- a/tools/include/nolibc/arch-sparc.h
> > +++ b/tools/include/nolibc/arch-sparc.h
> > @@ -12,6 +12,19 @@
> > =C2=A0#include "compiler.h"
> > =C2=A0#include "crt.h"
> > =C2=A0
> > +/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
> > +#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
> > +
> > +/* The includes are sane, if one sets __WANT_POSIX1B_SIGNALS__ */
> > +#define __WANT_POSIX1B_SIGNALS__
> > +#include <linux/signal.h>
>=20
> This also assumes the user did not already include <linux/signal.h>
> before including nolibc.
>=20
> > +
> > +/*
> > + * sparc has ODD_RT_SIGACTION, we always pass our restorer as an argum=
ent
> > + * to rt_sigaction. The restorer is implemented in this file.
> > + */
> > +#define _NOLIBC_RT_SIGACTION_PASSES_RESTORER
> > +
> > =C2=A0/*
> > =C2=A0 * Syscalls for SPARC:
> > =C2=A0 *=C2=A0=C2=A0 - registers are native word size
> > @@ -188,4 +201,34 @@ pid_t sys_fork(void)
> > =C2=A0}
> > =C2=A0#define sys_fork sys_fork
> > =C2=A0
> > +#define __nolibc_stringify_1(x...)=C2=A0=C2=A0=C2=A0=C2=A0 #x
> > +#define __nolibc_stringify(x...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _=
_stringify_1(x)
>=20
> If we need this, IMO it belongs into compiler.h.
>=20
> > +
> > +/* The compiler insists on adding a SAVE call to the start of every fu=
nction */
> > +#define __nolibc_sa_restorer __nolibc_sa_restorer
> > +void __nolibc_sa_restorer (void);
> > +#ifdef __arch64__
> > +__asm__(=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>=20
> We are avoiding bare toplevel asm calls.
> You could use the same trick as my SuperH _start() function and use
> asm() inside a function.
>=20
> https://lore.kernel.org/lkml/20250623-nolibc-sh-v2-3-0f5b4b303025@weisssc=
huh.net/
>=20
> > +	".section .text\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> > +	".align=C2=A0 4 \n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +	"__nolibc_sa_restorer:\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +	"nop\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > +	"nop\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > +	"mov=C2=A0=C2=A0=C2=A0=C2=A0 " __stringify(__NR_rt_sigreturn) ", %g1 =
\n"=C2=A0=C2=A0=C2=A0 \
> > +	"t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x6d \n");
> > +#else
> > +__asm__(=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +	".section .text\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> > +	".align=C2=A0 4 \n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +	"__nolibc_sa_restorer:\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +	"nop\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > +	"nop\n"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > +	"mov=C2=A0=C2=A0=C2=A0=C2=A0 " __stringify(__NR_rt_sigreturn) ", %g1 =
\n"=C2=A0=C2=A0=C2=A0 \
> > +	"t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x10 \n"=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>=20
> Only one line differs. I'd prefer the #ifdef around that.
>=20
> > +	);
> > +#endif
> > +
> > +#undef __nolibc_stringify_1(x...)
> > +#undef __nolibc_stringify
>=20
> And there is no need to undef it again.
>=20
> > +
> > =C2=A0#endif /* _NOLIBC_ARCH_SPARC_H */
> > diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/=
arch-x86_64.h
> > index 67305e24dbef..9f13a2205876 100644
>=20
> <snip>
>=20
> > --- a/tools/include/nolibc/signal.h
> > +++ b/tools/include/nolibc/signal.h
> > @@ -14,6 +14,8 @@
> > =C2=A0#include "arch.h"
> > =C2=A0#include "types.h"
> > =C2=A0#include "sys.h"
> > +#include "string.h"
> > +/* signal definitions are included by arch.h */
> > =C2=A0
> > =C2=A0/* This one is not marked static as it's needed by libgcc for div=
ide by zero */
> > =C2=A0int raise(int signal);
> > @@ -23,4 +25,99 @@ int raise(int signal)
> > =C2=A0	return sys_kill(sys_getpid(), signal);
> > =C2=A0}
> > =C2=A0
> > +/*
> > + * sigaction(int signum, const struct sigaction *act, struct sigaction=
 *oldact)
> > + */
> > +#if defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER) && !defined(__nolibc_sa_re=
storer)
> > +static __attribute__((noreturn)) __nolibc_entrypoint __no_stack_protec=
tor
>=20
> __attribute__((noreturn)) is not always available and should be behind
> __nolibc_has_attribute().=20
> I'm a bit unhappy about reusing the entrypoint machinery, but I guess
> it's necessary.
>=20
> > +void __nolibc_sa_restorer(void)
> > +{
> > +	my_syscall0(__NR_rt_sigreturn);
> > +	__nolibc_entrypoint_epilogue();
> > +}
> > +#endif
> > +
> > +static __attribute__((unused))
> > +int sys_rt_sigaction(int signum, const struct sigaction *act, struct s=
igaction *oldact)
> > +{
> > +	struct sigaction real_act =3D *act;
> > +#if defined(SA_RESTORER) && defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER)
>=20
> If _NOLIBC_ARCH_NEEDS_SA_RESTORER is set then SA_RESTORER should also be
> present. SA_RESTORER doesn't need to be checked also.
> Are there cases where SA_RESTORER is defined but not needed?
>=20
> > +	if (!(real_act.sa_flags & SA_RESTORER)) {
> > +		real_act.sa_flags |=3D SA_RESTORER;
> > +		real_act.sa_restorer =3D __nolibc_sa_restorer;
> > +	}
> > +#endif
> > +#ifdef _NOLIBC_ARCH_FORCE_SIG_FLAGS
> > +	real_act.sa_flags |=3D _NOLIBC_ARCH_FORCE_SIG_FLAGS;
> > +#endif
> > +
> > +#ifndef _NOLIBC_RT_SIGACTION_PASSES_RESTORER
> > +	return my_syscall4(__NR_rt_sigaction, signum, &real_act, oldact,
> > +			=C2=A0=C2=A0 sizeof(act->sa_mask));
> > +#else
> > +	return my_syscall5(__NR_rt_sigaction, signum, &real_act, oldact,
> > +			=C2=A0=C2=A0 __nolibc_sa_restorer, sizeof(act->sa_mask));
>=20
> This calling convention is specific to SPARC, so I prefer it to be in
> arch-sparc.h. Alpha also uses 5 arguments for the syscall, but of course
> in a different order... (I do have nearly done patches for alpha
> support).
>=20
> Also if a user specified their custom sa_restorer in 'act', that one
> should be used, no?
>=20
> > +#endif
> > +}
> > +
> > +static __attribute__((unused))
> > +int sigaction(int signum, const struct sigaction *act, struct sigactio=
n *oldact)
> > +{
> > +	return __sysret(sys_rt_sigaction(signum, act, oldact));
> > +}
> > +
> > +/*
> > + * int sigemptyset(sigset_t *set)
> > + */
> > +static __attribute__((unused))
> > +int sigemptyset(sigset_t *set)
> > +{
> > +	memset(set, 0, sizeof(*set));
> > +	return 0;
> > +}
> > +
> > +/*
> > + * int sigfillset(sigset_t *set)
> > + */
> > +static __attribute__((unused))
> > +int sigfillset(sigset_t *set)
> > +{
> > +	memset(set, 0xff, sizeof(*set));
> > +	return 0;
> > +}
> > +
> > +/*
> > + * int sigaddset(sigset_t *set, int signum)
> > + */
> > +static __attribute__((unused))
> > +int sigaddset(sigset_t *set, int signum)
> > +{
> > +	set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] |=3D
> > +		1UL << ((signum - 1) % (8 * sizeof(set->sig[0])));
> > +	return 0;
>=20
> This is documented to return EINVAL for an invalid signum.
>=20
> > +}
> > +
> > +/*
> > + * int sigdelset(sigset_t *set, int signum)
> > + */
> > +static __attribute__((unused))
> > +int sigdelset(sigset_t *set, int signum)
> > +{
> > +	set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] &=3D
> > +		~(1UL << ((signum - 1) % (8 * sizeof(set->sig[0]))));
> > +	return 0;
> > +}
> > +
> > +/*
> > + * int sigismember(sigset_t *set, int signum)
> > + */
> > +static __attribute__((unused))
> > +int sigismember(sigset_t *set, int signum)
> > +{
> > +	unsigned long res =3D
> > +		set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] &
> > +			(1UL << ((signum - 1) % (8 * sizeof(set->sig[0]))));
> > +	return !!res;
> > +}
>=20
> These are similar to FD_CLR()/FD_SET() etc, no?
> Moving both sets of functions to common inline helpers would be nice.
>=20
> > +
> > =C2=A0#endif /* _NOLIBC_SIGNAL_H */
>=20
> <snip>
>=20
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testi=
ng/selftests/nolibc/nolibc-test.c
> > index dbe13000fb1a..af66b739ea18 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1750,6 +1750,57 @@ static int run_protection(int min __attribute__(=
(unused)),
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +volatile int signal_check;
>=20
> Technically this should be sig_atomic_t.
> Which can be a typedef to int.
>=20
> > +void test_sighandler(int signum)
> > +{
> > +	if (signum =3D=3D SIGUSR1) {
> > +		kill(getpid(), SIGUSR2);
> > +		signal_check =3D 1;
> > +	} else {
> > +		signal_check++;
> > +	}
> > +}
> > +
> > +int run_signal(int min, int max)
> > +{
> > +	struct sigaction sa =3D {
> > +		.sa_flags =3D 0,
> > +		.sa_handler =3D test_sighandler,
> > +	};
> > +	int llen; /* line length */
> > +	int ret =3D 0;
> > +	int res;
> > +
> > +	(void)min;
> > +	(void)max;
> > +
> > +	signal_check =3D 0;
> > +
> > +	sigemptyset(&sa.sa_mask);
> > +	sigaddset(&sa.sa_mask, SIGUSR2);
>=20
> It would be good to do some assertions after sigemptyset() and
> sigaddset() to validate the bitfiddling.
>=20
> > +
> > +	res =3D sigaction(SIGUSR1, &sa, NULL);
> > +	llen =3D printf("register SIGUSR1: %d", res);
> > +	EXPECT_EQ(1, 0, res);
> > +	res =3D sigaction(SIGUSR2, &sa, NULL);
> > +	llen =3D printf("register SIGUSR2: %d", res);
> > +	EXPECT_EQ(1, 0, res);
>=20
> Here it would be nice to validate the old action.
>=20
> > +
> > +	/* Trigger the first signal. */
> > +	kill(getpid(), SIGUSR1);
> > +
> > +	/* If signal_check is 1 or higher, then signal emission worked */
> > +	llen =3D printf("signal emission: 1 <=3D signal_check");
> > +	EXPECT_GE(1, signal_check, 1);
> > +
> > +	/* If it is 2, then signal masking worked */
> > +	llen =3D printf("signal masking: 2 =3D=3D signal_check");
> > +	EXPECT_EQ(1, signal_check, 2);
> > +
> > +	return ret;
> > +}
> > +
> > =C2=A0/* prepare what needs to be prepared for pid 1 (stdio, /dev, /pro=
c, etc) */
> > =C2=A0int prepare(void)
> > =C2=A0{
> > @@ -1815,6 +1866,7 @@ static const struct test test_names[] =3D {
> > =C2=A0	{ .name =3D "stdlib",=C2=A0=C2=A0=C2=A0=C2=A0 .func =3D run_stdl=
ib=C2=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0	{ .name =3D "printf",=C2=A0=C2=A0=C2=A0=C2=A0 .func =3D run_prin=
tf=C2=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0	{ .name =3D "protection", .func =3D run_protection },
> > +	{ .name =3D "signal",=C2=A0=C2=A0=C2=A0=C2=A0 .func =3D run_signal },
>=20
> These 'struct test's are really more test suites.
> This testcase can be part of the syscall suite.
>=20
> > =C2=A0	{ 0 }
> > =C2=A0};
> > =C2=A0
> > --=20
> > 2.50.0
> >=20
>=20


