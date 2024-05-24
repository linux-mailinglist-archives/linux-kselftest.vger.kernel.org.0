Return-Path: <linux-kselftest+bounces-10673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0479D8CE87E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280841C20A96
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66A12E1D9;
	Fri, 24 May 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Em9LLFkQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663B12E1CD;
	Fri, 24 May 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567156; cv=none; b=YRPsAKNjeMolLHCL1ke3yTSQwSyb73JhjEQzZcuHZ8DucVgfGYokzZrq/K/sJ7ZhYMe/SSJYOSIfg1gJWCmI69nS0K9n62gtF/jjN9Thi/5lDLV3aq8VjHQgPjbCijfReaTtWeEx0Z6ReCyJKdQe4ZCao1/5JnElsjjCO8lOQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567156; c=relaxed/simple;
	bh=PkpmlA/zkNI792rcgDNLFPKWwIP63bpddmC62RpAfLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxXV3TRwk5/tIYMRA6kkOkPMehmq+jJOQ2BvkLaIZOr5f9RDLMhGSfMmBsjTrJbyXElOQwurGScrjV4KQzzFr37DYctywZepoPx/WPU65zE2ADUatDoxJQUIRv1mZHXxBzHPrTmq/OpvSJ3GsjNNoh3s6fdsh3Z58v31hvX9+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Em9LLFkQ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vm96b4pdgz9snk;
	Fri, 24 May 2024 18:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716567143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+5qKHX2IsWM7J9FUKkWmszqqI4gGvklJbYhyzY7vqE=;
	b=Em9LLFkQiu/6zjn522ieKWQ1hrqAxhUL7BmUAJlC1xLxLR78NDZdWzOFQJPTPqWufI0lH4
	1a447gcUo4U3LOmz3aZPvN91yOpaBxzJkICnaJ3aojVWRp622POE241XfpZ4znfpWZI6Cn
	gwCtNKxZBENlEvZXzQZ7qzW9C6m0/Z1EH+G3lJ024fVySHH7/I4kNkMMB80xIsCG7Gfyza
	q7xEZbwstnrFWuIhNcmboL+pG1+6sFoCX3CZAsItZ3DDPsUc6SjKQ2pQknugrv73UBba5B
	ZSs4UESPLleQZ9pwqK56V5rKePDs6fY5LRTyFjGCpCXPla95626wOeEiTw+FGA==
Date: Fri, 24 May 2024 09:12:14 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jeff Xu <jeffxu@google.com>
Cc: David Rheinsberg <david@readahead.eu>, 
	=?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com, 
	Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, jorgelo@chromium.org, 
	skhan@linuxfoundation.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply
 `MFD_ALLOW_SEALING`
Message-ID: <20240524.160158-custard.odds.smutty.cuff-caukvmB4EWP9@cyphar.com>
References: <20240513191544.94754-1-pobrn@protonmail.com>
 <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com>
 <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o6rbmbukevbfurx5"
Content-Disposition: inline
In-Reply-To: <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>


--o6rbmbukevbfurx5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-23, Jeff Xu <jeffxu@google.com> wrote:
> On Thu, May 23, 2024 at 1:24=E2=80=AFAM David Rheinsberg <david@readahead=
=2Eeu> wrote:
> >
> > Hi
> >
> > On Thu, May 23, 2024, at 4:25 AM, Barnab=C3=A1s P=C5=91cze wrote:
> > > 2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 1:23 keltez=C3=A9ssel,=
 Andrew Morton
> > > <akpm@linux-foundation.org> =C3=ADrta:
> > >> It's a change to a userspace API, yes?  Please let's have a detailed
> > >> description of why this is OK.  Why it won't affect any existing use=
rs.
> > >
> > > Yes, it is a uAPI change. To trigger user visible change, a program h=
as to
> > >
> > >  - create a memfd
> > >    - with MFD_NOEXEC_SEAL,
> > >    - without MFD_ALLOW_SEALING;
> > >  - try to add seals / check the seals.
> > >
> > > This change in essence reverts the kernel's behaviour to that of Linux
> > > <6.3, where
> > > only `MFD_ALLOW_SEALING` enabled sealing. If a program works correctly
> > > on those
> > > kernels, it will likely work correctly after this change.
> > >
> > > I have looked through Debian Code Search and GitHub, searching for
> > > `MFD_NOEXEC_SEAL`.
> > > And I could find only a single breakage that this change would case:
> > > dbus-broker
> > > has its own memfd_create() wrapper that is aware of this implicit
> > > `MFD_ALLOW_SEALING`
> > > behaviour[0], and tries to work around it. This workaround will break.
> > > Luckily,
> > > however, as far as I could tell this only affects the test suite of
> > > dbus-broker,
> > > not its normal operations, so I believe it should be fine. I have
> > > prepared a PR
> > > with a fix[1].
> >
> > We asked for exactly this fix before, so I very much support this. Our =
test-suite in `dbus-broker` merely verifies what the current kernel behavio=
r is (just like the kernel selftests). I am certainly ok if the kernel brea=
ks it. I will gladly adapt the test-suite.
> >
> > Previous discussion was in:
> >
> >     [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
> >     https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahea=
d.eu/
> >
> > Note that this fix is particularly important in combination with `vm.me=
mfd_noexec=3D2`, since this breaks existing user-space by enabling sealing =
on all memfds unconditionally. I also encourage backporting to stable kerne=
ls.
> >
> Also with vm.memfd_noexec=3D1.
> I think that problem must be addressed either with this patch, or with
> a new flag.
>=20
> Regarding vm.memfd_noexec, on another topic.
> I think in addition to  vm.memfd_noexec =3D 1 and 2,  there still could
> be another state: 3
>=20
> =3D0. Do nothing.
> =3D1. This will add MFD_NOEXEC_SEAL if application didn't set EXEC or
> MFD_NOEXE_SEAL (to help with the migration)
> =3D2: This will reject all calls without MFD_NOEXEC_SEAL (the whole
> system doesn't allow executable memfd)
> =3D3:  Application must set MFD_EXEC or MFD_NOEXEC_SEAL explicitly, or
> else it will be rejected.
>=20
> 3 is useful because it lets applications choose what to use, and
> forces applications to migrate to new semantics (this is what 2 did
> before 9876cfe8).
> The caveat is 3 is less restrictive than 2, so must document it clearly.

As discussed at the time, "you must use this flag" is not a useful
setting for a general purpose operating system because it explicitly
disables backwards compatibility (breaking any application that was
written in the past 10 years!) for no reason other than "new is better".

As I suggested when we fixed the semantics of vm.memfd_noexec, if you
really want to block a particular flag from not being set, seccomp lets
you do this incredibly easily without acting as a footgun for admins.
Yes, vm.memfd_noexec can break programs that use executable memfds, but
that is the point of the sysctl -- making vm.memfd_noexec break programs
that don't use executable memfds (they are only guilty of being written
before mid-2023) is not useful.

In addition, making 3 less restrictive than 2 would make the original
restriction mechanism useless. A malicious process could raise the
setting to 3 and disable the "protection" (as discussed before, I really
don't understand the threat model here, but making it possible to
disable easily is pretty clearly). You could change the policy, but now
you're adding more complexity for a feature that IMO doesn't really make
sense in the first place.

> -Jeff
>=20
> > Reviewed-by: David Rheinsberg <david@readahead.eu>
> >
> > Thanks
> > David

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--o6rbmbukevbfurx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZlC8XgAKCRAol/rSt+lE
b1u8AQCSXfCJULF5mlBI3NTwWtmfPXHkw9y5f+xKfcb1hs0lMgEAnnJpD63h0VKg
jcEGjPSfyrhbIP6TbC+mELL+Af3N7Ao=
=SpBD
-----END PGP SIGNATURE-----

--o6rbmbukevbfurx5--

