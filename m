Return-Path: <linux-kselftest+bounces-49435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E91D3BDD7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 04:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B8333462ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C772316193;
	Tue, 20 Jan 2026 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4PN4Taf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD7315D30;
	Tue, 20 Jan 2026 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768878704; cv=none; b=OQTnjtyLVY4TuXPhAwjLlm9ApbxpkMnknQlYklLxp/QobSZTn3qe4BdYcmlvlsy2Ua36DPRuFm2kpd6x+C2cxO/k6A0iY1vO2N/neIz/K+gCHbVHd9ky/qMr8rKiVp9BeJ8gRuvBcvp3blrbPhdwLFqwbS/Xomd/QOiFm/v9A9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768878704; c=relaxed/simple;
	bh=Wx1SqFN3hDIwD8rraPxQ/DXNJK+yMpYLmyu6geBXNcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QquaTxsT+2BP3LfagwPVJxLOyF7gY1mu2wGO10MY7URFHO2mdWAAyo3kVaobLaWptOtFBWerH3gG2xM5ctLlUctl6xDgHwPDMgZzJ4ihVqIcHVyYnycnNUzYOJYV1iOh1XGm668W7z5KVe3AtygEN0e9uBKDRH5/bCTIS3bIKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4PN4Taf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4F3C116C6;
	Tue, 20 Jan 2026 03:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768878704;
	bh=Wx1SqFN3hDIwD8rraPxQ/DXNJK+yMpYLmyu6geBXNcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4PN4TafSC6fPoELc+gFEmzM9r3aWlz+a9PgPcBknVKtzDen0/8buxdFrg8g81xcb
	 GDH9oaSDqwwZvlWFIsQcUT/Q9Wa4RjAE1inSCcWxgRU3Yrv0Up0HVVi3XVeWFWou+y
	 oqkYLU/67t5jMEYmhRX/C5WnDOMkTcvBsIDMxP8+ejZMoDMLPZwfgZjFgLFZkK8zia
	 9LRrrEvhspvau4kaI1OkFkmG9vNHkQTYuji2Y7pqS761L5rO9Bdowd1ixNyu6TcX/a
	 k/VUfP66OBP/BfjJId1GTJRBc6GiYH1/LaT/HO+PSrRVfTJ5xTE9GmqRqusPLvfcjU
	 2mklgSOfiM3Eg==
Date: Tue, 20 Jan 2026 03:11:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org,
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 04/23] gpiolib: Fix resource leaks on errors in
 lineinfo_changed_notify()
Message-ID: <aW7yazJvgRu-WyZQ@google.com>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <20260116081036.352286-5-tzungbi@kernel.org>
 <CAMRc=Mc4UoXif=vwUQG1jYW8G3QziZwbdcfvZGquytdrd4SBpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mc4UoXif=vwUQG1jYW8G3QziZwbdcfvZGquytdrd4SBpg@mail.gmail.com>

On Fri, Jan 16, 2026 at 01:26:01PM +0000, Bartosz Golaszewski wrote:
> On Fri, 16 Jan 2026 09:10:17 +0100, Tzung-Bi Shih <tzungbi@kernel.org> said:
> > On error handling paths, lineinfo_changed_notify() doesn't free the
> > allocated resources which results leaks.  Fix it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d4cd0902c156 ("gpio: cdev: make sure the cdev fd is still active before emitting events")
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index ba1eae15852d..6196aab5ed74 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -2549,7 +2549,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
> >  	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
> >  	if (!ctx) {
> >  		pr_err("Failed to allocate memory for line info notification\n");
> > -		return NOTIFY_DONE;
> > +		goto err_put_fp;
> >  	}
> >
> >  	ctx->chg.event_type = action;
> > @@ -2563,6 +2563,9 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
> >  	queue_work(ctx->gdev->line_state_wq, &ctx->work);
> >
> >  	return NOTIFY_OK;
> > +err_put_fp:
> > +	fput(fp);
> > +	return NOTIFY_DONE;
> >  }
> >
> >  static int gpio_device_unregistered_notify(struct notifier_block *nb,
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
> >
> 
> There's only one place where you need this fput(), please do it directly in
> the error path of kzalloc() and drop the label.

Sure, just wanted to give a heads up: 17/23 might introduce the label back.

v2: https://lore.kernel.org/all/20260120030857.2144847-1-tzungbi@kernel.org

