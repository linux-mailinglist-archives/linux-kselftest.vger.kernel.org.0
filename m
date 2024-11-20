Return-Path: <linux-kselftest+bounces-22372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 001689D412D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 18:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB947B2DFF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5CF1AA7AA;
	Wed, 20 Nov 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RLdObkge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E01AA1C0
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123257; cv=none; b=RxWfND43Hd8PexzVluqLeQXSWn5SS62uleK/AKY+VnSB33L4wggxzKOaXHnFhQ3cFu51Qk1s1ZOyscsXVkODqjvxet3MtaN+8B2X53GxMMw8EAirvgFnu43dc0DcblOKCshPQgj6d7IF8rznIooRPq9O0L/lnP44Dw8s+huacDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123257; c=relaxed/simple;
	bh=ZHFKuY0fjwbcfP5H0oN136GXGZnXgOPc9J2oDjgrrIE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbcQO5WI5rjQTP6z2KobSSszzjlYK5OoBe2LOXfW/q9QXHw5ZnmL+EOpUhJabBf0B6CzwJfOvyMWlP1ptwkcqiDsxifcaDwTnLMJAo8zEO0kNtkvFkftpZlutwPrkg3fBr8DU7YHvKgEsA7m75q/aQ5os/0ibgJAW8a3SVS4wws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=RLdObkge; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1732123247; x=1732382447;
	bh=OlGaza0B5c6KUUDofYWjGR9m+lHpK3J3GBTEAcZ2GV0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RLdObkgeYcNfH39o8cuG5d0ikHScQiyIR3eX2RdQ0QVpuwb7UUnp2G+zvSnowFqNK
	 9K2ONjH5eEAVrw77i8w2qrfb8uku0O1SxaBI9N79ivQmKif+KFy09Mw8gVOIQ4uxwR
	 quSb6YiUY7JrOIJCse3WzAO/Pd1roZLxV97EGXfFtqaYLk/OfJbjqUMnJ0KReppdsp
	 LtX5BRTRmQTuN7UjOEJpJLwgNZt2YOgQh0cZgFlBNtU8Z/t5ZCOdbGQOhLPxLF6sND
	 QL8sA53+RRgHy3od54iAefqrld0j9G0KqUzyJV6Sy+GQFIRRTCW2MpEyk7WOigK/bu
	 iycfY/XlmxnLA==
Date: Wed, 20 Nov 2024 17:20:43 +0000
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org, skhan@linuxfoundation.org
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Message-ID: <oW_SDTKktmL4lr9x_8kUjLvw13YMMZswM0raHDnFVLlMeaW24MSuxe7pr28Tu0JYh-19Y_4E7AU8GvWyOspbyw7qIcxgo-I-7358ix1HdL0=@protonmail.com>
In-Reply-To: <aOShI37M3MN63hDFOQGncbS8dxBsKGXVaxrwu0a5ubcrTqrPrgZJRXXYBOyiW3cHKFqh61sT4efgRsbJpvnJMDOHsurGYnr454oa3dUW3r8=@protonmail.com>
References: <20240630184912.37335-1-pobrn@protonmail.com> <aOShI37M3MN63hDFOQGncbS8dxBsKGXVaxrwu0a5ubcrTqrPrgZJRXXYBOyiW3cHKFqh61sT4efgRsbJpvnJMDOHsurGYnr454oa3dUW3r8=@protonmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: c499259deb5b64d7a1adf3c1fadcdee5e51a3006
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi


Gentle ping again. I am still hoping we can move forward with this.


Regards,
Barnab=C3=A1s P=C5=91cze


2024. szeptember 28., szombat 0:09 keltez=C3=A9ssel, Barnab=C3=A1s P=C5=
=91cze <pobrn@protonmail.com> =C3=ADrta:

> Hi
>=20
>=20
> Gentle ping. Is there any chance we could move forward with this? I am no=
t aware
> of any breakage it would cause; but longer the wait, the higher the likel=
ihood.
>=20
>=20
> Regards,
> Barnab=C3=A1s P=C5=91cze
>=20
> 2024. j=C3=BAnius 30., vas=C3=A1rnap 20:49 keltez=C3=A9ssel, Barnab=C3=
=A1s P=C5=91cze <pobrn@protonmail.com> =C3=ADrta:
>=20
> > `MFD_NOEXEC_SEAL` should remove the executable bits and set `F_SEAL_EXE=
C`
> > to prevent further modifications to the executable bits as per the comm=
ent
> > in the uapi header file:
> >
> >   not executable and sealed to prevent changing to executable
> >
> > However, commit 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_=
EXEC")
> > that introduced this feature made it so that `MFD_NOEXEC_SEAL` unsets
> > `F_SEAL_SEAL`, essentially acting as a superset of `MFD_ALLOW_SEALING`.
> >
> > Nothing implies that it should be so, and indeed up until the second ve=
rsion
> > of the of the patchset[0] that introduced `MFD_EXEC` and `MFD_NOEXEC_SE=
AL`,
> > `F_SEAL_SEAL` was not removed, however, it was changed in the third rev=
ision
> > of the patchset[1] without a clear explanation.
> >
> > This behaviour is surprising for application developers, there is no
> > documentation that would reveal that `MFD_NOEXEC_SEAL` has the addition=
al
> > effect of `MFD_ALLOW_SEALING`. Additionally, combined with `vm.memfd_no=
exec=3D2`
> > it has the effect of making all memfds initially sealable.
> >
> > So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested,
> > thereby returning to the pre-Linux 6.3 behaviour of only allowing
> > sealing when `MFD_ALLOW_SEALING` is specified.
> >
> > Now, this is technically a uapi break. However, the damage is expected
> > to be minimal. To trigger user visible change, a program has to do the
> > following steps:
> >
> >  - create memfd:
> >    - with `MFD_NOEXEC_SEAL`,
> >    - without `MFD_ALLOW_SEALING`;
> >  - try to add seals / check the seals.
> >
> > But that seems unlikely to happen intentionally since this change
> > essentially reverts the kernel's behaviour to that of Linux <6.3,
> > so if a program worked correctly on those older kernels, it will
> > likely work correctly after this change.
> >
> > I have used Debian Code Search and GitHub to try to find potential
> > breakages, and I could only find a single one. dbus-broker's
> > memfd_create() wrapper is aware of this implicit `MFD_ALLOW_SEALING`
> > behaviour, and tries to work around it[2]. This workaround will
> > break. Luckily, this only affects the test suite, it does not affect
> > the normal operations of dbus-broker. There is a PR with a fix[3].
> >
> > I also carried out a smoke test by building a kernel with this change
> > and booting an Arch Linux system into GNOME and Plasma sessions.
> >
> > There was also a previous attempt to address this peculiarity by
> > introducing a new flag[4].
> >
> > [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google=
.com/
> > [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google=
.com/
> > [2]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc=
46f267d4a8784cb/src/util/misc.c#L114
> > [3]: https://github.com/bus1/dbus-broker/pull/366
> > [4]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahe=
ad.eu/
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > ---
> >
> > * v3: https://lore.kernel.org/linux-mm/20240611231409.3899809-1-jeffxu@=
chromium.org/
> > * v2: https://lore.kernel.org/linux-mm/20240524033933.135049-1-jeffxu@g=
oogle.com/
> > * v1: https://lore.kernel.org/linux-mm/20240513191544.94754-1-pobrn@pro=
tonmail.com/
> >
> > This fourth version returns to removing the inconsistency as opposed to=
 documenting
> > its existence, with the same code change as v1 but with a somewhat exte=
nded commit
> > message. This is sent because I believe it is worth at least a try; it =
can be easily
> > reverted if bigger application breakages are discovered than initially =
imagined.
> >
> > ---
> >  mm/memfd.c                                 | 9 ++++-----
> >  tools/testing/selftests/memfd/memfd_test.c | 2 +-
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 7d8d3ab3fa37..8b7f6afee21d 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
> >
> >  =09=09inode->i_mode &=3D ~0111;
> >  =09=09file_seals =3D memfd_file_seals_ptr(file);
> > -=09=09if (file_seals) {
> > -=09=09=09*file_seals &=3D ~F_SEAL_SEAL;
> > +=09=09if (file_seals)
> >  =09=09=09*file_seals |=3D F_SEAL_EXEC;
> > -=09=09}
> > -=09} else if (flags & MFD_ALLOW_SEALING) {
> > -=09=09/* MFD_EXEC and MFD_ALLOW_SEALING are set */
> > +=09}
> > +
> > +=09if (flags & MFD_ALLOW_SEALING) {
> >  =09=09file_seals =3D memfd_file_seals_ptr(file);
> >  =09=09if (file_seals)
> >  =09=09=09*file_seals &=3D ~F_SEAL_SEAL;
> > diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing=
/selftests/memfd/memfd_test.c
> > index 95af2d78fd31..7b78329f65b6 100644
> > --- a/tools/testing/selftests/memfd/memfd_test.c
> > +++ b/tools/testing/selftests/memfd/memfd_test.c
> > @@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
> >  =09=09=09    mfd_def_size,
> >  =09=09=09    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
> >  =09mfd_assert_mode(fd, 0666);
> > -=09mfd_assert_has_seals(fd, F_SEAL_EXEC);
> > +=09mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
> >  =09mfd_fail_chmod(fd, 0777);
> >  =09close(fd);
> >  }
> > --
> > 2.45.2
> >

