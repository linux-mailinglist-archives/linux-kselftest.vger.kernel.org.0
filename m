Return-Path: <linux-kselftest+bounces-25090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB1A1B630
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 13:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC203AB7D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33A21B8EC;
	Fri, 24 Jan 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="TxayL//A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25121ADD2;
	Fri, 24 Jan 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737722351; cv=pass; b=epatdpgg2bSaQ7Dqi7QoYfjLd/0u4eVTxJ5K/Nqtkpv+Ir5phRYbuQ8007E5Z7GgxeAj8ehWghn3omclITcAkhskENO/BDJXjJA0GY6qFHfgbKhY2SH8r3Fg1jBUtOAelT99jH0JNbpTaHNrITr41j+qvI9bhMRCJFS1FE77+PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737722351; c=relaxed/simple;
	bh=BnaKqUMx/5xxJpefsuh2ZWFnIFl/tt2gQ7RQyWhf3+o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PrLEmCFJLhMX0EKp8yoJXLj2GQxnkhXeWn2b2VZRQj5dUvua7CnjVy579NN/5d7DWzjg2zHCepA//9rkN8rN17/3lCr52qlDnm/Yy3LrtsfYfGg9SMz5nkqJLSQh7VfuB0oXoD8ACvLk/S8cx6AxV/iRqIjBIyJj+Req3RUQtAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=TxayL//A; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1737722236; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U3VHYO1tH1DMPzZ5cJJ5KRlwIKMY5izvskTTfMCKmRw8idAUgvJ3YnFpDLJpuKbSIWLTkDDIPLlo0icKGFkwMadJagFqhsbCVvyYXxuA3duDqWb4O8IJC9JWSxEEYYmgeEDCpk9mQOgvO+eu0VLWDiv7TD9MXEkIR3NDfSkIwuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737722236; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t3fpFLpP+ybPFZs7+3nyDWIgdfGTRgmmLMx7sHYoeVE=; 
	b=hbvtKuRCVBCKiVXtUaXdVEvNuHWY387RaH66LtcdJg1JEgD9rCIAIrqTwlcE1us8KJurSTCCqpqmlGvHt1sUQ9z+kXs/hvQHVxRVQ7054FnRIYHsLYqH/Y3F89cwBIvJmJR1FN8QgL8KSj32TTqemyMlv59EGpr3CWVIpZzR9Zw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737722236;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=t3fpFLpP+ybPFZs7+3nyDWIgdfGTRgmmLMx7sHYoeVE=;
	b=TxayL//AsaV0OsyQtjmpdcZXozgpOcW0p2sNgH5x4s410pxrrWpow50elj7CJmTx
	SuAdTfPOLSz/wA9p8+cDNRz1gCrNO8P5v5AMXlG9FKzKLBSGABxOTYT9kth4HkDmj34
	7Duh/lyaB0RsiwqHWJKzs/9mg01dYkZnC4owIbXE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1737722233660655.1626114574647; Fri, 24 Jan 2025 04:37:13 -0800 (PST)
Date: Fri, 24 Jan 2025 09:37:13 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "Simona Vetter" <simona.vetter@ffwll.ch>
Cc: "Vignesh Raman" <vignesh.raman@collabora.com>,
	"kernelci" <kernelci@lists.linux.dev>,
	"linuxtv-ci" <linuxtv-ci@linuxtv.org>,
	"dave.pigott" <dave.pigott@collabora.com>,
	"mripard" <mripard@kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"gustavo.padovan" <gustavo.padovan@collabora.com>,
	"pawiecz" <pawiecz@collabora.com>, "spbnick" <spbnick@gmail.com>,
	"tales.aparecida" <tales.aparecida@gmail.com>,
	"workflows" <workflows@vger.kernel.org>,
	"skhan" <skhan@linuxfoundation.org>,
	"kunit-dev" <kunit-dev@googlegroups.com>,
	"nfraprado" <nfraprado@collabora.com>,
	"davidgow" <davidgow@google.com>, "cocci" <cocci@inria.fr>,
	"Julia.Lawall" <Julia.Lawall@inria.fr>,
	"laura.nao" <laura.nao@collabora.com>,
	"kernel" <kernel@collabora.com>,
	"torvalds" <torvalds@linuxfoundation.org>,
	"gregkh" <gregkh@linuxfoundation.org>,
	"daniels" <daniels@collabora.com>,
	"shreeya.patel" <shreeya.patel@collabora.com>,
	"denys.f" <denys.f@collabora.com>,
	"nicolas.dufresne" <nicolas.dufresne@collabora.com>,
	"louis.chauvet" <louis.chauvet@bootlin.com>,
	"hamohammed.sa" <hamohammed.sa@gmail.com>,
	"melissa.srw" <melissa.srw@gmail.com>, "simona" <simona@ffwll.ch>,
	"airlied" <airlied@gmail.com>, "Tim.Bird" <Tim.Bird@sony.com>,
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
	"broonie" <broonie@kernel.org>, "leobras.c" <leobras.c@gmail.com>,
	"groeck" <groeck@google.com>, "rdunlap" <rdunlap@infradead.org>,
	"geert" <geert@linux-m68k.org>,
	"michel.daenzer" <michel.daenzer@mailbox.org>,
	"sakari.ailus" <sakari.ailus@iki.fi>, "jarkko" <jarkko@kernel.org>
Message-ID: <194985102fd.cfcde36741735.2441429304516590558@collabora.com>
In-Reply-To: <Z5KhNx2gUU2kc9NP@phenom.ffwll.local>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <20250123135342.1468787-4-vignesh.raman@collabora.com> <Z5KhNx2gUU2kc9NP@phenom.ffwll.local>
Subject: Re: [PATCH v2 3/5] kci-gitlab: Add drm scenario
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Simona,

Thank you for your comments,


---- On Thu, 23 Jan 2025 17:06:15 -0300 Simona Vetter  wrote ---

 > On Thu, Jan 23, 2025 at 07:23:33PM +0530, Vignesh Raman wrote:=20
 > > Add a drm scenario that includes a job to run IGT tests for vkms.=20
 > > It also includes helper scripts to build deqp-runner and IGT,=20
 > > which are based on the mesa-ci project.=20
 > >=20
 > > The xfails are added from drm-ci (drivers/gpu/drm/ci/xfails)=20
 > > Refer to Documentation/gpu/automated_testing.rst for details=20
 > > regarding fails/flakes/skips files.=20
 > =20
 > Why does this need to be duplicated, especially since this is another=20
 > gitlab-ci support like we have already? I know there's difference betwee=
n=20
 > the gitlab on fd.o and others, but this is a bit much.=20


We didn't want to duplicate, we were planing to remove it from drm-ci, plea=
se
see this commit:

    https://gitlab.freedesktop.org/vigneshraman/kernel/-/commit/d5ac1612be0=
c67ea7b164800ccf124481042f5ce=20

But we wanted to make sure the entire approach is correct first, so we drop=
ped
that commit for this version.

 > =20
 > What I expected:=20
 > - Stuff that's relevant for the subsystem like the xfail list, or the ig=
t=20
 >  version we want to test against or any of these things would stay in th=
e=20
 >  subsystem ci folder, so drivers/gpu/drm/ci here. There should be no nee=
d=20
 >  to duplicate anything, definitely not for a virtual driver like vkms.=
=20

We can move the ci scenario folder to be inside the subsystem specific fold=
er,
I think this is a nice idea, we can do that for v3.

 > =20
 > - Stuff that's used by multiple different ci needs to be shared somewher=
e,=20
 >  maybe in tools/ci/gitlab-ci/ or maybe in the drm/ci directory. Things=
=20
 >  like the script to build igt or assemble a drm specific container.=20
 >  Ideally we'd also be able to share entire gitlab build targets, at leas=
t=20
 >  the pure sw stuff really should work the same everywhere (plus/minus=20
 >  infra differences in how the docker images are stitched together maybe,=
=20
 >  but that's separate build targets anyway).=20

Ack

 > =20
 > - Stuff that's needed by the kernel at large (like the rust build script=
)=20
 >  shouldn't be in a subsystem specific place at all once we get something=
=20
 >  else than what we have in drm/ci right now.=20

Ack

 > =20
 > I'm confused.=20

I hope my replies above help, and thanks a lot for your feedback. please,
keep them coming :)

Cheers, Helen

 > =20
 > Cheers, Sima=20
 > =20
 > >=20
 > > Signed-off-by: Vignesh Raman vignesh.raman@collabora.com>=20
 > > ---=20
 > >  MAINTAINERS                                   |   1 +=20
 > >  .../scenarios/drm/build-deqp-runner.sh        |  42 +=20
 > >  tools/ci/gitlab-ci/scenarios/drm/build-igt.sh |  80 ++=20
 > >  .../ci/gitlab-ci/scenarios/drm/build-rust.sh  |  42 +=20
 > >  .../scenarios/drm/create-cross-file.sh        |  65 ++=20
 > >  tools/ci/gitlab-ci/scenarios/drm/drm.yml      |  45 +-=20
 > >  .../scenarios/drm/prepare-container.sh        |  18 +=20
 > >  tools/ci/gitlab-ci/scenarios/drm/run-igt.sh   |  83 ++=20
 > >  tools/ci/gitlab-ci/scenarios/drm/test.yml     |  32 +=20
 > >  .../scenarios/drm/xfails/vkms-none-fails.txt  |  22 +=20
 > >  .../scenarios/drm/xfails/vkms-none-flakes.txt |  90 ++=20
 > >  .../scenarios/drm/xfails/vkms-none-skips.txt  | 812 +++++++++++++++++=
+=20
 > >  12 files changed, 1326 insertions(+), 6 deletions(-)=20
 > >  create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner=
.sh=20
 > >  create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-igt.sh=20
 > >  create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-rust.sh=20
 > >  create mode 100755 tools/ci/gitlab-ci/scenarios/drm/create-cross-file=
.sh=20
 > >  create mode 100755 tools/ci/gitlab-ci/scenarios/drm/prepare-container=
.sh=20
 > >  create mode 100755 tools/ci/gitlab-ci/scenarios/drm/run-igt.sh=20
 > >  create mode 100644 tools/ci/gitlab-ci/scenarios/drm/test.yml=20
 > >  create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-=
fails.txt=20
 > >  create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-=
flakes.txt=20
 > >  create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-=
skips.txt=20
 > >=20
 > > diff --git a/MAINTAINERS b/MAINTAINERS=20
 > > index 874044e570f7..8de12618c3e1 100644=20
 > > --- a/MAINTAINERS=20
 > > +++ b/MAINTAINERS=20
 > > @@ -7551,6 +7551,7 @@ S:=C2=A0=C2=A0=C2=A0=C2=A0Maintained=20
 > >  T:=C2=A0=C2=A0=C2=A0=C2=A0git https://gitlab.freedesktop.org/drm/misc=
/kernel.git=20
 > >  F:=C2=A0=C2=A0=C2=A0=C2=A0Documentation/gpu/vkms.rst=20
 > >  F:=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/ci/xfails/vkms*=20
 > > +F:=C2=A0=C2=A0=C2=A0=C2=A0tools/ci/gitlab-ci/scenarios/drm/xfails/vkm=
s*=20
 > >  F:=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/vkms/=20
 > >=20
 > >  DRM DRIVER FOR VIRTUALBOX VIRTUAL GPU=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh b/t=
ools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh=20
 > > new file mode 100755=20
 > > index 000000000000..9f2574537423=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh=20
 > > @@ -0,0 +1,42 @@=20
 > > +#!/usr/bin/env bash=20
 > > +# SPDX-License-Identifier: GPL-2.0-or-later=20
 > > +#=20
 > > +# Copyright (C) 2025 Collabora, Vignesh Raman vignesh.raman@collabora=
.com>=20
 > > +#=20
 > > +# Based on the build-deqp-runner.sh script from the mesa project:=20
 > > +# https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/con=
tainer/build-deqp-runner.sh=20
 > > +#=20
 > > +# shellcheck disable=3DSC2086 # we want word splitting=20
 > > +=20
 > > +set -uex=20
 > > +=20
 > > +DEQP_RUNNER_GIT_URL=3D"${DEQP_RUNNER_GIT_URL:-https://gitlab.freedesk=
top.org/mesa/deqp-runner.git}"=20
 > > +DEQP_RUNNER_GIT_TAG=3D"${DEQP_RUNNER_GIT_TAG:-v0.20.0}"=20
 > > +=20
 > > +git clone $DEQP_RUNNER_GIT_URL --single-branch --no-checkout=20
 > > +pushd deqp-runner=20
 > > +git checkout $DEQP_RUNNER_GIT_TAG=20
 > > +=20
 > > +RUST_TARGET=3D"${RUST_TARGET:-}"=20
 > > +=20
 > > +# When CC (/usr/lib/ccache/gcc) variable is set, the rust compiler us=
es=20
 > > +# this variable when cross-compiling arm32 and build fails for zsys-s=
ys.=20
 > > +# So unset the CC variable when cross-compiling for arm32.=20
 > > +SAVEDCC=3D${CC:-}=20
 > > +if [ "$RUST_TARGET" =3D "armv7-unknown-linux-gnueabihf" ]; then=20
 > > +    unset CC=20
 > > +fi=20
 > > +cargo install --locked  \=20
 > > +    -j ${FDO_CI_CONCURRENT:-4} \=20
 > > +    --root /usr/local \=20
 > > +    ${EXTRA_CARGO_ARGS:-} \=20
 > > +    --path .=20
 > > +CC=3D$SAVEDCC=20
 > > +=20
 > > +popd=20
 > > +rm -rf deqp-runner=20
 > > +=20
 > > +# remove unused test runners=20
 > > +if [ -z "${DEQP_RUNNER_GIT_TAG:-}" ]; then=20
 > > +    rm -f /usr/local/bin/igt-runner=20
 > > +fi=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/build-igt.sh b/tools/ci/=
gitlab-ci/scenarios/drm/build-igt.sh=20
 > > new file mode 100755=20
 > > index 000000000000..fc82aa6fddec=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/build-igt.sh=20
 > > @@ -0,0 +1,80 @@=20
 > > +#!/bin/bash=20
 > > +# SPDX-License-Identifier: GPL-2.0-or-later=20
 > > +#=20
 > > +# Copyright (C) 2025 Collabora, Vignesh Raman vignesh.raman@collabora=
.com>=20
 > > +#=20
 > > +# Based on the build-igt.sh script from the drm-ci project:=20
 > > +# https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next=
/drivers/gpu/drm/ci/build-igt.sh=20
 > > +=20
 > > +set -ex=20
 > > +=20
 > > +function generate_testlist {=20
 > > +    set +x=20
 > > +    while read -r line; do=20
 > > +        if [ "$line" =3D "TESTLIST" ] || [ "$line" =3D "END TESTLIST"=
 ]; then=20
 > > +            continue=20
 > > +        fi=20
 > > +=20
 > > +        tests=3D$(echo "$line" | tr ' ' '\n')=20
 > > +=20
 > > +        for test in $tests; do=20
 > > +            output=3D$(/igt/libexec/igt-gpu-tools/"$test" --list-subt=
ests || true)=20
 > > +=20
 > > +            if [ -z "$output" ]; then=20
 > > +                echo "$test"=20
 > > +            else=20
 > > +                echo "$output" | while read -r subtest; do=20
 > > +                    echo "$test@$subtest"=20
 > > +                done=20
 > > +            fi=20
 > > +        done=20
 > > +    done  /igt/libexec/igt-gpu-tools/ci-testlist.txt=20
 > > +    set -x=20
 > > +}=20
 > > +=20
 > > +git clone https://gitlab.freedesktop.org/drm/igt-gpu-tools.git --sing=
le-branch --no-checkout=20
 > > +pushd igt-gpu-tools=20
 > > +git checkout $IGT_VERSION=20
 > > +=20
 > > +if [[ "$KCI_KERNEL_ARCH" =3D "arm" ]]; then=20
 > > +    . ../tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh armhf=
=20
 > > +    EXTRA_MESON_ARGS=3D"--cross-file /cross_file-armhf.txt"=20
 > > +fi=20
 > > +=20
 > > +MESON_OPTIONS=3D"-Doverlay=3Ddisabled                    \=20
 > > +               -Dchamelium=3Ddisabled                  \=20
 > > +               -Dvalgrind=3Ddisabled                   \=20
 > > +               -Dman=3Denabled                         \=20
 > > +               -Dtests=3Denabled                       \=20
 > > +               -Drunner=3Denabled                      \=20
 > > +               -Dlibunwind=3Denabled                   \=20
 > > +               -Dprefix=3D/igt"=20
 > > +=20
 > > +if [[ "$KCI_KERNEL_ARCH" =3D "arm64" ]] || [[ "$KCI_KERNEL_ARCH" =3D =
"arm" ]]; then=20
 > > +    MESON_OPTIONS=3D"$MESON_OPTIONS -Dxe_driver=3Ddisabled"=20
 > > +fi=20
 > > +=20
 > > +mkdir -p /igt=20
 > > +meson build $MESON_OPTIONS $EXTRA_MESON_ARGS=20
 > > +ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1=20
 > > +ninja -C build install=20
 > > +=20
 > > +if [[ "$KCI_KERNEL_ARCH" =3D "arm64" ]]; then=20
 > > +    export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-=
gnu=20
 > > +elif [[ "$KCI_KERNEL_ARCH" =3D "arm" ]]; then=20
 > > +    export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib=20
 > > +else=20
 > > +    export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib/x86_64-linux-g=
nu=20
 > > +fi=20
 > > +=20
 > > +echo "Generating ci-testlist.txt"=20
 > > +generate_testlist=20
 > > +=20
 > > +export INSTALL_PATH=3D"${CI_PROJECT_DIR}/artifacts/"=20
 > > +INSTALL_PATH+=3D"igt-install-${KCI_KERNEL_ARCH}"=20
 > > +mkdir -p "$INSTALL_PATH"=20
 > > +=20
 > > +tar -cf $INSTALL_PATH/igt.tar /igt=20
 > > +=20
 > > +popd=20
 > > +rm -rf igt-gpu-tools=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/build-rust.sh b/tools/ci=
/gitlab-ci/scenarios/drm/build-rust.sh=20
 > > new file mode 100755=20
 > > index 000000000000..48702d5a9648=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/build-rust.sh=20
 > > @@ -0,0 +1,42 @@=20
 > > +#!/bin/bash=20
 > > +# SPDX-License-Identifier: GPL-2.0-or-later=20
 > > +#=20
 > > +# Copyright (C) 2025 Collabora, Vignesh Raman vignesh.raman@collabora=
.com>=20
 > > +#=20
 > > +# Based on the build-rust.sh script from the mesa project:=20
 > > +# https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/con=
tainer/build-rust.sh=20
 > > +=20
 > > +# Note that this script is not actually "building" rust, but build- i=
s the=20
 > > +# convention for the shared helpers for putting stuff in our containe=
rs.=20
 > > +=20
 > > +set -ex=20
 > > +=20
 > > +# cargo (and rustup) wants to store stuff in $HOME/.cargo, and binari=
es in=20
 > > +# $HOME/.cargo/bin.  Make bin a link to a public bin directory so the=
 commands=20
 > > +# are just available to all build jobs.=20
 > > +mkdir -p "$HOME"/.cargo=20
 > > +ln -s /usr/local/bin "$HOME"/.cargo/bin=20
 > > +=20
 > > +# Pick a specific snapshot from rustup so the compiler doesn't drift =
on us.=20
 > > +RUST_VERSION=3D1.78.0-2024-05-02=20
 > > +=20
 > > +# For rust in Mesa, we use rustup to install.  This lets us pick an a=
rbitrary=20
 > > +# version of the compiler, rather than whatever the container's Debia=
n comes=20
 > > +# with.=20
 > > +curl -L --retry 4 -f --retry-all-errors --retry-delay 60 \=20
 > > +    --proto '=3Dhttps' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s --=
 \=20
 > > +      --default-toolchain $RUST_VERSION \=20
 > > +      --profile minimal \=20
 > > +      -y=20
 > > +=20
 > > +rustup component add clippy rustfmt=20
 > > +=20
 > > +# Set up a config script for cross compiling -- cargo needs your syst=
em cc for=20
 > > +# linking in cross builds, but doesn't know what you want to use for =
system cc.=20
 > > +cat > /root/.cargo/config <<EOF=20
 > > +[target.armv7-unknown-linux-gnueabihf]=20
 > > +linker =3D "arm-linux-gnueabihf-gcc"=20
 > > +=20
 > > +[target.aarch64-unknown-linux-gnu]=20
 > > +linker =3D "aarch64-linux-gnu-gcc"=20
 > > +EOF=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh b/t=
ools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh=20
 > > new file mode 100755=20
 > > index 000000000000..e078346f23b3=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh=20
 > > @@ -0,0 +1,65 @@=20
 > > +#!/bin/bash=20
 > > +# SPDX-License-Identifier: GPL-2.0-or-later=20
 > > +#=20
 > > +# Copyright (C) 2025 Collabora, Vignesh Raman vignesh.raman@collabora=
.com>=20
 > > +#=20
 > > +# Based on the create-cross-file.sh script from the mesa project:=20
 > > +# https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/con=
tainer/create-cross-file.sh=20
 > > +=20
 > > +arch=3D$1=20
 > > +cross_file=3D"/cross_file-$arch.txt"=20
 > > +meson env2mfile --cross --debarch "$arch" -o "$cross_file"=20
 > > +=20
 > > +# Explicitly set ccache path for cross compilers=20
 > > +sed -i \=20
 > > +    "s|/usr/bin/\([^-]*\)-linux-gnu\([^-]*\)-g|/usr/lib/ccache/\\1-li=
nux-gnu\\2-g|g" \=20
 > > +    "$cross_file"=20
 > > +=20
 > > +# Rely on qemu-user being configured in binfmt_misc on the host=20
 > > +# shellcheck disable=3DSC1003 # how this sed doesn't seems to work fo=
r me locally=20
 > > +sed -i -e '/\[properties\]/a\' -e "needs_exe_wrapper =3D False" "$cro=
ss_file"=20
 > > +=20
 > > +# Add a line for rustc, which meson env2mfile is missing.=20
 > > +cc=3D$(sed -n "s|^c\s*=3D\s*\[?'\(.*\)'\]?|\1|p" < "$cross_file")=20
 > > +=20
 > > +if [[ "$arch" =3D "arm64" ]]; then=20
 > > +    rust_target=3Daarch64-unknown-linux-gnu=20
 > > +elif [[ "$arch" =3D "armhf" ]]; then=20
 > > +    rust_target=3Darmv7-unknown-linux-gnueabihf=20
 > > +elif [[ "$arch" =3D "i386" ]]; then=20
 > > +    rust_target=3Di686-unknown-linux-gnu=20
 > > +elif [[ "$arch" =3D "ppc64el" ]]; then=20
 > > +    rust_target=3Dpowerpc64le-unknown-linux-gnu=20
 > > +elif [[ "$arch" =3D "s390x" ]]; then=20
 > > +    rust_target=3Ds390x-unknown-linux-gnu=20
 > > +else=20
 > > +    echo "Needs rustc target mapping"=20
 > > +fi=20
 > > +=20
 > > +# shellcheck disable=3DSC1003 # single-quoted string ends in a backsl=
ash=20
 > > +sed -i \=20
 > > +    -e '/\[binaries\]/a\' \=20
 > > +    -e "rust =3D ['rustc', '--target=3D$rust_target', '-C', 'linker=
=3D$cc']" \=20
 > > +    "$cross_file"=20
 > > +=20
 > > +# Set up cmake cross compile toolchain file for dEQP builds=20
 > > +toolchain_file=3D"/toolchain-$arch.cmake"=20
 > > +if [[ "$arch" =3D "arm64" ]]; then=20
 > > +    GCC_ARCH=3D"aarch64-linux-gnu"=20
 > > +    DE_CPU=3D"DE_CPU_ARM_64"=20
 > > +elif [[ "$arch" =3D "armhf" ]]; then=20
 > > +    GCC_ARCH=3D"arm-linux-gnueabihf"=20
 > > +    DE_CPU=3D"DE_CPU_ARM"=20
 > > +fi=20
 > > +=20
 > > +if [[ -n "$GCC_ARCH" ]]; then=20
 > > +    {=20
 > > +        echo "set(CMAKE_SYSTEM_NAME Linux)";=20
 > > +        echo "set(CMAKE_SYSTEM_PROCESSOR arm)";=20
 > > +        echo "set(CMAKE_C_COMPILER /usr/lib/ccache/$GCC_ARCH-gcc)";=
=20
 > > +        echo "set(CMAKE_CXX_COMPILER /usr/lib/ccache/$GCC_ARCH-g++)";=
=20
 > > +        echo "set(CMAKE_CXX_FLAGS_INIT \"-Wno-psabi\")";  # makes ABI=
 warnings quiet for ARMv7=20
 > > +        echo "set(ENV{PKG_CONFIG} \"/usr/bin/$GCC_ARCH-pkgconf\")";=
=20
 > > +        echo "set(DE_CPU $DE_CPU)";=20
 > > +    } > "$toolchain_file"=20
 > > +fi=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/drm.yml b/tools/ci/gitla=
b-ci/scenarios/drm/drm.yml=20
 > > index 206e6f0d1a46..220223544673 100644=20
 > > --- a/tools/ci/gitlab-ci/scenarios/drm/drm.yml=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/drm.yml=20
 > > @@ -1,11 +1,44 @@=20
 > >  # SPDX-License-Identifier: GPL-2.0-or-later=20
 > >  #=20
 > >  # Copyright (C) 2024 Collabora, Helen Koike helen.koike@collabora.com=
>=20
 > > +# DRM-specific scenario configurations based on drivers/gpu/drm/ci/bu=
ild.yml=20
 > >=20
 > > -# Write here specific configurations and extensions for the given sce=
nario=20
 > > +variables:=20
 > > +  FDO_DISTRIBUTION_TAG: "2025-01-21-drm"=20
 > > +  FDO_DISTRIBUTION_EXEC: ./tools/ci/gitlab-ci/scenarios/drm/prepare-c=
ontainer.sh=20
 > > +  IGT_VERSION: a73311079a5d8ac99eb25336a8369a2c3c6b519b=20
 > > +  DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-runne=
r.git=20
 > > +  DEQP_RUNNER_GIT_TAG: v0.20.0=20
 > >=20
 > > -# Example - overwrite kernel combinations in the pipeline=20
 > > -# build:arm64:=20
 > > -#   variables:=20
 > > -#     KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"=20
 > > -#     KCI_DEFCONFIG: "my/custom/config1"=20
 > > +build:x86_64:=20
 > > +  variables:=20
 > > +    KCI_KCONFIGS_ENABLE: "DRM_VKMS DRM_BOCHS"=20
 > > +=20
 > > +.igt:=20
 > > +  stage: build=20
 > > +  script:=20
 > > +    - FDO_CI_CONCURRENT=3D${FDO_CI_CONCURRENT} bash ./tools/ci/gitlab=
-ci/scenarios/drm/build-igt.sh=20
 > > +  artifacts:=20
 > > +    when: always=20
 > > +    paths:=20
 > > +      - artifacts/=20
 > > +=20
 > > +# Build IGT for testing on devices=20
 > > +# TODO: Fix cross compilation issue=20
 > > +.igt:arm32:=20
 > > +  extends:=20
 > > +    - .arm32-config=20
 > > +    - .use-debian/arm64_build=20
 > > +    - .igt=20
 > > +=20
 > > +igt:arm64:=20
 > > +  extends:=20
 > > +    - .arm64-config=20
 > > +    - .use-debian/arm64_build=20
 > > +    - .igt=20
 > > +=20
 > > +igt:x86_64:=20
 > > +  extends:=20
 > > +    - .x86_64-config=20
 > > +    - .use-debian/x86_64_build=20
 > > +    - .igt=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh b/t=
ools/ci/gitlab-ci/scenarios/drm/prepare-container.sh=20
 > > new file mode 100755=20
 > > index 000000000000..43fbfdcd3514=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh=20
 > > @@ -0,0 +1,18 @@=20
 > > +#!/bin/bash=20
 > > +# SPDX-License-Identifier: GPL-2.0-or-later=20
 > > +#=20
 > > +# Copyright (C) 2025 Collabora, Vignesh Raman vignesh.raman@collabora=
.com>=20
 > > +=20
 > > +set -ex=20
 > > +=20
 > > +############### Install Smatch=20
 > > +=20
 > > +. ./tools/ci/gitlab-ci/ci-scripts/install-smatch.sh=20
 > > +=20
 > > +############### Install Rust toolchain=20
 > > +=20
 > > +. ./tools/ci/gitlab-ci/scenarios/drm/build-rust.sh=20
 > > +=20
 > > +############### Build dEQP runner=20
 > > +=20
 > > +. ./tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/run-igt.sh b/tools/ci/gi=
tlab-ci/scenarios/drm/run-igt.sh=20
 > > new file mode 100755=20
 > > index 000000000000..4822fcc2780f=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/run-igt.sh=20
 > > @@ -0,0 +1,83 @@=20
 > > +#!/bin/sh=20
 > > +# SPDX-License-Identifier: GPL-2.0-or-later=20
 > > +#=20
 > > +# Copyright (C) 2025 Collabora, Vignesh Raman vignesh.raman@collabora=
.com>=20
 > > +#=20
 > > +# Based on the igt_runner.sh script from the drm-ci project:=20
 > > +# https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next=
/drivers/gpu/drm/ci/igt_runner.sh=20
 > > +=20
 > > +set -ex=20
 > > +=20
 > > +STATUS_FILE=3D"${1}"=20
 > > +=20
 > > +export IGT_FORCE_DRIVER=3D${DRIVER_NAME}=20
 > > +export PATH=3D$PATH:/igt/bin/=20
 > > +export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:\=20
 > > +/igt/lib/aarch64-linux-gnu:\=20
 > > +/igt/lib/x86_64-linux-gnu:\=20
 > > +/igt/lib:\=20
 > > +/igt/lib64=20
 > > +=20
 > > +# Uncomment the below to debug problems with driver probing=20
 > > +: '=20
 > > +ls -l /dev/dri/=20
 > > +cat /sys/kernel/debug/devices_deferred=20
 > > +cat /sys/kernel/debug/device_component/*=20
 > > +'=20
 > > +=20
 > > +# Dump drm state to confirm that kernel was able to find a connected =
display:=20
 > > +set +e=20
 > > +cat /sys/kernel/debug/dri/*/state=20
 > > +set -e=20
 > > +=20
 > > +if [ -e "/install/xfails/$DRIVER_NAME-$GPU_VERSION-skips.txt" ]; then=
=20
 > > +    IGT_SKIPS=3D"--skips /install/xfails/$DRIVER_NAME-$GPU_VERSION-sk=
ips.txt"=20
 > > +fi=20
 > > +=20
 > > +if [ -e "/install/xfails/$DRIVER_NAME-$GPU_VERSION-flakes.txt" ]; the=
n=20
 > > +    IGT_FLAKES=3D"--flakes /install/xfails/$DRIVER_NAME-$GPU_VERSION-=
flakes.txt"=20
 > > +fi=20
 > > +=20
 > > +if [ -e "/install/xfails/$DRIVER_NAME-$GPU_VERSION-fails.txt" ]; then=
=20
 > > +    IGT_FAILS=3D"--baseline /install/xfails/$DRIVER_NAME-$GPU_VERSION=
-fails.txt"=20
 > > +fi=20
 > > +=20
 > > +TESTLIST=3D"/igt/libexec/igt-gpu-tools/ci-testlist.txt"=20
 > > +=20
 > > +# If the job is parallel at the gitab job level, take the correspondi=
ng fraction=20
 > > +# of the caselist.=20
 > > +if [ -n "$CI_NODE_INDEX" ]; then=20
 > > +    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" $TESTLIST=20
 > > +fi=20
 > > +=20
 > > +# core_getversion checks if the driver is loaded and probed correctly=
=20
 > > +# so run it in all shards=20
 > > +if ! grep -q "core_getversion" $TESTLIST; then=20
 > > +    # Add the line to the file=20
 > > +    echo "core_getversion" >> $TESTLIST=20
 > > +fi=20
 > > +=20
 > > +set +e=20
 > > +igt-runner \=20
 > > +    run \=20
 > > +    --igt-folder /igt/libexec/igt-gpu-tools \=20
 > > +    --caselist $TESTLIST \=20
 > > +    --output /results \=20
 > > +    -vvvv \=20
 > > +    $IGT_SKIPS \=20
 > > +    $IGT_FLAKES \=20
 > > +    $IGT_FAILS \=20
 > > +    --jobs 1=20
 > > +ret=3D$?=20
 > > +set -e=20
 > > +=20
 > > +deqp-runner junit \=20
 > > +   --testsuite IGT \=20
 > > +   --results /results/failures.csv \=20
 > > +   --output /results/junit.xml \=20
 > > +   --limit 50 \=20
 > > +   --template "See https://$CI_PROJECT_ROOT_NAMESPACE.pages.freedeskt=
op.org/-/$CI_PROJECT_NAME/-/jobs/$CI_JOB_ID/artifacts/results/{{testcase}}.=
xml"=20
 > > +=20
 > > +cd $oldpath=20
 > > +echo $ret > ${STATUS_FILE}=20
 > > +exit $ret=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/test.yml b/tools/ci/gitl=
ab-ci/scenarios/drm/test.yml=20
 > > new file mode 100644=20
 > > index 000000000000..9fb37beb446d=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/test.yml=20
 > > @@ -0,0 +1,32 @@=20
 > > +# SPDX-License-Identifier: GPL-2.0-or-later=20
 > > +#=20
 > > +# Copyright (C) 2025 Collabora, Vignesh Raman vignesh.raman@collabora=
.com>=20
 > > +=20
 > > +vkms:none:=20
 > > +  extends: build:x86_64=20
 > > +  stage: test=20
 > > +  timeout: "1h30m"=20
 > > +  variables:=20
 > > +    DRIVER_NAME: vkms=20
 > > +    GPU_VERSION: none=20
 > > +  tags:=20
 > > +    - kvm=20
 > > +  script:=20
 > > +    - mkdir -p /install/xfails=20
 > > +    - cp -rfv tools/ci/gitlab-ci/scenarios/drm/xfails /install/=20
 > > +    - cp $CI_PROJECT_DIR/artifacts/kernel-install-${KCI_KERNEL_ARCH}/=
bzImage /install=20
 > > +    - tar -xv -C / -f $CI_PROJECT_DIR/artifacts/igt-install-${KCI_KER=
NEL_ARCH}/igt.tar=20
 > > +    - mkdir -p $CI_PROJECT_DIR/results=20
 > > +    - ln -sf $CI_PROJECT_DIR/results /results=20
 > > +    - ./tools/ci/gitlab-ci/ci-scripts/run-virtme.sh /install/bzImage =
./tools/ci/gitlab-ci/scenarios/drm/run-igt.sh "DRIVER_NAME=3D$DRIVER_NAME G=
PU_VERSION=3D$GPU_VERSION"=20
 > > +  artifacts:=20
 > > +    when: always=20
 > > +    paths:=20
 > > +      - results/=20
 > > +  needs:=20
 > > +    - build:x86_64=20
 > > +    - igt:x86_64=20
 > > +=20
 > > +test-boot:=20
 > > +  rules:=20
 > > +    - when: never=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.t=
xt b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.txt=20
 > > new file mode 100644=20
 > > index 000000000000..3979c95c07ed=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.txt=20
 > > @@ -0,0 +1,22 @@=20
 > > +kms_cursor_crc@cursor-rapid-movement-256x85,Fail=20
 > > +kms_cursor_crc@cursor-rapid-movement-32x10,Fail=20
 > > +kms_cursor_crc@cursor-rapid-movement-64x64,Fail=20
 > > +kms_cursor_legacy@basic-flip-before-cursor-atomic,Fail=20
 > > +kms_cursor_legacy@basic-flip-before-cursor-legacy,Fail=20
 > > +kms_cursor_legacy@cursor-vs-flip-atomic,Fail=20
 > > +kms_cursor_legacy@cursor-vs-flip-legacy,Fail=20
 > > +kms_cursor_legacy@cursor-vs-flip-toggle,Fail=20
 > > +kms_cursor_legacy@cursor-vs-flip-varying-size,Fail=20
 > > +kms_cursor_legacy@flip-vs-cursor-atomic,Fail=20
 > > +kms_cursor_legacy@flip-vs-cursor-crc-atomic,Fail=20
 > > +kms_cursor_legacy@flip-vs-cursor-crc-legacy,Fail=20
 > > +kms_cursor_legacy@flip-vs-cursor-legacy,Fail=20
 > > +kms_flip@flip-vs-modeset-vs-hang,Fail=20
 > > +kms_flip@flip-vs-panning-vs-hang,Fail=20
 > > +kms_writeback@writeback-check-output,Fail=20
 > > +kms_writeback@writeback-check-output-XRGB2101010,Fail=20
 > > +kms_writeback@writeback-fb-id,Fail=20
 > > +kms_writeback@writeback-fb-id-XRGB2101010,Fail=20
 > > +kms_writeback@writeback-invalid-parameters,Fail=20
 > > +kms_writeback@writeback-pixel-formats,Fail=20
 > > +perf@i915-ref-count,Fail=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.=
txt b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.txt=20
 > > new file mode 100644=20
 > > index 000000000000..62428f3c8f31=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.txt=20
 > > @@ -0,0 +1,90 @@=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@basic-flip-vs-wf_vblank=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@flip-vs-expired-vblank-interruptible=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@flip-vs-wf_vblank-interruptible=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@plain-flip-fb-recreate-interruptible=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@plain-flip-ts-check=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@plain-flip-ts-check-interruptible=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@flip-vs-absolute-wf_vblank=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@flip-vs-absolute-wf_vblank-interruptible=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-g0df7b9b97=20
 > > +# Linux Version: 6.9.0-rc7=20
 > > +kms_flip@flip-vs-blocking-wf-vblank=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-gf13702b8e=20
 > > +# Linux Version: 6.10.0-rc5=20
 > > +kms_cursor_legacy@flip-vs-cursor-varying-size=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-gf13702b8e=20
 > > +# Linux Version: 6.10.0-rc5=20
 > > +kms_flip@flip-vs-expired-vblank=20
 > > +=20
 > > +# Board Name: vkms=20
 > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9d=
f2-d1ee319f3fb0@collabora.com/T/#u=20
 > > +# Failure Rate: 50=20
 > > +# IGT Version: 1.28-gf13702b8e=20
 > > +# Linux Version: 6.10.0-rc5=20
 > > +kms_pipe_crc_basic@nonblocking-crc-frame-sequence=20
 > > diff --git a/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.t=
xt b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.txt=20
 > > new file mode 100644=20
 > > index 000000000000..24659c18c765=20
 > > --- /dev/null=20
 > > +++ b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.txt=20
 > > @@ -0,0 +1,812 @@=20
 > > +# skip suspend tests=20
 > > +.*suspend.*=20
 > > +=20
 > > +# keeps printing vkms_vblank_simulate: vblank timer overrun and never=
 ends=20
 > > +kms_invalid_mode@int-max-clock=20
 > > +=20
 > > +# kernel panic seen with kms_cursor_crc tests=20
 > > +kms_cursor_crc.*=20
 > > +# kms_cursor_crc@cursor-rapid-movement-32x10=20
 > > +# Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 0 PID: 2635 Comm: kworker/u8:13 Not tainted 6.9.0-rc7-g4093526=
3a1fd #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]=20
 > > +# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 0=
0 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00  42 78 89 =
c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34=20
 > > +# RSP: 0018:ffffbb4700c17d58 EFLAGS: 00010246=20
 > > +# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002=
=20
 > > +# RDX: 0000000000000000 RSI: ffffa2ad0788c000 RDI: 00000000fff479a8=
=20
 > > +# RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffffa2ad0bb14000 R11: 0000000000000000 R12: ffffa2ad03e21700=
=20
 > > +# R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffffa2ad2bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000078 CR3: 000000010bd30000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x490=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x1c7/0x4e0 [vkms]=20
 > > +#  ? compose_active_planes+0x2a3/0x4e0 [vkms]=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x1f4/0x6b0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x350=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 0000000000000078=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]=20
 > > +# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 0=
0 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00  42 78 89 =
c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34=20
 > > +# RSP: 0018:ffffbb4700c17d58 EFLAGS: 00010246=20
 > > +# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002=
=20
 > > +# RDX: 0000000000000000 RSI: ffffa2ad0788c000 RDI: 00000000fff479a8=
=20
 > > +# RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffffa2ad0bb14000 R11: 0000000000000000 R12: ffffa2ad03e21700=
=20
 > > +# R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffffa2ad2bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +=20
 > > +#kms_cursor_crc@cursor-rapid-movement-256x85=20
 > > +# [drm:drm_crtc_add_crc_entry] *ERROR* Overflow of CRC buffer, usersp=
ace reads too slow.=20
 > > +# Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 1 PID: 10 Comm: kworker/u8:0 Not tainted 6.9.0-rc7-g646381cde4=
63 #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]=20
 > > +# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 0=
0 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00  42 78 89 =
c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34=20
 > > +# RSP: 0018:ffffa7e980057d58 EFLAGS: 00010246=20
 > > +# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002=
=20
 > > +# RDX: 0000000000000000 RSI: ffff977987aa5c00 RDI: 000000001b43a85f=
=20
 > > +# RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff977981bf0000 R11: 0000000000000000 R12: ffff977989622590=
=20
 > > +# R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9779abd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000078 CR3: 0000000109b38000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x490=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x1c7/0x4e0 [vkms]=20
 > > +#  ? compose_active_planes+0x2a3/0x4e0 [vkms]=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x1f4/0x6b0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x350=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 0000000000000078=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]=20
 > > +# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 0=
0 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00  42 78 89 =
c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34=20
 > > +# RSP: 0018:ffffa7e980057d58 EFLAGS: 00010246=20
 > > +# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002=
=20
 > > +# RDX: 0000000000000000 RSI: ffff977987aa5c00 RDI: 000000001b43a85f=
=20
 > > +# RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff977981bf0000 R11: 0000000000000000 R12: ffff977989622590=
=20
 > > +# R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9779abd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000078 CR3: 0000000109b38000 CR4: 0000000000350ef0=
=20
 > > +=20
 > > +#kms_cursor_crc@cursor-onscreen-256x256=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 1 PID: 1913 Comm: kworker/u8:6 Not tainted 6.10.0-rc5-g8a28e73=
ebead #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff f=
f 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00  63 70 18 =
8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48=20
 > > +# RSP: 0018:ffffb477409fbd58 EFLAGS: 00010282=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff8b124a242000=
=20
 > > +# RDX: 00000000000000ff RSI: ffff8b124a243ff8 RDI: ffff8b124a244000=
=20
 > > +# RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000000003ff=
=20
 > > +# R10: ffff8b124a244000 R11: 0000000000000000 R12: ffff8b1249282f30=
=20
 > > +# R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff8b126bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000018 CR3: 0000000107a86000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +#  ? compose_active_planes+0x32f/0x4e0 [vkms]=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x350=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 0000000000000018=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff f=
f 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00  63 70 18 =
8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48=20
 > > +# RSP: 0018:ffffb477409fbd58 EFLAGS: 00010282=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff8b124a242000=
=20
 > > +# RDX: 00000000000000ff RSI: ffff8b124a243ff8 RDI: ffff8b124a244000=
=20
 > > +# RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000000003ff=
=20
 > > +# R10: ffff8b124a244000 R11: 0000000000000000 R12: ffff8b1249282f30=
=20
 > > +# R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff8b126bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000018 CR3: 0000000107a86000 CR4: 0000000000350ef0=
=20
 > > +=20
 > > +kms_cursor_edge_walk@128x128-right-edge=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 0 PID: 1911 Comm: kworker/u8:3 Not tainted 6.10.0-rc5-g5e7a002=
eefe5 #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff f=
f 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00  63 70 18 =
8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48=20
 > > +# RSP: 0018:ffffb2f040a43d58 EFLAGS: 00010282=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa2c181792000=
=20
 > > +# RDX: 0000000000000000 RSI: ffffa2c181793ff8 RDI: ffffa2c181790000=
=20
 > > +# RBP: 0000000000000031 R08: 0000000000000000 R09: 00000000000003ff=
=20
 > > +# R10: ffffa2c181790000 R11: 0000000000000000 R12: ffffa2c1814fa810=
=20
 > > +# R13: 0000000000000031 R14: 0000000000000031 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffffa2c1abc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000018 CR3: 0000000106768000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  ? mark_held_locks+0x49/0x80=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +#  ? compose_active_planes+0x32f/0x4e0 [vkms]=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x350=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 0000000000000018=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff f=
f 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00  63 70 18 =
8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48=20
 > > +# RSP: 0018:ffffb2f040a43d58 EFLAGS: 00010282=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa2c181792000=
=20
 > > +# RDX: 0000000000000000 RSI: ffffa2c181793ff8 RDI: ffffa2c181790000=
=20
 > > +# RBP: 0000000000000031 R08: 0000000000000000 R09: 00000000000003ff=
=20
 > > +# R10: ffffa2c181790000 R11: 0000000000000000 R12: ffffa2c1814fa810=
=20
 > > +# R13: 0000000000000031 R14: 0000000000000031 R15: 000000000000=20
 > > +=20
 > > +kms_cursor_edge_walk@128x128-left-edge=20
 > > +# DEBUG - Begin test kms_cursor_edge_walk@128x128-left-edge=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 0 UID: 0 PID: 27 Comm: kworker/u8:1 Not tainted 6.11.0-rc5-g5d=
3429a7e9aa #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff f=
f 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00  63 70 18 =
8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48=20
 > > +# RSP: 0018:ffffa437800ebd58 EFLAGS: 00010282=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa0e841904000=
=20
 > > +# RDX: 00000000000000ff RSI: ffffa0e841905ff8 RDI: ffffa0e841902000=
=20
 > > +# RBP: 0000000000000000 R08: ffffa0e84158a600 R09: 00000000000003ff=
=20
 > > +# R10: 0000000078b2bcd2 R11: 00000000278b2bcd R12: ffffa0e84870fc60=
=20
 > > +# R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffffa0e86bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000018 CR3: 0000000101710000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +#  ? compose_active_planes+0x32f/0x4e0 [vkms]=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x310=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 0000000000000018=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]=20
 > > +# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff f=
f 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00  63 70 18 =
8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48=20
 > > +# RSP: 0018:ffffa437800ebd58 EFLAGS: 00010282=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa0e841904000=
=20
 > > +# RDX: 00000000000000ff RSI: ffffa0e841905ff8 RDI: ffffa0e841902000=
=20
 > > +# RBP: 0000000000000000 R08: ffffa0e84158a600 R09: 00000000000003ff=
=20
 > > +# R10: 0000000078b2bcd2 R11: 00000000278b2bcd R12: ffffa0e84870fc60=
=20
 > > +# R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000=
=20
 > > +# FS:  0000000000000000(0000) GS:ffffa0e86bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 0000000000000018 CR3: 0000000101710000 CR4: 0000000000350ef0=
=20
 > > +# vkms_vblank_simulate: vblank timer overrun=20
 > > +=20
 > > +# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-64x64=20
 > > +# ------------[ cut here ]------------=20
 > > +# WARNING: CPU: 1 PID: 1250 at drivers/gpu/drm/vkms/vkms_crtc.c:139 v=
kms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Modules linked in: vkms=20
 > > +# CPU: 1 UID: 0 PID: 1250 Comm: kms_cursor_crc Not tainted 6.13.0-rc2=
-ge95c88d68ac3 #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Code: f7 48 89 f3 e8 d0 bf ee ec 48 8b 83 50 01 00 00 a8 01 75 15 4=
8 8b bb a0 01 00 00 e8 59 05 95 ec 48 89 df 5b e9 50 05 95 ec 90  0b 90 eb =
e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90=20
 > > +# RSP: 0018:ffff9fb640aafb08 EFLAGS: 00010202=20
 > > +# RAX: ffff8e7240859e05 RBX: ffff8e7241cd6400 RCX: ffffffffae496b65=
=20
 > > +# RDX: ffffffffad2d1f80 RSI: 0000000000000000 RDI: 0000000000000000=
=20
 > > +# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002=
=20
 > > +# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff8e72590cc000=
=20
 > > +# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000=
=20
 > > +# FS:  00007f0942ad56c0(0000) GS:ffff8e726bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 00007f0942ad0008 CR3: 0000000118d1e000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __warn+0x8c/0x190=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? report_bug+0x164/0x190=20
 > > +#  ? handle_bug+0x54/0x90=20
 > > +#  ? exc_invalid_op+0x17/0x70=20
 > > +#  ? asm_exc_invalid_op+0x1a/0x20=20
 > > +#  ? __pfx_drm_property_free_blob+0x10/0x10=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]=20
 > > +#  drm_atomic_state_default_clear+0x137/0x2f0=20
 > > +#  __drm_atomic_state_free+0x6c/0xb0=20
 > > +#  drm_atomic_helper_update_plane+0x100/0x150=20
 > > +#  drm_mode_cursor_universal+0x10e/0x270=20
 > > +#  drm_mode_cursor_common+0x115/0x240=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  drm_mode_cursor_ioctl+0x4a/0x70=20
 > > +#  drm_ioctl_kernel+0xb0/0x110=20
 > > +#  drm_ioctl+0x235/0x4b0=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  __x64_sys_ioctl+0x92/0xc0=20
 > > +#  do_syscall_64+0xbb/0x1d0=20
 > > +#  entry_SYSCALL_64_after_hwframe+0x77/0x7f=20
 > > +# RIP: 0033:0x7f0943a84cdb=20
 > > +# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05  c2 3d 00 =
f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00=20
 > > +# RSP: 002b:00007fff267d68d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010=20
 > > +# RAX: ffffffffffffffda RBX: 000000000000005a RCX: 00007f0943a84cdb=
=20
 > > +# RDX: 00007fff267d6960 RSI: 00000000c01c64a3 RDI: 0000000000000005=
=20
 > > +# RBP: 00007fff267d6960 R08: 0000000000000007 R09: 00005619a60f3450=
=20
 > > +# R10: fe95a83851609dee R11: 0000000000000246 R12: 00000000c01c64a3=
=20
 > > +# R13: 0000000000000005 R14: 00005619a3cd2c68 R15: 00005619a608c830=
=20
 > > +#  =20
 > > +# irq event stamp: 57793=20
 > > +# hardirqs last  enabled at (57799): [] __up_console_sem+0x4d/0x60=20
 > > +# hardirqs last disabled at (57804): [] __up_console_sem+0x32/0x60=20
 > > +# softirqs last  enabled at (45586): [] handle_softirqs+0x310/0x3f0=
=20
 > > +# softirqs last disabled at (45569): [] __irq_exit_rcu+0xa1/0xc0=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 0 UID: 0 PID: 119 Comm: kworker/u8:6 Tainted: G        W      =
    6.13.0-rc2-ge95c88d68ac3 #1=20
 > > +# Tainted: [W]=3DWARN=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffff9fb640efbd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff8e7241926000 RSI: ffff8e7241927ffc RDI: 000000000b7fb767=
=20
 > > +# RBP: ffff9fb640efbde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff8e7241b09a80 R11: 0000000000000000 R12: ffff8e7241cd6200=
=20
 > > +# R13: 0000000000000013 R14: 0000000000000000 R15: ffff8e7241b09a80=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff8e726bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000118d1e000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x320=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 000000000000001c=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffff9fb640efbd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff8e7241926000 RSI: ffff8e7241927ffc RDI: 000000000b7fb767=
=20
 > > +# RBP: ffff9fb640efbde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff8e7241b09a80 R11: 0000000000000000 R12: ffff8e7241cd6200=
=20
 > > +# R13: 0000000000000013 R14: 0000000000000000 R15: ffff8e7241b09a80=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff8e726bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000118d1e000 CR4: 0000000000350ef0=
=20
 > > +=20
 > > +# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-128x42=20
 > > +# ------------[ cut here ]------------=20
 > > +# WARNING: CPU: 0 PID: 2933 at drivers/gpu/drm/vkms/vkms_crtc.c:139 v=
kms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Modules linked in: vkms=20
 > > +# CPU: 0 UID: 0 PID: 2933 Comm: kms_cursor_crc Not tainted 6.13.0-rc2=
-g5219242748c8 #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Code: f7 48 89 f3 e8 d0 bf 6e d0 48 8b 83 50 01 00 00 a8 01 75 15 4=
8 8b bb a0 01 00 00 e8 59 05 15 d0 48 89 df 5b e9 50 05 15 d0 90  0b 90 eb =
e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90=20
 > > +# RSP: 0018:ffffa14cc08b3b08 EFLAGS: 00010202=20
 > > +# RAX: ffff9b864084b605 RBX: ffff9b8641ba4600 RCX: ffffffff91c96b65=
=20
 > > +# RDX: ffffffff90ad1f80 RSI: 0000000000000000 RDI: 0000000000000000=
=20
 > > +# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002=
=20
 > > +# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff9b864099c000=
=20
 > > +# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000=
=20
 > > +# FS:  00007f4f437ab6c0(0000) GS:ffff9b866bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 00007f4f44c3cd40 CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __warn+0x8c/0x190=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? report_bug+0x164/0x190=20
 > > +#  ? handle_bug+0x54/0x90=20
 > > +#  ? exc_invalid_op+0x17/0x70=20
 > > +#  ? asm_exc_invalid_op+0x1a/0x20=20
 > > +#  ? __pfx_drm_property_free_blob+0x10/0x10=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]=20
 > > +#  drm_atomic_state_default_clear+0x137/0x2f0=20
 > > +#  __drm_atomic_state_free+0x6c/0xb0=20
 > > +#  drm_atomic_helper_update_plane+0x100/0x150=20
 > > +#  drm_mode_cursor_universal+0x10e/0x270=20
 > > +#  drm_mode_cursor_common+0x115/0x240=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  drm_mode_cursor_ioctl+0x4a/0x70=20
 > > +#  drm_ioctl_kernel+0xb0/0x110=20
 > > +#  drm_ioctl+0x235/0x4b0=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  __x64_sys_ioctl+0x92/0xc0=20
 > > +#  do_syscall_64+0xbb/0x1d0=20
 > > +#  entry_SYSCALL_64_after_hwframe+0x77/0x7f=20
 > > +# RIP: 0033:0x7f4f44960c5b=20
 > > +# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05  c2 3d 00 =
f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00=20
 > > +# RSP: 002b:00007ffcdfb0b560 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010=20
 > > +# RAX: ffffffffffffffda RBX: 0000000000000060 RCX: 00007f4f44960c5b=
=20
 > > +# RDX: 00007ffcdfb0b5f0 RSI: 00000000c01c64a3 RDI: 0000000000000005=
=20
 > > +# RBP: 00007ffcdfb0b5f0 R08: 0000000000000007 R09: 000055c3a5801a30=
=20
 > > +# R10: 3107764f00e1f281 R11: 0000000000000246 R12: 00000000c01c64a3=
=20
 > > +# R13: 0000000000000005 R14: 000055c38b7e42c8 R15: 000055c3a579aab0=
=20
 > > +#  =20
 > > +# irq event stamp: 58747=20
 > > +# hardirqs last  enabled at (58753): [] __up_console_sem+0x4d/0x60=20
 > > +# hardirqs last disabled at (58758): [] __up_console_sem+0x32/0x60=20
 > > +# softirqs last  enabled at (47324): [] handle_softirqs+0x310/0x3f0=
=20
 > > +# softirqs last disabled at (47307): [] __irq_exit_rcu+0xa1/0xc0=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Tainted: G        W       =
   6.13.0-rc2-g5219242748c8 #1=20
 > > +# Tainted: [W]=3DWARN=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39=
=20
 > > +# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800=
=20
 > > +# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? __kvmalloc_node_noprof+0x3e/0xc0=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x320=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 000000000000001c=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39=
=20
 > > +# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800=
=20
 > > +# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +=20
 > > +# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-32x32=20
 > > +# ------------[ cut here ]------------=20
 > > +# WARNING: CPU: 0 PID: 2933 at drivers/gpu/drm/vkms/vkms_crtc.c:139 v=
kms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Modules linked in: vkms=20
 > > +# CPU: 0 UID: 0 PID: 2933 Comm: kms_cursor_crc Not tainted 6.13.0-rc2=
-g5219242748c8 #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Code: f7 48 89 f3 e8 d0 bf 6e d0 48 8b 83 50 01 00 00 a8 01 75 15 4=
8 8b bb a0 01 00 00 e8 59 05 15 d0 48 89 df 5b e9 50 05 15 d0 90  0b 90 eb =
e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90=20
 > > +# RSP: 0018:ffffa14cc08b3b08 EFLAGS: 00010202=20
 > > +# RAX: ffff9b864084b605 RBX: ffff9b8641ba4600 RCX: ffffffff91c96b65=
=20
 > > +# RDX: ffffffff90ad1f80 RSI: 0000000000000000 RDI: 0000000000000000=
=20
 > > +# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002=
=20
 > > +# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff9b864099c000=
=20
 > > +# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000=
=20
 > > +# FS:  00007f4f437ab6c0(0000) GS:ffff9b866bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 00007f4f44c3cd40 CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __warn+0x8c/0x190=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? report_bug+0x164/0x190=20
 > > +#  ? handle_bug+0x54/0x90=20
 > > +#  ? exc_invalid_op+0x17/0x70=20
 > > +#  ? asm_exc_invalid_op+0x1a/0x20=20
 > > +#  ? __pfx_drm_property_free_blob+0x10/0x10=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]=20
 > > +#  drm_atomic_state_default_clear+0x137/0x2f0=20
 > > +#  __drm_atomic_state_free+0x6c/0xb0=20
 > > +#  drm_atomic_helper_update_plane+0x100/0x150=20
 > > +#  drm_mode_cursor_universal+0x10e/0x270=20
 > > +#  drm_mode_cursor_common+0x115/0x240=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  drm_mode_cursor_ioctl+0x4a/0x70=20
 > > +#  drm_ioctl_kernel+0xb0/0x110=20
 > > +#  drm_ioctl+0x235/0x4b0=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  __x64_sys_ioctl+0x92/0xc0=20
 > > +#  do_syscall_64+0xbb/0x1d0=20
 > > +#  entry_SYSCALL_64_after_hwframe+0x77/0x7f=20
 > > +# RIP: 0033:0x7f4f44960c5b=20
 > > +# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05  c2 3d 00 =
f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00=20
 > > +# RSP: 002b:00007ffcdfb0b560 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010=20
 > > +# RAX: ffffffffffffffda RBX: 0000000000000060 RCX: 00007f4f44960c5b=
=20
 > > +# RDX: 00007ffcdfb0b5f0 RSI: 00000000c01c64a3 RDI: 0000000000000005=
=20
 > > +# RBP: 00007ffcdfb0b5f0 R08: 0000000000000007 R09: 000055c3a5801a30=
=20
 > > +# R10: 3107764f00e1f281 R11: 0000000000000246 R12: 00000000c01c64a3=
=20
 > > +# R13: 0000000000000005 R14: 000055c38b7e42c8 R15: 000055c3a579aab0=
=20
 > > +#  =20
 > > +# irq event stamp: 58747=20
 > > +# hardirqs last  enabled at (58753): [] __up_console_sem+0x4d/0x60=20
 > > +# hardirqs last disabled at (58758): [] __up_console_sem+0x32/0x60=20
 > > +# softirqs last  enabled at (47324): [] handle_softirqs+0x310/0x3f0=
=20
 > > +# softirqs last disabled at (47307): [] __irq_exit_rcu+0xa1/0xc0=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Tainted: G        W       =
   6.13.0-rc2-g5219242748c8 #1=20
 > > +# Tainted: [W]=3DWARN=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39=
=20
 > > +# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800=
=20
 > > +# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? __kvmalloc_node_noprof+0x3e/0xc0=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x320=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 000000000000001c=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39=
=20
 > > +# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800=
=20
 > > +# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +=20
 > > +# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-32x32=20
 > > +# ------------[ cut here ]------------=20
 > > +# WARNING: CPU: 0 PID: 2933 at drivers/gpu/drm/vkms/vkms_crtc.c:139 v=
kms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Modules linked in: vkms=20
 > > +# CPU: 0 UID: 0 PID: 2933 Comm: kms_cursor_crc Not tainted 6.13.0-rc2=
-g5219242748c8 #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Code: f7 48 89 f3 e8 d0 bf 6e d0 48 8b 83 50 01 00 00 a8 01 75 15 4=
8 8b bb a0 01 00 00 e8 59 05 15 d0 48 89 df 5b e9 50 05 15 d0 90  0b 90 eb =
e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90=20
 > > +# RSP: 0018:ffffa14cc08b3b08 EFLAGS: 00010202=20
 > > +# RAX: ffff9b864084b605 RBX: ffff9b8641ba4600 RCX: ffffffff91c96b65=
=20
 > > +# RDX: ffffffff90ad1f80 RSI: 0000000000000000 RDI: 0000000000000000=
=20
 > > +# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002=
=20
 > > +# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff9b864099c000=
=20
 > > +# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000=
=20
 > > +# FS:  00007f4f437ab6c0(0000) GS:ffff9b866bc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 00007f4f44c3cd40 CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __warn+0x8c/0x190=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? report_bug+0x164/0x190=20
 > > +#  ? handle_bug+0x54/0x90=20
 > > +#  ? exc_invalid_op+0x17/0x70=20
 > > +#  ? asm_exc_invalid_op+0x1a/0x20=20
 > > +#  ? __pfx_drm_property_free_blob+0x10/0x10=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]=20
 > > +#  drm_atomic_state_default_clear+0x137/0x2f0=20
 > > +#  __drm_atomic_state_free+0x6c/0xb0=20
 > > +#  drm_atomic_helper_update_plane+0x100/0x150=20
 > > +#  drm_mode_cursor_universal+0x10e/0x270=20
 > > +#  drm_mode_cursor_common+0x115/0x240=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  drm_mode_cursor_ioctl+0x4a/0x70=20
 > > +#  drm_ioctl_kernel+0xb0/0x110=20
 > > +#  drm_ioctl+0x235/0x4b0=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  __x64_sys_ioctl+0x92/0xc0=20
 > > +#  do_syscall_64+0xbb/0x1d0=20
 > > +#  entry_SYSCALL_64_after_hwframe+0x77/0x7f=20
 > > +# RIP: 0033:0x7f4f44960c5b=20
 > > +# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05  c2 3d 00 =
f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00=20
 > > +# RSP: 002b:00007ffcdfb0b560 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010=20
 > > +# RAX: ffffffffffffffda RBX: 0000000000000060 RCX: 00007f4f44960c5b=
=20
 > > +# RDX: 00007ffcdfb0b5f0 RSI: 00000000c01c64a3 RDI: 0000000000000005=
=20
 > > +# RBP: 00007ffcdfb0b5f0 R08: 0000000000000007 R09: 000055c3a5801a30=
=20
 > > +# R10: 3107764f00e1f281 R11: 0000000000000246 R12: 00000000c01c64a3=
=20
 > > +# R13: 0000000000000005 R14: 000055c38b7e42c8 R15: 000055c3a579aab0=
=20
 > > +#  =20
 > > +# irq event stamp: 58747=20
 > > +# hardirqs last  enabled at (58753): [] __up_console_sem+0x4d/0x60=20
 > > +# hardirqs last disabled at (58758): [] __up_console_sem+0x32/0x60=20
 > > +# softirqs last  enabled at (47324): [] handle_softirqs+0x310/0x3f0=
=20
 > > +# softirqs last disabled at (47307): [] __irq_exit_rcu+0xa1/0xc0=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Tainted: G        W       =
   6.13.0-rc2-g5219242748c8 #1=20
 > > +# Tainted: [W]=3DWARN=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39=
=20
 > > +# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800=
=20
 > > +# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? __kvmalloc_node_noprof+0x3e/0xc0=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x320=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 000000000000001c=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39=
=20
 > > +# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800=
=20
 > > +# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0=
=20
 > > +=20
 > > +# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-128x128=20
 > > +# ------------[ cut here ]------------=20
 > > +# WARNING: CPU: 0 PID: 2898 at drivers/gpu/drm/vkms/vkms_crtc.c:139 v=
kms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Modules linked in: vkms=20
 > > +# CPU: 0 UID: 0 PID: 2898 Comm: kms_cursor_crc Not tainted 6.13.0-rc2=
-g1f006005ebf8 #1=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +# Code: f7 48 89 f3 e8 d0 bf 6e e1 48 8b 83 50 01 00 00 a8 01 75 15 4=
8 8b bb a0 01 00 00 e8 59 05 15 e1 48 89 df 5b e9 50 05 15 e1 90  0b 90 eb =
e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90=20
 > > +# RSP: 0018:ffffa35c4082fb08 EFLAGS: 00010202=20
 > > +# RAX: ffff8b02c1c0f005 RBX: ffff8b02d4509600 RCX: ffffffffa2c96b65=
=20
 > > +# RDX: ffffffffa1ad1f80 RSI: 0000000000000000 RDI: 0000000000000000=
=20
 > > +# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002=
=20
 > > +# R10: 0000000030f11ddf R11: 00000000f30f11dd R12: ffff8b02d2528000=
=20
 > > +# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000=
=20
 > > +# FS:  00007f4b071ab6c0(0000) GS:ffff8b02efc00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000055f7f8384b48 CR3: 0000000104ef0000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __warn+0x8c/0x190=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? report_bug+0x164/0x190=20
 > > +#  ? handle_bug+0x54/0x90=20
 > > +#  ? exc_invalid_op+0x17/0x70=20
 > > +#  ? asm_exc_invalid_op+0x1a/0x20=20
 > > +#  ? __pfx_drm_property_free_blob+0x10/0x10=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]=20
 > > +#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]=20
 > > +#  drm_atomic_state_default_clear+0x137/0x2f0=20
 > > +#  __drm_atomic_state_free+0x6c/0xb0=20
 > > +#  drm_atomic_helper_update_plane+0x100/0x150=20
 > > +#  drm_mode_cursor_universal+0x10e/0x270=20
 > > +#  drm_mode_cursor_common+0x115/0x240=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  drm_mode_cursor_ioctl+0x4a/0x70=20
 > > +#  drm_ioctl_kernel+0xb0/0x110=20
 > > +#  drm_ioctl+0x235/0x4b0=20
 > > +#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10=20
 > > +#  __x64_sys_ioctl+0x92/0xc0=20
 > > +#  do_syscall_64+0xbb/0x1d0=20
 > > +#  entry_SYSCALL_64_after_hwframe+0x77/0x7f=20
 > > +# RIP: 0033:0x7f4b0815ac5b=20
 > > +# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05  c2 3d 00 =
f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00=20
 > > +# RSP: 002b:00007ffd726f75e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010=20
 > > +# RAX: ffffffffffffffda RBX: 000000000000005d RCX: 00007f4b0815ac5b=
=20
 > > +# RDX: 00007ffd726f7670 RSI: 00000000c01c64a3 RDI: 0000000000000005=
=20
 > > +# RBP: 00007ffd726f7670 R08: 0000000000000007 R09: 000055f7f83e30c0=
=20
 > > +# R10: 2b16893c03bd381a R11: 0000000000000246 R12: 00000000c01c64a3=
=20
 > > +# R13: 0000000000000005 R14: 000055f7dbee72c8 R15: 000055f7f837bab0=
=20
 > > +#  =20
 > > +# irq event stamp: 58921=20
 > > +# hardirqs last  enabled at (58927): [] __up_console_sem+0x4d/0x60=20
 > > +# hardirqs last disabled at (58932): [] __up_console_sem+0x32/0x60=20
 > > +# softirqs last  enabled at (46140): [] handle_softirqs+0x310/0x3f0=
=20
 > > +# softirqs last disabled at (46135): [] __irq_exit_rcu+0xa1/0xc0=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI=20
 > > +# CPU: 1 UID: 0 PID: 1657 Comm: kworker/u8:14 Tainted: G        W    =
      6.13.0-rc2-g1f006005ebf8 #1=20
 > > +# Tainted: [W]=3DWARN=20
 > > +# Hardware name: ChromiumOS crosvm, BIOS 0=20
 > > +# Workqueue: vkms_composer vkms_composer_worker [vkms]=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa35c40c43d20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff8b02c52c8000 RSI: ffff8b02c52c9ffc RDI: 00000000fa4761c9=
=20
 > > +# RBP: ffffa35c40c43de0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff8b02c1c87840 R11: 0000000000000000 R12: ffff8b02d4508800=
=20
 > > +# R13: 0000000000000021 R14: 0000000000000000 R15: ffff8b02c1c87840=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff8b02efd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +# CR2: 000000000000001c CR3: 0000000104ef0000 CR4: 0000000000350ef0=
=20
 > > +# Call Trace:=20
 > > +#  =20
 > > +#  ? __die+0x1e/0x60=20
 > > +#  ? page_fault_oops+0x17b/0x4a0=20
 > > +#  ? srso_return_thunk+0x5/0x5f=20
 > > +#  ? exc_page_fault+0x6d/0x230=20
 > > +#  ? asm_exc_page_fault+0x26/0x30=20
 > > +#  ? compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +#  vkms_composer_worker+0x205/0x240 [vkms]=20
 > > +#  process_one_work+0x201/0x6c0=20
 > > +#  ? lock_is_held_type+0x9e/0x110=20
 > > +#  worker_thread+0x17e/0x320=20
 > > +#  ? __pfx_worker_thread+0x10/0x10=20
 > > +#  kthread+0xce/0x100=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork+0x2f/0x50=20
 > > +#  ? __pfx_kthread+0x10/0x10=20
 > > +#  ret_from_fork_asm+0x1a/0x30=20
 > > +#  =20
 > > +# Modules linked in: vkms=20
 > > +# CR2: 000000000000001c=20
 > > +# ---[ end trace 0000000000000000 ]---=20
 > > +# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]=20
 > > +# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 6=
0 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00  50 1c 44 =
39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00=20
 > > +# RSP: 0018:ffffa35c40c43d20 EFLAGS: 00010202=20
 > > +# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002=
=20
 > > +# RDX: ffff8b02c52c8000 RSI: ffff8b02c52c9ffc RDI: 00000000fa4761c9=
=20
 > > +# RBP: ffffa35c40c43de0 R08: 0000000000000000 R09: 0000000000000000=
=20
 > > +# R10: ffff8b02c1c87840 R11: 0000000000000000 R12: ffff8b02d4508800=
=20
 > > +# R13: 0000000000000021 R14: 0000000000000000 R15: ffff8b02c1c87840=
=20
 > > +# FS:  0000000000000000(0000) GS:ffff8b02efd00000(0000) knlGS:0000000=
000000000=20
 > > +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
 > > +=20
 > > +# Skip driver specific tests=20
 > > +^amdgpu.*=20
 > > +^msm.*=20
 > > +nouveau_.*=20
 > > +^panfrost.*=20
 > > +^v3d.*=20
 > > +^vc4.*=20
 > > +^vmwgfx*=20
 > > +=20
 > > +# Skip intel specific tests=20
 > > +gem_.*=20
 > > +i915_.*=20
 > > +xe_.*=20
 > > +tools_test.*=20
 > > +=20
 > > +# IGT issue. is_joiner_mode() should return false for non-Intel hardw=
are.=20
 > > +# https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/162=20
 > > +kms_display_modes@extended-mode-basic=20
 > > +kms_display_modes@mst-extended-mode-negative=20
 > > --=20
 > > 2.43.0=20
 > >=20
 > =20
 > --=20
 > Simona Vetter=20
 > Software Engineer, Intel Corporation=20
 > http://blog.ffwll.ch=20
 >=20


