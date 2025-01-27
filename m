Return-Path: <linux-kselftest+bounces-25214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7FA1D0CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 07:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E5B7A2A88
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 06:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE21547FE;
	Mon, 27 Jan 2025 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wg76r+aL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1C291E;
	Mon, 27 Jan 2025 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958079; cv=none; b=AoRUXbAiROfV13JSsORDmFrjGX+i2EYUYSXteC+QzfvSA1wcvTHSemquenFc+yrHlMM7WSMrtHXfBptY/oo5qFIJwE+y7D6PUK56iOCxu4kFtbagFFfGIF+ZluVW/ThAX/S1aNht+70nO8LQfwhFN9QZ3OopT18N0P+rtbFFBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958079; c=relaxed/simple;
	bh=1PaZnQBrTgFdzNwyFGepkFiUf9DmyMOVozBizg170xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAASzUvr4iwrS9CMD/Yl2Sk1QdD25FNXMrTw4lRkIlJF2vFzt93qG25BoE8tO6mFgWRRiLBUQqkv8l7NEoNGWvmcfCxsrt9ZjwJPnFt0sSwDw31VrxUnrTukYnds1Yb4NXDbtHd8DojjYsdJYERoYFu9oYXHnherbv+UwWiqu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wg76r+aL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 981F9496;
	Mon, 27 Jan 2025 07:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737958002;
	bh=1PaZnQBrTgFdzNwyFGepkFiUf9DmyMOVozBizg170xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wg76r+aLaFMHJluyTdjsdq+Inq2rF8WaS13E1+T6WTus5cN3mHgPYCKYKmAyFUcwf
	 LruXKaGbye7fMI4VJDL5/tACuukhXEf+qbB5dXx15WCUsSOEcVouiEpLea6BTeSBy5
	 5MfnZLdJTtA8GQI3XY0xYDfbw6L0BkK9FtHnXlU8=
Date: Mon, 27 Jan 2025 08:07:38 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	kernel@collabora.com, torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org, daniels@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
	melissa.srw@gmail.com, simona@ffwll.ch, airlied@gmail.com,
	Tim.Bird@sony.com, broonie@kernel.org, groeck@google.com,
	rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20250127060738.GA16795@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <20250124135203.040d0852@foz.lan>
 <20250124130021.GA6853@pendragon.ideasonboard.com>
 <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
 <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>

On Fri, Jan 24, 2025 at 06:12:24PM -0300, Leonardo Brás wrote:
> On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote:
> > Le vendredi 24 janvier 2025 à 15:00 +0200, Laurent Pinchart a écrit :
> > > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > > > 
> > > > > > It's been a few years since I first thought on finding a good way of helping
> > > > > > kernel developers testing their patches, while making use of the free runner
> > > > > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > > > > new to kernel development, or students trying to understand it better.
> > > > > > 
> > > > > > And this patchset allows that to happen :)
> > > > > > 
> > > > > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > > > 
> > > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> > > > 
> > > > Sounds interesting!
> > > > 
> > > > > Gitlab as an open-source software project (the community edition) is one
> > > > > thing, but can we please avoid advertising specific proprietary services
> > > > > in the kernel documentation ?
> > > > 
> > > > Every time Gitlab is mentioned, the brand of the company that
> > > > developed it and has been providing proprietary services is also
> > > > advertised. If you're not happy with that, you should move to use
> > > > a git forge developed by some open source community.
> > > 
> > > I'm fine mentioning the gitlab community edition, I'm not fine
> > > advertising gitlab.com SaaS in the kernel source tree.
> 
> Hello Laurent,
> 
> I see your point, and I see no issue on removing the two last lines of CI_TAGS
> documentation.
> 
> I just added this information on documentation because the default runner used
> for the Free Tier of Gitlab does not work for this CI, as it needs more
> resources to run. This information can be added on some other place, but at the
> time I thought it would be ok to let it be there. 
> This other runner I mentioned in the patch is also available on the Free Tier
> (free as in beer).
> 
> I would like to make it clear that I have no connection/affiliation to Gitlab,
> other than a free account in their system, which I use for some CI. I have no
> interest on advertising anything from them.
> 
> My only objective is to make it easier to hobbyists/beginners to use those
> available free minutes to test some change before sending the patch, if they
> think that's valuable.

Given the 400 free computes minute per month, and the fact that the
saas-linux-medium-amd64 runner consumers two minutes per minute, how
many of the proposed CI runs would be available per month ?

CI pipeline runs always compile the kernel from scratch as far as  can
see. This may not be an issue for final testing before submission of a
patch series, but it just won't work for incremental testing of changes.
Think of how inefficient it would be to run a full pipeline just to get
the checkpatch.pl output for instance. This is why I believe tests
should focus first and foremost on ease of use in developers' local
environments. A standardized, from-scratch, comprehensive test run as a
gate keeper for integration has value as well, but that won't help
beginners much.

> > I've just looked attentively, the intention is just to explain you may need to
> > set gitlab variable in your project fork in order to select correctly sized
> > sized runners in your own instance.
> 
> That's correct
> 
> >  Its is not strictly about commercial gitlab.com instance. 
> 
> Exactly, the change is about being able to choose the runner you want.
> 
> > The default only works with the original project used
> > instance (which is not gitlab.com as far as I know), but the comment refer to
> > companies that will choose gitlab.com internally to reduce their IT cost.
> 
> Correct.
> Companies can benefit on that, but my focus was on hobbyist (or begginers) who
> may want to test their patches on free CI before sending them to the ML.
> 
> > Its quite a stretch to call this "advertisement", that makes it looks very
> > dramatic. I personally believe its quite ahead of most other gitlab CI to take
> > into consideration running these pipelines on foreign (to the project)
> > instances.
> >
> > > > The way I see, the best would be if the CI integration could work
> > > > with more than one type of forge and being able to use any
> > > > free Git??b-CI runners that would be available for developers to
> > > > use, as this would allow testing more subsystems with CI, thus
> > > > increasing code quality.

-- 
Regards,

Laurent Pinchart

