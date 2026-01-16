Return-Path: <linux-kselftest+bounces-49154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C5FD32CC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B90803019197
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81039341F;
	Fri, 16 Jan 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/srJcu2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF239341E
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574331; cv=none; b=flBi6ddsPoUK1FsE9ia0I9+WzOAiTMzKbLDWFc1ZK4IFI+k4NEHp2j21JbC33MT/aihTMu6BBAJSx4kjGxkjdC7i4mXORSgxEdXreJQZKZwSxREnk0Kn7GR2WJ2S5eaMlUuGLdECRtJAZddSjEcM43BycHprZaFvyBopRvbLnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574331; c=relaxed/simple;
	bh=CeYWVW8VfM0P+9OVOOOqSKgq9221JvmOkwmMFowPykI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1OV0TRknb7G3mDkEeQe9Vv1UWPBYKZY8A2fO6HRhYXT4AXZH9xfR/DB0r3Vk2DeYpX8+zg7y1NhVXc1GCPfJdyz/KjGRiN2JyNivYEfLsOuxFFuZ2dS3HXVGKPQLPEQ68VsaynrVUjQusppTRPEVFVGK9Kj+WwzAzrZOcm8q10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/srJcu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFA6C2BC87
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574331;
	bh=CeYWVW8VfM0P+9OVOOOqSKgq9221JvmOkwmMFowPykI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B/srJcu2r3cvdNI6HK8d6Kg+l8A/v0Bq/olfgH6KG4o4xi62a0HXFRi5TFQmV5H1e
	 Lwi5/BvbmXsSS7NPOUaYqpumCEL4zeX6crZaRQD7MiDre21uViPRRmmffUkxIzV44b
	 LpBtlAFE6FRI1B6MLnK9FQVcLCg/fadTDmAsh8vycF7ga6NY/js9LXphuCkn2lsuZJ
	 sF6JvSaoZ5O5bV364tAHmRJEKNwHyyUkaWz6i7uua79W42zncyDuvWzR+b+AIcjfCg
	 WttAs6nIuC81VUD48JLawqHW4N4IiIh1Fekt7D/S9sqtjKe7ey+awNDDL8iStuOnlC
	 AlUXeDS+LReJA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59a10df8027so2402755e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 06:38:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVADS1BTa9xjj9QCFhmbep90p+fG+tzF5WOvOVIIrVuA2RJfj9O1PGbFam+zph4b7W6YGdp1Mb+juQ4Pzlo32I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl90+IBYPqpvKZZCUbBW7HWZzzLMKo5xa8hph17jtELAHwVf65
	9BLQP3MOCVsjf+Al8Yp2IgDZ/kVN/lzUJdTVZZtHeLQLLW58id3fVrVyMlXKVVOfUMk3q3pMl5P
	DFCylAqJn5g6DzsNGnivhCTXCwfRl6hNFKSJE5NUrgw==
X-Received: by 2002:a05:6512:2209:b0:595:910c:8eea with SMTP id
 2adb3069b0e04-59baeedb8d0mr1047903e87.32.1768574329704; Fri, 16 Jan 2026
 06:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org> <20260116081036.352286-2-tzungbi@kernel.org>
 <20260116141356.GI961588@nvidia.com>
In-Reply-To: <20260116141356.GI961588@nvidia.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 16 Jan 2026 15:38:37 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfNHuTYsZJ+_RqPN1TtLOHsenv2neD5wvhA18NH6m7XjA@mail.gmail.com>
X-Gm-Features: AZwV_QgKGGwLD0w6o4kmw7zFNYd6T1XDEchQCsf09zNM0M9ftM2EdmkAv3QwV20
Message-ID: <CAMRc=MfNHuTYsZJ+_RqPN1TtLOHsenv2neD5wvhA18NH6m7XjA@mail.gmail.com>
Subject: Re: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for `kobj->name`
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:14=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Jan 16, 2026 at 08:10:14AM +0000, Tzung-Bi Shih wrote:
> > `kobj->name` should be freed by kfree_const()[1][2].  Correct it.
> >
> > [1] https://elixir.bootlin.com/linux/v6.18/source/lib/kasprintf.c#L41
> > [2] https://elixir.bootlin.com/linux/v6.18/source/lib/kobject.c#L695
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c351bb64cbe6 ("gpiolib: free device name on error path to fix km=
emleak")
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> >  drivers/gpio/gpiolib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 5eb918da7ea2..ba9323432e3a 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1263,7 +1263,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *=
gc, void *data,
> >  err_free_descs:
> >       kfree(gdev->descs);
> >  err_free_dev_name:
> > -     kfree(dev_name(&gdev->dev));
> > +     kfree_const(dev_name(&gdev->dev));
> >  err_free_ida:
> >       ida_free(&gpio_ida, gdev->id);
> >  err_free_gdev:
>         kfree(gdev);
>
> I don't think users should be open coding this, put_device() frees the
> dev_name properly. The issue here is that the code doesn't call
> device_initialize() before doing dev_set_name() and then tries to
> fiddle a weird teardown sequence when it eventually does get initialized:
>
> err_remove_from_list:
>         if (gdev->dev.release) {
>                 /* release() has been registered by gpiochip_setup_dev() =
*/
>                 gpio_device_put(gdev);
>                 goto err_print_message;
>         }
>
> If gpiochip_add_data_with_key() is split into two functions, one that
> does kzalloc(), some initialization and then ends with
> device_initialize(), then a second function that calls the first and
> does the rest of the initialization and error unwinds with
> put_device() it will work a lot better.
>

In theory yes but you wouldn't be the first one to attempt to improve
it. This code is very brittle when it comes to GPIO chips that need to
be initialized very early into the boot process. I'm talking old
drivers in arch which call this function without even an associated
parent struct device. When I'm looking at it now, it does seem
possible to call device_initialize() early but whether that will work
correctly for all existing users is a bigger question.

I'm open to trying it after v7.0-rc1 is tagged. This would give it
enough time in linux-next to make sure it works.

Bartosz

