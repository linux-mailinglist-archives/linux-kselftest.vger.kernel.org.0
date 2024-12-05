Return-Path: <linux-kselftest+bounces-22852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0434F9E4D09
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 05:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769E818804F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 04:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D55185955;
	Thu,  5 Dec 2024 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTVqPHhY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48A18AE2
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733372947; cv=none; b=cS8gT6j98m05TWmdqzF5sb8l29ifXKcvwJ7gumK0m9nt4bz/FIh1ozyfKAS5rzYt174FXzgyqYyZJQrXRPPooZ81ZD2FEk20mi6aIa4PUDo2Wg6kZj0p1P/WNR0BHw5EM3imGHoBpCHFbnEW0zH2C5IbgO41ksdcWJsy6NcG4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733372947; c=relaxed/simple;
	bh=erk2X4YEFsAHN5OvyynVLnBl/UM325O03lgRgw8NVzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oqPHYVjhpBFkcgeBOla6OHdOE1kP0LHgx5sCoOLZgQFfpFgwN3M+4nBI4gjHKxQcjFRmMMsDi3gl8vZ+9am9a4AWhPZmGn2Diyp/pRTphwaWDmlCfWpEd2TFA/yO6WThuNWV5cREswKOlijGZ11PnlXCh20ODZxcDHu8VhmFLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTVqPHhY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725a84ff55dso70524b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 20:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733372945; x=1733977745; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnNG0y2KdMxz8GD2qGxxV98/B5aTxULgFrbHO+ouIYA=;
        b=UTVqPHhYQxJSAQ9nAAolCAZm+aJh4J9k5+mHnEx5F4BqCs2oVF7oRF15fnBc8/Kr/2
         LzmnkNPhiO+T+dijMwyvNXKNWEY7yYAY6k4qtO3Dhd4AGwsJVQ7gT/2b/jUa7W1WjxhY
         6vksyQbcUaHwFdsPvjKS7uiR58AM7jB9fblUMulyNZnWCJhlAo/iba9W8lVufkRkxCZ7
         2EeFRTGy2xIQGNk5CdzpA9JftHw8+Kor+jzKzCq9J1yWwqsK8g09RvPRMqqO15FlHWZ5
         XE+5EfRmjC1IXP9BFeTx+NMmkDiVgtSyfCLAUEGa/fOVqvZ660kTYpH4oxFIoaBRbvCa
         kjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733372945; x=1733977745;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnNG0y2KdMxz8GD2qGxxV98/B5aTxULgFrbHO+ouIYA=;
        b=qAmutMNmulbBaRpbFeeVwkTWAw0T7Bvdnbx767Y33rDVtO0qBcxg71ewD1qdR1AhAR
         l1ueK34iIn8hPdBcAp+FPulsdz/iYL/gb8b3PWTPZbgebVMKfTgj1zi4fS+xS/zN9ZXe
         QUTPA2KvI7l6a29seToDV/yzMLfNivWMhG6ngryLV9W5AHiP0jCTV4wwZDkr5UgFdeJ5
         CXc68Ujq19onie8QBCVViyP0foCqcyl9X6nPFyhbDXHnC21LlUDYa3IEqIQ//gz1IDh8
         WPcUPZ7sNNq1Dd7V6gHp2DePxExqHNoC0WMi6P10P19fxWkl2k1zO57jhZGmc5tUZzDJ
         MGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNu449RVKpAq11Xar/8XBgMZu6vn1NfAUo2iZrTt3RJq1e2MhgJQjWwwc0aX0NWAAOIUDJqSSn+tB311k2t2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZiPZevjyURNkmq5BPihSgRUrXsTF11ClUI6Hcv4QetANizxi
	F7m9K3MI/w7gKw5V3iY2KQbBYCodL3UaGVJ6Vn9P65MDkRSJP4/FW8HLYyJZEg==
X-Gm-Gg: ASbGncvO0/R/ojuibh65YlfqFd/uRXN2AjxxZzit50oopjr0gQ8kpCnDYLaBVoTcaol
	ii8NkiqXFhgZR2ZRkkWKN01EGU+HGzaY068FhIgWlGYS9WrFIod5hmxmWtXVB31g3VD8fefKFkJ
	EpGKPyZos+XAooigqrI6SA2N1UGHHW5G/WQFgeTf6p7mLey80LiOlyhS1JcU0fmJgcfSP9sgxx+
	nqUma1S6mjfCaX/TJvBoRMAtq7avpdabGa9mQ3PbkkHgykjcBuWa3OAuJzOGEYnssiiOOWJTDVk
	p/P2UD1zMM+Z+Mikp57uUOk2SgaaeN/AFg==
X-Google-Smtp-Source: AGHT+IEzZg9Ycu6ACq6V918QeX+9XdnvPsY4ARwZ5lCe/wSw9M9g/EJq52WOr7BFv+Eht6UWmlBMow==
X-Received: by 2002:a05:6a00:1704:b0:71e:744a:3fbc with SMTP id d2e1a72fcca58-7257fcd8eebmr13689101b3a.21.1733372945107;
        Wed, 04 Dec 2024 20:29:05 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a90566sm316118b3a.94.2024.12.04.20.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 20:29:04 -0800 (PST)
Date: Wed, 4 Dec 2024 20:29:02 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Jann Horn <jannh@google.com>
cc: =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, 
    cyphar@cyphar.com, david@readahead.eu, dmitry.torokhov@gmail.com, 
    dverkamp@chromium.org, hughd@google.com, jeffxu@google.com, 
    jorgelo@chromium.org, keescook@chromium.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v4] memfd: `MFD_NOEXEC_SEAL` should not imply
 `MFD_ALLOW_SEALING`
In-Reply-To: <oW_SDTKktmL4lr9x_8kUjLvw13YMMZswM0raHDnFVLlMeaW24MSuxe7pr28Tu0JYh-19Y_4E7AU8GvWyOspbyw7qIcxgo-I-7358ix1HdL0=@protonmail.com>
Message-ID: <90ecfdb0-6b2a-3f86-b7b7-918d62345ab5@google.com>
References: <20240630184912.37335-1-pobrn@protonmail.com> <aOShI37M3MN63hDFOQGncbS8dxBsKGXVaxrwu0a5ubcrTqrPrgZJRXXYBOyiW3cHKFqh61sT4efgRsbJpvnJMDOHsurGYnr454oa3dUW3r8=@protonmail.com>
 <oW_SDTKktmL4lr9x_8kUjLvw13YMMZswM0raHDnFVLlMeaW24MSuxe7pr28Tu0JYh-19Y_4E7AU8GvWyOspbyw7qIcxgo-I-7358ix1HdL0=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1189122800-1733372944=:7673"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1189122800-1733372944=:7673
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Jann, I notice you active in the SEALing arena recently, and wonder
whether you would would have time to consider Barnab=C3=A1s's patiently
pinged and repinged points here.  Instinct tells me that he knows
what he's talking about: but the SEALing protocol was a little too
subtle for me, even at the start, and would take me a bit too long
to remaster and comment now (which may well be true of others too).

Thanks!
Hugh

On Wed, 20 Nov 2024, Barnab=C3=A1s P=C5=91cze wrote:

> Hi
>=20
>=20
> Gentle ping again. I am still hoping we can move forward with this.
>=20
>=20
> Regards,
> Barnab=C3=A1s P=C5=91cze
>=20
>=20
> 2024. szeptember 28., szombat 0:09 keltez=C3=A9ssel, Barnab=C3=A1s P=C5=
=91cze <pobrn@protonmail.com> =C3=ADrta:
>=20
> > Hi
> >=20
> >=20
> > Gentle ping. Is there any chance we could move forward with this? I am =
not aware
> > of any breakage it would cause; but longer the wait, the higher the lik=
elihood.
> >=20
> >=20
> > Regards,
> > Barnab=C3=A1s P=C5=91cze
> >=20
> > 2024. j=C3=BAnius 30., vas=C3=A1rnap 20:49 keltez=C3=A9ssel, Barnab=C3=
=A1s P=C5=91cze <pobrn@protonmail.com> =C3=ADrta:
> >=20
> > > `MFD_NOEXEC_SEAL` should remove the executable bits and set `F_SEAL_E=
XEC`
> > > to prevent further modifications to the executable bits as per the co=
mment
> > > in the uapi header file:
> > >
> > >   not executable and sealed to prevent changing to executable
> > >
> > > However, commit 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MF=
D_EXEC")
> > > that introduced this feature made it so that `MFD_NOEXEC_SEAL` unsets
> > > `F_SEAL_SEAL`, essentially acting as a superset of `MFD_ALLOW_SEALING=
`.
> > >
> > > Nothing implies that it should be so, and indeed up until the second =
version
> > > of the of the patchset[0] that introduced `MFD_EXEC` and `MFD_NOEXEC_=
SEAL`,
> > > `F_SEAL_SEAL` was not removed, however, it was changed in the third r=
evision
> > > of the patchset[1] without a clear explanation.
> > >
> > > This behaviour is surprising for application developers, there is no
> > > documentation that would reveal that `MFD_NOEXEC_SEAL` has the additi=
onal
> > > effect of `MFD_ALLOW_SEALING`. Additionally, combined with `vm.memfd_=
noexec=3D2`
> > > it has the effect of making all memfds initially sealable.
> > >
> > > So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested,
> > > thereby returning to the pre-Linux 6.3 behaviour of only allowing
> > > sealing when `MFD_ALLOW_SEALING` is specified.
> > >
> > > Now, this is technically a uapi break. However, the damage is expecte=
d
> > > to be minimal. To trigger user visible change, a program has to do th=
e
> > > following steps:
> > >
> > >  - create memfd:
> > >    - with `MFD_NOEXEC_SEAL`,
> > >    - without `MFD_ALLOW_SEALING`;
> > >  - try to add seals / check the seals.
> > >
> > > But that seems unlikely to happen intentionally since this change
> > > essentially reverts the kernel's behaviour to that of Linux <6.3,
> > > so if a program worked correctly on those older kernels, it will
> > > likely work correctly after this change.
> > >
> > > I have used Debian Code Search and GitHub to try to find potential
> > > breakages, and I could only find a single one. dbus-broker's
> > > memfd_create() wrapper is aware of this implicit `MFD_ALLOW_SEALING`
> > > behaviour, and tries to work around it[2]. This workaround will
> > > break. Luckily, this only affects the test suite, it does not affect
> > > the normal operations of dbus-broker. There is a PR with a fix[3].
> > >
> > > I also carried out a smoke test by building a kernel with this change
> > > and booting an Arch Linux system into GNOME and Plasma sessions.
> > >
> > > There was also a previous attempt to address this peculiarity by
> > > introducing a new flag[4].
> > >
> > > [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@goog=
le.com/
> > > [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@goog=
le.com/
> > > [2]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025=
bc46f267d4a8784cb/src/util/misc.c#L114
> > > [3]: https://github.com/bus1/dbus-broker/pull/366
> > > [4]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@reada=
head.eu/
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > > ---
> > >
> > > * v3: https://lore.kernel.org/linux-mm/20240611231409.3899809-1-jeffx=
u@chromium.org/
> > > * v2: https://lore.kernel.org/linux-mm/20240524033933.135049-1-jeffxu=
@google.com/
> > > * v1: https://lore.kernel.org/linux-mm/20240513191544.94754-1-pobrn@p=
rotonmail.com/
> > >
> > > This fourth version returns to removing the inconsistency as opposed =
to documenting
> > > its existence, with the same code change as v1 but with a somewhat ex=
tended commit
> > > message. This is sent because I believe it is worth at least a try; i=
t can be easily
> > > reverted if bigger application breakages are discovered than initiall=
y imagined.
> > >
> > > ---
> > >  mm/memfd.c                                 | 9 ++++-----
> > >  tools/testing/selftests/memfd/memfd_test.c | 2 +-
> > >  2 files changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > index 7d8d3ab3fa37..8b7f6afee21d 100644
> > > --- a/mm/memfd.c
> > > +++ b/mm/memfd.c
> > > @@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
> > >
> > >  =09=09inode->i_mode &=3D ~0111;
> > >  =09=09file_seals =3D memfd_file_seals_ptr(file);
> > > -=09=09if (file_seals) {
> > > -=09=09=09*file_seals &=3D ~F_SEAL_SEAL;
> > > +=09=09if (file_seals)
> > >  =09=09=09*file_seals |=3D F_SEAL_EXEC;
> > > -=09=09}
> > > -=09} else if (flags & MFD_ALLOW_SEALING) {
> > > -=09=09/* MFD_EXEC and MFD_ALLOW_SEALING are set */
> > > +=09}
> > > +
> > > +=09if (flags & MFD_ALLOW_SEALING) {
> > >  =09=09file_seals =3D memfd_file_seals_ptr(file);
> > >  =09=09if (file_seals)
> > >  =09=09=09*file_seals &=3D ~F_SEAL_SEAL;
> > > diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testi=
ng/selftests/memfd/memfd_test.c
> > > index 95af2d78fd31..7b78329f65b6 100644
> > > --- a/tools/testing/selftests/memfd/memfd_test.c
> > > +++ b/tools/testing/selftests/memfd/memfd_test.c
> > > @@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
> > >  =09=09=09    mfd_def_size,
> > >  =09=09=09    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
> > >  =09mfd_assert_mode(fd, 0666);
> > > -=09mfd_assert_has_seals(fd, F_SEAL_EXEC);
> > > +=09mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
> > >  =09mfd_fail_chmod(fd, 0777);
> > >  =09close(fd);
> > >  }
> > > --
> > > 2.45.2
> > >
>=20
---1463770367-1189122800-1733372944=:7673--

