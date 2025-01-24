Return-Path: <linux-kselftest+bounces-25128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EBCA1BB85
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 18:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D5B3A59E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3D1DA2F1;
	Fri, 24 Jan 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g7Zd+FqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88E3224;
	Fri, 24 Jan 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740107; cv=none; b=QaUVarjFFdjub0lFvk5JleCCpKCZhCDLFu1lpJqok1rEwtxA22NE/ceGRVKlpCu1crJbZwUecQbAMIuwzC8p87w2d63buSdMa0iNJqUsJSmRvP/Pz9dNFHF1m0FgmEuUxmYEUescucuLIWN+CoVfgMMF/Fm8208G/bUv3hr6vTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740107; c=relaxed/simple;
	bh=u5gqofTHiDlo8VB6AXG6vGQEZvkFPpUHAM6ATnvul0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWaSdCXGIcCLmCKRj5p/wcfb/93Tfnmjqr7Hqa4JSWs4Mslltx/bnTDyofn4JHX4BFE3lsBSD31zdPPotzDXj2uoDJ/VqNbi6ohxl3yovHRuvn1vwrOLL2zc9utj8HIiZVCmXHGNQlTYuk22th88W0OPytplEIxAO912iIS6FU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=g7Zd+FqQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7AC4564;
	Fri, 24 Jan 2025 18:33:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737740038;
	bh=u5gqofTHiDlo8VB6AXG6vGQEZvkFPpUHAM6ATnvul0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7Zd+FqQs3gh0jbqOC817PsrYMY32rUW6mT0aGjlYbkvrnOIDo/2keCFUWMx378so
	 uvW++ypSeE2VkYKVaWwARTfQzwWSMLm44taxCiayqhogqc2EYUORGcHqw0gONmyepD
	 T1uHIbRnPdXdzwSqiF5FF3z+DMIaEP5WTS2/4s+4=
Date: Fri, 24 Jan 2025 19:34:51 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
	daniels@collabora.com, helen.koike@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
	airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
	leobras.c@gmail.com, groeck@google.com, rdunlap@infradead.org,
	geert@linux-m68k.org, michel.daenzer@mailbox.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20250124173451.GB17899@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
 <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>

On Fri, Jan 24, 2025 at 06:32:07PM +0200, Jarkko Sakkinen wrote:
> On Fri Jan 24, 2025 at 2:58 PM EET, Nikolai Kondrashov wrote:
> > On 1/23/25 11:30 PM, Jarkko Sakkinen wrote:
> > > On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> > >> We are working towards creating a generic, upstream GitLab-CI pipeline
> > >> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
> > >> is designed with a distributed infrastructure model, making it possible
> > >> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> > >> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> > >> integration.
> > > 
> > > Why can't you keep the next version of your great pipeline outside the
> > > kernel tree?
> > > 
> > > If there is a legit motivation for doing that, why it needs to be bound
> > > to Gitlab? Why can't you make script callable from any CI?
> >
> > Greetings from the (today's) sunny Espoo!
> >
> > Of course we could keep it outside the kernel tree. However, the point of this
> > contribution is to provide kernel maintainers and developers with an easy way
> > to setup their CI pipeline on a GitLab instance (the main one, FreeDesktop
> > one, or any other). Basically this is like a template or a library, if you
> > wish, which helps you do that. Approved by Linus too.
> 
> With all due respect, "approved by Linus" is not an argument :-) I get
> that Linus can make the "ultimate decision" but in argumentation I'm not
> a strong believer of authority based decision making process. Not
> downplaying this more than that I knowingly ignore this comment.
> 
> > Why GitLab? Because it's one of the best, if not *the* best CI system these
> > days, with lots of flexibility, and it's Open-Source too (well, at least
> > open-core, which is still very capable). And also because a number of
> > maintainers and companies are already using it.
> 
> There's also Github Runners and Woodpecker CI used by Codeberg. To add,
> some companies and other organizations prefer Jenkins. This one fit for
> all strategy is somewhat short-sighted.
> 
> Also running Gitlab tasks locally is possible but is heavy-lifting.

That's my personal opinion too. In all the CI pipelines I've designed
(which totals to an amount of exactly one) I've implemented as much as
possible in shell scripts that are called from a minimal
service-specific CI configuration. I find this architecture to ease
running tests locally.

> Can we then agree that any CI changes can be sent untested to LKML if
> a patch set needs to reflect on those? It's not reasonable to except
> local runs Gitlab from individuals for patch sets. It makes our lives
> more difficult, not easier.
> 
> All maintainers I know test their patches for the most part with
> BuildRoot, distro VM's and stuff like that. Not claiming that they
> don't exist, but never heard of kernel maintainer who uses Gitlab
> as their main kernel testing tool.

That's highly subsystem-specific, and depends on what kind of testing is
performed. The Linux media subsystem recently adopted
gitlab.freedesktop.org for compilation and other static tests. As a
developer, I compile-test my kernel patches locally, and run them on
hardware without going through CI pipelines.

> > Sure, a script could be contributed too, but the value of this contribution is
> > a ready-made integration. And we want to make it easily discoverable, and
> > easily contributed to.
> 
> This is definitely NOT "lots of flexibility".
> 
> Are you dead seriously claiming that DevOps engineers could not handle
> well defined CI scripts and bind to whatever CI makes sense to them?
> o_O
> 
> > BTW, here's the talk we gave at last year's LPC regarding current use of
> > GitLab in the kernel and surrounding community:
> >
> > https://lpc.events/event/18/contributions/1728/
> 
> This patch set should make the case, not an old presentation.

-- 
Regards,

Laurent Pinchart

