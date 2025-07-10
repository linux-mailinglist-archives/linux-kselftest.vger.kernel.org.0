Return-Path: <linux-kselftest+bounces-36902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EFEAFF88A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 07:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1133BFCB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 05:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F221FF23;
	Thu, 10 Jul 2025 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fX/wUKfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCA284665
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125705; cv=none; b=ZHS/YzEn1nWzdrkuPoTfZ9//gKtYE+Uds8oXWwlGppQNtZjd7N5Dp1MOLkBi7TzsKwJqetPxqupPKf6DFcor+CmeUxlpiYQ89V5cYTqGA7JcmxGbot6cA7J8mkVQ6DWsItlaIPUofrRsb+gWDFdGS1ywN8JEQRh2co8pOBTrSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125705; c=relaxed/simple;
	bh=eiHWOdhVsqBEJQQ7rkUfw5idQMaDzabGdmcivzSrmw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BAWAd1K8UfTDrpSEJ/bthpO97g/l9S2cz27Tla6cGy2OY/SvGMniVCX0MoUjDkpf8kzIJwj8s+T+xIU7DJ+wq2yivX0FoDtCb6gP2nTZQELHy7C4N8BLwSsns+GwgBkb55C3b9Z40ChEHEQSXCCsu0eUfSV7Cf5MAgJBI+JC200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fX/wUKfi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DaXyqqCmB6axP8TKvI2sI3ymTSmDZMwkHqFrC8fuiSk=;
	t=1752125703; x=1753335303; b=fX/wUKfiBUeI7uV+4u/DNs13/J6qb+baDeqa/TV/soO6cHr
	uYN6jKw95odS4C/QFnyNRJsuDDt4cKO7GFptRBhWk0GaxO/Fyq1Wnq8J322Tri3z28CuOpufR6Ehu
	IQDDI9w1DMRQb9Z7S02jrdM0AtEv15T0OPengzxF59eWGJ89q5LxzsVLfNPGeCHd7N+484TncsgZN
	pPrbiB4cn8KOfmaVtNMMbexT2s94sUroRrRk1wsskwC7u0tAkh+aaWetwt9Gw2+dRkHHnXFzIarIe
	ptH7D6YEy67BO1TP039J4n77zYm7uHHmQ/lai3YpwMkKUchIwsHh8GPo7iXUMcjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZjvr-0000000ET5J-2KMY;
	Thu, 10 Jul 2025 07:34:56 +0200
Message-ID: <aba37e62148b65c9f127c7f4248c72920f9cf0de.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] tools/nolibc: add signal support
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org
Date: Thu, 10 Jul 2025 07:34:52 +0200
In-Reply-To: <7a524c29-6d2e-4676-82cb-28b0af76e1b7@t-8ch.de>
References: <20250709155512.971080-1-benjamin@sipsolutions.net>
	 <20250709155512.971080-4-benjamin@sipsolutions.net>
	 <7a524c29-6d2e-4676-82cb-28b0af76e1b7@t-8ch.de>
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

On Wed, 2025-07-09 at 23:21 +0200, Thomas Wei=C3=9Fschuh wrote:
> On 2025-07-09 17:55:12+0200, Benjamin Berg wrote:
> (...)
>=20
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1270,6 +1270,72 @@ int test_namespace(void)
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > +sig_atomic_t signal_check;
>=20
> static?

Oops.

>=20
> > +
> > +static void sighandler(int signum)
> > +{
> > +	if (signum =3D=3D SIGUSR1) {
> > +		kill(getpid(), SIGUSR2);
> > +		signal_check =3D 1;
> > +	} else {
> > +		signal_check++;
> > +	}
>=20
> This could use some operations which make it clearer which steps
> occurred in which order. See the constructor tests.

Could it be that the constructor test logic is buggy? It seems to
simply OR the bottom two bits, but doing that will not verify the
order.

Maybe something more generic like the below macro? i.e. use the bottom
bit to store whether the order has been correct.

/* Set BIT(step + 1), BIT(0) shows whether all steps ran in order */
#define mark_step_done(v, step) do {  \
        v |=3D v & (1 << ((step) + 1)); \
        if (v =3D=3D 0 && (step) =3D=3D 0)    \
            v |=3D 0x1;                 \
        else if (!(v & (1 << (step))) \
            v &=3D ~0x1;                \
    } while (0)

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
> > +	sigemptyset(&sa.sa_mask);
> > +	sigaddset(&sa.sa_mask, SIGUSR2);
>=20
> I'd like to see some tests for the sigset functions.

Heh, yeah. sigaddset is kind of tested indirectly when verifying the
emission order. But that just makes it unclear where the test failed.

Benjamin

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
> > +	/* If signal_check is 1 or higher, then signal emission
> > worked */
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 signal emission: 1 <=3D signal_ch=
eck");
> > +	EXPECT_GE(1, signal_check, 1);
> > +
> > +	/* If it is 2, then signal masking worked */
> > +	llen =3D printf("=C2=A0=C2=A0=C2=A0 signal masking: 2 =3D=3D signal_c=
heck");
> > +	EXPECT_EQ(1, signal_check, 2);
> > +
> > +out:
> > +	llen =3D printf("%d %s", test_idx, "sigaction");
> > +	EXPECT_EQ(1, res, 0);
>=20
> Restore the default handler afterwards?
>=20
> > +
> > +	return ret;
> > +}
> > +
> > =C2=A0/* Run syscall tests between IDs <min> and <max>.
> > =C2=A0 * Return 0 on success, non-zero on failure.
> > =C2=A0 */
> > @@ -1398,6 +1464,7 @@ int run_syscall(int min, int max)
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


