Return-Path: <linux-kselftest+bounces-25215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7755A1D0F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 07:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE61116382F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A0156F39;
	Mon, 27 Jan 2025 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxNfvZiR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0413AA2D;
	Mon, 27 Jan 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737959981; cv=none; b=LiU++6zm5dBNSNZmI9iZwWxqafeeVR5Y8ZknQhSg3bv1RXJuFvfvQle8508EN1GWAtL1+EZ+Ofip4NniEVQGbyKM73nW/ZWq4pIvWr3b5oUMJiQRer0fC189cZrUSI0LaaWQRtsBZaiyjSBp/MtEZUISk7VXF+48JWCjeg1bOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737959981; c=relaxed/simple;
	bh=o0L9ITlbXOuGoG5NvSGkBzqfS1QOGvu9eKNxY3F9rHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7dIpL4jXRKO49nnB7pAkyqOY0tQ7ZUWT5xPEVVVlsiQEPtFhyN2Hqgbuxs38g5+sLrjcKNyQ0k1YDgSHoR+N2DHqc72ev3DPbJniWHO953UL3A8jK34+J953gLEendgsBdnUp3Dd4b5N9Qx9UYTjEUiLL4DnHDSmnZVEQFFOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxNfvZiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D25C4CED2;
	Mon, 27 Jan 2025 06:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737959980;
	bh=o0L9ITlbXOuGoG5NvSGkBzqfS1QOGvu9eKNxY3F9rHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxNfvZiRWJwa/UVTqhlDj9DaNKCCoh7fy2jNfvL+/1YFt0KI6yr3MRvyWSCv9fOT/
	 hWOPCpYqBZkH7Tm/DG1eRJFvL7wLwTJmabXYY4tNdo8XaNe2rMVK2QHsKZxB05Abm6
	 JGO7LPaTa+WZiPZe656OG3/9h+NlimjjUH5D90qJ35EYQiESb6M936sYoWbiUtliXW
	 ZsWMEu6YoCos20hKD2g18+sWnRC9tNppWG0uY3vb01wYpxSdpGyPrgE4ktyCx6rNTB
	 TCW20ZbrmBmV+XHlSnwt7wC2xmA6oryeNUQDl30mpZAZppbzLmHv+5QPmGGGfVwWCh
	 kDBsvl5T4nSzg==
Date: Mon, 27 Jan 2025 07:39:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc: "Nicolas Dufresne" <nicolas.dufresne@collabora.com>, "Nikolai
 Kondrashov" <Nikolai.Kondrashov@redhat.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Leonardo =?UTF-8?B?QnLDoXM=?="
 <leobras.c@gmail.com>, "Vignesh Raman" <vignesh.raman@collabora.com>,
 "kernelci" <kernelci@lists.linux.dev>, "linuxtv-ci"
 <linuxtv-ci@linuxtv.org>, "dave.pigott" <dave.pigott@collabora.com>,
 "mripard" <mripard@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel@lists.freedesktop.org>, "linux-kselftest"
 <linux-kselftest@vger.kernel.org>, "gustavo.padovan"
 <gustavo.padovan@collabora.com>, "pawiecz" <pawiecz@collabora.com>,
 "spbnick" <spbnick@gmail.com>, "tales.aparecida"
 <tales.aparecida@gmail.com>, "workflows" <workflows@vger.kernel.org>,
 "skhan" <skhan@linuxfoundation.org>, "kunit-dev"
 <kunit-dev@googlegroups.com>, "nfraprado" <nfraprado@collabora.com>,
 "davidgow" <davidgow@google.com>, "cocci" <cocci@inria.fr>, "Julia.Lawall"
 <Julia.Lawall@inria.fr>, "laura.nao" <laura.nao@collabora.com>, "kernel"
 <kernel@collabora.com>, "torvalds" <torvalds@linuxfoundation.org>, "gregkh"
 <gregkh@linuxfoundation.org>, "daniels" <daniels@collabora.com>,
 "shreeya.patel" <shreeya.patel@collabora.com>, "denys.f"
 <denys.f@collabora.com>, "louis.chauvet" <louis.chauvet@bootlin.com>,
 "hamohammed.sa" <hamohammed.sa@gmail.com>, "melissa.srw"
 <melissa.srw@gmail.com>, "simona" <simona@ffwll.ch>, "airlied"
 <airlied@gmail.com>, "Tim.Bird" <Tim.Bird@sony.com>, "broonie"
 <broonie@kernel.org>, "groeck" <groeck@google.com>, "rdunlap"
 <rdunlap@infradead.org>, "geert" <geert@linux-m68k.org>, "michel.daenzer"
 <michel.daenzer@mailbox.org>, "sakari.ailus" <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20250127073400.6307d033@foz.lan>
In-Reply-To: <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	<298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
	<b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
	<20250124162916.38e5c6a0@foz.lan>
	<19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Fri, 24 Jan 2025 16:49:30 -0300
Helen Mae Koike Fornazier <helen.koike@collabora.com> escreveu:

> Hi Mauro,
>=20
>=20
>=20
> ---- On Fri, 24 Jan 2025 12:29:16 -0300 Mauro Carvalho Chehab  wrote ---
>=20
>  > Em Fri, 24 Jan 2025 09:26:33 -0500=20
>  > Nicolas Dufresne nicolas.dufresne@collabora.com> escreveu:=20
>  >   =20
>  > > Hi,=20
>  > >=20
>  > > Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Nikolai Kondrashov a=
 =C3=A9crit=C2=A0:  =20
>  > > > On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:  =20
>  > > > > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:  =20
>  > > > > > Gitlab as an open-source software project (the community editi=
on) is one=20
>  > > > > > thing, but can we please avoid advertising specific proprietar=
y services=20
>  > > > > > in the kernel documentation ?  =20
>  > > > >=20
>  > > > > I don't think we should have any of this in the mainline kernel.=
=20
>  > > > >=20
>  > > > > One angle is that "no regressions rule" applies also to the shen=
anigans.=20
>  > > > >=20
>  > > > > Do we really spend energy on this proprietary crap to the eterni=
ty?  =20
>  > > >=20
>  > > > This is not getting included into the kernel itself, the contribut=
ed code is,=20
>  > > > of course, open-source. And yes it would execute just fine on the =
fully=20
>  > > > open-source community-edition GitLab.  =20
>  >   =20
>  > > > I don't think "no regressions rule" should apply here.  =20
>  > =20
>  > It doesn't, as this is not a Kernel userspace API. It is just some=20
>  > facility to integrate Kernel builds using a CI infrastructure. This ca=
n=20
>  > change with time as needed.=20
>  > =20
>  > Still, once people start using it, developers need to take some care t=
o=20
>  > avoid regressions that would cause CI builds to fail for the ones usin=
g=20
>  > such facilities.=20
>  > =20
>  > Also, ideally, this should be completely independent of the Kernel ver=
sion,=20
>  > e.g. if one sets up an infra using the version that was there when, le=
t's=20
>  > say, Kernel 6.14 is released, the same CI scripts should work just fin=
e=20
>  > with stable Kernels and even future Kernels.  =20
>=20
> Or you can just configure your GitLab CI to work and an older version of
> the script by just pointing the right yaml URL at that versions in the co=
nfigs,
> or am I missing something?

The problem of placing them altogether is that it would be hard to track
incompatible changes, as there's not separate versioning for the yaml
files.

>  > =20
>  > Due to that, I'm not convinced that such kernel CI files should be=20
>  > hosted at the Kernel tree.=20
>  > =20
>  > IMO, this should be stored on a separate repository hosted at=20
>  > kernel.org, using Semantic Versoning (https://semver.org/) - e. g.=20
>  > when there are incompatible changes, major version number will be=20
>  > increased.  =20
>=20
> A key benefit of having it in-tree is the test expectation list, as seen =
with
> DRM-CI. This allows developers to track the state of drivers and progress=
 over
> time by showing which tests are expected to pass or fail at a given point=
 in
> history. (From what I see in DRM-CI, this adds a considerable amount of v=
alue.)
> Please check the VKMS patch in this patchset.

I'm not saying that everything should be on a separate tree. Things like
expected tests and test results are dependent at Kernel versions.

What I'm saying is that hosting CI-specific files a separate repository is
better, as you can keep there what is generic.

> Also, if we keep this tool out of tree, I=E2=80=99m concerned that subsys=
tems like DRM
> and Media will continue not collaborating=E2=80=94each currently has its =
own solution
> when the base could be shared and reused. All static checks, build proces=
ses,
> and boot mechanisms are fundamentally the same, with only minor differenc=
es
> that are customizable. Other subsystems could use just the base or build =
their
> specific configurations/tests on top of it.

I'm in favor of having a common set of CI tooling for all subsystems intere=
sted
on setting up CI. Yet moving part of it to be on a separate repository won't
prevent collaboration. Also, either in or out of tree won't avoid different
subsystems to use different solutions.

What would make people use it is the capability of quickly setting it up
on a new repository. For this to happen, documentation is really important.
Equally important is to have support for multiple git forges and other CI e=
ngines.

For instance, besides media and DRM, I'm also personally interested on havi=
ng
it setup for other subsystems that I also collaborate.

> Having it in-tree sends a message: "You can create your own GitLab CI pip=
eline,
> but why not use this existing one, contribute to it, and collaborate for
> everyone's benefit?".
>
> Since it's under the tools/ folder, it=E2=80=99s a helper tool.

It makes sense to have it documented at the Kernel Documentation folder
and to have something at tools/ that would setup the git forge repositories=
=20
used for CI to do Kernel builds.

> Make sense?
>=20
> Thanks,
> Helen
>=20
>  >   =20
>  > > > This is for developers only, and is a template for making=20
>  > > > your own pipeline mostly, with pieces which can be reused.  =20
>  > >=20
>  > > Perhpas worth clarifying that Media and DRM subsystem have opted for=
 the=20
>  > > Freedesktop instance. This instance is running the Open Source versi=
on of=20
>  > > Gitlab, with hundreds of CI runners contributed and shared among man=
y projects=20
>  > > (which includes Mesa, GStreamer, Wayland, Pipewire, libcamera, just =
to name=20
>  > > few).  =20
>  > =20
>  > It doesn't matter much what git forge some projects are currently usin=
g, as=20
>  > things like that could change with time.=20
>  > =20
>  > Starting with supporting just one type of git forge sounds OK to me,=20
>  > but long term goal should be to make it generic enough to be used with=
 as=20
>  > much CI engines as possible - not only forges developed by companies t=
hat=20
>  > provide paid services like Gitlab/Github, but also completely open=20
>  > source forges and even Jenkins.=20
>  > =20
>  > Thanks,=20
>  > Mauro=20
>  >  =20
>=20



Thanks,
Mauro

