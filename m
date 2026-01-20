Return-Path: <linux-kselftest+bounces-49482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E68D3C47D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12BE05611CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204E3D411B;
	Tue, 20 Jan 2026 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz7m9ThW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C03D34A6
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901975; cv=none; b=j0p656XS0u4Cj11jpGKI8XiegbKVVCgAvSJijo3HNqk/KR1+QdxPGof+ZK2hl/id7rIuYQVSvUCssIWUJWbUWY5EbKg1eujuNPJFR+ILz74XOuoc1aGIqjhs2qnkoVFk17JK4oc9Ay7vugr5FAheCOLn4VQYfzFCGm7THdVF4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901975; c=relaxed/simple;
	bh=zV6mcVSfiA6R6YgOwKrRpUiAkBy2C7szWuRfdGfT91o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC+i2sjOtaAGI6Mw3nc9Ybmb7H28fwDQLNSZoMVc2XDCYPVRg4MkNf0fvFTvakkp6YknAS8YCCUBdDj08IIxzdR+/gqWCeLcJjaNfBh8Lr2kym4ePcbIbC6GPM9+W4ceSiz20ac0g/EABvlufcbm7ArYfv+p4jouoSGhJwNmMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz7m9ThW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D198BC2BCB4
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768901974;
	bh=zV6mcVSfiA6R6YgOwKrRpUiAkBy2C7szWuRfdGfT91o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dz7m9ThW+mNmCcXxUyI64zTlRztIe9SRBW+tPDTy4UU2Scyb23znMoh4FOdEmvNq2
	 n2DcCt9Ck6X/56LrHgdzCWVCKv+/iEGAN4Uz5NLJ6nYc/ta3ocUOSo6v4E+muM5TS/
	 fQEMKDgzy5AZClnUCbY3yveOXECz9Si1DhfUOvKCBmeloIO+cXAujUKdB96foIDH80
	 65624e13kLUzj29R4/M0VsB1X+aOKS1pTVYmnBH2C8plN7CKoy8hM52UvoJkLFBGtt
	 ugq37lxaPzsoVUz/iQFydWm3xdTUcSooKTrdsE/7sQlHWgBB7t4vvMuT9DZoQ/EY0a
	 FYu7UThlOuB/w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b7882e605so6887583e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:39:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhqO7Esd0mfMzsH1h07d1dfeRwREaohkLmVKnLUXF7+teu6igtfzg+qNKbVY9Rgrrrqbtj3N4piVMNwvyV5/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kiE1FXuLgicV3XG8B79mWP3b5Ju+TkTmcjJDpb+g5nSPpTKO
	Ayx6Rm1PM26pJN+wG2Q1M58JpRVxxzUBZQ9lDQQAbOEPOQr18cXdO3EBXbUwieGBuVaS2JDCX/P
	Qa9kRBtQroq+7DYryUWTPOSwWAxA7mJhATKCqQzfrHw==
X-Received: by 2002:a05:6512:1105:b0:59b:6f90:4a2 with SMTP id
 2adb3069b0e04-59bafdb6c43mr4763812e87.16.1768901973337; Tue, 20 Jan 2026
 01:39:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org> <20260116081036.352286-3-tzungbi@kernel.org>
 <CAMRc=Mdngn4c4QW_ZhDs+VcDovO0nQ9XO2PkrNdrbyHDxrm3AA@mail.gmail.com> <aW9MKzQkVW97IFN-@google.com>
In-Reply-To: <aW9MKzQkVW97IFN-@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 20 Jan 2026 10:39:19 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfKSsJ29z7VksybNnOxRwSzNKB2uw6wMJS5-oz9RwTfaw@mail.gmail.com>
X-Gm-Features: AZwV_QgkatyCaeogI3O8WpI3KaBI6v2MG1QzvwvyHka4GBUT00V9OEoMiuxkc70
Message-ID: <CAMRc=MfKSsJ29z7VksybNnOxRwSzNKB2uw6wMJS5-oz9RwTfaw@mail.gmail.com>
Subject: Re: [PATCH 02/23] gpiolib: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:34=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Tue, Jan 20, 2026 at 09:50:42AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Jan 16, 2026 at 9:11=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.o=
rg> wrote:
> > >
> > > On error handling paths, gpiolib_cdev_register() doesn't free the
> > > allocated resources which results leaks.  Fix it.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 7b9b77a8bba9 ("gpiolib: add a per-gpio_device line state notif=
ication workqueue")
> > > Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_=
device with SRCU")
> > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > ---
> > >  drivers/gpio/gpiolib-cdev.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.=
c
> > > index 3735c9fe1502..ba1eae15852d 100644
> > > --- a/drivers/gpio/gpiolib-cdev.c
> > > +++ b/drivers/gpio/gpiolib-cdev.c
> > > @@ -2797,16 +2797,23 @@ int gpiolib_cdev_register(struct gpio_device =
*gdev, dev_t devt)
> > >
> > >         ret =3D cdev_device_add(&gdev->chrdev, &gdev->dev);
> > >         if (ret)
> > > -               return ret;
> > > +               goto err_free_workqueue;
> > >
> >
> > I need to drop this because it jumps over the guard(). I think you'll
> > have to free the workqueue locally here instead.
> >
> > Can you send a separate v2?
>
> v2: https://lore.kernel.org/linux-gpio/20260120092650.2305319-1-tzungbi@k=
ernel.org/
>
> Heads up: I'll respin the whole series for targeting v7.0-rc1 for:
> - Rebase after you applied some of the patches.

I guess this concerns the device_initialize() rework? Yeah v7.0-rc1 is
good timing.

> - I found you prefer "gpio" to "gpiolib" in the title prefix.

Just makes the line shorter.

> - I found yet another build warning when testing with
>   https://lore.kernel.org/linux-gpio/202601200022.ZFwz8K6u-lkp@intel.com/

Yeah, this is the one I referred to in my previous email, just forgot
to link it.

Bart

