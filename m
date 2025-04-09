Return-Path: <linux-kselftest+bounces-30401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38985A82095
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0560C1897232
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5F25A357;
	Wed,  9 Apr 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="cxcc6t7l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71925B690;
	Wed,  9 Apr 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188813; cv=none; b=h96KGNSJkpfoPSR4JP/CGWFEvj5BbPSkePUxkfXhhWsZ++Zy9wdig0yd4FbZppRaqnl6RVSbMIl/DbSZlxV+8ctPIggOsofH8v5S8ffklgi3Yyzh6ZF8PEufO2kcft5oc6vk9GvUziwNrcpDt7WsPcY/1QeGelVeLAyONaVzHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188813; c=relaxed/simple;
	bh=JANr8K80gzH6YMzB+AZDfrbEWVNq16HUPHiOCM3wntw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIOgZIuF5LNJ5V6m0BkGUtFtnVRlWA3GaL/Q24e0S/6XrXJuYXhRNftwNcb0pw5NvNYdWwgaxxmk9S7T105V8nm68d5ymLFcdaJpHdyzgN0w7NSK2M4ewu/gQWQjupHfeMAcDCQ51hQilda0WizDjw5WEUPR8ANlK0o678QOqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=cxcc6t7l; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744188807; x=1744793607; i=ps.report@gmx.net;
	bh=LWkTvKzxVOyUC8wTNsRvStz4gBx6U7IfQSnDVtRjgKc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cxcc6t7liwvnrZzvCpI0GcNiHBDSmjks6yyNz/b5PtQvR8sM3nVQw5RQNFOhhjyz
	 afDPuyiiw8jHO+bxbV1Vlm/QUcG5XOZxYtTiKFxGO+nMeajO3eadBjtLY3RubW740
	 x7GPiaillEYbeefivreB9FzpEx5e4oJZGnccpcBA+WuvSSnIafjHjt9DHwwONpMpv
	 RrgtdLB0yUbBkS9oxngHvDgn88+lp2yHCDeDKzOyqcMJGGb7EINjRDdlKvrsJbxod
	 sU92ENAUagwdgPm0S47mFH5kaj9uh6Hwe2iX8u5zjurLiZb7Wss2yKLLcjc3L3o7Z
	 nFJ/vLWfbHUSox8tJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.142]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1tJzlN2TcA-00ktu5; Wed, 09
 Apr 2025 10:53:27 +0200
Date: Wed, 9 Apr 2025 10:53:26 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests: pid_namespace: Add missing sys/mount.h
Message-ID: <20250409105326.0686ae7a@gmx.net>
In-Reply-To: <20250408230204.2775226-1-tjmercier@google.com>
References: <20250408230204.2775226-1-tjmercier@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NnAG57Me9pX9d0366GkvHaF+G1AesokUJ1FFcDYeqlh37P8A4+a
 5JcNlnbdYdq5yWRRutP4NfcJB9AE6wf6JTMmVCWOV0poKF2tCgpOqnTxGd9xgxNy2NqlgLS
 XUMLFYgP75qjav0LG7Phvg3DpJ5a6eemOvhIbKPmJRKAW/MMkMVzVoBwRxrKI04o532rEun
 OlfI7uY8mnlUzCYIZJPiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dy3nV4WxeDk=;aUdo22BEm/h0SBbu7axpZrYrjrw
 OXyYyPB9xnwrYQYL4hPxbuK2rR6L1Vlvr3XVYlJAFl673whT9oMO1OtAxx1MLKRu/5SHHYxM7
 C/zo9S95eSzfiCtDqzFtK9xq99XO6EBTPDZCvBuuf+Bu94BB53gh3JcfF08LleL478e0xozoB
 LM45HFr/rupT4ReT1FTfkSgzxVEsTs3kqi3QfWi0fUV5+jQ3bn0YSnyE3pVybMgAIJdo45K/H
 mlA1VDkjFjNnYG5C8WXol6W3FElxfeiBQeEUsMRz8bBMLYvfNYSxFJhMJf1SkoaKGg2Sna6B7
 +5MWK0e/a81XB7nd6J056/UZxMVQ98O3aRMgi9iniDdCxdAcEln+p8NyB0ZIZZ2KUOF9k8Iqr
 Gt882UWzevHyBTw5e+3/lyatpFt02kLC/vBdsb1ZoXmGRq4FuJRdIPYkSd0FNRgm/tRbb1rwc
 YVRU+OzmvfJ91qoVWYppX1Dz13vsRobJDvXnZ8NMHBJ5O6LyNBGphq1ezcEWW/nzzes9ehEXZ
 ONJ52Cq3EIGFQ7oTDJmSFF9OzUWBt8CIEoi5gIKtRx5x+9TRBu6ovYfNTssxc932TiuKicQiZ
 cTMVtg2gssYh36UsdB8LtSpOnQDALDMsMFv0vzHo8CLn1tHd9ZlmILo8ENKSMuvoshOX/3Pu4
 ZrDn8XGzhiKHiOHWuTUaDfqMXblSVEAlOEgGPDeRig4pY+6tAM51pZfMIBny2Am2JmDwOknT3
 PSebRKrJeawhDocXhaUkaV48L3Sx4bCzcXVBnifrhPFer+ka8pRw1Z68gUl18dytVO9/geZpG
 EBW3zFVvgWcp3N/zDwZXknbCaCr3nmPDGf8US5HW2ecSEdVyJHLJ+Xv8rWgzGNNxlc0c1ZeBX
 mY+K/Ukbrk9VLDz8oAol9S8YJ1ae7JFXbvAnKQcjf9ZXs7uuspHDu4nY3wiI9g9aWc0B1oCU/
 SPPuW0j9wrPlY0OiOYYSm+o2KejvGhWIcF8itzS7xlJTwr3SY8oXbcCyJR0xw19jdZJHLFqIh
 qbAiP7k92k9ouvSc4bRcwYgqbtctth8msaoOs5WQvgbH70Nqtugz+GSFpS22q4Oormz+UE8ws
 XhsPxBeSYTZC6BAtZI/iaFNnXpPb5dpCNtzKx8hAp0HYpTubqu8heJJ1EiDgv14OltqBmqIvR
 sSXZ0POqE9Yii8odHa8LIZjnXXsEm67JLhaRg383nKS7HoGuIFXuHW4JRhkTR+LyrRZ1BX+OC
 Jnfw8gczBe4hUlV8zkgXoKoCsYTA/KkrGXSJ/5K1zokNHP3DRIKns7gtPaeM4ZgqG1I2Bza7Q
 yhrOYmV1JpjPtxtmuN9HG/CGnq0dpOKfLgikKN9eo+KjH2iA72EqSPtXvb5MHAVwIAUJkEfnM
 bUIpZj0t6AOVp9RvxP11KyD5JLUN5N958G2Mu6VcpO5zw0tJZIa7jA+bjRPs59iftlcgB9Mns
 YmkU/uA==

Hello T.J.,

On Tue,  8 Apr 2025 23:02:02 +0000, "T.J. Mercier" <tjmercier@google.com> w=
rote:

> pid_max.c: In function =E2=80=98pid_max_cb=E2=80=99:
> pid_max.c:42:15: error: implicit declaration of function =E2=80=98mount=
=E2=80=99
>                                        [-Wimplicit-function-declaration]
>    42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>       |               ^~~~~
> pid_max.c:42:36: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclared (first us=
e in this
>                                   function); did you mean =E2=80=98MAP_PR=
IVATE=E2=80=99?
>    42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>       |                                    ^~~~~~~~~~
>       |                                    MAP_PRIVATE
> pid_max.c:42:49: error: =E2=80=98MS_REC=E2=80=99 undeclared (first use in=
 this function)
>    42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>       |                                                 ^~~~~~
> pid_max.c:48:9: error: implicit declaration of function =E2=80=98umount2=
=E2=80=99; did
>                you mean =E2=80=98SYS_umount2=E2=80=99? [-Wimplicit-functi=
on-declaration]
>    48 |         umount2("/proc", MNT_DETACH);
>       |         ^~~~~~~
>       |         SYS_umount2
> pid_max.c:48:26: error: =E2=80=98MNT_DETACH=E2=80=99 undeclared (first us=
e in this
>                                                                function)
>    48 |         umount2("/proc", MNT_DETACH);
>=20
> Fixes: 615ab43b838b ("tests/pid_namespace: add pid_max tests")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  tools/testing/selftests/pid_namespace/pid_max.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/test=
ing/selftests/pid_namespace/pid_max.c
> index 51c414faabb0..96f274f0582b 100644
> --- a/tools/testing/selftests/pid_namespace/pid_max.c
> +++ b/tools/testing/selftests/pid_namespace/pid_max.c
> @@ -10,6 +10,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> +#include <sys/mount.h>
>  #include <sys/wait.h>
> =20
>  #include "../kselftest_harness.h"

Predated patch already available, see

	https://lore.kernel.org/linux-kselftest/20250115105211.390370-3-ps.report@=
gmx.net/

Regards,
Peter

