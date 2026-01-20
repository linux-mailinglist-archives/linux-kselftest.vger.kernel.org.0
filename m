Return-Path: <linux-kselftest+bounces-49438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74911D3BE6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 05:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0770A4EAAB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 04:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832A346FA7;
	Tue, 20 Jan 2026 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBSIMFob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DE1F12E0;
	Tue, 20 Jan 2026 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883424; cv=none; b=mCSxjuDP6vNZ/Qaxy500MSjebrSNDT8Lzb1JyVy2I7/Iq06r3pa66KF6kSbhcQvxkQH0Z3J7CeHs20P3Z0mtMMJq2Ze+wfiby/r8ksVqr3mmLkf+v1gOCytfAksaUKMw5pP7sU5W+MqfZwjnZ1lKHwikEuyczVQJi9y7zlozrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883424; c=relaxed/simple;
	bh=HrTGxOIzAWOsG442JYWnxT5VLuB38BiL2DLjt2iHGC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAyXWI5UuYpLq5sV0XirRSj3iLJg+Wes0Ew3QQLVO7BqoVyIAQ/XjUN07667HVy7cSpEWocO5yidc7/bKFpoqUZY09OOSKXqNBmHu6zS2bwjelZICrHAjPzzgNoCNTNrPeNtapFohSkA8H1uTNk+ykuzhOvIXQ1+iG7w0W1/JV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBSIMFob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B01AC16AAE;
	Tue, 20 Jan 2026 04:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768883419;
	bh=HrTGxOIzAWOsG442JYWnxT5VLuB38BiL2DLjt2iHGC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBSIMFobJeA77Y+l8QTN3AbJFijrNmnr5lDh4TawZ3CvFV60KRDyx1E8s1jVb5Vrf
	 ALL4yL6k8FxoklE4h4n6j+zrIBCtaxyxuFw/Xw6t6l5Vr2mEQx+1MpnD9GJwhdFqsk
	 ra4zHUzFyrZiTkxxlHIOTdfCMuAWNqi9z9DMAVwdC9aR6Yqxwqo5lZutGiCVeiY/lP
	 uRIbuRbe06cDopPqiuufc5BBqsEt5pSRA+SeTi4l/yhfzF56lI8pgOMpUv69wyyYve
	 /MU6wR9BgMc/jO7UYPTV3BU+bBHoZ51afst/oumh+1zVZfLKvwnQhuHBkz+xMwIY8E
	 Zuclt0UzSo7SQ==
Date: Tue, 20 Jan 2026 04:30:14 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for
 `kobj->name`
Message-ID: <aW8E1i6L7-fhORFA@google.com>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <20260116081036.352286-2-tzungbi@kernel.org>
 <20260116141356.GI961588@nvidia.com>
 <CAMRc=MfNHuTYsZJ+_RqPN1TtLOHsenv2neD5wvhA18NH6m7XjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfNHuTYsZJ+_RqPN1TtLOHsenv2neD5wvhA18NH6m7XjA@mail.gmail.com>

On Fri, Jan 16, 2026 at 03:38:37PM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 16, 2026 at 3:14 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Jan 16, 2026 at 08:10:14AM +0000, Tzung-Bi Shih wrote:
> > > `kobj->name` should be freed by kfree_const()[1][2].  Correct it.
> > >
> > > [1] https://elixir.bootlin.com/linux/v6.18/source/lib/kasprintf.c#L41
> > > [2] https://elixir.bootlin.com/linux/v6.18/source/lib/kobject.c#L695
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c351bb64cbe6 ("gpiolib: free device name on error path to fix kmemleak")
> > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > ---
> > >  drivers/gpio/gpiolib.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index 5eb918da7ea2..ba9323432e3a 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -1263,7 +1263,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
> > >  err_free_descs:
> > >       kfree(gdev->descs);
> > >  err_free_dev_name:
> > > -     kfree(dev_name(&gdev->dev));
> > > +     kfree_const(dev_name(&gdev->dev));
> > >  err_free_ida:
> > >       ida_free(&gpio_ida, gdev->id);
> > >  err_free_gdev:
> >         kfree(gdev);
> >
> > I don't think users should be open coding this, put_device() frees the
> > dev_name properly. The issue here is that the code doesn't call
> > device_initialize() before doing dev_set_name() and then tries to
> > fiddle a weird teardown sequence when it eventually does get initialized:
> >
> > err_remove_from_list:
> >         if (gdev->dev.release) {
> >                 /* release() has been registered by gpiochip_setup_dev() */
> >                 gpio_device_put(gdev);
> >                 goto err_print_message;
> >         }
> >
> > If gpiochip_add_data_with_key() is split into two functions, one that
> > does kzalloc(), some initialization and then ends with
> > device_initialize(), then a second function that calls the first and
> > does the rest of the initialization and error unwinds with
> > put_device() it will work a lot better.

That's basically what the aggressive patch 03/23 tries to do without
separating the first half to an indepedent function.

Generally, I think we can try to move device_initialize() earlier in the
function.  On error handling paths, just put_device() for it.  In the
.release() callback, free the resource iff it has initialized.

> In theory yes but you wouldn't be the first one to attempt to improve
> it. This code is very brittle when it comes to GPIO chips that need to
> be initialized very early into the boot process. I'm talking old
> drivers in arch which call this function without even an associated
> parent struct device. When I'm looking at it now, it does seem
> possible to call device_initialize() early but whether that will work
> correctly for all existing users is a bigger question.

FWIW: found a very early stage calling path when I was investigating
`gpiolib_initialized`: start_kernel() -> init_IRQ() -> dove_init_irq() ->
orion_gpio_init() -> gpiochip_add_data() -> gpiochip_add_data_with_key().

Prior to aab5c6f20023 ("gpio: set device type for GPIO chips"),
device_initialize() is also called in gpiochip_add_data_with_key().  It
seems to me it's possible to move it back to gpiochip_add_data_with_key()
as 03/23 does, and move it earlier in the function.

