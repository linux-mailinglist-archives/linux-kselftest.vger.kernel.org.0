Return-Path: <linux-kselftest+bounces-6060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F78755C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 19:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78927B224D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10F131752;
	Thu,  7 Mar 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OU0fE8FN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6712F5B1;
	Thu,  7 Mar 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834723; cv=none; b=fS9QUNKkXjIdyQ/+qivdpgCv4k/2tYRuIKA+GPn7TcGYAc0r1J9kla+eqAB0itwarbs3wsQGchXxyxOpBmWEu1m5yV1U8P7eSvrXMI1fHo82I8hgxyKcTgbAT8oLAylQJ/2soMdqIxQpV+iB8CIu0PGlBfFW0aPso0E+d97H6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834723; c=relaxed/simple;
	bh=6PdhETDwSB9x/LARJancAnLAUQJ5EbrpK/EH1ojZ3Mc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbBSRdWpYLA/1D0HFhmm5pkoGm8N9H/zBhC1k4XGxSKCUgRPvYhKFaUnXY2YsbXc+5+ri9obhZyBr538nLga6i7ahkLJf7xUVcf+RO9xXjTRGUy8HbgLTUXihVv26vK02d+HFk2vCNJVUE0UF0lGjsDDBfTVXwd6g/H4eOulM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OU0fE8FN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709834719;
	bh=6PdhETDwSB9x/LARJancAnLAUQJ5EbrpK/EH1ojZ3Mc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OU0fE8FNWeNCdyMVaBI+4zAWM0y2JrwciNVCgXFIk5Qctuiac9EcJSIQWKn8GLdzL
	 gTAxVJhidM9b0q5MCeaePZ7UfOi7iTQl+GDy25E8GwfzLhm2EZbuM7ZX5bdQlbSakU
	 W4D0VZxomztXYGrHt7Bq2604MnjnKHvYJXfNqvuDbMvD4PELUTQDKC6NNd65GJWs5o
	 8XgGro4CnGW93oz1/rOknU6b0cERoQtqPMi+NPzgZtMuDwftt0avBWCu1W72EIjcSV
	 H/B1QVCYi1lbljlJPuaG92wNbtiFCWyXvgp9pxF13OCGia3NHbCOCIXo4WiDqm8YOl
	 4nSNokRv8JaKw==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 53FE037820ED;
	Thu,  7 Mar 2024 18:05:16 +0000 (UTC)
Message-ID: <d417daa2a8e3951da44bf2d555e04d98c83a3c5c.camel@collabora.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Maxime Ripard <mripard@kernel.org>, Helen Koike
 <helen.koike@collabora.com>
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com, 
 workflows@vger.kernel.org, kernelci@lists.linux.dev,
 skhan@linuxfoundation.org,  kunit-dev@googlegroups.com,
 nfraprado@collabora.com, davidgow@google.com,  cocci@inria.fr,
 Julia.Lawall@inria.fr, laura.nao@collabora.com, 
 ricardo.canuelo@collabora.com, kernel@collabora.com, 
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Date: Thu, 07 Mar 2024 13:05:12 -0500
In-Reply-To: <20240229-dancing-laughing-groundhog-d85161@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
	 <20240228225527.1052240-2-helen.koike@collabora.com>
	 <20240229-dancing-laughing-groundhog-d85161@houat>
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

Le jeudi 29 f=C3=A9vrier 2024 =C3=A0 10:02 +0100, Maxime Ripard a =C3=A9cri=
t=C2=A0:
> Hi Helen,
>=20
> Thanks for working on this
>=20
> On Wed, Feb 28, 2024 at 07:55:25PM -0300, Helen Koike wrote:
> > This patch introduces a `.gitlab-ci` file along with a `ci/` folder,
> > defininga basic test pipeline triggered by code pushes to a GitLab-CI
> > instance. This initial version includes static checks (checkpatch and
> > smatch for now) and build tests across various architectures and
> > configurations. It leverages an integrated cache for efficient build
> > times and introduces a flexible 'scenarios' mechanism for
> > subsystem-specific extensions.
> >=20
> > [ci: add prerequisites to run check-patch on MRs]
> > Co-developed-by: Tales Aparecida <tales.aparecida@redhat.com>
> > Signed-off-by: Tales Aparecida <tales.aparecida@redhat.com>
> > Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >=20
> > ---
> >=20
> > Hey all,
> >=20
> > You can check the validation of this patchset on:
> >         https://gitlab.collabora.com/koike/linux/-/pipelines/87035
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
> 4.5 :)
>=20
> One thing I'm wondering here is how we're going to cope with the
> different requirements each user / framework has.
>=20
> Like, Linus probably want to have a different set of CI before merging a
> PR than (say) linux-next does, or stable, or before doing an actual
> release.
>=20
> Similarly, DRM probably has a different set of requirements than
> drm-misc, drm-amd or nouveau.
>=20
> I don't see how the current architecture could accomodate for that. I
> know that Gitlab allows to store issues template in a separate repo,
> maybe we could ask them to provide a feature where the actions would be
> separate from the main repo? That way, any gitlab project could provide
> its own set of tests, without conflicting with each others (and we could
> still share them if we wanted to)
>=20
> I know some of use had good relationship with Gitlab, so maybe it would
> be worth asking?

As agreed, the .gitlab-ci.yaml file at the list will go away. Its a default
location, but not a required location. This way, each sub-system can have t=
heir
own (or not have one). The different sub-system forks will have to be confi=
gured
to point to their respective CI main configuration.

Of course nothing prevents having common set of configuration for jobs and =
jobs
template. As an example, we could have a job template common for checkpatch=
, and
allow each subsystem adding their own sauce on top. It can save the duplica=
te
effort of parsing the tool results and reporting it in a format gitlab
understand.

This also allow subsystems to offer different coverage, e.g. a fast vs a fu=
ll
coverage. Or perhaps a configuration to focus on specific devices. But in
general, just not having a central config is enough to support the idea. Wh=
at we
have now could be entirely drm specific and "commonized" later when other
subsystem wanting to use gitlab joins (Linux Media is among those).

Nicolas

