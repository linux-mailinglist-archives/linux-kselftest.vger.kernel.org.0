Return-Path: <linux-kselftest+bounces-49145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69929D31D38
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99E7302AFCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11F23D2B2;
	Fri, 16 Jan 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8rYg66r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CC1E98E3;
	Fri, 16 Jan 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570052; cv=none; b=lBSNYQl2PwMR/nRNUKO3q6KtcDA8NhWGOo0t6P1n3NNeH+3N+QYGDwazoAivL2yrEC2gczulUXIMZnjuxpp3/eFaCD0Qxfpzhwv4uqurgeVjmWyORpJVVRImoJ+ZVeOnT87fpbMokucelPt7J17gT5KFKc/u9ggKjeLmQjJEBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570052; c=relaxed/simple;
	bh=XhuLxwCt5Gl49d4V3p8V2DE9GSzoFp1ZV3PU2uiPHw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THAs9onAZJgPt1lY2NIPLKfIPuL5/QbPXpQ1vI7I4aOi7ti4BKXpuqwlmmhrOjQxFv20jjhyB2ZTRxNY2VAOAkRAMn9G8xJ8YPjcBGAqtRuDkNE8+RdO/hj4Nyvzy6NIuCqT1JwbVj7Xqfj4nTotuYEHuiXkgrPM7eoWIprdPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8rYg66r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E7DC19421;
	Fri, 16 Jan 2026 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768570051;
	bh=XhuLxwCt5Gl49d4V3p8V2DE9GSzoFp1ZV3PU2uiPHw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8rYg66r1YJ6Heo3JT8C4Org0LuKeE37jcN5XGG7yCo2d4zVw5aP1aZCKj0We7qbr
	 ft58xfbsgPnD3qXyq79YetSpoUC5cDkDlFpy0kPjma3Bgad9z/QQ3xHeHSsKOJkFKj
	 jdEvCM9JptULbe8EAiB4U+lGtm75qVLEHGSZDE+c=
Date: Fri, 16 Jan 2026 14:27:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org,
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for
 `kobj->name`
Message-ID: <2026011600-thirsty-troubling-dc76@gregkh>
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

That one is wrong, I already rejected it :)

> It looks to me that the device name is not really used in
> gpiochip_add_data_with_key(). Can we move dev_set_name() after
> device_initialize()?

This should be cleaned up automatically by the driver core, no need to
free this on its own.

thanks,

greg k-h

