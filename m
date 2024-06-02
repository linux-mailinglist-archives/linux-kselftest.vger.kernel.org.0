Return-Path: <linux-kselftest+bounces-11091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D08D74A4
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 11:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9948B21167
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4B2E83F;
	Sun,  2 Jun 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZFmM/uM9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427C2940F;
	Sun,  2 Jun 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717321572; cv=none; b=kR06V17ebjlp8+fiUTurR3sxsEodhSEI4hcwa6u0U1Mqel7OTOiDne8vDMClo6tPkg1Cnz8eoTb67YFMMf4OR6Edu+yFQjIxqxpqDfHco1Mfy4RHNRi1g789rE45rk3KWL9VNzf0q89KvT7bYEovzNgTw4UyVjqmY29+TKYXkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717321572; c=relaxed/simple;
	bh=rZQdH55qQNRJ+oPz8I2FNyBtIDd6V4p/NcS1HbWfaA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVUIvLrQ9EvlcqSD15iJ7igSgMdEWrOx0gpH7u/V4Vt9qCvMvDZ3g36evN00CKliM0WxZAgEgubJOyriQk4oGkCO4tmhJ3byb8d/swrwHL5bySLrxF6Y6GrKvAkMd/ZNCbyAnzqbWel7SN/KBaW45e2kv/dYWkc6Wf3ShvsrNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZFmM/uM9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VsX6b6bGRz9sbl;
	Sun,  2 Jun 2024 11:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1717321559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4MGu+gYZhHiqQdLEwANI+Rx5K32ShCShDlDKn8KZM4I=;
	b=ZFmM/uM9aQEG5iqhB8sZv+w10ZBsfRncNOSL2unXs6RzGq/blznplwjgtysGSuruIFy30B
	ooPcAByTguqi7yXwAmEZnhm8nBclfdQP6O2Cen8zOdI5B2vJ70gBg8SNKx3DGuk6Ibzzct
	/GozljH3xX/ItFtWaJbDdxiY8q24KbHeExCQJz5k7xfe1hUiEO9OjwiOjFl8ZblIu6uQ0p
	KFqs6maZ3e+E+NEmBuVrMuc32kxUINiyHvUt7x0NYyZrdubL3pxu93gSi1+8xNhRpmF2aZ
	S6p7jAdCxR1cxll1LiEVESfy6Q/OKDw6nYyvQCgWQKneDmlBd9aZ9V9pWcCiFA==
Date: Sun, 2 Jun 2024 02:45:44 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jeff Xu <jeffxu@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>, David Rheinsberg <david@readahead.eu>, 
	=?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com, 
	Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, jorgelo@chromium.org, 
	skhan@linuxfoundation.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply
 `MFD_ALLOW_SEALING`
Message-ID: <20240602.091422-rusty.lint.soft.almond-nzWkHp0rBUnx@cyphar.com>
References: <20240513191544.94754-1-pobrn@protonmail.com>
 <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com>
 <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
 <20240524.160158-custard.odds.smutty.cuff-caukvmB4EWP9@cyphar.com>
 <CALmYWFs18vUwXx5p-VxNO5BZ0wvaHE54cG8n_+UdAL5-etAK=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nsxvarx63lbmw3nq"
Content-Disposition: inline
In-Reply-To: <CALmYWFs18vUwXx5p-VxNO5BZ0wvaHE54cG8n_+UdAL5-etAK=w@mail.gmail.com>
X-Rspamd-Queue-Id: 4VsX6b6bGRz9sbl


--nsxvarx63lbmw3nq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-28, Jeff Xu <jeffxu@google.com> wrote:
> Hi Aleksa,
>=20
> On Fri, May 24, 2024 at 9:12=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > On 2024-05-23, Jeff Xu <jeffxu@google.com> wrote:
>=20
> > > Regarding vm.memfd_noexec, on another topic.
> > > I think in addition to  vm.memfd_noexec =3D 1 and 2,  there still cou=
ld
> > > be another state: 3
> > >
> > > =3D0. Do nothing.
> > > =3D1. This will add MFD_NOEXEC_SEAL if application didn't set EXEC or
> > > MFD_NOEXE_SEAL (to help with the migration)
> > > =3D2: This will reject all calls without MFD_NOEXEC_SEAL (the whole
> > > system doesn't allow executable memfd)
> > > =3D3:  Application must set MFD_EXEC or MFD_NOEXEC_SEAL explicitly, or
> > > else it will be rejected.
> > >
> > > 3 is useful because it lets applications choose what to use, and
> > > forces applications to migrate to new semantics (this is what 2 did
> > > before 9876cfe8).
> > > The caveat is 3 is less restrictive than 2, so must document it clear=
ly.
> >
> > As discussed at the time, "you must use this flag" is not a useful
> > setting for a general purpose operating system because it explicitly
> > disables backwards compatibility (breaking any application that was
> > written in the past 10 years!) for no reason other than "new is better".
> >
> Are you referring to ratcheting in the sysctl in my original patch or
> is this something else ?
> I do not disagree with your change of  "removing the ratcheting" from
> the admin point of view.

I'm referring to your original patch making vm.memfd_noexec=3D2 reject
memfd_create() when called without MFD_EXEC or MFD_NOEXEC_SEAL (which is
what every program written pre-mid-2023 did, since those flags didn't
exist yet). This was fixed in 202e14222fad, and is separate to
ratcheting (which was fixed in 9876cfe8ec1c).

We definitely had a long discussion about it at the time.

> > As I suggested when we fixed the semantics of vm.memfd_noexec, if you
> > really want to block a particular flag from not being set, seccomp lets
> > you do this incredibly easily without acting as a footgun for admins.
>=20
> seccomp can but it requires more work for the container, e.g.
> container needs to allow-list all the syscalls.

If you're applying the rule for a single syscall you can create a
deny-list, so no need for a full-on filter for everything. Also, most
containers already have allow-list seccomp filters applied, so adjusting
them to add a restriction for one syscall is not that complicated.

> I'm trying to point out that seccomp might not cover all user-cases.

One of the reasons I'm suggesting seccomp because I think that this
"use-case" probably only exists within ChromeOS, and so adding more
kernel infrastructure around it makes little sense. seccomp has
effectively no performance overhead for something this simple and lets
you block this if you really want to.

For general purpose distributions and systems, an administrative knob to
make working programs error out if they don't pass an effectively-noop
flag to memfd_create(2) doesn't help pressure anyone into migrating
because the random unmaintained program using memfd_create(2) isn't
developed by the same company making the distribution...

How would an admin setting vm.memfd_break_random_programs=3D1 help
random_app_downloaded_from_the_internet get patched to use
MFD_EXEC/MFD_NOEXEC_SEAL? (It doesn't.)

> "ratcheting" in the vm.memfd_noexec is lightweight  and can be applied
> to the sandbox  of the container in advance, but since admin doesn't
> like ratcheting in sysctl, maybe prctl or LSM are ways to implement
> such restriction.
>
> > Yes, vm.memfd_noexec can break programs that use executable memfds, but
> > that is the point of the sysctl -- making vm.memfd_noexec break programs
> > that don't use executable memfds (they are only guilty of being written
> > before mid-2023) is not useful.
> >
> > In addition, making 3 less restrictive than 2 would make the original
> > restriction mechanism useless. A malicious process could raise the
> > setting to 3 and disable the "protection" (as discussed before, I really
> > don't understand the threat model here, but making it possible to
> > disable easily is pretty clearly).
> > You could change the policy, but now
> > you're adding more complexity for a feature that IMO doesn't really make
> > sense in the first place.
> >
> The reason of 3 is help with migration (not for threat-model), e.g. a
> container can force every apps run in the container migrates their
> memfd_create  to use either MFD_EXEC or MFD_NOEXEC_SEAL.

This is the argument you had for the behaviour of vm.memfd_noexec=3D2 at
the time. In the discussion we had last year, I explained that this is
not "helpful" for the reasons explained above.

There are plenty of old interfaces in Linux and we don't generally push
people to migrate to newer interfaces, especially since in this case
we're talking about a flag that is a no-op for the vast majority of
programs on most systems.

Only programs that need MFD_EXEC actually _need_ to switch (if distros
eventually make vm.memfd_noexec=3D1 the default in a decade or two) and
the most well-known programs that use MFD_EXEC have already been patched
(runc is probably the most obvious one, and we patched this last year).

Not to mention that a lot of programs that are maintained have already
switched to the mostly-noop MFD_NOEXEC_SEAL, so the only programs that
would be affected by this migration "help" would be older programs that
won't be pressured to update because they're unmaintained.

> But I understand what you mean, with current code,  adding 3 would
> cause more confusion to vm.memfd_noexec. Perhaps a new sysctl or prctl
> is the way to go if the app wants to force migration.
> In the hinder sight: two sysctls would work betters:  the first deal
> with migration, the second enforces NO_EXEC_SEAL.

The "help with migration" feature shouldn't exist, and I removed it in
9876cfe8ec1c for a reason.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nsxvarx63lbmw3nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZlw/SAAKCRAol/rSt+lE
b6A4AP9fzI5YnQ1cBUbCzMflLGqWUZpRUakBfO3/Jz7O67iKtQD+I9fniZeHnJ/i
Wv8Omud46bsFJbnEyO1ZrAiM2HXO+Aw=
=ZDBf
-----END PGP SIGNATURE-----

--nsxvarx63lbmw3nq--

