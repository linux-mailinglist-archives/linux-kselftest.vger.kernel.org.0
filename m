Return-Path: <linux-kselftest+bounces-10156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAAC8C476B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5238B1F22AE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1C54FB8;
	Mon, 13 May 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="paUo6HvC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0745016
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627768; cv=none; b=fFT6V4JMNwvpZV/+Q/VxBJacn7t7HTIocweNqM24JtXJrgB8+8zrCwzJ6TAy+tWienZ0tOe45A1pEmZDx2wYKo6JzpqKKm0mZBNac01EEe3vEz3lNrtrzWzzGTz0x32Ki6vtX8X8tVq8/h9V4vBWHtZVWTSC9JLNdxCIPxAwg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627768; c=relaxed/simple;
	bh=VTNZ62sNInU+Dd0cJEiFTSXsmrSxsvXnwZWnDCIDW1w=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=hgldSHEFB7SUdny1m39ODq5BV1ccwqI3lMEjXp9OkFqOxlUiv2OiKt73Qlo4tJ3Kq6lNiiw3UnXUT5GVX8mbyD/pNFnoiuZ2XVFUymhEjiHzWnpAFJ6Nkrth68Nk/kV1b72RQA2cNeCSvUOMIV4tbA5tZ/H6Pmac7jWo2T0u8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=paUo6HvC; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1715627756; x=1715886956;
	bh=dnjH8R0E9R4kgtyNo0zRZg9A30KPJQ23f20lyVjqLUg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=paUo6HvCMLe0YNG7ppE6+OPvGgid8o+AocVm7IAPnTOOrvFA/8N/tGUWjA2zzNR1c
	 GVx7xT77FF6o+JP6+Zh09H3imzNnz4rQhZagjM1M4nrgThGaih72r6wrtOP2kNxl1N
	 DHbwRXhrAulrtdz47x25GKugAUt/IFC4+3U0hkAal6Rsx3QureSft5H303iwrUXdAZ
	 2d1HKUW2K6Qb8kG8VCuE3vE68ZJkRpggJJeRMvYUA1o6wPDzzN/Xw3TwTFvAZ09tQI
	 fER0eEvBGTX1P0vNjY9qTuqab6A7AQNHppc7siqrvJvq4Vy0zENWkFww/RnFLoYQde
	 aPh/FMAymeUSw==
Date: Mon, 13 May 2024 19:15:47 +0000
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jeffxu@google.com, jorgelo@chromium.org, skhan@linuxfoundation.org, keescook@chromium.org
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Message-ID: <20240513191544.94754-1-pobrn@protonmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 67eeb4ec5ac3eaf815ed12f6c17c9a0732f87faa
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`MFD_NOEXEC_SEAL` should remove the executable bits and set
`F_SEAL_EXEC` to prevent further modifications to the executable
bits as per the comment in the uapi header file:

  not executable and sealed to prevent changing to executable

However, currently, it also unsets `F_SEAL_SEAL`, essentially
acting as a superset of `MFD_ALLOW_SEALING`. Nothing implies
that it should be so, and indeed up until the second version
of the of the patchset[0] that introduced `MFD_EXEC` and
`MFD_NOEXEC_SEAL`, `F_SEAL_SEAL` was not removed, however it
was changed in the third revision of the patchset[1] without
a clear explanation.

This behaviour is suprising for application developers,
there is no documentation that would reveal that `MFD_NOEXEC_SEAL`
has the additional effect of `MFD_ALLOW_SEALING`.

So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested.
This is technically an ABI break, but it seems very unlikely that an
application would depend on this behaviour (unless by accident).

[0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google.com=
/
[1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google.com=
/

Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---

Or did I miss the explanation as to why MFD_NOEXEC_SEAL should
imply MFD_ALLOW_SEALING? If so, please direct me to it and
sorry for the noise.

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
index 18f585684e20..b6a7ad68c3c1 100644
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
2.45.0



