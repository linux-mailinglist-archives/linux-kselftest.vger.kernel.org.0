Return-Path: <linux-kselftest+bounces-49473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A7D3C2E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B35C0B30
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2963B8D7C;
	Tue, 20 Jan 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyAaH/lL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3A3B8D69
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899056; cv=none; b=pDuFU69UzuNoEPVTs7hAzXhmDRKKhV52pHxVstBEKUbXZF+9UGMcMiAm8ma/BbkLKQH+MlBcwuaxqsGJT262uwJ616Yy0t4in+slFjt2Wo41y6PWwtnOJ50yUOdoTR29v7EyAsPGB/EjlfakgGIH8tZf65wQpHUfb80FK6RmJpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899056; c=relaxed/simple;
	bh=do0XuP3Zi8PjdCXNfroMPixzMEA5ulmxumiLJlFnLiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anmelP/L26JFhmq+IENH8fp14hn7nGIYHArUnmWa6u0T/wV/41QIz2hHIgzg6OvSQZ5loQMVlPZwDDfEGG2oM2AO4RIUkqE+0e8nxqKQQfUkiogJefimQNSLJ2L0/A/0ki42eJb3+cKdaVD4cdY7rlAJVpdeHJU/0FFG8ONpSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyAaH/lL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF56FC19424
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768899055;
	bh=do0XuP3Zi8PjdCXNfroMPixzMEA5ulmxumiLJlFnLiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FyAaH/lL8VE3aH99ISrOjFjfIvkNRgiC+i925sxblrmPHXs25OFOw9k9ckByjAHhy
	 tPVJPAMrDkpiakXnA1Qog+/hRXgryia1C1g0YdACYIB7NYud52dfcECuJ0Ps6QU1b4
	 shl2cdVbPsqbuC2+A3vJq2QZidTlUi1Jm9UCEA/BByfZWuVMCNCRgffph1Y/nepuMS
	 ZAGqRjL7NvLbG1ZgeJ7XwJPU/Jt9WUiVS2/N0UNzzMi4mHormRDf0ENFT8vm3gyqCd
	 SuxmnrCGqz5133ZvMx6uSO1/UbBZrtIj8xC+CDPeH9OXK++Lova+Ocm9LmsN/o3i1U
	 Vt/CRRt2WGcwA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-382fa0dc9f4so55637231fa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 00:50:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNX5WvIQJ2ob16JeYloef7rkip+TWg8sdNSAFzo6AsOhcS68b75n+CtJa9zGNjr+qS4XUum61oPGKQdnpr9iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nJUZOt213x8uFZMy1z+vc+GrLZ6ekufSQalk/zCgrf7X79IN
	A10MOTMr42fKJfGT/XtiAyGmH37Df+nDlkQgeSDsOgr7N4ilCckYbXSHOw1BdodF9HNUj72QXr/
	3SF9VBi51R/i2EXszVs1mRnhmvh1QOGD1fvyYO16TEQ==
X-Received: by 2002:a05:6512:4028:b0:59b:7864:9776 with SMTP id
 2adb3069b0e04-59dc93613b6mr485045e87.46.1768899054537; Tue, 20 Jan 2026
 00:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org> <20260116081036.352286-3-tzungbi@kernel.org>
In-Reply-To: <20260116081036.352286-3-tzungbi@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 20 Jan 2026 09:50:42 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mdngn4c4QW_ZhDs+VcDovO0nQ9XO2PkrNdrbyHDxrm3AA@mail.gmail.com>
X-Gm-Features: AZwV_Qh3M58U2X97aT7pLBRq3LyYL2qXklUQjfDBH6SF1QA_AYfcibS66WclyeE
Message-ID: <CAMRc=Mdngn4c4QW_ZhDs+VcDovO0nQ9XO2PkrNdrbyHDxrm3AA@mail.gmail.com>
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

On Fri, Jan 16, 2026 at 9:11=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On error handling paths, gpiolib_cdev_register() doesn't free the
> allocated resources which results leaks.  Fix it.
>
> Cc: stable@vger.kernel.org
> Fixes: 7b9b77a8bba9 ("gpiolib: add a per-gpio_device line state notificat=
ion workqueue")
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_devi=
ce with SRCU")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 3735c9fe1502..ba1eae15852d 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -2797,16 +2797,23 @@ int gpiolib_cdev_register(struct gpio_device *gde=
v, dev_t devt)
>
>         ret =3D cdev_device_add(&gdev->chrdev, &gdev->dev);
>         if (ret)
> -               return ret;
> +               goto err_free_workqueue;
>

I need to drop this because it jumps over the guard(). I think you'll
have to free the workqueue locally here instead.

Can you send a separate v2?

Bart

>         guard(srcu)(&gdev->srcu);
>         gc =3D srcu_dereference(gdev->chip, &gdev->srcu);
> -       if (!gc)
> -               return -ENODEV;
> +       if (!gc) {
> +               ret =3D -ENODEV;
> +               goto err_free_cdev;
> +       }
>
>         gpiochip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gde=
v->id);
>
>         return 0;
> +err_free_cdev:
> +       cdev_device_del(&gdev->chrdev, &gdev->dev);
> +err_free_workqueue:
> +       destroy_workqueue(gdev->line_state_wq);
> +       return ret;
>  }
>
>  void gpiolib_cdev_unregister(struct gpio_device *gdev)
> --
> 2.52.0.457.g6b5491de43-goog
>

