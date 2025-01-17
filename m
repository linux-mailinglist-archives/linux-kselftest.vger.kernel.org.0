Return-Path: <linux-kselftest+bounces-24734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FFA1519B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 15:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2227160C82
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A0A86337;
	Fri, 17 Jan 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="eu6pQa2S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B270825;
	Fri, 17 Jan 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123615; cv=none; b=M2d48z3jLutON2sUTBAQMgdWvHcZjHO2KodAue9JCIIFICIN54nMsjQox922Ze6jpF+2vDsGyMTo56Zz9nWV0kXjQuehmcvBWxHgGl0mQc3CHWd56DoAmEGiM4MweXeYKVQVO3msD9BB8ipx9y77h2cMuVnhHFiAsJWA7919ZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123615; c=relaxed/simple;
	bh=nrNJvYhw8E4VkDopDgg0689v5vx5bJZFp7VAxEcWrt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0spvgSbUHFBsKxmWjCwwF0JSzIBTtmnfKsalBugfy4Ggqc6ppDNBCfT+M1CLTaGyT24YEa5VLjeUrntV5sInTxW6+0OKZwjGuYu/gbexRNY7miMows4P0JOvr/GKSg1HoMDn5/10+oLgebsnLxpJoZiCFJmQKrfXTIW+rm8kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=eu6pQa2S; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737123609; x=1737728409; i=ps.report@gmx.net;
	bh=OwNrLLAH49IljKaaNps5+6vqCS+0Kwlc5Fu4kpYvACQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eu6pQa2SpGlGsNAyOBE7z7Gv/EWAoapJtiCIjeVQd9Q9An8ZMp9XRlNA0XaoVPlT
	 vESyiBxzAuWOW1P9oDO6PxnSaxSOP+mVbNy7abcC4mcfja0qxMmPyHvQKNGwLdqnG
	 fA5dEspvC6KM8ZxlUsn8BsKOiTbPPlacRpULxmX0x/MM//vQ/392wFaCT8f8SoUbr
	 k4E9j0BXFuA/h50uOdFz6OfqxdlvasHhi+VvYNeBLwRh0POEDHrAlq/eHFWo7wE0z
	 D2Tkr+U/0Kbw6TlFSlDjtjff6taGxYbXFlhzD1mO2JPZl/bSKD6eCh2nRHQww1YDh
	 AaZ2R7Htxadd69bBIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.138]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1tI54I2OUp-015wtB; Fri, 17
 Jan 2025 15:20:09 +0100
Date: Fri, 17 Jan 2025 15:20:08 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, Artem Chernyshev <artem.chernyshev@red-soft.ru>, Nam
 Cao <namcao@linutronix.de>
Subject: Re: [PATCH v1 1/3] selftests: pidfd: add missing sys/mount.h
 include in pidfd_fdinfo_test.c
Message-ID: <20250117152008.62f637be@gmx.net>
In-Reply-To: <20250117141450.691272-1-ps.report@gmx.net>
References: <20250117141450.691272-1-ps.report@gmx.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eApopXXwA9UNKUe2O9S7GZrapUqNy0n6QgLL2+5PCXs1T4ggodd
 g6VV9KkSxKjL1joSw/CoVz2PhJAHjGfDD0Ii6zXvVTnWGKSufbswgTFon1BNuZSX6Ez9o6M
 XlejCaDg6J66sHz2I/8EQWE31oSJ0FvRGd5Yd5jzrUAKebTPwfQfpMfl2kmhqEIAZt+T7I0
 TcvbTC0n4NeFlTinpL4lA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rrwAwxfgoao=;6TaHZpALwUOtJPJ5TPCmM9jRf01
 Pxafk0/eX6A5UbI5ImQNoQUnOaPJQTHrBOont2O0PNQxqnkJSYU3eMrYR62IRosuNGWhlIf2g
 XjD7yLGdtkFDLb1GaWHYxjqy+kwTR2XBtJRElk2SsQv/1I6e088Vx4koWmKwBi8R/YWB7GQFG
 mlmLlQN5JAxsaEu2t+1s3+W/AlJKTLqhXojFA75XtksRmFTefu6USEeRWpwy/60G308tPEI/J
 Z+93Zf0gri5sUYIVSSqMxzQisN94q6+HpyhRYWTp0JDnRXsseHyadLJapjkr1ms3A3oKH8bBR
 nJ9pVxSy6t1p58EmTjaUn1Cq+gduCgdnUDSXg+wwObVw6SeGn4UPEvRarDV9URuef0KoO5xkM
 nzo6MFeRspAgVtPGCCp9g1UYxb+U/Q97SLTsZnJP2LHwfT2jNtZK/fCARApQFsbPeB8HPO5Jm
 1JIU3QS1+AZSyCGuJmrJlqhkq9i5Isj1n8Sn3VeSZ10gz9YVuKabWU6h7mFyWs+xoaETTiR0N
 CD5ry0z/+q/If7Df9d4PifiiTuCBXvZyF6UIjBU+tIN2Pyx1qu4g8NB1hvXhIUwA/nbf6STis
 ZxKsOedqEHsRq2mTUeP2Eaowi0UucV2kQnt2FwYGUtA4hV9zxYmhZBBNkR7RG74Syx0/30ceF
 jPNZTDbC+WNVZKhBCM0UN0XZQvSvestkhCDua0sUx+h9ASFQhfmO9nlwK1l2VcFRXDBSPtBzp
 BetU4DPuZBwbiv4i4DRnvQ+tb1OmP4r9B4eDUcCFS9v9EFOJDTAVS9XlV6kZPIwp9yN+j6oMJ
 zM4WV7N7zysNW7/3aGGjiO5A1Jpia8uhsXibWNOL43KDnAhS4EYcDJ6OxCkm3wkyEZQLI5N8L
 NjOAOnofKIpL+qvjq+dY9eOuCrZW8BxqM5c4AxO0fV78/ofXeFJI6CPow9Xu6UW78v0WV91sp
 7btGi+bEHg14519vl0oK2IRD0fREZBwun/ffA0Lz718wVCoISDP7PWm1ZYwm4fSyyuoMeoVMd
 ACHEkFGi5UEiJdB5KIzu/HoA3E9jMTIo32fOn2x9xDRq0OhM1p5U2XkuA/y1/YZR1/U2lsm/y
 UHEpOXhrFi9W8MTr+CS9Vj/tJvPqVr1r4a+WKaFjMziluH2vHojsLH9K3Jd1W5O0E+ZN2FX0o
 p90oSVR6sSDcgJ7zTXWpKgkRSln6NJypjKmcBOMl3HQ==

Please ignore this e-mail (re-send by mistake of [1])..., sorry for the noi=
se...

Regards,
Peter

[1] https://lore.kernel.org/linux-kselftest/20250115105211.390370-1-ps.repo=
rt@gmx.net/


On Fri, 17 Jan 2025 15:14:48 +0100, Peter Seiderer <ps.report@gmx.net> wrot=
e:

> Fix compile on openSUSE Tumbleweed (gcc-14.2.1, glibc-2.40):
>   - add missing sys/mount.h include
>=20
> Fixes:
>=20
>   pidfd_fdinfo_test.c: In function =E2=80=98child_fdinfo_nspid_test=E2=80=
=99:
>   pidfd_fdinfo_test.c:230:13: error: implicit declaration of function =E2=
=80=98mount=E2=80=99 [-Wimplicit-function-declaration]
>     230 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>         |             ^~~~~
>=20
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/te=
sting/selftests/pidfd/pidfd_fdinfo_test.c
> index f062a986e382..f718aac75068 100644
> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> @@ -13,6 +13,7 @@
>  #include <syscall.h>
>  #include <sys/wait.h>
>  #include <sys/mman.h>
> +#include <sys/mount.h>
> =20
>  #include "pidfd.h"
>  #include "../kselftest.h"


