Return-Path: <linux-kselftest+bounces-10635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85E8CDB9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 22:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31161C211BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF685620;
	Thu, 23 May 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Cxyn3lWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BF85280;
	Thu, 23 May 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497476; cv=none; b=hY7htP3E4I0/dkO2AFScaJHcwn1VQI16A01twmoFJ+/Ayur2olYciQ+Xbx7NTdSWXHutL5n52ZAiRfubWHyNtwZr5jjj/K9bRmV7us/+/TwMlN26FNg2v31Zun36iaa6Tb/1YcoxHor1p3jZ0ERmB3Ld4LV2KFvBf2y8rEsF4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497476; c=relaxed/simple;
	bh=qCDeyfO04dhekItSi0mjMM0uFYDyrtCWscgp+KdPtrg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=by0TGstbCfeyOmyAh5lQjcX3883G4sIavafcX6yf62egKto/3VcEb7SvX8TGWa1ATq10+8f5yFQgrFkgOpTL3td7ma9CM7lr2XV0kK3U4K+XV+RdY6YoK+Aq1h4E47p8peoSB6fCmdMWUNYUnYZXmkaPA2YQAyIhdcN1N0fBRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Cxyn3lWg; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716497463; x=1716756663;
	bh=18i3/SzNqk7N9vvvs6RCob8+nMoLtrDWnp5u15Ezqno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Cxyn3lWgUdY+wgFWr19GeIF66D7HaGUCKHDj90GGXp2Kz0jYJDIgRWmzVsKtpU+tc
	 T8xFPiTEmpHMGTtf7q8wcjAjnDVuvG+XEl4TKtYEu/Y8M17LHyeaXgaRcLENYE3QOg
	 oN6qTV9IntZhit7ZqNAXvUjxl6lKWw7hrvKufg+UNLgN2kCYZjOAAAN+H9VWxk3SUq
	 pSYeHsUwIziNr1+5ztaLFeZ7u7/jiOquXj82jqKDDodNh6yRnbBodkYqUBQdhTITVG
	 keiIiw0fWWxDSkV7BS0FNcdHKn5Yg33MU7IADNTpQ2vZ/xhKQJ8wWGW/Cl2q/i8yEY
	 CZelDLs5B+SWg==
Date: Thu, 23 May 2024 20:50:58 +0000
To: Jeff Xu <jeffxu@google.com>
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, skhan@linuxfoundation.org, keescook@chromium.org
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Message-ID: <GTqwAy-YlNIACA_YFuJsxsV3yJdf-Xcv7jxRaCQrUPf8VN2MKrsb2O_37I3Pi5YyUtFa6WVoC-a_lnu_NF-bt5fjOcDHTFYBuVbSAWNpRDs=@protonmail.com>
In-Reply-To: <CALmYWFtNtyzkbUVR+cQ+3zxMf9TU4SHDoMsH0267n=8V-2ENcw@mail.gmail.com>
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com> <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org> <CALmYWFuLe6RaJkZ4koQpgZR-77b9PP=wooPYN-jFFw1KQ5K3aQ@mail.gmail.com> <20240523124521.99a798d645b0939d331d70c1@linux-foundation.org> <CALmYWFtNtyzkbUVR+cQ+3zxMf9TU4SHDoMsH0267n=8V-2ENcw@mail.gmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 6e2c55039883f8444e85eb2b710969c08b235ce4
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 22:44 keltez=C3=A9ssel, Jeff=
 Xu <jeffxu@google.com> =C3=ADrta:

> Hi Barnab=C3=A1s
>=20
> Is that OK that I work on V2 ? It will be based on your V1 change and
> I will also add more test cases.

Sure, please go ahead. At the very end of this letter you'll find
the commit message that I would have sent in v2, maybe you can salvage
some of it.


Regards,
Barnab=C3=A1s P=C5=91cze


>=20
> Thanks
> -Jeff
>=20
> -
>=20
> On Thu, May 23, 2024 at 12:45=E2=80=AFPM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 22 May 2024 19:32:35 -0700 Jeff Xu <jeffxu@google.com> wrote:
> >
> > > >
> > > > It's a change to a userspace API, yes?  Please let's have a detaile=
d
> > > > description of why this is OK.  Why it won't affect any existing us=
ers.
> > > >
> > > Unfortunately, this is a breaking change that might break a
> > > application if they do below:
> > > memfd_create("", MFD_NOEXEC_SEAL)
> > > fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE); <-- this will fail in new
> > > semantics, due to mfd not being sealable.
> > >
> > > However, I still think the new semantics is a better, the reason is
> > > due to  the sysctl: memfd_noexec_scope
> > > Currently, when the sysctl  is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> > > kernel adds MFD_NOEXEC_SEAL to memfd_create, and the memfd  becomes s=
ealable.
> > > E.g.
> > > When the sysctl is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> > > The app calls memfd_create("",0)
> > > application will get sealable memfd, which might be a surprise to app=
lication.
> > >
> > > If the app doesn't want this behavior, they will need one of two belo=
w
> > > in current implementation.
> > > 1>
> > > set the sysctl: memfd_noexec_scope to 0.
> > > So the kernel doesn't overwrite the mdmfd_create
> > >
> > > 2>
> > > modify their code  to get non-sealable NOEXEC memfd.
> > > memfd_create("", MEMFD_NOEXEC_SCOPE_NOEXEC)
> > > fcntl(fd, F_ADD_SEALS, F_SEAL_SEAL)
> > >
> > > The new semantics works better with the sysctl.
> > >
> > > Since memfd noexec is new, maybe there is no application using the
> > > MFD_NOEXEC_SEAL to create
> > > sealable memfd. They mostly likely use
> > > memfd(MFD_NOEXEC_SEAL|MFD_ALLOW_SEALING) instead.
> > > I think it might benefit in the long term with the new semantics.
> >
> > Yes, it's new so I expect any damage will be small.  Please prepare a
> > v2 which fully explains/justifies the thinking for this
> > non-backward-compatible change and which include the cc:stable.
> >
> >
>=20

---

memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`

`MFD_NOEXEC_SEAL` should remove the executable bits and
set `F_SEAL_EXEC` to prevent further modifications to the
executable bits as per the comment in the uapi header file:

  not executable and sealed to prevent changing to executable

However, currently, it also unsets `F_SEAL_SEAL`, essentially
acting as a superset of `MFD_ALLOW_SEALING`. Nothing implies that
it should be so, and indeed up until the second version of the of
the patchset[0] that introduced `MFD_EXEC` and `MFD_NOEXEC_SEAL`,
`F_SEAL_SEAL` was not removed, however it was changed in the
third revision of the patchset[1] without a clear explanation.

This behaviour is surprising for application developers, there
is no documentation that would reveal that `MFD_NOEXEC_SEAL`
has the additional effect of `MFD_ALLOW_SEALING`.
Additionally, combined with `vm.memfd_noexec=3D2` it has
the effect of making all memfds initially sealable.

So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is
requested, thereby returning to the pre-Linux 6.3 behaviour of
only allowing sealing when `MFD_ALLOW_SEALING` is specified.

Now, this is technically a uAPI break. However, the
damage is expected to be minimal. To trigger user
visible change, a program has to do the following steps:

 - create memfd:
   - with `MFD_NOEXEC_SEAL`,
   - without `MFD_ALLOW_SEALING`;
 - try to add seals / check the seals.

But that seems unlikely to happen intentionally since this
change essentially reverts the kernel's behaviour to that of
Linux <6.3, so if a program worked correctly on those older
kernels, it will likely work correctly after this change.

I have used Debian Code Search and GitHub to try to find potential
breakages, and I could only find a single one. dbus-broker's
memfd_create() wrapper is aware of this implicit `MFD_ALLOW_SEALING`
behaviour, and tries to work around it[2]. This workaround will
break. Luckily, this only affects the test suite, it does not affect
the normal operations of dbus-broker. There is a PR with a fix[3].

There was also a previous attempt to address
this peculiarity by introducing a new flag[4].

[0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google.com=
/
[1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google.com=
/
[2]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f2=
67d4a8784cb/src/util/misc.c#L114
[3]: https://github.com/bus1/dbus-broker/pull/366
[4]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.e=
u/

Cc: stable@vger.kernel.org
Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
Reviewed-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: David Rheinsberg <david@readahead.eu>

---

