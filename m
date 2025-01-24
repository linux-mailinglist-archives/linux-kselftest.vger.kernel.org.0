Return-Path: <linux-kselftest+bounces-25130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B64AA1BCF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 20:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAFD188FDD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D92219A74;
	Fri, 24 Jan 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="G6dRYysp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724C4A1D;
	Fri, 24 Jan 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748253; cv=pass; b=A70FIwI0/XgJtGQ1Q9kMgleOFd77v2jC2IKPyMWyN3TCiLGB86r0iD87mUyCpE2NdfrZugDwWRTu8mka2ru+G/KK6Kga+3V0bkuDuy93pwSJJTKIghBXWFJco7kn594etLfdFizAOy8zU64XwnGhjflIN7v2ddwhBt/l3tHhJNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748253; c=relaxed/simple;
	bh=XvFJMcw24740CmSTkFgdYljRGC+NsHdPeg8XoMbmVjY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UhCBlxmtlfsO1FaSPxj6qYWtsdoGki/yiQdT+omhkT0lJJiRtc1Vv+b5WLLTkFkg8mPd1t2mwfxodGsmEjMD48e+ypxHvFUf5KUDZsZcjc8b6rabIjA3TI63lseyOa0BtTvql6ira53bgp9SLvEcIZhwSCseHrPWJ4Qvxa6MoCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=G6dRYysp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1737748172; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ky4r6TF07Lob+Ez5NvZxliQNWjB06Ko6ISb5A8jkdRrK7cWRkjawZZv99VwjE+CpwqAPfPVQycd8SooO/SF/FtRQfRIch6f78vzJ0wDraBlkGKfGDMMO5nIBHdw9O6MPFo4/z8/mql1sNo/LFWfnKvmEpr8dTJp52QqwBDXMuHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737748172; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P3plHeS1o3KvPZ1XoCcefzHmD3HT2RUHL6C1XVcnSgw=; 
	b=h8iYZaTY/Xye1Wl3/TjEaXv4nB4nn2J/y/z2lKE4foZ5PefjqoKK08K01dEqaD1OOA801IpFfe3MbtwnolnNi8irplmauwxvBXgH/DcxuIFoyLt6pLmcMdvPX/DJe3cEtc3DEaobSP1xldtkEasiG3VBrD99AO726WIoXNANBdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737748172;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=P3plHeS1o3KvPZ1XoCcefzHmD3HT2RUHL6C1XVcnSgw=;
	b=G6dRYyspG/n+UZlni8DR0M1S94yBZIZtpGcCi9rwapNjc4V4MuO26GvzfejV3Gta
	+3ulO24vLha/n+JGzLD20695nB94aQ5TiG8tVk25OnLtay10v5bsgdos/ziuqBVI8I5
	4hnDxGrvctHtow+i8LiyR1PwFKfEKnrrplo0tUnw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1737748170108910.7137931457631; Fri, 24 Jan 2025 11:49:30 -0800 (PST)
Date: Fri, 24 Jan 2025 16:49:30 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Cc: "Nicolas Dufresne" <nicolas.dufresne@collabora.com>,
	"Nikolai Kondrashov" <Nikolai.Kondrashov@redhat.com>,
	"Jarkko Sakkinen" <jarkko@kernel.org>,
	"Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
	=?UTF-8?Q?=22Leonardo_Br=C3=A1s=22?= <leobras.c@gmail.com>,
	"Vignesh Raman" <vignesh.raman@collabora.com>,
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
	"louis.chauvet" <louis.chauvet@bootlin.com>,
	"hamohammed.sa" <hamohammed.sa@gmail.com>,
	"melissa.srw" <melissa.srw@gmail.com>, "simona" <simona@ffwll.ch>,
	"airlied" <airlied@gmail.com>, "Tim.Bird" <Tim.Bird@sony.com>,
	"broonie" <broonie@kernel.org>, "groeck" <groeck@google.com>,
	"rdunlap" <rdunlap@infradead.org>, "geert" <geert@linux-m68k.org>,
	"michel.daenzer" <michel.daenzer@mailbox.org>,
	"sakari.ailus" <sakari.ailus@iki.fi>
Message-ID: <19499dcc55d.d07a9615183956.5491109771298297030@collabora.com>
In-Reply-To: <20250124162916.38e5c6a0@foz.lan>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	<298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
	<b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com> <20250124162916.38e5c6a0@foz.lan>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
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

Hi Mauro,



---- On Fri, 24 Jan 2025 12:29:16 -0300 Mauro Carvalho Chehab  wrote ---

 > Em Fri, 24 Jan 2025 09:26:33 -0500=20
 > Nicolas Dufresne nicolas.dufresne@collabora.com> escreveu:=20
 > =20
 > > Hi,=20
 > >=20
 > > Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Nikolai Kondrashov a =
=C3=A9crit=C2=A0:=20
 > > > On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:=20
 > > > > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:=20
 > > > > > Gitlab as an open-source software project (the community edition=
) is one=20
 > > > > > thing, but can we please avoid advertising specific proprietary =
services=20
 > > > > > in the kernel documentation ?=20
 > > > >=20
 > > > > I don't think we should have any of this in the mainline kernel.=
=20
 > > > >=20
 > > > > One angle is that "no regressions rule" applies also to the shenan=
igans.=20
 > > > >=20
 > > > > Do we really spend energy on this proprietary crap to the eternity=
?=20
 > > >=20
 > > > This is not getting included into the kernel itself, the contributed=
 code is,=20
 > > > of course, open-source. And yes it would execute just fine on the fu=
lly=20
 > > > open-source community-edition GitLab.=20
 > =20
 > > > I don't think "no regressions rule" should apply here.=20
 > =20
 > It doesn't, as this is not a Kernel userspace API. It is just some=20
 > facility to integrate Kernel builds using a CI infrastructure. This can=
=20
 > change with time as needed.=20
 > =20
 > Still, once people start using it, developers need to take some care to=
=20
 > avoid regressions that would cause CI builds to fail for the ones using=
=20
 > such facilities.=20
 > =20
 > Also, ideally, this should be completely independent of the Kernel versi=
on,=20
 > e.g. if one sets up an infra using the version that was there when, let'=
s=20
 > say, Kernel 6.14 is released, the same CI scripts should work just fine=
=20
 > with stable Kernels and even future Kernels.=20

Or you can just configure your GitLab CI to work and an older version of
the script by just pointing the right yaml URL at that versions in the conf=
igs,
or am I missing something?

 > =20
 > Due to that, I'm not convinced that such kernel CI files should be=20
 > hosted at the Kernel tree.=20
 > =20
 > IMO, this should be stored on a separate repository hosted at=20
 > kernel.org, using Semantic Versoning (https://semver.org/) - e. g.=20
 > when there are incompatible changes, major version number will be=20
 > increased.=20

A key benefit of having it in-tree is the test expectation list, as seen wi=
th
DRM-CI. This allows developers to track the state of drivers and progress o=
ver
time by showing which tests are expected to pass or fail at a given point i=
n
history. (From what I see in DRM-CI, this adds a considerable amount of val=
ue.)
Please check the VKMS patch in this patchset.

Also, if we keep this tool out of tree, I=E2=80=99m concerned that subsyste=
ms like DRM
and Media will continue not collaborating=E2=80=94each currently has its ow=
n solution
when the base could be shared and reused. All static checks, build processe=
s,
and boot mechanisms are fundamentally the same, with only minor differences
that are customizable. Other subsystems could use just the base or build th=
eir
specific configurations/tests on top of it.
Having it in-tree sends a message: "You can create your own GitLab CI pipel=
ine,
but why not use this existing one, contribute to it, and collaborate for
everyone's benefit?".
Since it's under the tools/ folder, it=E2=80=99s a helper tool.

Make sense?

Thanks,
Helen

 > =20
 > > > This is for developers only, and is a template for making=20
 > > > your own pipeline mostly, with pieces which can be reused.=20
 > >=20
 > > Perhpas worth clarifying that Media and DRM subsystem have opted for t=
he=20
 > > Freedesktop instance. This instance is running the Open Source version=
 of=20
 > > Gitlab, with hundreds of CI runners contributed and shared among many =
projects=20
 > > (which includes Mesa, GStreamer, Wayland, Pipewire, libcamera, just to=
 name=20
 > > few).=20
 > =20
 > It doesn't matter much what git forge some projects are currently using,=
 as=20
 > things like that could change with time.=20
 > =20
 > Starting with supporting just one type of git forge sounds OK to me,=20
 > but long term goal should be to make it generic enough to be used with a=
s=20
 > much CI engines as possible - not only forges developed by companies tha=
t=20
 > provide paid services like Gitlab/Github, but also completely open=20
 > source forges and even Jenkins.=20
 > =20
 > Thanks,=20
 > Mauro=20
 >=20


