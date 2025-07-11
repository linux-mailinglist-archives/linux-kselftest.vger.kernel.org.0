Return-Path: <linux-kselftest+bounces-37066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2CEB0148F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 09:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1998C763CBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 07:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94921E9B1C;
	Fri, 11 Jul 2025 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MH+l+2QO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80561E9915
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218746; cv=none; b=EDr3q9vyKU4cTeylYh2H8LvUyEJJ16lErOP+Mpjbq7QedyzwdSskN2FczSjdAijpkX3OsXFqXS3MJUGTTZxSyxSEUXvxfIuZZ+oqOcAASnUaLA/SBeZx4FsmbVUaDiDEV2VetfM3ibErxsaIdTRnGcZzIVomCbbcfA5/wPwVkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218746; c=relaxed/simple;
	bh=5THOdq4Srt85LMmib2c4S+O66dO0y9b0wHhyu9Hy5Wc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qeJRl6GwTbejtHRziu7IVcpmbIUNy451ZPGBK2K5pVXFyM+i8B5EPMiWqsfxhaFRp+8Caw/fj7ggg7rq10ObPXB5nwje+4GV0iivAHtD/zdrPCY5iQM5spclUViH0JLR2mE7GHs39aX6/lSeBG1v8HcbsFJDNIGIxUB3+BhT/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MH+l+2QO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wD0BUrDVSjLK0DgQfKX+MIzwBwlkEDfhnDHlZfXng4E=;
	t=1752218745; x=1753428345; b=MH+l+2QOAHYKwQiuQS23NigyUUKta7ZZCedQDRMMlGMUGTP
	rWveuWFvI3H4QD2m5UOE4IYib4EAL7ZCckL70F/FWpZkiDchSLP/0VLUY7y92lYDtPY22/0PAKrD4
	eeBIKq9+LBukUgrZJFEpnsFlTUG3saADA9zaPdJyOm05Kxmdc41ZIudeJNvDozZwAbkavCE9fkk0o
	RKKy3ZkxgsPEbmGg8AGai6USFNivtltJ3Fdok6tE8XnWQOzRRqKHS16ZSmVEhbd3eVtSPBPQmPIqg
	g698HJqyz+HBrAzY+cfn3gpCK3puTjJWK6J8w/twk8GK3iGdB/ZwBKamsWHwBPQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1ua88S-0000000FzFq-2VlM;
	Fri, 11 Jul 2025 09:25:33 +0200
Message-ID: <b1c3684e1e299f787a88c58a063ab4d0485a59a7.camel@sipsolutions.net>
Subject: Re: [PATCH v2 4/4] tools/nolibc: add signal support
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org
Date: Fri, 11 Jul 2025 09:25:26 +0200
In-Reply-To: <f72ddf71-40e4-49d0-92b6-da219e33bd29@t-8ch.de>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
	 <20250710103950.1272379-5-benjamin@sipsolutions.net>
	 <f72ddf71-40e4-49d0-92b6-da219e33bd29@t-8ch.de>
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

On Fri, 2025-07-11 at 07:40 +0200, Thomas Wei=C3=9Fschuh wrote:
> On 2025-07-10 12:39:50+0200, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > Add support for sigaction() and implement the normal sa_mask helpers.
> >=20
> > On many architectures, linux/signal.h pulls in compatibility
> > definitions
> > for the old sigaction syscall instead of rt_sigaction. However, the
> > kernel can be compiled without support for this compatibility
> > syscall
> > and it also results in sa_mask to be too small for realtime
> > signals.
> >=20
> > To work around this, the includes are handled separately for each
> > architecture. This way either linux/signal.h or the asm-generic
> > headers
> > can be used to get the correct definition for the rt_sigaction
> > syscall
> > including sigset_t.
>=20
> I checked this against my WIP alpha support and there this scheme
> breaks. linux/signal.h provides the old compat types but
> the asm-generic variant provides an incorrect SIGCHLD.
>=20
> Any ideas?

I had a quick look, and I don't have a good idea really. For sparc
there was at least a #define that permitted to get the correct version.
But here, there is nothing.

Probably the best is to just copy in a modified version of signal.h
with the correct definitions present. i.e. replace the "ifndef
__KERNEL__" sections with something reasonable.

>=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > ---
> >=20
> > v2:
> > - Use newly added macros to check signal emission order
> > - Add tests for sigset handling
> > - Restore the default handler after signal test
> > - make signal_check variable static
> >=20
> > v1:
> > - Update architecture support (adding sh)
> > - Move sparc sys_rt_sigaction logic into its header
> > - Add sig_atomic_t
> > - Use new BITSET_* macros
> > - Move test into syscall suite
> > - Various other small changes
> > ---
> > =C2=A0tools/include/nolibc/arch-arm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 ++
> > =C2=A0tools/include/nolibc/arch-arm64.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0tools/include/nolibc/arch-loongarch.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0tools/include/nolibc/arch-m68k.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> > =C2=A0tools/include/nolibc/arch-mips.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0tools/include/nolibc/arch-powerpc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> > =C2=A0tools/include/nolibc/arch-riscv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0tools/include/nolibc/arch-s390.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> > =C2=A0tools/include/nolibc/arch-sh.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> > =C2=A0tools/include/nolibc/arch-sparc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 47 ++++++++
> > =C2=A0tools/include/nolibc/arch-x86.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +++
> > =C2=A0tools/include/nolibc/signal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 103
> > +++++++++++++++++
> > =C2=A0tools/include/nolibc/sys.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
> > =C2=A0tools/include/nolibc/time.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 3 +-
> > =C2=A0tools/include/nolibc/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
9 ++
> > =C2=A0tools/testing/selftests/nolibc/nolibc-test.c | 115
> > +++++++++++++++++++
> > =C2=A016 files changed, 338 insertions(+), 4 deletions(-)
> >=20
>=20
> (...)
>=20
> > diff --git a/tools/include/nolibc/signal.h
> > b/tools/include/nolibc/signal.h
> > index ac13e53ac31d..16b8b17496bc 100644
> > --- a/tools/include/nolibc/signal.h
> > +++ b/tools/include/nolibc/signal.h
> > @@ -14,6 +14,14 @@
> > =C2=A0#include "arch.h"
> > =C2=A0#include "types.h"
> > =C2=A0#include "sys.h"
> > +#include "string.h"
>=20
> Unnecessary now as memset() is not used anymore.
>=20
> > +/* other signal definitions are included by arch.h */
> > +
> > +/* The kernel headers do not provide a sig_atomic_t definition */
> > +#ifndef __sig_atomic_t_defined
> > +#define __sig_atomic_t_defined 1
> > +typedef int sig_atomic_t;
> > +#endif
>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c
> > b/tools/testing/selftests/nolibc/nolibc-test.c
> > index d612150d2ea3..fcd44b27cd5e 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1293,6 +1293,120 @@ int test_namespace(void)
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > +sig_atomic_t signal_check;
>=20
> Still not static :-)

Eeks.

>=20
> > +
> > +static void sighandler(int signum)
> > +{
> > +	if (signum =3D=3D SIGUSR1) {
> > +		kill(getpid(), SIGUSR2);
> > +		/* The second step has not run because SIGUSR2 is
> > masked */
> > +		MARK_STEP_DONE(signal_check, 0);
> > +	} else {
> > +		MARK_STEP_DONE(signal_check, 1);
> > +	}
> > +}
> > +
> > +int test_signals(int test_idx)
> > +{
> > +	struct sigaction sa =3D {
> > +		.sa_flags =3D 0,
> > +		.sa_handler =3D sighandler,
> > +	};
> > +	struct sigaction sa_old =3D {
> > +		/* Anything other than SIG_DFL */
> > +		.sa_handler =3D sighandler,
> > +	};
> > +	int llen; /* line length */
> > +	int ret =3D 0;
> > +	int res;
> > +
> > +	signal_check =3D 0;
> > +
> > +#ifdef NOLIBC
> > +	/* Do some checks on sa_mask handling */
> > +	sigfillset(&sa.sa_mask);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[0] (full): ");
> > +	EXPECT_EQ(1, sa.sa_mask.sig[0],
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 ~(__typeof__(sa.sa_mask.sig[0]))0);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[%d] (full): ",
> > (int)_NSIG_WORDS - 1);
> > +	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1],
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 ~(__typeof__(sa.sa_mask.sig[0]))0);
> > +
> > +	sigemptyset(&sa.sa_mask);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[0] (empty): ");
> > +	EXPECT_EQ(1, sa.sa_mask.sig[0], 0);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[%d] (empty): ",
> > (int)_NSIG_WORDS - 1);
> > +	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1], 0);
> > +
> > +	/* SIGUSR2 is always in the first word */
> > +	sigaddset(&sa.sa_mask, SIGUSR2);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[0] (SIGUSR2 set): ");
> > +	EXPECT_EQ(1, sa.sa_mask.sig[0], 1 << (SIGUSR2 - 1));
> > +
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[0] (test SIGUSR2): ")=
;
> > +	EXPECT_NZ(1, sigismember(&sa.sa_mask, SIGUSR2));
> > +
> > +	sigdelset(&sa.sa_mask, SIGUSR2);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[0] (SIGUSR2 unset): "=
);
> > +	EXPECT_ZR(1, sigismember(&sa.sa_mask, SIGUSR2));
> > +
> > +	/* _NSIG is the highest valid number and may not be in the
> > first word */
> > +	sigaddset(&sa.sa_mask, _NSIG);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[%d] (_NSIG set): ",
> > (int)_NSIG_WORDS - 1);
> > +	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1],
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 1UL << (_NSIG - (_NSIG_WORDS - 1) * _NSIG_B=
PW
> > - 1));
> > +
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[%d] (test _NSIG): ",
> > (int)_NSIG_WORDS - 1);
> > +	EXPECT_NZ(1, sigismember(&sa.sa_mask, _NSIG));
> > +
> > +	sigdelset(&sa.sa_mask, _NSIG);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_mask.sig[%d] (_NSIG unset): ",
> > (int)_NSIG_WORDS - 1);
> > +	EXPECT_ZR(1, sigismember(&sa.sa_mask, _NSIG));
> > +#endif
>=20
> This is more testing than expected, but that's good.
> Could you move it to a dedicated test function, gated on "is_nolibc" and
> the #ifdef.

It did find the bit shift type bug in the macros :-)

Benjamin

>=20
> > +
> > +	/* sa_mask is empty at this point, set SIGUSR2 to verify
> > masking */
> > +	sigaddset(&sa.sa_mask, SIGUSR2);
> > +
> > +	res =3D sigaction(SIGUSR1, &sa, &sa_old);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 register SIGUSR1: %d", res);
> > +	EXPECT_SYSZR(1, res);
> > +	if (res)
> > +		goto out;
> > +
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 sa_old.sa_handler: SIG_DFL (%p)",
> > SIG_DFL);
> > +	EXPECT_PTREQ(1, SIG_DFL, sa_old.sa_handler);
> > +	if (res)
> > +		goto out;
> > +
> > +	res =3D sigaction(SIGUSR2, &sa, NULL);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 register SIGUSR2: %d", res);
> > +	EXPECT_SYSZR(1, res);
> > +	if (res)
> > +		goto out;
> > +
> > +	/* Trigger the first signal. */
> > +	kill(getpid(), SIGUSR1);
> > +
> > +	/* Check the two signal handlers ran in the expected order
> > */
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 signal emission: ");
> > +	EXPECT_STEPS(1, signal_check, 2);
> > +
> > +out:
> > +	sa.sa_handler =3D SIG_DFL;
> > +	res =3D sigaction(SIGUSR1, &sa, NULL);
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 restore SIGUSR1: %d", res);
> > +	EXPECT_SYSZR(1, res);
> > +
> > +	res =3D sigaction(SIGUSR1, &sa, NULL);
>=20
> SIGUSR2?
>=20
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 restore SIGUSR2: %d", res);
> > +	EXPECT_SYSZR(1, res);
> > +
> > +	llen =3D printf("%d %s", test_idx, "sigaction");
> > +	EXPECT_EQ(1, res, 0);
> > +
> > +	return ret;
> > +}
> > +
> > =C2=A0/* Run syscall tests between IDs <min> and <max>.
> > =C2=A0 * Return 0 on success, non-zero on failure.
> > =C2=A0 */
> > @@ -1421,6 +1535,7 @@ int run_syscall(int min, int max)
> > =C2=A0		CASE_TEST(syscall_noargs);=C2=A0=C2=A0=C2=A0 EXPECT_SYSEQ(1,
> > syscall(__NR_getpid), getpid()); break;
> > =C2=A0		CASE_TEST(syscall_args);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXPECT_S=
YSER(1,
> > syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
> > =C2=A0		CASE_TEST(namespace);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 EXPECT_SYSZR(euid0
> > && proc, test_namespace()); break;
> > +		case __LINE__:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D
> > test_signals(test); break;
> > =C2=A0		case __LINE__:
> > =C2=A0			return ret; /* must be last */
> > =C2=A0		/* note: do not set any defaults so as to permit
> > holes above */
> > --=20
> > 2.50.0
> >=20
>=20


