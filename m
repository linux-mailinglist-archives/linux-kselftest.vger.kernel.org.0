Return-Path: <linux-kselftest+bounces-10867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969518D4074
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 23:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293A32841E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 21:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2C169380;
	Wed, 29 May 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="bPj6VEjT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98279D3;
	Wed, 29 May 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019193; cv=none; b=AtpNhVCmPZUWtRzfUqXfYsEBh5QbfEcHcfKVrN6pM8c1adeqFS70K9jrYHumeguYt3AKJLz+MSeyWbzKunyn2c2OydSv+3mYr/wAbBQ8MtD9aIIH/CxiYm7h3ml+iCbSQ9tINk1yx/SzhK5UhxsRTtMZDXaTVaaWRv9LyvuVl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019193; c=relaxed/simple;
	bh=aNTUuXTrxMvY6T0Y5OT0xICrIYI5BjDP8IYj5p2z6jQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr+ml7bamn9u9nn0W+OAwh1k4w5OW85u0o6aeAC/Pww8qR5Ad/JIUI5hpvbA95/cbEIn1rREFmWqrRKpdg5gT2RQTIOIJAt+TkvwJw+tNhoSz2L+UqM1sJk70muLxaaixPqRETYEspe4MDPZU5WrauxbnHM7mHtKHldPY+WeRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=bPj6VEjT; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1717019184; x=1717278384;
	bh=KZdmKtYJwlym/dE/71cs1Cejh1tSMfTg6pcRpWzcT0k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bPj6VEjT8xdiArCiKo9on63FwOOGf2RdFRvVjJuA7djaRgo4l8g/l/hlw/BjHplji
	 WSM/1TSls5hw1ApQDTtOOfdZ4GxL+TgnxFqGxBKc3K0jp2dlNYgd1quk9BfuCqwVZk
	 epfx0yWeErkuRRTW4u0ThJU6RmP1iQjlPQWVBwwpYK7SeTdXi315lmBQ7d2aN89QR1
	 91S3Te9Zld9+h4e35elokPYU/IfeMYGL5GLzt1DMdYpNU5TzzH9qicjyuik9ZNMbpI
	 PIZ9F6Si+ShgTqvsA115LwxyiHAHdU3vltr2TM5X2tQt0mhqmg3+oqwfKm7IqwWRcx
	 +nbCdufmQ8qqw==
Date: Wed, 29 May 2024 21:46:19 +0000
To: Jeff Xu <jeffxu@google.com>
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: David Rheinsberg <david@readahead.eu>, Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, jorgelo@chromium.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, skhan@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
Message-ID: <b8cGJnU5ofWgsiKD5z8RGlW-2ijs7IW9h4LUg1tzFBu3agFinCvdxuiSaUDG_DfVen2vCDNu-QbGfOR7DeARf4jsy3CNNTfzQGMX1HfqHdo=@protonmail.com>
In-Reply-To: <CALmYWFu61FkbboWkXUSKBGmXeiNtBwrgfizS5kNvPMx4ByUqPQ@mail.gmail.com>
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-2-jeffxu@google.com> <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com> <CALmYWFu61FkbboWkXUSKBGmXeiNtBwrgfizS5kNvPMx4ByUqPQ@mail.gmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 713e68629d8783518d3538e80e4bce8eb2fe251c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi


2024. m=C3=A1jus 29., szerda 23:30 keltez=C3=A9ssel, Jeff Xu <jeffxu@google=
.com> =C3=ADrta:

> Hi David and Barnab=C3=A1s
>=20
> On Fri, May 24, 2024 at 7:15=E2=80=AFAM David Rheinsberg <david@readahead=
.eu> wrote:
> >
> > Hi
> >
> > On Fri, May 24, 2024, at 5:39 AM, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@google.com>
> > >
> > > By default, memfd_create() creates a non-sealable MFD, unless the
> > > MFD_ALLOW_SEALING flag is set.
> > >
> > > When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD create=
d
> > > with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
> > > This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
> > > unless MFD_ALLOW_SEALING is explicitly set.
> > >
> > > This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
> > > is new, we expect not many applications will rely on the nature of
> > > MFD_NOEXEC_SEAL being sealable. In most cases, the application alread=
y
> > > sets MFD_ALLOW_SEALING if they need a sealable MFD.
> >
> > This does not really reflect the effort that went into this. Shouldn't =
this be something along the lines of:
> >
> >     This is a non-backward compatible change. However, MFD_NOEXEC_SEAL
> >     was only recently introduced and a codesearch revealed no breaking
> >     users apart from dbus-broker unit-tests (which have a patch pending
> >     and explicitly support this change).
> >
> Actually, I think we might need to hold on to this change. With debian
> code search, I found more codes that already use MFD_NOEXEC_SEAL
> without MFD_ALLOW_SEALING. e.g. systemd [1], [2] [3]

Yes, I have looked at those as well, and as far as I could tell,
they are not affected. Have I missed something?


Regards,
Barnab=C3=A1s


>=20
> I'm not sure if this  will break  more applications not-knowingly that
> have started relying on MFD_NOEXEC_SEAL being sealable. The feature
> has been out for more than a year.
>=20
> Would you consider my augments in [4] to make MFD to be sealable by defau=
lt ?
>=20
> At this moment, I'm willing to add a document to clarify that
> MFD_NOEXEC_SEAL is sealable by default, and that an app that needs
> non-sealable MFD can  set  SEAL_SEAL.  Because both MFD_NOEXEC_SEAL
> and vm.memfd_noexec are new,  I don't think it breaks the existing
> ABI, and vm.memfd_noexec=3D0 is there for backward compatibility
> reasons. Besides, I honestly think there is little reason that MFD
> needs to be non-sealable by default.  There might be few rare cases,
> but the majority of apps don't need that.  On the flip side, the fact
> that MFD is set up to be sealable by default is a nice bonus for an
> app - it makes it easier for apps to use the sealing feature.
>=20
> What do you think ?
>=20
> Thanks
> -Jeff
>=20
> [1] https://codesearch.debian.net/search?q=3DMFD_NOEXEC_SEAL
> [2] https://codesearch.debian.net/show?file=3Dsystemd_256~rc3-5%2Fsrc%2Fh=
ome%2Fhomed-home.c&line=3D1274
> [3] https://sources.debian.org/src/elogind/255.5-1debian1/src/shared/seri=
alize.c/?hl=3D558#L558
> [4] https://lore.kernel.org/lkml/CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=3DuO9Oew=
MhGfhGCY66Hbw@mail.gmail.com/
>=20
>=20
> > > Additionally, this enhances the useability of  pid namespace sysctl
> > > vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
> > > add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
> > > MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
> > > to be sealable. This means, any application that does not desire this
> > > behavior will be unable to utilize vm.memfd_noexec =3D 1 or 2 to
> > > migrate/enforce non-executable MFD. This adjustment ensures that
> > > applications can anticipate that the sealable characteristic will
> > > remain unmodified by vm.memfd_noexec.
> > >
> > > This patch was initially developed by Barnab=C3=A1s P=C5=91cze, and B=
arnab=C3=A1s
> > > used Debian Code Search and GitHub to try to find potential breakages
> > > and could only find a single one. Dbus-broker's memfd_create() wrappe=
r
> > > is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
> > > work around it [1]. This workaround will break. Luckily, this only
> > > affects the test suite, it does not affect
> > > the normal operations of dbus-broker. There is a PR with a fix[2]. In
> > > addition, David Rheinsberg also raised similar fix in [3]
> > >
> > > [1]:
> > > https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f=
267d4a8784cb/src/util/misc.c#L114
> > > [2]: https://github.com/bus1/dbus-broker/pull/366
> > > [3]:
> > > https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.=
eu/
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> > > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > Reviewed-by: David Rheinsberg <david@readahead.eu>
> >
> > Looks good! Thanks!
> > David
> 

