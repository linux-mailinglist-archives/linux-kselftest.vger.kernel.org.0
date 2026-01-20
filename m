Return-Path: <linux-kselftest+bounces-49437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F45D3BE68
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 05:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 473464E8DB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 04:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B33446C9;
	Tue, 20 Jan 2026 04:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKIh6bug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B3341650;
	Tue, 20 Jan 2026 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883402; cv=none; b=kxKHaWqjw6n5YC+GejX5fQYFlx8+NCTpePGIwd+9ZI0JjcG5x3yIxQZ9dp71fZj/QthGnwTds02yRFfVJjyiD67r8nB609aKdQKeD+UU9bkLwHz6r7VDK6/3XuNQBxWHltV6eG4lI5nXMVBt5TJDK31k+rsXuzqXhhzMbWlPe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883402; c=relaxed/simple;
	bh=cYjerY6szdEn95B1eJP/zMvuYZZ2i7dp9IFg4E5RrDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm9zRy4NN2+30p41SXxohHMLNkpMT9u2tSC/kY61cnOWJcvzDrubUUbENMAHca6d0pVc3i0noxc/HDBxAWmDJfYm1B9Jwvne7x2hu7WWMv9uTtCk6Bmm65gh7nTUKJtg6i96ysf/XRY4n/3IJk4e5KhGPwSfhhAIcOKSSkjt/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKIh6bug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B54CC16AAE;
	Tue, 20 Jan 2026 04:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768883399;
	bh=cYjerY6szdEn95B1eJP/zMvuYZZ2i7dp9IFg4E5RrDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKIh6bugrWlQRhg665NKqztcIoaXHw/Aq2cjFkYu2BAjrbmTzD5KYxHuvEXS4uC2M
	 z7vb3WAIgR+sjhYjeHGebXqlOprTiYc+IKLOK2UXiuDdcvlIGZ90/ITWMgIIaNP080
	 oCQn9YevljFrDP5gzS8PHKAofwxIOIYz4+lPHrHhoZjDWryOTc985zr/a+N+Fx2gd1
	 s26KDS1cwjukUb5K25R7ojnRneqak1e7KYihyNXTOYRWbjdknsNM34zBj1WWtA0qPX
	 /nIIe4ULdPtrmWTgrEjco9A7acJ7sveyLER//lsABrIVd1tEabIV9RXC/lM/P+Ovlc
	 XWdAW1L1xlspw==
Date: Tue, 20 Jan 2026 04:29:54 +0000
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
Subject: Re: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for
 `kobj->name`
Message-ID: <aW8EwgEJ8XgwGhQ-@google.com>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <20260116081036.352286-2-tzungbi@kernel.org>
 <CAMRc=MeiQho5mfxGsL1AZ60brCzfox64XQao=xWnxMsdHF2-vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeiQho5mfxGsL1AZ60brCzfox64XQao=xWnxMsdHF2-vA@mail.gmail.com>

On Fri, Jan 16, 2026 at 01:15:17PM +0000, Bartosz Golaszewski wrote:
> On Fri, 16 Jan 2026 09:10:14 +0100, Tzung-Bi Shih <tzungbi@kernel.org> said:
> > `kobj->name` should be freed by kfree_const()[1][2].  Correct it.
> >
> > [1] https://elixir.bootlin.com/linux/v6.18/source/lib/kasprintf.c#L41
> > [2] https://elixir.bootlin.com/linux/v6.18/source/lib/kobject.c#L695
> >
> 
> Please don't add links third-party groks to git commit messages.
> 
> > Cc: stable@vger.kernel.org
> > Fixes: c351bb64cbe6 ("gpiolib: free device name on error path to fix kmemleak")
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> >  drivers/gpio/gpiolib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 5eb918da7ea2..ba9323432e3a 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1263,7 +1263,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
> >  err_free_descs:
> >  	kfree(gdev->descs);
> >  err_free_dev_name:
> > -	kfree(dev_name(&gdev->dev));
> > +	kfree_const(dev_name(&gdev->dev));
> >  err_free_ida:
> >  	ida_free(&gpio_ida, gdev->id);
> >  err_free_gdev:
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
> >
> 
> I've never paid attention to this bit but it really looks broken. I understand
> that this string won't get freed until we initialize refcounting on the
> underlying kobject but reaching two abstraction layers below to get the string
> for freeing out of the kobject looks incorrect to me.
> 
> It's also one of only two instances of doing kfree(dev_name(dev)), the other
> one being in drivers/scsi/hosts.c.
> 
> It looks to me that the device name is not really used in

The device name is indeed used in gpiochip_add_data_with_key().  E.g.,
gpiochip_get_ngpios() -> dev_err().

> gpiochip_add_data_with_key(). Can we move dev_set_name() after
> device_initialize()?

Sounds a good idea.  I'll try to approach it in accompany with the
aggressive patch 03/23.

