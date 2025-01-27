Return-Path: <linux-kselftest+bounces-25216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6DA1D135
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 08:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261EE164BE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754C1FC0F9;
	Mon, 27 Jan 2025 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ3yAWrb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DE1FBEB0;
	Mon, 27 Jan 2025 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737961633; cv=none; b=jLEyNrUAvLBl6uYbAmVdKvCNdhPa5cffTSIakZdiD3hNTpKp8/YWwUqvfXhtW6325WJjT7KJNspgxtxlWRWH1t0a9TE1U3boVgTlyL02ZXgPjKm1fEX7gkR/O2AQKjjHR9Yeu0j1Tj9QGcQrBmcqBZv2aLECtsyT63DEcJUGIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737961633; c=relaxed/simple;
	bh=9Ez1zOChWlmyhAFXJELL4Q+Ba8u7zI70k04btQJ7GY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0eUSQUzSMciQmHEUP8YENasvJfseMEs9CpTZzjotxp+n7yHituzNctNhpTXBut5zojRymWE/3eZzP3xb43pDxXbx9Y2xGHD+TDQQ8gqxgoS3S30Cyp9oXpG07HL/KCzj2MtKVYNRZCJJtSP0gxvGbVGpe9vWqYw7CbCnk7MUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ3yAWrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF15DC4CEE4;
	Mon, 27 Jan 2025 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737961633;
	bh=9Ez1zOChWlmyhAFXJELL4Q+Ba8u7zI70k04btQJ7GY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZ3yAWrbH0ux0vOf0oP6c8x4wyiAhU+pzINvZTmepJq8amVfhad2FZTMJ3Pfam/B3
	 hBvyREeMomlzBmyiw1+EhdtrYAendqzX2erOtad0dQiSG8N3ZaGT8wezgigwHKYddf
	 zFwQiVkPOBwtXK2fW/ypHzo2doKJ6qbzAjEjt2tXpntOeunKP239ejfuiYurMjqXpw
	 3KEdYFnyxzL3E+nh+3FxoAS++7hc/NxEhwZz63y7yM1zKTbdXELeJlpJ1C+Y0BoSky
	 dKVRLHV+Hz6zFy+vf6EHcp8/VGAsg3vkI2UfTpsajcLiPCOyn276K4vqs9LvTSADAe
	 b37EheV7PDmBA==
Date: Mon, 27 Jan 2025 08:07:03 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leonardo =?UTF-8?B?QnLDoXM=?= <leobras.c@gmail.com>, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Vignesh Raman
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
 daniels@collabora.com, shreeya.patel@collabora.com, denys.f@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20250127080618.55f5f915@foz.lan>
In-Reply-To: <20250127060738.GA16795@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
	<20250124135203.040d0852@foz.lan>
	<20250124130021.GA6853@pendragon.ideasonboard.com>
	<f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
	<bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
	<20250127060738.GA16795@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Mon, 27 Jan 2025 08:07:38 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> On Fri, Jan 24, 2025 at 06:12:24PM -0300, Leonardo Br=C3=A1s wrote:
> > On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote: =20
> > > Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Laurent Pinchart a =
=C3=A9crit=C2=A0: =20
> > > > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wro=
te: =20
> > > > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > > > >  =20
> > > > > > > It's been a few years since I first thought on finding a good=
 way of helping
> > > > > > > kernel developers testing their patches, while making use of =
the free runner
> > > > > > > minutes Gitlab offers. It can greatly simplify the testing fo=
r people who are
> > > > > > > new to kernel development, or students trying to understand i=
t better.
> > > > > > >=20
> > > > > > > And this patchset allows that to happen :)
> > > > > > >=20
> > > > > > > Actually, I spoke to Helen last year, and to enable it to run=
 on the free
> > > > > > > Gitlab-CI runners, there is a small extra patch which is need=
ed:
> > > > > > >=20
> > > > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@r=
edhat.com/   =20
> > > > >=20
> > > > > Sounds interesting!
> > > > >  =20
> > > > > > Gitlab as an open-source software project (the community editio=
n) is one
> > > > > > thing, but can we please avoid advertising specific proprietary=
 services
> > > > > > in the kernel documentation ? =20
> > > > >=20
> > > > > Every time Gitlab is mentioned, the brand of the company that
> > > > > developed it and has been providing proprietary services is also
> > > > > advertised. If you're not happy with that, you should move to use
> > > > > a git forge developed by some open source community. =20
> > > >=20
> > > > I'm fine mentioning the gitlab community edition, I'm not fine
> > > > advertising gitlab.com SaaS in the kernel source tree. =20
> >=20
> > Hello Laurent,
> >=20
> > I see your point, and I see no issue on removing the two last lines of =
CI_TAGS
> > documentation.
> >=20
> > I just added this information on documentation because the default runn=
er used
> > for the Free Tier of Gitlab does not work for this CI, as it needs more
> > resources to run. This information can be added on some other place, bu=
t at the
> > time I thought it would be ok to let it be there.=C2=A0
> > This other runner I mentioned in the patch is also available on the Fre=
e Tier
> > (free as in beer).
> >=20
> > I would like to make it clear that I have no connection/affiliation to =
Gitlab,
> > other than a free account in their system, which I use for some CI. I h=
ave no
> > interest on advertising anything from them.
> >=20
> > My only objective is to make it easier to hobbyists/beginners to use th=
ose
> > available free minutes to test some change before sending the patch, if=
 they
> > think that's valuable. =20
>=20
> Given the 400 free computes minute per month, and the fact that the
> saas-linux-medium-amd64 runner consumers two minutes per minute, how
> many of the proposed CI runs would be available per month ?
>=20
> CI pipeline runs always compile the kernel from scratch as far as  can
> see. This may not be an issue for final testing before submission of a
> patch series, but it just won't work for incremental testing of changes.
> Think of how inefficient it would be to run a full pipeline just to get
> the checkpatch.pl output for instance. This is why I believe tests
> should focus first and foremost on ease of use in developers' local
> environments. A standardized, from-scratch, comprehensive test run as a
> gate keeper for integration has value as well, but that won't help
> beginners much.

To better cope with free minutes, CI pipelines should allow setting
up build just the subsystem instead of the entire Kernel. Not perfect,
but still if CI would test multiple archs/Kconfig options, it would
be useful to get early lots of potential issues.

That's said, using developers' local environments is interesting.
Yet, there's s potential risk of using it while having an external
entity running a git forge, as it would mean that a remote entity
would trigger something to run locally. Personally, I would=20

So, if I were to setup a local build environment, I would either use
a separate machine outside my internal network or I would opt to
install a local git forge instance. No idea how easy/hard would
be to maintain such local gitlab instance.

Thanks,
Mauro

