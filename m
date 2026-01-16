Return-Path: <linux-kselftest+bounces-49142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38952D31B12
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B248D30DC03B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C523D2B2;
	Fri, 16 Jan 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgcXouMJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A9218592
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569320; cv=none; b=ZY+ValHNW6yxEksWqneyA305HhDWpdN+CcQ1fiOxVqnNwli+3SFiNXpeNfVBk8EXig0LnQ4CRisoNLqJKKCSthmsfa/h8ItQLUjF8qdnpeVHI+9zHBqOkwZivDkzhT4p52JBVoGD2xkRoSiR3RSNBD0uB7JEuXN87x75Bogu7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569320; c=relaxed/simple;
	bh=F0zejtQsFxq+RFGdR3iowVouDSNSub03rMOOO/DadmM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3V8dbQuaEf7RA9dnV6Bhua5sIjaDdeLTLI8jxPibzn6N64HIsQUNGu32YzFjGV8Aof4QR35MyYV6YTdKV4y+DxeDwVMTDVgCpPvGbqvRTOAjR20izhpWUno6PkpM5mso8c6g4VSdf63ynVfymbNMKbWTWoQVKDvc8mUgf72O8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgcXouMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2DC2BC86
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768569320;
	bh=F0zejtQsFxq+RFGdR3iowVouDSNSub03rMOOO/DadmM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=XgcXouMJNUoG6WpBiXxL9gT9CCq/mOISBP6ZpjC5wQxLiE1J5koGWpNtEjVRyWJbL
	 DE9pVJJM607nFdFx7SfyyXD4DjGUZwbpPlIhA3Bsji+L+yhKzYQa5B/Pks/8JsIeY+
	 GbR7PwJgiVlwN9n4REV6Vriu2Wptoop1OcQPJMTH5S4XpUtQ5LSGqkKr4CuaksRFLT
	 lRnbhQxFmg+ebNYejENnbG8ecxX1v/ORJbesoD4Xk5fBFTvJx802KY8yYNdQ3RzNor
	 b5yGG4pW7oae+1qbdONKqATe32iX/xjVKoY9zlsr1AkcnbNhTC0Hs28FN65XWIOB+m
	 F3qHNnauKyWGA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6c905a46so2041967e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 05:15:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1Oo2JBxXgkkSMx+VxLDvjupkTOJ9cQKSo93Oiy2YTVwAyKsulUyAugw9kf8hxNw8ghCpxRjoivT4UfT4gN2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjfpACwAI2uLCIW2Zf1aTWtyM0VbL7Remud5RmoBUnsHy8HKE
	zHWAaMwMaelN73ykfGheZQIAPZFppjcktJGEfHdPhpl1en7+S21OIHKstTAkvBPtVadHkFX4LZK
	SZaFx3J9hLZ97729Ny9+0xApg1JV6bo99fWwTeHVFEg==
X-Received: by 2002:a05:6512:32c8:b0:598:eef2:e209 with SMTP id
 2adb3069b0e04-59baeec26ebmr1143109e87.5.1768569318553; Fri, 16 Jan 2026
 05:15:18 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 13:15:17 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 13:15:17 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260116081036.352286-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org> <20260116081036.352286-2-tzungbi@kernel.org>
Date: Fri, 16 Jan 2026 13:15:17 +0000
X-Gmail-Original-Message-ID: <CAMRc=MeiQho5mfxGsL1AZ60brCzfox64XQao=xWnxMsdHF2-vA@mail.gmail.com>
X-Gm-Features: AZwV_QjtzprOMqG2qDnke0_Bxhon5JnActWvxaD629LTW7BB9RenENKWKCocUJE
Message-ID: <CAMRc=MeiQho5mfxGsL1AZ60brCzfox64XQao=xWnxMsdHF2-vA@mail.gmail.com>
Subject: Re: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for `kobj->name`
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 09:10:14 +0100, Tzung-Bi Shih <tzungbi@kernel.org> said:
> `kobj->name` should be freed by kfree_const()[1][2].  Correct it.
>
> [1] https://elixir.bootlin.com/linux/v6.18/source/lib/kasprintf.c#L41
> [2] https://elixir.bootlin.com/linux/v6.18/source/lib/kobject.c#L695
>

Please don't add links third-party groks to git commit messages.

> Cc: stable@vger.kernel.org
> Fixes: c351bb64cbe6 ("gpiolib: free device name on error path to fix kmemleak")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5eb918da7ea2..ba9323432e3a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1263,7 +1263,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  err_free_descs:
>  	kfree(gdev->descs);
>  err_free_dev_name:
> -	kfree(dev_name(&gdev->dev));
> +	kfree_const(dev_name(&gdev->dev));
>  err_free_ida:
>  	ida_free(&gpio_ida, gdev->id);
>  err_free_gdev:
> --
> 2.52.0.457.g6b5491de43-goog
>
>

I've never paid attention to this bit but it really looks broken. I understand
that this string won't get freed until we initialize refcounting on the
underlying kobject but reaching two abstraction layers below to get the string
for freeing out of the kobject looks incorrect to me.

It's also one of only two instances of doing kfree(dev_name(dev)), the other
one being in drivers/scsi/hosts.c.

It looks to me that the device name is not really used in
gpiochip_add_data_with_key(). Can we move dev_set_name() after
device_initialize()?

Bart

