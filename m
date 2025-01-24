Return-Path: <linux-kselftest+bounces-25094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE377A1B67E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 14:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6413A7EC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB071FBF6;
	Fri, 24 Jan 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U4qb+ksv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7A469D;
	Fri, 24 Jan 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723636; cv=none; b=tgyE1cDKeVX393tpPilyEqKjARrF14WuB0U+niSHY5vuR8487fJAoE0KzNJOjXUI0PSVAyc/WUqiLxu5AScaaFuShTweTZ1GUJcztAvz7YGCuFeYcA8HnBIAAfX8VSvgWminvFdJOaYZ5aaGlVuCgsY7K1znYB5SUh4aLh1w6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723636; c=relaxed/simple;
	bh=xNXL25JANeVMtEb0+OfqIO3h2IoWDgiFX+8jcNI02p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siCQz/x019EiT4ekAeDkVrhRvnWMs+1Rx2XSwaJ5DvVNS98DT3LH9WnMxP9LwDuPeB2KlUuhhBbTFS5ycu1HovscSL2dQR88yRjW0DUGoHWhlTDBidiMURFppMK2HxijHlgGb5wzp4h58eVtOEeYTT5YhWU6VUY7DfLzHvq/j/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U4qb+ksv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3285514;
	Fri, 24 Jan 2025 13:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737723567;
	bh=xNXL25JANeVMtEb0+OfqIO3h2IoWDgiFX+8jcNI02p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4qb+ksvrFNjt1lUlMKYpvv6Llm2SfKel8ltpSoSKQB/zL+rhRnXN9nqD7v7PAZOT
	 0zQHazpPs0rYNHY58A5Q+uNQOh3k/vIWQckRdLAc34lAkpLOC2/lpa2DpLb/D1w8zX
	 yAx03s18qJJI2X4j5+o14/20nCIGnJQvwM78BlBY=
Date: Fri, 24 Jan 2025 15:00:21 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>,
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
	groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20250124130021.GA6853@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <20250124135203.040d0852@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124135203.040d0852@foz.lan>

On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> 
> > > It's been a few years since I first thought on finding a good way of helping
> > > kernel developers testing their patches, while making use of the free runner
> > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > new to kernel development, or students trying to understand it better.
> > > 
> > > And this patchset allows that to happen :)
> > > 
> > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > 
> > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> 
> Sounds interesting!
> 
> > Gitlab as an open-source software project (the community edition) is one
> > thing, but can we please avoid advertising specific proprietary services
> > in the kernel documentation ?
> 
> Every time Gitlab is mentioned, the brand of the company that
> developed it and has been providing proprietary services is also
> advertised. If you're not happy with that, you should move to use
> a git forge developed by some open source community.

I'm fine mentioning the gitlab community edition, I'm not fine
advertising gitlab.com SaaS in the kernel source tree.

> The way I see, the best would be if the CI integration could work
> with more than one type of forge and being able to use any
> free Git??b-CI runners that would be available for developers to
> use, as this would allow testing more subsystems with CI, thus
> increasing code quality.

-- 
Regards,

Laurent Pinchart

