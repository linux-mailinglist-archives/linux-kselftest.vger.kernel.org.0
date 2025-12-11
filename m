Return-Path: <linux-kselftest+bounces-47394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E11CB5098
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6693011A72
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1FC26FA67;
	Thu, 11 Dec 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iAUDs4oI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3521CFFD;
	Thu, 11 Dec 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765440343; cv=none; b=fksSbzn/tt6j8HWufgkYLLpHhVZbK/WDQAy18wqjOHd63wbncsFxBHu7SSpojGtl+YrKkFjISuOXf/3M6unn3UXCeo9gIwjRuNivWFXhjhOcnLT9WqmSNJtlA/XVtNFxgBSDuhRpGVvqZMVDhTLaOKHz3NMOg9o2nBAS5Ngw+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765440343; c=relaxed/simple;
	bh=aPKeMjxLi1HLi972Uhx0X3LDVwP8dUt8WWUBTZJ2J6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4IAzqHqE/cPve2dId6NFfvQGlIW+NDS3PH6D6+DCMpsOM6rr3NQpQCBOytR9gOfBJhyfr5xthBxJbTzJ3rlXGcXXnAUAubuMrT8tFYK9ZBDs7pao4z/V/jqvCjmRcr+hoEh8/PX5sMhQiZjzym4mSLC8ximmgZfewJx+vd4NI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iAUDs4oI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id C0E251352;
	Thu, 11 Dec 2025 09:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1765440334;
	bh=aPKeMjxLi1HLi972Uhx0X3LDVwP8dUt8WWUBTZJ2J6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAUDs4oIUydn6rrPRIuVUdCNUpEL+az2VKNxP9B6OPXnKkhu3klGwfLA9C8EP8VX+
	 QqErQWBNtYnYeQq3edS6V1ZfeWtiniXCp6Z7bQSqXtLF+prmVu3W0qloYDDPkBbzbt
	 HH1qOdz2qK6x1jiqNGM45RMPIHhk/p3SjgtN9mEQ=
Date: Thu, 11 Dec 2025 17:05:17 +0900
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
Message-ID: <20251211080517.GA28411@pendragon.ideasonboard.com>
References: <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251211032306.GO28860@pendragon.ideasonboard.com>
 <aTo-xErTTiJcribR@shikoro>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTo-xErTTiJcribR@shikoro>

On Thu, Dec 11, 2025 at 12:47:16PM +0900, Wolfram Sang wrote:
> 
> > Replying late to this thread, I don't think this is right for V4L2. When
> > it comes to solving the .remove() vs. userspace race, I think the right
> > solution is at the cdev level.
> 
> Isn't there even prototype code from Dan Williams?
> 
> "[PATCH 1/3] cdev: Finish the cdev api with queued mode support"
> 
> https://lkml.org/lkml/2021/1/20/997

I mentioned that in my LPC talk in 2022 :-) I think we should merge that
(or a rebased, possibly improved version of it). I've meant to try
plumbing that series in V4L2 but couldn't find the time so far.

-- 
Regards,

Laurent Pinchart

