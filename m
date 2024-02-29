Return-Path: <linux-kselftest+bounces-5656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30E486CEDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211291C22549
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685816065D;
	Thu, 29 Feb 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="np8gxXQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C00160648;
	Thu, 29 Feb 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223357; cv=none; b=V3brKlmhPewXpYUtZaZ9IUQdQJNCqNIo6jHsj9480e3kai4+CtSYg0NY8fpIiFSxfejVo9TGzPpVbFmCvdvQIo3LaVZ8BRJMzpyPTJN9w7U5gdPvxb1qaWkH3alKSoScTE4zsoiZJv9f9FpyC46DOBe+L6SttzZGscNGs9PdUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223357; c=relaxed/simple;
	bh=UpVGGJLkVxk/JHWyNG/+nRTE1UZyw5IEdWGeltmxxe4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ap9Qef248g0Vuk3iG+o0LXLKCAFH1H8buWlB9eCzIogpu+QX+83NH30H0CI1/BUFTKqyAqtcDi+LeENsKlCStGdPVUrAXNnPyEXyDGKuRdLZBLdPFMCv9tHSSyBlNKBu2xcur5v+11Gpd6C+S08P+eoQLk4WvoTnyeWvyqm5Rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=np8gxXQ/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709223354;
	bh=UpVGGJLkVxk/JHWyNG/+nRTE1UZyw5IEdWGeltmxxe4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=np8gxXQ/vROfwRZ9gCBey2vgqhlJumul0Odq0Y+0GjFWziC4W+ENCmNE6rkalTIZL
	 WIjTrY49PEJXBXhxW2mONjHao955mN2B8Sf2Stdc0RN/5ib2otB8dHl9z/6qHo5NjG
	 xdFdKU0ed55iLmoddHQqX25i5sEI3xT8MbP47rh5Pre2jq61+wUeGM1+G+DsrIDT/A
	 tUuZBM4XANenFT6auHER2jbNysgG0Uq5UZ2ZIsmGinE7MLsybkmKBafAmmLGaPHyDP
	 4hbx1Q1+QGemuq9Zw3sP/r8i2YFIRFq+5wj2IlC7RqpViGTBoptb4Pv5UWM0VBzc8E
	 63/5MTXvBLE4w==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 78AE637810EF;
	Thu, 29 Feb 2024 16:15:50 +0000 (UTC)
Message-ID: <3c308cfe3e029ab841ab71f2e159a50a9b3fbf92.camel@collabora.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Bird, Tim" <Tim.Bird@sony.com>, Helen Koike
 <helen.koike@collabora.com>,  "linuxtv-ci@linuxtv.org"
 <linuxtv-ci@linuxtv.org>, "dave.pigott@collabora.com"
 <dave.pigott@collabora.com>, "mripard@kernel.org" <mripard@kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
 "pawiecz@collabora.com" <pawiecz@collabora.com>,  "spbnick@gmail.com"
 <spbnick@gmail.com>, "tales.aparecida@gmail.com"
 <tales.aparecida@gmail.com>,  "workflows@vger.kernel.org"
 <workflows@vger.kernel.org>, "kernelci@lists.linux.dev"
 <kernelci@lists.linux.dev>, "skhan@linuxfoundation.org"
 <skhan@linuxfoundation.org>, "kunit-dev@googlegroups.com"
 <kunit-dev@googlegroups.com>, "nfraprado@collabora.com"
 <nfraprado@collabora.com>, "davidgow@google.com" <davidgow@google.com>, 
 "cocci@inria.fr" <cocci@inria.fr>, "Julia.Lawall@inria.fr"
 <Julia.Lawall@inria.fr>,  "laura.nao@collabora.com"
 <laura.nao@collabora.com>, "ricardo.canuelo@collabora.com"
 <ricardo.canuelo@collabora.com>, "kernel@collabora.com"
 <kernel@collabora.com>,  "torvalds@linuxfoundation.org"
 <torvalds@linuxfoundation.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>
Date: Thu, 29 Feb 2024 11:15:46 -0500
In-Reply-To: <SA3PR13MB63726E6742A05C401D484147FD5F2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
	 <20240228225527.1052240-2-helen.koike@collabora.com>
	 <SA3PR13MB63726E6742A05C401D484147FD5F2@SA3PR13MB6372.namprd13.prod.outlook.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tim,

just replying below to one of your comment which I happen to be involved in=
, but
I'll let others reply for the more specific comments.

Le jeudi 29 f=C3=A9vrier 2024 =C3=A0 02:44 +0000, Bird, Tim a =C3=A9crit=C2=
=A0:
> > -----Original Message-----
> > From: Helen Koike <helen.koike@collabora.com>
> >=20
> ....
>=20
> > Hey all,
> >=20
> > You can check the validation of this patchset on:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://gitlab.collabor=
a.com/koike/linux/-/pipelines/87035
> >=20
> > I would appreciate your feedback on this work, what do you think?
> >=20
> > If you would rate from 0 to 5, where:
> >=20
> > [ ] 0. I don't think this is useful at all, and I doubt it will ever be=
. It doesn't seem worthwhile.
> > [ ] 1. I don't find it useful in its current form.
> > [ ] 2. It might be useful to others, but not for me.
> > [ ] 3. It has potential, but it's not yet something I can incorporate i=
nto my workflow.
> > [ ] 4. This is useful, but it needs some adjustments before I can inclu=
de it in my workflow.
> > [ ] 5. This is really useful! I'm eager to start using it right away. W=
hy didn't you send this earlier? :)
> >=20
> > Which rating would you select?
>=20
> For me, this is a "5".  I don't currently use gitlab, but I might install=
 it just to test this out.
>=20
> It looks like there are a large number of YAML files which define the int=
egration between the
> test scripts and gitlab.  Also, there are a number of shell scripts to pe=
rform some of the setup
> and tests.  Do you have any idea how difficult it would be to use the she=
ll scripts outside of
> the CI system (e.g. manually)?  That is, are there dependencies between t=
he CI system
> and the shell scripts?

You are effectively the second person I'm aware to provide similar feedback=
. We
agreed to conduct an effort to remove the gitlab specifics from the script.
Avoid using gitlab CI shell environment in favour of command line arguments=
.
Also ensure scripts have a "-h" option. This should ease local reproduction=
 and
allow for other CI integration. After all, the Linux kernel is a large comm=
unity
and gitlab is just one option for managing CI. It is a big system, so we ra=
rely
"just install it" ourself. DRM and Linux Media community are using the
Freedesktop instance, sharing resources and cost within that instance. In L=
inux
Media we are developing out of tree scripts with similar purpose, but we al=
so
believe a common set of tool, directly in the kernel tree would be a better=
 long
term solution.

>=20
> I think the convention, of putting this kind of stuff under a "ci" direct=
ory, makes sense.
> And it appears that the sub-dir structure allows for other CI systems to =
add their
> own config and files also.

CI scripts have the particularity of being very granular, which is very unl=
ike
what a human user would prefer. But when CI fails, you really want to know =
which
small step failed, which can sometimes be hidden by more en-globing scripts=
. We
also care a lot about parallelism, since we have hundreds of runners availa=
ble
to execute these tests.

Short answer, I also like that this is under a CI directory, its makes ensu=
re
the purpose and intention of this work is clear.

regards,
Nicolas

