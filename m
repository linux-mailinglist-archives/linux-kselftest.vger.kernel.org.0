Return-Path: <linux-kselftest+bounces-5625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43E86C661
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 11:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F11F21486
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E96657BC;
	Thu, 29 Feb 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ViWpHkNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519EC651A4;
	Thu, 29 Feb 2024 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201107; cv=none; b=XXzwQQ2E4j/rNO4d8JQCd4owjRnLh7Kah56sEZeFobVOSTvaAGkouF8fTTGY3tnHgJwQChh59+L1agfclvD7XRSn6AZOJPoVdBDqQKjuA+ohyaOq49eLGtjt4nhk/YZ0kIpNWjftbzVS0V4WciemvQz2dgFXiBUO1m2QXoEyLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201107; c=relaxed/simple;
	bh=3lGwHxI8UnE8JqcWEhpZmZgiy3H+Qv7T/7shG1gtysA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+VaKQpf2lddb4n/Ktljytvij17oFgxq3YDvtUcBOgefLpOepGWdXO9VxEti4/dbN4fm5AuS83w2WvnxWyYEl65h8uZsBG3NYKQzIk+tACA82Q12Md44j/8TuoIpvgygGpgCXPoEku1SvxDVYByt8BFGX3mTLVmi4jVt66uVRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ViWpHkNz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1517D2E7;
	Thu, 29 Feb 2024 11:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709201090;
	bh=3lGwHxI8UnE8JqcWEhpZmZgiy3H+Qv7T/7shG1gtysA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViWpHkNz18IU7gDdLPt4zKYPqt2i2i0z6PKTAE5PRvqDrWqFkGYWvgXCXYl0a9hFz
	 g2+YeoFWRkF21qCjEbAulYDEGfHU2kOiY9fWxx6Ue6nFn4CMHmRvu0FYl84NfI4ghP
	 YcCcGm8xarEITCnMTBean4AbPUWFEEnyZA/t7hLs=
Date: Thu, 29 Feb 2024 12:05:05 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nikolai Kondrashov <spbnick@gmail.com>,
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kernelci@lists.linux.dev, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, ricardo.canuelo@collabora.com,
	kernel@collabora.com, torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240229100505.GB30889@pendragon.ideasonboard.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <20240229-quizzical-persimmon-honeybee-b5db48@houat>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229-quizzical-persimmon-honeybee-b5db48@houat>

On Thu, Feb 29, 2024 at 10:56:58AM +0100, Maxime Ripard wrote:
> Hi!
> 
> On Thu, Feb 29, 2024 at 11:23:22AM +0200, Nikolai Kondrashov wrote:
> > Hi everyone,
> > 
> > On 2/29/24 11:02, Maxime Ripard wrote:
> > > On Wed, Feb 28, 2024 at 07:55:25PM -0300, Helen Koike wrote:
> > > > Which rating would you select?
> > > 
> > > 4.5 :)
> > > 
> > > One thing I'm wondering here is how we're going to cope with the
> > > different requirements each user / framework has.
> > > 
> > > Like, Linus probably want to have a different set of CI before merging a
> > > PR than (say) linux-next does, or stable, or before doing an actual
> > > release.
> > > 
> > > Similarly, DRM probably has a different set of requirements than
> > > drm-misc, drm-amd or nouveau.
> > > 
> > > I don't see how the current architecture could accomodate for that. I
> > > know that Gitlab allows to store issues template in a separate repo,
> > > maybe we could ask them to provide a feature where the actions would be
> > > separate from the main repo? That way, any gitlab project could provide
> > > its own set of tests, without conflicting with each others (and we could
> > > still share them if we wanted to)
> > > 
> > > I know some of use had good relationship with Gitlab, so maybe it would
> > > be worth asking?
> > 
> > GitLab already supports getting the CI YAML from other repos. You can change
> > that in the repo settings.
> 
> I'm interested but couldn't find it in the doc, do you have a link to
> the right section?

e.g. https://gitlab.freedesktop.org/camera/libcamera/-/settings/ci_cd

Expand "General pipelines", the setting is "CI/CD configuration file".
You can specify the path to a file in the local repository, or in a
separate repository. See
https://gitlab.freedesktop.org/help/ci/pipelines/settings#specify-a-custom-cicd-configuration-file
for the syntax.

> > However, I think a better approach would be *not* to add the .gitlab-ci.yaml
> > file in the root of the source tree, but instead change the very same repo
> > setting to point to a particular entry YAML, *inside* the repo (somewhere
> > under "ci" directory) instead.
> > 
> > This way all the different subtrees can have completely different setup, but
> > some could still use Helen's work and employ the "scenarios" she
> > implemented.
> 
> I'm worried that this kind of setup will just create duplicated YAML
> that will be developped in complete silos and will become difficult to
> maintain. But that's definitely an opinion :)

-- 
Regards,

Laurent Pinchart

