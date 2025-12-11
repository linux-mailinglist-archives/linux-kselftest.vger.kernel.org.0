Return-Path: <linux-kselftest+bounces-47414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C60CB6128
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 14:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC0C33001BE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27142FF156;
	Thu, 11 Dec 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dbFMSp1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC9286418;
	Thu, 11 Dec 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460614; cv=none; b=b5AkHbjUhxM56qJYWXaoyJNgb03jiuXRwFIK9rM+H4dwOcsuiUXUo16zciG1O1j56uMam6tZ5v18I9JV7iWgicXeCl7jB/pA3jUF1IM2dHJs3vfccHe03J86RE0XipIueYtG8jUixzwSAxeE9yR1jCDeHsAKxE9T3kbOqVFxdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460614; c=relaxed/simple;
	bh=GHYEhlkvcFeFuGWpDaxnbBTjKdxg8bMF0QV/AkgQAig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTWkOc4a0w8Cm8f6d0fr2IB8H7jjubqDTedoioMF0Pfavk+9XkBJOVdnOcJ5Xon++d57UF1pOKePzvpFb8fPVmDw3CNAUoTrn/UywHgPhCEzWNj78DFqVQ1ItI8O6Or5QWluOA4mYufLsg/OqOyIQL2ieIeoDOusYFXA6dY3f78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dbFMSp1A; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (p7838222-ipoefx.ipoe.ocn.ne.jp [123.225.39.221])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 66639667;
	Thu, 11 Dec 2025 14:43:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1765460606;
	bh=GHYEhlkvcFeFuGWpDaxnbBTjKdxg8bMF0QV/AkgQAig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbFMSp1AqU3bnnjDdUEE3/kzX7SQCG+yy/mGts/WuUB8P6bmdsDyZhiHFzl7Zlp5L
	 tqvjaY5Hsb9siuSBgzclY6Vkx8Gl+3UFhTp58xxCaoXCrabR5oon/mrGpx1+29fHXJ
	 VQSM65zvmVFFXqnxZp10sqjVbdMJIQQrolZDmuro=
Date: Thu, 11 Dec 2025 22:43:06 +0900
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251211134306.GC28411@pendragon.ideasonboard.com>
References: <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251211032306.GO28860@pendragon.ideasonboard.com>
 <aTo-xErTTiJcribR@shikoro>
 <20251211080517.GA28411@pendragon.ideasonboard.com>
 <aTqCqab1pGB9LNZy@shikoro>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTqCqab1pGB9LNZy@shikoro>

On Thu, Dec 11, 2025 at 05:36:57PM +0900, Wolfram Sang wrote:
> 
> > > Isn't there even prototype code from Dan Williams?
> > > 
> > > "[PATCH 1/3] cdev: Finish the cdev api with queued mode support"
> > > 
> > > https://lkml.org/lkml/2021/1/20/997
> > 
> > I mentioned that in my LPC talk in 2022 :-) I think we should merge that
> > (or a rebased, possibly improved version of it). I've meant to try
> > plumbing that series in V4L2 but couldn't find the time so far.
> 
> Yes, you mentioned it in 2022 but maybe not everyone in this thread is
> right now aware of it ;) The patch above got changes requested. I talked
> to Dan very briefly about it at Maintainers Summit 2023 and he was also
> open (back then) to pick it up again.

After discussing with Tzung-Bi today after his presentation (thank you
Tzung-Bi for your time, it helped me understand the problem you're
facing better), I wonder if this series is fixing the issue in the right
place.

At the core of the problem is a devm_kzalloc() call to allocate
driver-specific data. That data structure is then referenced from a
cdev, which can dereference is after it gets freed. It seems that
reference-counting the data structure instead of using devm_kzalloc()
could be a better solution.

-- 
Regards,

Laurent Pinchart

