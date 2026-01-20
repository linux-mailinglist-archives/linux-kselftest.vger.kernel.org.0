Return-Path: <linux-kselftest+bounces-49479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D735D3C431
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2440529B85
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE233E36D;
	Tue, 20 Jan 2026 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miilWumG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A23D3CE9;
	Tue, 20 Jan 2026 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901680; cv=none; b=CqrfwxBlHl611xJ0nKqi0/DzS/jQPgMUBCQnhJS4t/eOGo+YCqjxExJJYtEu1brYIM/c9lY6mt0IuNqsYwEGvaqIezkOxxoivQEg2sWPPpfDrSBCsWCAw1VPreftn3yZPQPHTqNHCUbpWxTuHhUHifkh1QkJqc5LbEI9mq216/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901680; c=relaxed/simple;
	bh=wxOq5VdKgiynI7xbiIuE/pnh/uY+AxG71MkcSKQPQ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMmsIC+8yJOevE2AunhE2qlIctyw4ApSTweqnhImPIV8SN9VY6mp2mTIs3H02lPn8zuTjwHR4OwrH42kYBTo5TVq/VIxpCBuCGjjLNm6dGeJJjWP4vC0eyMr1Tva70ubpoavh+kXz3tnZnKUYMtUB/DGIRaYg+LJdEaP8CicotQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miilWumG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2541EC16AAE;
	Tue, 20 Jan 2026 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768901679;
	bh=wxOq5VdKgiynI7xbiIuE/pnh/uY+AxG71MkcSKQPQ/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miilWumGFPQf+Y6Gkp9skWZnmk3ztN4KX+HFQobLmqisjeBvFVrwcYKzD2/eFXWod
	 9HkghOrQvbqbmkhMOXoTlt+TArPvodha8qMA0sk5KvcCCyvpZUB9pFWrhZUJZT3bhA
	 PWlbii55IY0yRQzYj8O0jrrSwDY14Jnrqmc/zehxsCRoUjP+XXmUVEhrLT7KUv85Kn
	 RndBOr4WSE1/pdPGlgo15UsnOe9DrL908ZAspsOlMMCwgGZWrN4t2rfrvMbP1vGqrP
	 x3SqEZbAtAk1kE4vJ7ruToo5q2/dJpktYLM9mR8L+NJUsMjE2eMW3Lj93VQr5gK+Ux
	 XnnxT94NwBsWw==
Date: Tue, 20 Jan 2026 09:34:35 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
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
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/23] gpiolib: cdev: Fix resource leaks on errors in
 gpiolib_cdev_register()
Message-ID: <aW9MKzQkVW97IFN-@google.com>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <20260116081036.352286-3-tzungbi@kernel.org>
 <CAMRc=Mdngn4c4QW_ZhDs+VcDovO0nQ9XO2PkrNdrbyHDxrm3AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mdngn4c4QW_ZhDs+VcDovO0nQ9XO2PkrNdrbyHDxrm3AA@mail.gmail.com>

On Tue, Jan 20, 2026 at 09:50:42AM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 16, 2026 at 9:11 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On error handling paths, gpiolib_cdev_register() doesn't free the
> > allocated resources which results leaks.  Fix it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7b9b77a8bba9 ("gpiolib: add a per-gpio_device line state notification workqueue")
> > Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index 3735c9fe1502..ba1eae15852d 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -2797,16 +2797,23 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
> >
> >         ret = cdev_device_add(&gdev->chrdev, &gdev->dev);
> >         if (ret)
> > -               return ret;
> > +               goto err_free_workqueue;
> >
> 
> I need to drop this because it jumps over the guard(). I think you'll
> have to free the workqueue locally here instead.
> 
> Can you send a separate v2?

v2: https://lore.kernel.org/linux-gpio/20260120092650.2305319-1-tzungbi@kernel.org/

Heads up: I'll respin the whole series for targeting v7.0-rc1 for:
- Rebase after you applied some of the patches.
- I found you prefer "gpio" to "gpiolib" in the title prefix.
- I found yet another build warning when testing with
  https://lore.kernel.org/linux-gpio/202601200022.ZFwz8K6u-lkp@intel.com/

