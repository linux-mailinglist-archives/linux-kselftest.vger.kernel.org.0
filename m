Return-Path: <linux-kselftest+bounces-2364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473C81C965
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494FA1C2147F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481714AB1;
	Fri, 22 Dec 2023 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+ckMuZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450517984
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbc4675749so285131a34.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703245873; x=1703850673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BoM5xHXFmNnDYRPpvEPp480i76UtG2GRcAozKAy32GE=;
        b=S+ckMuZ7m8RC5KKbJNDz7mhVemuksrd65ncJQ2J40KIAGK2Xfya+73VgGf88PFU+I0
         /wa1QH/KWmaT+dsdMGrj9kzLKDAzgzvLIBmcHrH6HnvNqqPhQjUMafIDo9wf26F6JzJ6
         Z/wxU57ES3ZJqEPcKhR72IdHfcQAdmxZy6tEMQMZiPBG5rN9vuROAnq7XqoA2p6fuBN7
         ix3UvfuCIRayhZBbi4KxkIA4aO+pECRRfCHgiMSRF51hxWP73CerX8OorXTUKWANcLbO
         JTavaFfLIEbEUy7sVmPgdK+g/8YDmV5d4aDASeN+L2I6xnWsmq9fZYYbQ6i/QsLxWVxI
         25LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703245873; x=1703850673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoM5xHXFmNnDYRPpvEPp480i76UtG2GRcAozKAy32GE=;
        b=Ue6Cunt7N+i3AkrTavoNKUnaYxsHRQlA0ImErS9XUjPf03ZT8SEq+bfTj8lmTx0gta
         yjM/sY9SoastahXmb7EGEEHBc1w24hwATnfom2iJt6zK1bm2ycGfDqRzWSXWIZwm3l1e
         0L/Nox/LxQpA0fHOMNdc6OHCtaT5/P2QfnBPd7CdZjnsl502bZAVCvmWFtSmr8cyqQtp
         L58aXh/JHUT24HKQheirW/79J6Giy8KhW+oTRFdVhZaB9ZWudxLalLb5GCrSn0slDnaI
         eD1mzlqq71nNr5qw8zxC/hkiXVgbSeDCIHELyn6Wt+WN3SSq6lTH21SUj7SCptPbpYKC
         AVYg==
X-Gm-Message-State: AOJu0YwP8rLDrx0XIrw3+8dwPtlMOjdlChyWagi4UvxK/OKil7ohMOjH
	HR0PBKPr9+nU6LoDQenktrGBZThw+hX0kB3mmEe7Dd49jIo=
X-Google-Smtp-Source: AGHT+IFw4K55CFuOVXFhnBfb+XlWVqL/EHzoInQ/RG677cRc/CcrXScIzdNRNNszNL9RZPILzb/MRQ==
X-Received: by 2002:a05:6830:100e:b0:6db:bd00:d646 with SMTP id a14-20020a056830100e00b006dbbd00d646mr956782otp.26.1703245869210;
        Fri, 22 Dec 2023 03:51:09 -0800 (PST)
Received: from vps.terceiro.xyz (vps.terceiro.xyz. [191.101.235.31])
        by smtp.gmail.com with ESMTPSA id b16-20020a63cf50000000b005aa800c149bsm3174759pgj.39.2023.12.22.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:51:08 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:14d:7224:8745:26f4:3599:ce80:10])
	by vps.terceiro.xyz (Postfix) with ESMTPSA id 8B129441D4;
	Fri, 22 Dec 2023 08:51:04 -0300 (-03)
Date: Fri, 22 Dec 2023 08:50:56 -0300
From: Antonio Terceiro <antonio.terceiro@linaro.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: uevent: use shared makefile library
Message-ID: <ZYV4ICTvandgWE4I@linaro.org>
References: <20231221204908.341677-2-antonio.terceiro@linaro.org>
 <f38374bd-bb1f-451e-9d34-9c38029ffd15@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VtLPA9UNJt+q8agv"
Content-Disposition: inline
In-Reply-To: <f38374bd-bb1f-451e-9d34-9c38029ffd15@linuxfoundation.org>


--VtLPA9UNJt+q8agv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 02:44:52PM -0700, Shuah Khan wrote:
> On 12/21/23 13:49, Antonio Terceiro wrote:
> > This makes the uevent selftests build not write to the source tree
> > unconditionally, as that breaks out of tree builds when the source tree
> > is read-only. It also avoids leaving a git repository in a dirty state
> > after a build.
> >=20
>=20
> Why can't you do that using make O=3D directive.

That's what I meant by out of tree builds. When using O=3D, the uevent
selftests build still writes to the source directory. Maybe my wording
in the commit message is not clear enough, I will try to improve it.

> > v2: drop spurious extra SPDX-License-Identifier
> >=20
> > Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> > ---
> >   tools/testing/selftests/uevent/Makefile | 15 +++------------
> >   1 file changed, 3 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/uevent/Makefile b/tools/testing/se=
lftests/uevent/Makefile
> > index f7baa9aa2932..872969f42694 100644
> > --- a/tools/testing/selftests/uevent/Makefile
> > +++ b/tools/testing/selftests/uevent/Makefile
> > @@ -1,17 +1,8 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   all:
> > -include ../lib.mk
> > -
> > -.PHONY: all clean
> > -
> > -BINARIES :=3D uevent_filtering
> > -CFLAGS +=3D -Wl,-no-as-needed -Wall
> > +CFLAGS +=3D -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
> > -uevent_filtering: uevent_filtering.c ../kselftest.h ../kselftest_harne=
ss.h
> > -	$(CC) $(CFLAGS) $< -o $@
> > +TEST_GEN_PROGS =3D uevent_filtering
> > -TEST_PROGS +=3D $(BINARIES)
> > -EXTRA_CLEAN :=3D $(BINARIES)
> > -
> > -all: $(BINARIES)
> > +include ../lib.mk
>=20
> This change doesn't get the intended result of not writing to
> source tree. Binaries will still be written to the source
> tree unless O=3D is specified.

It does in my tests. Maybe I am missing something.

mainline without the patch:

----------------8<----------------8<----------------8<-----------------
$ make -s defconfig O=3D/tmp/output && make -s kselftest-all TARGETS=3Dueve=
nt O=3D/tmp/output
make[4]: Entrando no diret=F3rio '/home/terceiro/src/linaro/linux/tools/tes=
ting/selftests/uevent'

make[4]: Nada a ser feito para 'all'.
make[4]: Saindo do diret=F3rio '/home/terceiro/src/linaro/linux/tools/testi=
ng/selftests/uevent'

$ git status --ignored
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	tools/testing/selftests/uevent/uevent_filtering

nothing added to commit but untracked files present (use "git add" to track)
$ git clean -dxf
Removing tools/testing/selftests/uevent/uevent_filtering
----------------8<----------------8<----------------8<-----------------

mainline with the patch:

----------------8<----------------8<----------------8<-----------------
$ git branch -m kselftest-uvent kselftest-uvent-o
$ rm -rf /tmp/output/
$ make -s defconfig O=3D/tmp/output && make -s kselftest-all TARGETS=3Dueve=
nt O=3D/tmp/output
make[4]: Entrando no diret=F3rio '/home/terceiro/src/linaro/linux/tools/tes=
ting/selftests/uevent'

gcc -Wl,-no-as-needed -Wall -isystem /tmp/output/usr/include     uevent_fil=
tering.c  -o /tmp/output/kselftest/uevent/uevent_filtering
make[4]: Saindo do diret=F3rio '/home/terceiro/src/linaro/linux/tools/testi=
ng/selftests/uevent'

$ git status --ignored
On branch kselftest-uvent-o
nothing to commit, working tree clean
$ git clean -dxf
$
----------------8<----------------8<----------------8<-----------------

--VtLPA9UNJt+q8agv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEst7mYDbECCn80PEM/A2xu81GC94FAmWFeBoACgkQ/A2xu81G
C94m0Q//WKZqcUvOON9R0vYG+fWY3pF617BKqujoKftM8Glhtq1bQob8x7z3P7u/
FvFvuG7VhkkUtUmOsKFSWghJRnSGDQiKzFnmwWO3U48rsFsuWIohk58kGTDRacoU
gfYXHLhe7yRNGtHfZXh+s7XSNxaX3QZG1YVstMmb4WJwAqXN6WaKIuXcPTwAl7rO
G1SPD+kxUDc+jpAx9j81o6Syy5F3Cuj8hqQEjJrk/rD6QhgCxNtWwNM1OnxnJZRc
pGzu23Ta7y6JGEe0UfwGn/HbhhXL3TJXVvIgzlMb3eY3zPVRhjVT3T6mUyWjSCV5
wfpl2YrpSTp9Iay+booAZTrM+V5dUgFIj2kYGlxRlAYWwGxYr0LKPORMQ+FJQcla
H5L0exfaZDGmfv3H6BHH0YdmkyzK8o6T2BDCD+1VR+n1BlxgY7QPUfD9BwiS7aQ2
S2XttPwX7IvmnP7oRlT5aqudeooRadjhxcVLTQpvrXumq8EUgEmTa/GISyEx22Ct
a08kZMNWP5TN02G65swLfDLDmLgVvZdeFPbnoqjwbrCLnqaClhhqOd0Hvti1E653
y9AdomoOjtD28E6M+YFmcaZfMm9PjexWP8yQS2j0Qu5M31OtTjm4remReV2BfpYB
+g0KgpoW7bh11mQ3m2jKY620aeD1U1+1f/2YCPa26xND5FkqU6U=
=Khk4
-----END PGP SIGNATURE-----

--VtLPA9UNJt+q8agv--

