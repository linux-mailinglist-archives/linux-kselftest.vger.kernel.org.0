Return-Path: <linux-kselftest+bounces-25120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0B0A1BA73
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FA416D9F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A83158527;
	Fri, 24 Jan 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3I7/p6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF2770E2;
	Fri, 24 Jan 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736332; cv=none; b=RqHhbbw5PE56z2nQYaWV3yf6d7wNkaGMtaf2EU9iCm8OwCBCc6RCwkMmBOun37GjrWZTEECMJP5uk7TBE6hqBTFQg6yRNa5WRZWxA4SJ2z3m7/bsw2+jRGbN7idAUjNVUjka6pFaL1qgOg07CEbIsEtlw0wHSeEuEZhYhqWk+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736332; c=relaxed/simple;
	bh=buj9ZenxsIQ69t/K1EE7HtMo+2bG/oWLj5fvcapjxUA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=j1IRybHV9GCKeimuTu0TUddEngahQbzqSIfI9s6RHeZXaiL2VUF09lheYr7pUw7pcVdKhdw9lm/zxqK26erhhd0SGelWymIaJwvSM21cUqzQAL2RwwHpsA9ZrrcZmKfFEBtiTc4tZ6Pqta4UiZmWOF4wmd5MNmwnpk2l+ioLGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3I7/p6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEBBC4CED2;
	Fri, 24 Jan 2025 16:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737736332;
	bh=buj9ZenxsIQ69t/K1EE7HtMo+2bG/oWLj5fvcapjxUA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=H3I7/p6qOiDIGiOoQBAUG1hcJ+tysCWHdaFE1PaW4uhteDjw3pR+npaF06v/zkBW0
	 MbvWEMBlbFZTbRdpQOSZ68zcmPDZrOiZ9D7DatPBA7aTco5xScRGmKpAsIm6Eo5fdW
	 GpjiAmKQyF+VYkNffdKZzHpx24g4AW9KqM++lgiw363/TI+q3ftRqDzId4liHJLawe
	 rANWO2Bs/y4K8MRmrCdmYTG11Hr08TVlZ6+7BRBcDxwtI4KHFazipsaMAhAk4FNAZh
	 8rCH0ZYiySGZMj8kltBgr6JzKJc5dxzmUi5mCX2w5sd1uJxWVGjvc8cNNU39uUUqD/
	 93AnUorFuJvJA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 18:32:07 +0200
Message-Id: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
Cc: <linuxtv-ci@linuxtv.org>, <dave.pigott@collabora.com>,
 <mripard@kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
 <gustavo.padovan@collabora.com>, <pawiecz@collabora.com>,
 <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>,
 <laurent.pinchart@ideasonboard.com>, <broonie@kernel.org>,
 <leobras.c@gmail.com>, <groeck@google.com>, <rdunlap@infradead.org>,
 <geert@linux-m68k.org>, <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Nikolai Kondrashov" <Nikolai.Kondrashov@redhat.com>, "Vignesh Raman"
 <vignesh.raman@collabora.com>, <kernelci@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
In-Reply-To: <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>

On Fri Jan 24, 2025 at 2:58 PM EET, Nikolai Kondrashov wrote:
> Hi Jarkko,
>
> On 1/23/25 11:30 PM, Jarkko Sakkinen wrote:
> > On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> >> We are working towards creating a generic, upstream GitLab-CI pipeline
> >> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipe=
line
> >> is designed with a distributed infrastructure model, making it possibl=
e
> >> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> >> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> >> integration.
> >=20
> > Why can't you keep the next version of your great pipeline outside the
> > kernel tree?
> >=20
> > If there is a legit motivation for doing that, why it needs to be bound
> > to Gitlab? Why can't you make script callable from any CI?
>
> Greetings from the (today's) sunny Espoo!
>
> Of course we could keep it outside the kernel tree. However, the point of=
 this
> contribution is to provide kernel maintainers and developers with an easy=
 way
> to setup their CI pipeline on a GitLab instance (the main one, FreeDeskto=
p
> one, or any other). Basically this is like a template or a library, if yo=
u
> wish, which helps you do that. Approved by Linus too.

With all due respect, "approved by Linus" is not an argument :-) I get
that Linus can make the "ultimate decision" but in argumentation I'm not
a strong believer of authority based decision making process. Not
downplaying this more than that I knowingly ignore this comment.

> Why GitLab? Because it's one of the best, if not *the* best CI system the=
se
> days, with lots of flexibility, and it's Open-Source too (well, at least
> open-core, which is still very capable). And also because a number of
> maintainers and companies are already using it.

There's also Github Runners and Woodpecker CI used by Codeberg. To add,
some companies and other organizations prefer Jenkins. This one fit for
all strategy is somewhat short-sighted.

Also running Gitlab tasks locally is possible but is heavy-lifting.

Can we then agree that any CI changes can be sent untested to LKML if
a patch set needs to reflect on those? It's not reasonable to except
local runs Gitlab from individuals for patch sets. It makes our lives
more difficult, not easier.

All maintainers I know test their patches for the most part with
BuildRoot, distro VM's and stuff like that. Not claiming that they
don't exist, but never heard of kernel maintainer who uses Gitlab
as their main kernel testing tool.

> Sure, a script could be contributed too, but the value of this contributi=
on is
> a ready-made integration. And we want to make it easily discoverable, and
> easily contributed to.

This is definitely NOT "lots of flexibility".

Are you dead seriously claiming that DevOps engineers could not handle
well defined CI scripts and bind to whatever CI makes sense to them?
o_O

>
> BTW, here's the talk we gave at last year's LPC regarding current use of
> GitLab in the kernel and surrounding community:
>
> https://lpc.events/event/18/contributions/1728/

This patch set should make the case, not an old presentation.

> Nick

BR, Jarkko

