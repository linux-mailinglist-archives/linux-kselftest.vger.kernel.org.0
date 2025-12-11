Return-Path: <linux-kselftest+bounces-47415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49275CB63E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 15:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7DE3022F31
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C8288C30;
	Thu, 11 Dec 2025 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKnWPMve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5F262FC0;
	Thu, 11 Dec 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765464376; cv=none; b=EfwKtDfYdvBORxLr7/fvesLAumarQdMxWcHlAf3Lm9PPePJ+wZ3OQhAq6fgTbM9l5ZPMln4GVjUBCPvooBT159/+skJ0gAi8t1cFPdbbctd4bK3682oksVRu1lPUcs30MbckRpL8JxoEXHkM2hcu6CWReg0IzrfWChuOCBSHqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765464376; c=relaxed/simple;
	bh=ct3eNG8xt/aRp6Oevi9PIN+vHA9Q69EYHCy9CGOfaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8wnZVPwFI3p3QOzTFECB9AxyPVSjrsPh/kYeBR9stDQaY0tKF2QnHzXcYzaDjlmp5zQ7Hq6PLPjTWNYK0zoSVqsJ80/1sSLumEuQcW5WCKwkPVyvRPrp6l7euIeiXDVCAt0pbRTeG9f7HCx06PJtQbnNOGmlCcUr9l2bDItIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKnWPMve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D2C4CEF7;
	Thu, 11 Dec 2025 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765464372;
	bh=ct3eNG8xt/aRp6Oevi9PIN+vHA9Q69EYHCy9CGOfaKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKnWPMve6z4TPVPac1KdXdcXMLak4J7e88dev1ppcJJS3wNDTcRV3QLy920Qr8VXP
	 bqJDHQTy7gAgN4wm/BmmWG/C0eopqnHGyO/XqQlsSKIsH8BLgEE3itB5Xt2t5/LDNS
	 77sieFDWwYND0S71kglLY7Hlaf7v/ptd0+YU02qEEXijLvZ0adYqbrYuAcy7rDGFwE
	 6EoAXx50lwZwbgCAW6W8EWo8cNLsg59BOQU9ffDtxVmaEy/Jo2JeOQrB2DIG0JR0Z4
	 wScDZxoNjETiV5qSansXs5Ts23iUrMuqVVCSmGXsL6r3RLat7gj/iyCRj4xQgvCzMu
	 FoCcrFTldHwhA==
Date: Thu, 11 Dec 2025 14:46:08 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <aTrZMJ8R6zybFNHR@google.com>
References: <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251211032306.GO28860@pendragon.ideasonboard.com>
 <aTo-xErTTiJcribR@shikoro>
 <20251211080517.GA28411@pendragon.ideasonboard.com>
 <aTqCqab1pGB9LNZy@shikoro>
 <20251211134306.GC28411@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211134306.GC28411@pendragon.ideasonboard.com>

On Thu, Dec 11, 2025 at 10:43:06PM +0900, Laurent Pinchart wrote:
> On Thu, Dec 11, 2025 at 05:36:57PM +0900, Wolfram Sang wrote:
> > 
> > > > Isn't there even prototype code from Dan Williams?
> > > > 
> > > > "[PATCH 1/3] cdev: Finish the cdev api with queued mode support"
> > > > 
> > > > https://lkml.org/lkml/2021/1/20/997
> > > 
> > > I mentioned that in my LPC talk in 2022 :-) I think we should merge that
> > > (or a rebased, possibly improved version of it). I've meant to try
> > > plumbing that series in V4L2 but couldn't find the time so far.
> > 
> > Yes, you mentioned it in 2022 but maybe not everyone in this thread is
> > right now aware of it ;) The patch above got changes requested. I talked
> > to Dan very briefly about it at Maintainers Summit 2023 and he was also
> > open (back then) to pick it up again.
> 
> After discussing with Tzung-Bi today after his presentation (thank you
> Tzung-Bi for your time, it helped me understand the problem you're
> facing better), I wonder if this series is fixing the issue in the right
> place.

Thank you for your time too for providing me some more context.

> At the core of the problem is a devm_kzalloc() call to allocate
> driver-specific data. That data structure is then referenced from a
> cdev, which can dereference is after it gets freed. It seems that
> reference-counting the data structure instead of using devm_kzalloc()
> could be a better solution.

After discussing with you, I recalled this was one of my previous attempts.
See the series [1] and Greg's feedback [2].

I want to provide some more context about the cdev level solution.  I failed
to do so for misc device [3] mainly because all misc devices share a same
cdev [4].  If one of the misc device drivers "revoke" the cdev, all other
drivers stop working.

I'm not saying we shouldn't seek for cdev level solution.  But at least it
doesn't work for misc device.  Still need some other ways for misc devices.

[1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-8-tzungbi@kernel.org/
[2] https://lore.kernel.org/chrome-platform/2025072114-unifier-screen-1594@gregkh/
[3] https://lore.kernel.org/chrome-platform/aQ1xfHuyg1y8eJQ_@google.com/
[4] https://elixir.bootlin.com/linux/v6.17/source/drivers/char/misc.c#L299

