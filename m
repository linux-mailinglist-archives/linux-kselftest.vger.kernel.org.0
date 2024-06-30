Return-Path: <linux-kselftest+bounces-12972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06291D342
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 20:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096F61F211FF
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F72C859;
	Sun, 30 Jun 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nQULbsA3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC291EB2C;
	Sun, 30 Jun 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719773378; cv=none; b=TTDSEKA7+R/2y6FDMTGNsCzmwsIER7xX/jh5K7ZDtCEzalYpGbS8BqEBiNoS/u3+GGWXZoK6G0YciE3RGClAPlI+i3YyPvdUFXhKVGt8750vU5QUcxA2kYzciGn7YzMvgadXbcjbmJK/Vi8yFPF6We1fU7WxA8+TJq3gbMJ5cuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719773378; c=relaxed/simple;
	bh=IqGTUYQRK90eTLxp0hAU3nLFudbhU6zhAXJoop2V/sU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pTh2o5y40AjQAJt1iQwI6J9y2918Jfwr0Twctk8S0dIrM1cLcZqXk914rbgZRRy/+uxWnKNWz7Sahx8mMxJhHPSFQgrZmWaY8+ZcYUIbhrTW1m8ksD7hctJT6OUKB4M8OlInCQVlYQeSVMDRo+YbCOukJnBTJ2lQ5hL5HOvFnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=nQULbsA3; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719773360; x=1720032560;
	bh=xnv/xRXqjwS70ESCf+ZLj4/uCgIU1w6IO5pGaPNkan0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nQULbsA3WewcSNNPM1MlIEbO+mRWVsHl4kyp+cPsV026zoUyPEgmrwTI5+EzFFqYe
	 HhCwROkKRum8CPwiphhndRsUZk/tAf7NPnTHuBE5/yt2dT08G3qPogp41i7hZtROZy
	 U0kYfGOHcGVb/c7NmZ3xagL0iVu9tB9/8AkOxB6gN/32QSBZOKF5hjBbL2h08M80dv
	 3T+r3w3p8zYiWlKQ8s4Pass+ItMTEQQJ6rcPOPpy+14aD/tDBvJo6NSF72+2hrOwjY
	 wgqbDKXOs4ZRKJb66c6g7ZrrKVKTBxsC3LgsWpR8YbOa3/1brKUJH02WTCQ+7sL2gE
	 fXqxqLMWqg4Zw==
Date: Sun, 30 Jun 2024 18:49:15 +0000
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org, skhan@linuxfoundation.org
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH v4] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Message-ID: <20240630184912.37335-1-pobrn@protonmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 16c190c8f7aecd734f2f341a0a7d6816e61973f2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`MFD_NOEXEC_SEAL` should remove the executable bits and set `F_SEAL_EXEC`
to prevent further modifications to the executable bits as per the comment
in the uapi header file:

  not executable and sealed to prevent changing to executable

However, commit 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC=
")
that introduced this feature made it so that `MFD_NOEXEC_SEAL` unsets
`F_SEAL_SEAL`, essentially acting as a superset of `MFD_ALLOW_SEALING`.

Nothing implies that it should be so, and indeed up until the second versio=
n
of the of the patchset[0] that introduced `MFD_EXEC` and `MFD_NOEXEC_SEAL`,
`F_SEAL_SEAL` was not removed, however, it was changed in the third revisio=
n
of the patchset[1] without a clear explanation.

This behaviour is surprising for application developers, there is no
documentation that would reveal that `MFD_NOEXEC_SEAL` has the additional
effect of `MFD_ALLOW_SEALING`. Additionally, combined with `vm.memfd_noexec=
=3D2`
it has the effect of making all memfds initially sealable.

So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested,
thereby returning to the pre-Linux 6.3 behaviour of only allowing
sealing when `MFD_ALLOW_SEALING` is specified.

Now, this is technically a uapi break. However, the damage is expected
to be minimal. To trigger user visible change, a program has to do the
following steps:

 - create memfd:
   - with `MFD_NOEXEC_SEAL`,
   - without `MFD_ALLOW_SEALING`;
 - try to add seals / check the seals.

But that seems unlikely to happen intentionally since this change
essentially reverts the kernel's behaviour to that of Linux <6.3,
so if a program worked correctly on those older kernels, it will
likely work correctly after this change.

I have used Debian Code Search and GitHub to try to find potential
breakages, and I could only find a single one. dbus-broker's
memfd_create() wrapper is aware of this implicit `MFD_ALLOW_SEALING`
behaviour, and tries to work around it[2]. This workaround will
break. Luckily, this only affects the test suite, it does not affect
the normal operations of dbus-broker. There is a PR with a fix[3].

I also carried out a smoke test by building a kernel with this change
and booting an Arch Linux system into GNOME and Plasma sessions.

There was also a previous attempt to address this peculiarity by
introducing a new flag[4].

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
Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---

* v3: https://lore.kernel.org/linux-mm/20240611231409.3899809-1-jeffxu@chro=
mium.org/
* v2: https://lore.kernel.org/linux-mm/20240524033933.135049-1-jeffxu@googl=
e.com/
* v1: https://lore.kernel.org/linux-mm/20240513191544.94754-1-pobrn@protonm=
ail.com/

This fourth version returns to removing the inconsistency as opposed to doc=
umenting
its existence, with the same code change as v1 but with a somewhat extended=
 commit
message. This is sent because I believe it is worth at least a try; it can =
be easily
reverted if bigger application breakages are discovered than initially imag=
ined.

---
 mm/memfd.c                                 | 9 ++++-----
 tools/testing/selftests/memfd/memfd_test.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 7d8d3ab3fa37..8b7f6afee21d 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
=20
 =09=09inode->i_mode &=3D ~0111;
 =09=09file_seals =3D memfd_file_seals_ptr(file);
-=09=09if (file_seals) {
-=09=09=09*file_seals &=3D ~F_SEAL_SEAL;
+=09=09if (file_seals)
 =09=09=09*file_seals |=3D F_SEAL_EXEC;
-=09=09}
-=09} else if (flags & MFD_ALLOW_SEALING) {
-=09=09/* MFD_EXEC and MFD_ALLOW_SEALING are set */
+=09}
+
+=09if (flags & MFD_ALLOW_SEALING) {
 =09=09file_seals =3D memfd_file_seals_ptr(file);
 =09=09if (file_seals)
 =09=09=09*file_seals &=3D ~F_SEAL_SEAL;
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/sel=
ftests/memfd/memfd_test.c
index 95af2d78fd31..7b78329f65b6 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
 =09=09=09    mfd_def_size,
 =09=09=09    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
 =09mfd_assert_mode(fd, 0666);
-=09mfd_assert_has_seals(fd, F_SEAL_EXEC);
+=09mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
 =09mfd_fail_chmod(fd, 0777);
 =09close(fd);
 }
--=20
2.45.2



