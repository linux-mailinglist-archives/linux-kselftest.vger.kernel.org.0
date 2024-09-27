Return-Path: <linux-kselftest+bounces-18521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149F988C52
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 00:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1300C28391E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF31B151B;
	Fri, 27 Sep 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Tx4j2PFR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AF1B151C;
	Fri, 27 Sep 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474960; cv=none; b=lOsHVaQAVqtlCHEw9PO8gNiPEUENM5dLog/37FWikRWjFTS30/75Dk5dHSDNAUynz8998V+ZD2VgxCTnxyTbJ8YblD6xro7zWRoU4/HH/81uqA9Op4zjuttfhlOZhlJhNnhzJMNkQ+fO8Wbj046PQA90K90YP0UiH5/NGYUTM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474960; c=relaxed/simple;
	bh=CM/qaVXfiW8uBR2C6CyoRxY7SPpnNXAueBczydPEdRQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/8mQyOC0Am44J0wcGI1f2YqtKPHt87lED3MmqmvX6mSOasQnUM7oSvj6bG2Im7wQLROYt/fu8ibQGbgAD7PweBduF8XWSEhcqYyvnKsrJQsUHsm5zDyxESxjTSNzIHpLdJpXu3mX7w+fDUUnmLR5465vcVUGSk6mFRgI2uwzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Tx4j2PFR; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1727474955; x=1727734155;
	bh=IPLRfC8BzQNV6CULWbRBUr4Rw+Tj/CmdqJzBvNMVXNA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Tx4j2PFRQxMBNSa4HE+J+OvJiC2rBzmY5mfDRY6pWkhrNteWd6fuhROfKcAuJGCbD
	 ryjUQ9pYbQoQnHV8EqVfpKuGBHOuHop/+2OCaalB9lxo9gkuy336EC6P3Rey2KDgeJ
	 ycSmXF93BxAQ7yOyp+h5aAxBIQvaDA4mQFmGXBxPZv/Z+82normoamF02e2fiOTFjY
	 /+2HDTDMUr4krv4JICNingcQ490pYYIMVrmodqyayceyPpFQ49lf8aVX7rYUJpQ9U/
	 JcqCksau/RyHrm8W1XYooujmYoseEVGs/RWL5d3mZ0l6mmhl7Q1gEtDEglNB0q51XJ
	 QhLtnKVLCbrUw==
Date: Fri, 27 Sep 2024 22:09:10 +0000
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org, skhan@linuxfoundation.org
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Message-ID: <aOShI37M3MN63hDFOQGncbS8dxBsKGXVaxrwu0a5ubcrTqrPrgZJRXXYBOyiW3cHKFqh61sT4efgRsbJpvnJMDOHsurGYnr454oa3dUW3r8=@protonmail.com>
In-Reply-To: <20240630184912.37335-1-pobrn@protonmail.com>
References: <20240630184912.37335-1-pobrn@protonmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 5c0df630e371707472ba21da6e6e8ab3c172f12a
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi


Gentle ping. Is there any chance we could move forward with this? I am not =
aware
of any breakage it would cause; but longer the wait, the higher the likelih=
ood.


Regards,
Barnab=C3=A1s P=C5=91cze

2024. j=C3=BAnius 30., vas=C3=A1rnap 20:49 keltez=C3=A9ssel, Barnab=C3=
=A1s P=C5=91cze <pobrn@protonmail.com> =C3=ADrta:

> `MFD_NOEXEC_SEAL` should remove the executable bits and set `F_SEAL_EXEC`
> to prevent further modifications to the executable bits as per the commen=
t
> in the uapi header file:
>=20
>   not executable and sealed to prevent changing to executable
>=20
> However, commit 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EX=
EC")
> that introduced this feature made it so that `MFD_NOEXEC_SEAL` unsets
> `F_SEAL_SEAL`, essentially acting as a superset of `MFD_ALLOW_SEALING`.
>=20
> Nothing implies that it should be so, and indeed up until the second vers=
ion
> of the of the patchset[0] that introduced `MFD_EXEC` and `MFD_NOEXEC_SEAL=
`,
> `F_SEAL_SEAL` was not removed, however, it was changed in the third revis=
ion
> of the patchset[1] without a clear explanation.
>=20
> This behaviour is surprising for application developers, there is no
> documentation that would reveal that `MFD_NOEXEC_SEAL` has the additional
> effect of `MFD_ALLOW_SEALING`. Additionally, combined with `vm.memfd_noex=
ec=3D2`
> it has the effect of making all memfds initially sealable.
>=20
> So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested,
> thereby returning to the pre-Linux 6.3 behaviour of only allowing
> sealing when `MFD_ALLOW_SEALING` is specified.
>=20
> Now, this is technically a uapi break. However, the damage is expected
> to be minimal. To trigger user visible change, a program has to do the
> following steps:
>=20
>  - create memfd:
>    - with `MFD_NOEXEC_SEAL`,
>    - without `MFD_ALLOW_SEALING`;
>  - try to add seals / check the seals.
>=20
> But that seems unlikely to happen intentionally since this change
> essentially reverts the kernel's behaviour to that of Linux <6.3,
> so if a program worked correctly on those older kernels, it will
> likely work correctly after this change.
>=20
> I have used Debian Code Search and GitHub to try to find potential
> breakages, and I could only find a single one. dbus-broker's
> memfd_create() wrapper is aware of this implicit `MFD_ALLOW_SEALING`
> behaviour, and tries to work around it[2]. This workaround will
> break. Luckily, this only affects the test suite, it does not affect
> the normal operations of dbus-broker. There is a PR with a fix[3].
>=20
> I also carried out a smoke test by building a kernel with this change
> and booting an Arch Linux system into GNOME and Plasma sessions.
>=20
> There was also a previous attempt to address this peculiarity by
> introducing a new flag[4].
>=20
> [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google.c=
om/
> [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google.c=
om/
> [2]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46=
f267d4a8784cb/src/util/misc.c#L114
> [3]: https://github.com/bus1/dbus-broker/pull/366
> [4]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead=
.eu/
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> ---
>=20
> * v3: https://lore.kernel.org/linux-mm/20240611231409.3899809-1-jeffxu@ch=
romium.org/
> * v2: https://lore.kernel.org/linux-mm/20240524033933.135049-1-jeffxu@goo=
gle.com/
> * v1: https://lore.kernel.org/linux-mm/20240513191544.94754-1-pobrn@proto=
nmail.com/
>=20
> This fourth version returns to removing the inconsistency as opposed to d=
ocumenting
> its existence, with the same code change as v1 but with a somewhat extend=
ed commit
> message. This is sent because I believe it is worth at least a try; it ca=
n be easily
> reverted if bigger application breakages are discovered than initially im=
agined.
>=20
> ---
>  mm/memfd.c                                 | 9 ++++-----
>  tools/testing/selftests/memfd/memfd_test.c | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d8d3ab3fa37..8b7f6afee21d 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
> =20
>  =09=09inode->i_mode &=3D ~0111;
>  =09=09file_seals =3D memfd_file_seals_ptr(file);
> -=09=09if (file_seals) {
> -=09=09=09*file_seals &=3D ~F_SEAL_SEAL;
> +=09=09if (file_seals)
>  =09=09=09*file_seals |=3D F_SEAL_EXEC;
> -=09=09}
> -=09} else if (flags & MFD_ALLOW_SEALING) {
> -=09=09/* MFD_EXEC and MFD_ALLOW_SEALING are set */
> +=09}
> +
> +=09if (flags & MFD_ALLOW_SEALING) {
>  =09=09file_seals =3D memfd_file_seals_ptr(file);
>  =09=09if (file_seals)
>  =09=09=09*file_seals &=3D ~F_SEAL_SEAL;
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/s=
elftests/memfd/memfd_test.c
> index 95af2d78fd31..7b78329f65b6 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
>  =09=09=09    mfd_def_size,
>  =09=09=09    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
>  =09mfd_assert_mode(fd, 0666);
> -=09mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +=09mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
>  =09mfd_fail_chmod(fd, 0777);
>  =09close(fd);
>  }
> --=20
> 2.45.2
> 

